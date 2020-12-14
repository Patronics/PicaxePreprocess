#!/usr/bin/env python3

# PICAXE #include, #define, and #macro preprocessor
# todo: make defines behave like single line macros, allowing(parameters)
# todo: more thoroughly test macro behaviors, especially with parentheses
# Created by Patrick Leiser, edited by Jotham Gates
# Run this script with no options for usage information.
# TODO: Friendlier error detection and explanations

import sys, getopt, os, datetime, re, os.path, subprocess
inputfilename = 'main.bas'
outputfilename = 'compiled.bas'
outputpath=""
definitions=dict()
macros=dict()
use_colour = True # Does not work on Windows, will end up with a lot of nonsense characters when
                  # showing an error.

# Default options to pass to the compiler
port = "/dev/ttyUSB0"
chip = "08m2" # Must be lowercase m or x if included

# Compiler path
compiler_path = "/usr/local/lib/picaxe/" # Needs a / afterwards
compiler_name = "picaxe"
compiler_extension = "" # File extension (.exe...). For linux anyway, there is none, but including
                        # just in case it is different for other platforms.
send_to_compiler = False
command = [""] # Empty string at the first position will be replaced by the compiler name and path.
tidy = False

def print_help():
    # Prints the help message 
    print("""
picaxepreprocess.py [OPTIONS] [INPUTFILE]

Optional switches
    -i, --ifile=       Input file (default main.bas). Flag not required if it is
                       the last argument given.
    -o, --ofile=       Output file (default compiled.bas)
    -u, --upload       Send the file to the compiler if this option is included.
    -h, --help         Display this help

Optional switches only used if sending to the compiler
    -v, --variant=     Variant (default 08m2)
                       (alternatively use #PICAXE directive within the program.
                       This option will be ignored if #PICAXE is used)
    -s, --syntax       Syntax check only (no download)
    -f, --firmware     Firmware check only (no download)
    -c, --comport=     Assign COM/USB port device (default /dev/ttyUSB0)
                       (alternately use #COM directive within program. This option
                       will be ignored if #COM is used). There should be a space
                       between the -c and the port, unlike the compilers.
    -d, --debug        Leave port open for debug display (b0-13)
        --debughex     Leave port open for debug display (hex mode)
    -e  --edebug       Leave port open for debug display (b14-b27)
        --edebughex    Leave port open for debug display (hex mode)
    -t, --term         Leave port open for sertxd display
        --termhex      Leave port open for sertxd display (hex mode)
        --termint      Leave port open for sertxd display (int mode)
    -p, --pass         Add pass message to error report file
        --tidy         Remove the output file on completion if in upload mode.
    -P  --compilepath= specify the path to the compilers directory (defaults to /usr/local/lib/picaxe/)

Preprocessor for PICAXE microcontrollers.
See https://github.com/Patronics/PicaxePreprocess for more info.
""")

