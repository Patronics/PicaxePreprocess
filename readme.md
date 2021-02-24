# PicaxePreprocess.py
A PICAXE preprocessor to implement most preprocessor directives found in Picaxe Programming editor 6 for use with axepad, blockly, and other non-PE6 editors.

This tool can also be used as a starting point for include/macro implementations in other software tools.

## Setup
If you don't already have it, install python3.

copy `picaxepreprocess.py` (and optionally the `Makefile` for advanced usage) to the directory your .bas files are in or to a known location in the system path such as `/usr/local/bin` so that the script can be accessible from anywhere on the system and not require remembering its filepath.

You might also want to edit the `compile_path` variable to point to the Picaxe compilers. If
you don't already have them, they can be downloaded from [here](https://picaxe.com/software/drivers/picaxe-compilers/). Alternatively, the compiler path can be specified with the `-P` option.

That's it!

## Usage
Run ./picaxepreprocess.py.
If your starting file is named "main.bas", and you're ok with outputing to "compiled.bas", that's it!

You can also specify an input file with `-i filename.bas` or without the `-i` if it is the last option, such as `picaxepreprocess.py input.bas`
Output files can be specified similarly with `-o outputfilename.bas`

The preprocessor will automatically look for included files in the working directory, and in a subdirectory called `/include` if it exists. (note: for optimal compatibility with PE6 includes, using this include directory on shared projects with PE6 users is not reccomended.) You can also specifiy absolute file paths.

### Options
```
picaxepreprocess.py [OPTIONS] [INPUTFILE]

Optional switches
    -i, --ifile=       Input file (default main.bas). Flag not required if it is
                       the last argument given.
    -o, --ofile=       Output file (default compiled.bas)
    -u, --upload       Send the file to the compiler if this option is included.
    -s, --syntax       Send the file to the compiler for a syntax check only (no download)
        --nocolor      Disable terminal colour for systems that do not support it (Windows).
        --noifs        Disable evaluation of #if and #ifdef - this will be left to the compiler if present.
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
```

See the Makefile for an example of advanced usage. When properly configured, the makefile can automatically handle preprocessing the code, compiling it, and uploading to a picaxe chip by simply invoking `make compile` and run a syntax check with `make syntax`. The makefile also demonstrates usage with multiple picaxe chips with separate programs in the same project directory.

If you're interested in this project, you may also like [this similar PICAXE Preprocessor implementation](https://github.com/jgOhYeah/PICAXE-Libraries-Extras), or  [this similar C-style preprocessor from ParksProjets](https://github.com/ParksProjets/C-Preprocessor).
