# PicaxePreprocess.py
A PICAXE preprocessor to implement `#include`, `#macro`, and `#define` for use with axepad, blockly, and other non-PE6 editors

This tool can also be used as a starting point for include/macro implementstions in other software tools

## usage
run ./picaxepreprocess.py from the same directory as the files you want to preprocess.
If your starting file is named "main.bas", and you're ok with outputing to compiled.bas, that's it!

You can also specify an input file with `-i filename.bas`, such as `picaxepreprocess.py -i input.bas`
Output files can be specified similarly with `-o outputfilename.bas`