def main(argv):
    """ Generates the combined and preprocessed file to send to the compiler """
    global inputfilename
    global outputfilename
    global outputpath
    global send_to_compiler
    global port
    global command
    global tidy
    global compiler_path

    # Use the last argument as the file name if it does not start with a dash
    if (len(argv) == 1 or len(argv) >= 2 and argv[-2] not in ("-o", "-v", "-c")) and argv[-1][0] != "-": # Double check the second last is -i if needed
            # This is not a flag
            inputfilename = argv[-1]
            argv.pop() # Remove the last argument to stop it being confused for getopt
            if len(argv) and argv[-1] == "-i":
                argv.pop() # Remove the -i option as it has been parsed here.

    try:
        opts, _ = getopt.getopt(argv,"hi:o:uv:sfc:detpP:",["help", "ifile=","ofile=","upload","variant=","syntax","firmware","comport=","debug","debughex","edebug","edebughex","term","termhex","termint", "pass", "tidy", "compilepath="])
    except getopt.GetoptError:
        print_help()
        sys.exit(2)
    for opt, arg in opts:
        if opt in ("-h", "--help"):
            print_help()
            sys.exit()
        elif opt in ("-i", "--ifile"):
            inputfilename = arg
        elif opt in ("-o", "--ofile"):
            outputfilename = arg
        elif opt in ("-u", "--upload"):
            send_to_compiler = True
        elif opt in ("-v", "--variant"): # Picaxe variant
            set_chip(arg)
        elif opt in ("-s", "--syntax"): # Syntax only
            send_to_compiler = True
            command.append("-s")
        elif opt in ("-f", "--firmware"): # Firmware check
            command.append("-f")
        elif opt in ("-c", "--comport"): # Serial port given
            port = arg
        elif opt in ("-d", "--debug"): # Leave port open for normal debug
            command.append("-d")
        elif opt in ("--debughex"): # Hex debug
            command.append("-dh")
        elif opt in ("e", "--edebug"): # Extended debug
            command.append("-e")
        elif opt in ("--edebughex"): # Extended hex debug
            command.append("-eh")
        elif opt in ("-t", "--term"): # Leave serial port open for monitoring
            command.append("-t")
        elif opt in ("--termhex"): # Terminal hex
            command.append("-th")
        elif opt in ("--termint"): # Terminal int mode
            command.append("-ti")
        elif opt in ("-p", "pass"): # Pass message in error file required
            command.append("-p")
        elif opt in ("--tidy"): # Remove the output file afterwards
            tidy = True
        elif opt in ("-P", "--compilepath"): #chose non-default path to compilers
            compiler_path = os.path.join(arg,'') #adds trailing slash if needed
    if not os.path.exists(inputfilename):
        preprocessor_error("'{}/{}' does not exist. Either specify an input file or put it in the same folder as this script with the name 'main.bas'".format(os.getcwd(), inputfilename))

    print('Input file is ', inputfilename)
    print('Output file is ', outputfilename)
    print('Using compilers at ', compiler_path , '\n')
    # Python should hopefully keep the same working directory as the shell, so do not need to change it?
    inputfile = inputfilename.replace("\\","/").split("/")[-1] # Get just the file name.
    with open (outputfilename, 'w') as output_file:   #desribe output file info at beginning in comments
        output_file.write("'-----PREPROCESSED BY picaxepreprocess.py-----\n")
        output_file.write("'----UPDATED AT "+ datetime.datetime.now().strftime("%I:%M%p, %B %d, %Y") + "----\n")
        output_file.write("'----SAVING AS "+outputfilename+" ----\n\n")
        output_file.write("'---BEGIN "+inputfilename+" ---\n")
    progparse(inputfile)   #begin parsing input file into output

    if send_to_compiler:
        if not os.path.exists(compiler_path):
            preprocessor_error("'{}' does not exist. Either specify a valid compilers directory or put them in '/usr/local/lib/picaxe/'".format(compiler_path))

        # Calling the correct compiler
        command[0] = "{}{}{}{}".format(compiler_path, compiler_name, chip, compiler_extension)
        command.append("-c{}".format(port))
        command.append(outputfilename)

        print()
        print()
        print("Running compiler with command:")
        for i in command:
            print("{} ".format(i), end="")
        print()
        
        try:
            subprocess.run(command)
        except FileNotFoundError:
            preprocessor_error("""The compiler was not found at '{}'.
Are you sure you have downloaded the compilers from
https://picaxe.com/software/drivers/picaxe-compilers/ and set the compiler
path with -P?""".format(command[0]))

        if tidy: # Delete afterwards if needed
            os.remove(outputfilename)
            err_file = outputfilename.replace("."+outputfilename.split(".")[-1],"") + ".err" # Calculate the name of the error file
            os.remove(err_file)


    print()
    print("Done.")
                
