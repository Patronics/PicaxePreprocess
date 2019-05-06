#!/usr/bin/python

#PICAXE #include, #define, and #macro preprocessor
#todo: make defines behave like single line macros, allowing(parameters)
#todo: more thoroughly test macro behaviors, especially with parentheses
#Created by Patrick Leiser
import sys, getopt, os, datetime, re, os.path
inputfilename = 'main.bas'
outputfilename = 'compiled.bas'
outputpath=""
definitions=dict()
macros=dict()
def main(argv):
    global inputfilename
    global outputfilename
    global outputpath
    try:
        opts, args = getopt.getopt(argv,"hi:o:",["ifile=","ofile="])
    except getopt.GetoptError:
        print 'picaxepreprocess.py -i <inputfile> -o <outputfile>'
        sys.exit(2)
    for opt, arg in opts:
        if opt == '-h':
            print 'picaxepreprocess.py -i <inputfile> -o <outputfile>'
            sys.exit()
        elif opt in ("-i", "--ifile"):
            inputfilename = arg
        elif opt in ("-o", "--ofile"):
            outputfilename = arg
    print 'Input file is ', inputfilename
    print 'Output file is ', outputfilename, '\n'
    path=os.path.dirname(os.path.abspath(__file__))
    if outputfilename.startswith("/"):
        outputpath=""
    else:
        outputpath=path+'/'
    with open (outputpath+outputfilename, 'w') as output_file:   #desribe output file info at beginning in comments
        output_file.write("'-----PREPROCESSED BY picaxepreprocess.py-----\n")
        output_file.write("'----UPDATED AT "+ datetime.datetime.now().strftime("%I:%M%p, %B %d, %Y") + "----\n")
        output_file.write("'----SAVING AS "+outputfilename+" ----\n\n")
        output_file.write("'---BEGIN "+inputfilename+" ---\n")
    progparse(inputfilename)   #begin parsing input file into output
        
def progparse(curfilename):
    global definitions
    savingmacro=False
    print("including file " + curfilename)
    path=os.path.dirname(os.path.abspath(__file__))+"/"
    if curfilename.startswith("/"):    #decide if an absolute or relative path
        curpath=""
    else:
        curpath=path
    if (not os.path.isfile(curpath+curfilename)):
        if os.path.isfile(curpath+"include/"+curfilename):
            curpath=curpath+"include/"
    with open(curpath+curfilename) as input_file:
        for i, line in enumerate(input_file):
            workingline=line.lstrip()
            if workingline.lower().startswith("#include"):
                workingline=workingline[9:].lstrip().split("'")[0].split(";")[0].rstrip()     #remove #include text, comments, and whitespace
                workingline=workingline.strip('"')         #remove quotation marks around path
                #print(workingline)
                with open (outputpath+'/'+outputfilename, 'a') as output_file:
                    output_file.write("'---BEGIN "+workingline+" ---\n")
                progparse(workingline)
            elif workingline.lower().startswith("#define"):     #Automatically substitute #defines
                workingline=workingline[8:].lstrip().split("'")[0].split(";")[0].rstrip()
                try:
                    definitions[workingline.split()[0]]=(workingline.split(None,1)[1])   #add to dictionary of definitions
                except:
                    print("old define found, leaving intact")
                
                with open (outputpath+'/'+outputfilename, 'a') as output_file:
                    output_file.write(line.rstrip()+"      'DEFINITION PARSED\n")
            elif workingline.lower().startswith("#macro"):     #Automatically substitute #macros
                savingmacro=True
                workingline=workingline[7:].lstrip().split("'")[0].split(";")[0].rstrip()
                macroname=workingline.split("(")[0].rstrip()
                print macroname
                with open (outputpath+outputfilename, 'a') as output_file:
                    output_file.write("'PARSED MACRO "+macroname)
                macrocontents=workingline.split("(")[1].rstrip()
                macros[macroname]={}
                argnum=0
                while(1):
                    argnum+=1
                    if macrocontents.strip()==")":
                        print("no parameters to macro")
                        macros[macroname][0]="'Start of macro: "+macroname
                        print macros
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
                                print params
                                break
                        line=line.replace(key,macrovars[0])
                        print macrovars
                        for num, name in macrovars.items():
                                if name in line:
                                    if num>0:
                                        line=re.sub(r"\b%s\b" % name,params[num],line)
                        line=line[:line.rfind(")", 0, line.rfind(")"))]+line[line.rfind(")", 0, line.rfind(")"))+1:]
                with open (outputpath+outputfilename, 'a') as output_file:
                    output_file.write(line)
                #print line,
        #print "{0} line(s) printed".format(i+1)
        with open (outputpath+'/'+outputfilename, 'a') as output_file:
            output_file.write("\n'---END "+curfilename+"---\n")
    #print (definitions)
    

if __name__ == "__main__":
    main(sys.argv[1:])
    