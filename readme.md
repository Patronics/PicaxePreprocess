# PicaxePreprocess.py
A PICAXE preprocessor to implement `#include`, `#macro`, and `#define` for use with axepad, blockly, and other non-PE6 editors

This tool can also be used as a starting point for include/macro implementstions in other software tools

## setup
If you don't already have it, install python.

copy `picaxepreprocess.py` (and optionally the `Makefile` for advanced usage) to the directory your .bas files are in

that's it!

## usage
run ./picaxepreprocess.py from the same directory as the files you want to preprocess.
If your starting file is named "main.bas", and you're ok with outputing to compiled.bas, that's it!


You can also specify an input file with `-i filename.bas`, such as `picaxepreprocess.py -i input.bas`
Output files can be specified similarly with `-o outputfilename.bas`


The preprocessor will automatically look for included files in the working directory, and in a subdirectory called `/include` if it exists. (note: for optimal compatibility with PE6 includes, using this include directory on shared projects with PE6 users is not reccomended.) You can also specifiy absolute file paths.

See the Makefile for an example of advanced usage. When properly configured, the makefile can automatically handle preprocessing the code, compiling it, and uploading to a picaxe chip by simply invoking `make compile` and run a syntax check with `make syntax`. The makefile also demonstrates usage with multiple picaxe chips with separate programs in the same project directory.

If you're interested in this project, you may also like [this similar PICAXE Preprocessor implementation](https://github.com/jgOhYeah/PICAXE-Libraries-Extras), or  [this similar C-style preprocessor from ParksProjets](https://github.com/ParksProjets/C-Preprocessor).