def progparse(curfilename, called_from_line=None, called_from_file=None):
    """ Recursively merges and processes files """
    global definitions
    global chip
    global port
    savingmacro=False
    print("Including file " + curfilename)
    path=os.path.dirname(os.path.abspath(inputfilename))+"/"
    if curfilename.startswith("/"):    #decide if an absolute or relative path
        curpath=""
    else:
        curpath=path
    if (not os.path.isfile(curpath+curfilename)):
        if os.path.isfile(curpath+"include/"+curfilename):
            curpath=curpath+"include/"
    if not os.path.exists(curpath + curfilename):
        preprocessor_error("""Call to include '{}{}' which does not exist.
Called from line {} in '{}'""".format(curpath, curfilename, called_from_line, called_from_file))
    with open(curpath + curfilename) as input_file:
        for count, line in enumerate(input_file):
            workingline=line.lstrip()
            if workingline.lower().startswith("#include"):
                workingline=workingline[9:].lstrip().split("'")[0].split(";")[0].rstrip()     #remove #include text, comments, and whitespace
                workingline=workingline.strip('"')         #remove quotation marks around path
                #print(workingline)
                with open (outputfilename, 'a') as output_file:
                    output_file.write("'---BEGIN "+workingline+" ---\n")
                progparse(workingline,count+1,curfilename) # +1 for 0 indexing
            elif workingline.lower().startswith("#define"):     #Automatically substitute #defines
                workingline=workingline[8:].lstrip().split("'")[0].split(";")[0].rstrip()
                try:
                    definitions[workingline.split()[0]]=(workingline.split(None,1)[1])   #add to dictionary of definitions
                except:
                    print("Old define found, leaving intact")
                
                with open (outputfilename, 'a') as output_file:
                    output_file.write(line.rstrip()+"      'DEFINITION PARSED\n")
            elif workingline.lower().startswith("#picaxe"): # Set the picaxe chip
                workingline=workingline[8:].lstrip().split("'")[0].split(";")[0].rstrip()     # Remove #picaxe text, comments, and whitespace
                set_chip(workingline)
                with open (outputfilename, 'a') as output_file:
                    output_file.write(line.rstrip()+"      'CHIP VERSION PARSED\n")
            elif workingline.lower().startswith("#com"): # Set the serial port
                port = workingline[5:].lstrip().split("'")[0].split(";")[0].rstrip()     # Remove #com text, comments, and whitespace
                port = port.strip('"')         #remove quotation marks around path
                print("Setting serial port to '{}'".format(port))
                with open (outputfilename, 'a') as output_file:
                    output_file.write(line.rstrip()+"      'SERIAL PORT PARSED\n")
            elif workingline.lower().startswith("#macro"):     #Automatically substitute #macros
                savingmacro=True
                workingline=workingline[7:].lstrip().split("'")[0].split(";")[0].rstrip()
                macroname=workingline.split("(")[0].rstrip()
                print(macroname)
                with open (outputfilename, 'a') as output_file:
                    output_file.write("'PARSED MACRO "+macroname)
                macrocontents=workingline.split("(")[1].rstrip()
                macros[macroname]={}
                argnum=0
                while(1):
                    argnum+=1
                    if macrocontents.strip()==")":
                        print("no parameters to macro")
                        macros[macroname][0]="'Start of macro: "+macroname
                        print(macros)
                        break
                    else:
                        macrocontents=macrocontents.rstrip(")").strip("(")
                        macros[macroname][argnum]=macrocontents.split(",")[0].rstrip()   #create spot in dictionary for macro variables, but don't populate yet
                        if "," in macrocontents:
                            macrocontents=macrocontents.split(",")[1].strip().rstrip()
                        else:
                            print("finished parsing macro contents")
                            macros[macroname][0]="'--START OF MACRO: "+macroname+"\n"
                            break
            elif savingmacro==True:
                if workingline.lower().startswith("#endmacro"):
                    savingmacro=False
                    macros[macroname][0]=macros[macroname][0]+"'--END OF MACRO: "+macroname
                    #print macros
                else:
                    macros[macroname][0]=macros[macroname][0]+line
            else:
                for key,value in definitions.items():
                    if key in line:
                        #print("substituting definition")
                        line=line.replace(key,value)
                        line=line.rstrip()+"      'DEFINE: "+value+" SUBSTITUTED FOR "+key+"\n"
                for key, macrovars in macros.items():
                    if key in line:
                        params={}
                        argnum=0
                        macrocontents=line.split(key)[1]
                        macrocontents=macrocontents.strip("(").strip(")")
                        while(1):
                            argnum+=1
                        
                            if "," in macrocontents:
                                params[argnum]=macrocontents.split(",")[0].rstrip()   #
                                
                                macrocontents=macrocontents.split(",")[1].strip().rstrip()
                            else:
                                print("finished parsing macro contents")
                                params[argnum]=macrocontents.split(",")[0].rstrip()
                                #params[argnum]=params[argnum].strip("(").strip(")").strip()
                                print(params)
                                break
                        line=line.replace(key,macrovars[0])
                        print(macrovars)
                        for num, name in macrovars.items():
                                if name in line:
                                    if num>0:
                                        line=re.sub(r"\b%s\b" % name,params[num],line)
                        line=line[:line.rfind(")", 0, line.rfind(")"))]+line[line.rfind(")", 0, line.rfind(")"))+1:]
                with open (outputpath+outputfilename, 'a') as output_file:
                    output_file.write(line)
                #print line,
        #print "{0} line(s) printed".format(i+1)
        with open (outputfilename, 'a') as output_file:
            output_file.write("\n'---END "+curfilename+"---\n")
    #print (definitions)

def set_chip(new_chip):
    """ Validates and selects the compiler to use.
    This needs to be validated as it will be used to run a command line program, so do not want to
    inject malicious code (although should they already have access to the command line directly if
    they are running this script??? """
    global chip
    valid_chips = ["08", "08m2", "08m2le", "14m", "14m2", "18", "18a", "18m", "18m2", "18x",
                   "18x_1", "20m", "20m2", "20x2", "28", "28a", "28x", "28x_1", "28x1", "28x1_0",
                   "28x2"]
    new_chip = new_chip.lower() # In case of 08M2 or 08m2
    if new_chip in valid_chips:
        print("Setting the PICAXE chip to: '{}'".format(new_chip))
        chip = new_chip
    else:
        preprocessor_error("""'{}' given as a PICAXE chip, but is not in the list of known parts or compilers.
Please select from:\n{}""".format(new_chip,valid_chips))

def preprocessor_error(msg):
    """ Prints an error message that may be coloured if there is an issue preprocessing.
    Will also stop the script executing. """
    # Header
    if use_colour:
        print("\u001b[1m\u001b[31m", end="") # Bold Red
    print("PREPROCESSOR ERROR")
    if use_colour:
        print("\u001b[0m", end="") # Reset
    
    # Body
    print(msg)

    # Note to say giving up
    if use_colour:
        print("\u001b[33m", end="") # Yellow
    print("Processing halted. Please try again.")
    if use_colour:
        print("\u001b[0m", end="") # Reset
    exit()
    
def preprocessor_warning(msg):
    """ Prints a warning message. Similar to error, but will not stop. """
    if use_colour:
        print("\u001b[1m\u001b[33m", end="") # Bold Yellow
    print("PREPROCESSOR WARNING")
    if use_colour:
        print("\u001b[0m", end="") # Reset
    print(msg)


if __name__ == "__main__":
    main(sys.argv[1:])
    
