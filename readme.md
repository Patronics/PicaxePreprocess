# PicaxePreprocess.py <!-- omit in toc -->
A PICAXE preprocessor to implement most preprocessor directives found in Picaxe Programming Editor 6 for use with axepad, blockly, and other non-PE6 editors.

This tool can also be used as a starting point for include/macro implementations in other software tools.

## Table of contents <!-- omit in toc -->
- [Setup](#setup)
- [Usage](#usage)
  - [Options and usage](#options-and-usage)
    - [Optional switches](#optional-switches)
    - [Optional switches only used if sending to the compiler](#optional-switches-only-used-if-sending-to-the-compiler)
    - [Table Sertxd Extension](#table-sertxd-extension)
  - [Usage with a makefile](#usage-with-a-makefile)
- [Other projects](#other-projects)

## Setup
If you don't already have it, install python3.

Copy `picaxepreprocess.py` (and optionally the `Makefile` for advanced usage) to the directory your .bas files are in or to a known location. For ease of use this location may be in the system path such as `/usr/local/bin` so that the script can be accessible from anywhere on the system by entering `picaxepreprocess.py` in the terminal without needing to know the actual location.

You might also want to edit the `compile_path` variable to point to the Picaxe compilers. If
you don't already have them, they can be downloaded from [here](https://picaxe.com/software/drivers/picaxe-compilers/). Alternatively, the compiler path can be specified with the `-P` option.

That's it!

## Usage
Run `./picaxepreprocess.py`.

If your starting file is named "main.bas", and you're ok with outputing to "compiled.bas", that's it!

You can also specify an input file with `-i filename.bas` or without the `-i` if it is the last option, such as `picaxepreprocess.py input.bas`
Output files can be specified similarly with `-o outputfilename.bas`

The preprocessor will automatically look for included files in the working directory, and in a subdirectory called `/include` if it exists. (note: for optimal compatibility with PE6 includes, using this include directory on shared projects with PE6 users is not reccomended.) You can also specifiy absolute file paths.

### Options and usage
In general usage, the script should be called and any required options and flags given after it on the same line as follows:
```bash
picaxepreprocess.py [OPTIONS] [INPUTFILE]
```

#### Optional switches
| Short | Extended        | Value expected | Description                                                                                                                                                          |
| :---: | --------------- | :------------: | -------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `-i`  | `--file=`       |      yes       | Input file (default `main.bas`). Flag not required if it is the last argument given.                                                                                 |
| `-o`  | `--ofile=`      |      yes       | Output file (default `compiled.bas`)                                                                                                                                 |
| `-u`  | `--upload`      |       no       | Send the file to the compiler if this option is included.                                                                                                            |
| `-s`  | `--syntax`      |       no       | Send the file to the compiler for a syntax check only (no download)                                                                                                  |
|       | `--nocolor`     |       no       | Disable terminal colour for systems that do not support it (Windows).                                                                                                |
|       | `--noifs`       |       no       | Disable evaluation of `#if` and `#ifdef` - this will be left to the compiler if this flag is present.                                                                |
|       | `--tablesertxd` |       no       | Enable a non standard extension that will evaluate a `;#sertxd` directive. See the [Table Sertxd Extension](#table-sertxd-extension) section below for more details. |
| `-h`  | `--help`        |       no       | Display a text version of this help message                                                                                                                          |

#### Optional switches only used if sending to the compiler
| Short | Extended         | Value expected | Description                                                                                                                                                                                                                                             |
| :---: | ---------------- | :------------: | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `-v`  | `--variant=`     |      yes       | Variant (default `08m2`) (alternatively use `#PICAXE` directive within the program. This option will be ignored if `#PICAXE` is used)                                                                                                                   |
| `-s`  | `--syntax`       |       no       | Syntax check only (no download)                                                                                                                                                                                                                         |
| `-f`  | `--firmware`     |       no       | Firmware check only (no download)                                                                                                                                                                                                                       |
| `-c`  | `--comport=`     |      yes       | Assign COM/USB port device (default `/dev/ttyUSB0`). Alternately use `#COM` directive within program. This option will be ignored if `#COM` is used. There should be a space between the `-c` and the port on unix based systems, unlike the compilers. |
| `-d`  | `--debug`        |       no       | Leave port open for debug display (`b0-13`)                                                                                                                                                                                                             |
|       | `--debughex`     |       no       | Leave port open for debug display (hex mode)                                                                                                                                                                                                            |
| `-e`  | `--edebug`       |       no       | Leave port open for debug display (`b14-b27`)                                                                                                                                                                                                           |
|       | `--edebughex`    |       no       | Leave port open for debug display (hex mode)                                                                                                                                                                                                            |
| `-t`  | `--term`         |       no       | Leave port open for `sertxd` display                                                                                                                                                                                                                    |
|       | `--termhex`      |       no       | Leave port open for `sertxd` display (hex mode)                                                                                                                                                                                                         |
|       | `--termint`      |       no       | Leave port open for `sertxd` display (int mode)                                                                                                                                                                                                         |
| `-p`  | `--pass`         |       no       | Add pass message to error report file                                                                                                                                                                                                                   |
|       | `--tidy`         |       no       | Remove the output file on completion if in upload mode.                                                                                                                                                                                                 |
| `-P`  | `--compilepath=` |      yes       | Specify the path to the compilers directory (defaults to `/usr/local/lib/picaxe/`)                                                                                                                                                                      |

#### Table Sertxd Extension
Enable a non standard extension that will evaluate a `;#sertxd` directive to automatically save, load and print a string from table memory on supported chips.

For example:
```basic
;#sertxd("Hello world", cr, lf)
```

Syntax is the same as the `sertxd` command, although dynamic content such as printing variables is not supported and may cause cryptic errors if attempted.

Two word and one byte variables are required for storing addresses and processing, as set by the defines outlined below. These variables can be modified between calls to `;#sertxd`, although any call to `;#sertxd` will modify them unless variable backup and restore to storage ram is enabled.

##### The folowing definitions can be used to change the default behaviour: <!-- omit in toc -->

| Definition                     |  Default Value   | Description                                                                                                                                                                |
| ------------------------------ | :--------------: | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `TABLE_SERTXD_ADDRESS_VAR`     |       `w0`       | Changes the word used. If not backing up, the value in it will be lost when `;#sertxd` is called.                                                                          |
| `TABLE_SERTXD_ADDRESS_END_VAR` |       `w1`       | Changes the word used.                                                                                                                                                     |
| `TABLE_SERTXD_TMP_BYTE`        |       `b4`       | Changes the byte used.                                                                                                                                                     |
| `TABLE_SERTXD_BACKUP_VARS`     |  Do not backup   | Enable saving & restoring the variables used to storage ram. This is slower as it uses peek & poke, but allows the variables to keep their value accross `;#sertxd` calls. |
| `TABLE_SERTXD_USE_EEPROM`      | Use table memory | If defined, uses eeprom to store strings instead of table memory, allowing this extension to be used on chips without table memory.                                        |
| `TABLE_SERTXD_MEM_OFFSET`      |        0         | Offset the start of the first string in case the first part of the memory is needed for something else.                                                                    |

##### Only required if backing up variables: <!-- omit in toc -->
| Definition                       | Default Value | Description                                                                                                     |
| -------------------------------- | :-----------: | --------------------------------------------------------------------------------------------------------------- |
| `TABLE_SERTXD_BACKUP_LOC`        |      121      | The location in storage ram to save the existing values of the general purpose variables. 5 bytes are required. |
| `TABLE_SERTXD_ADDRESS_VAR_L`     |     `b0`      | The lower byte (I haven't had much success in using `peek` and `poke` with words, so need the individual bytes) |
| `TABLE_SERTXD_ADDRESS_VAR_H`     |     `b1`      | The upper byte                                                                                                  |
| `TABLE_SERTXD_ADDRESS_END_VAR_L` |     `b2`      | The lower byte                                                                                                  |
| `TABLE_SERTXD_ADDRESS_END_VAR_H` |     `b3`      | The upper byte                                                                                                  |

This flag also enables the non standard `;#sertxdnl` directive that prints a new line. When called many times, this uses less program space than `sertxd(cr, lf)`

##### Table Sertxd Extension usage example <!-- omit in toc -->
<details>
  <summary>Click to expand</summary>

As an example of what it does, a cutdown version of the [simple.bas](Examples/SertxdTableExtension/simple.bas) example:
```basic
#picaxe 14m2
main:
    ;#sertxd("Hello World", cr, lf)
    ;#sertxd("That's a really annoying line!", cr,lf,"(because of all the characters that have to be ignored when in a string;",cr, lf, "such as ',', ''', ';', ')', '(', ']', '[', ':', '#', ...")
    ;#sertxd("This line contains dynamic content that cannot be printed", #w0)
    pause 5000
    goto main
```
is preprocessed (on Ubuntu) using:
```bash
cd Examples/SertxdTableExtension
# picaxepreprocess.py is copied into a folder on the path, so I can just call it as follows:
picaxepreprocess.py -s --tablesertxd simple.bas # Syntax check and enable tablesertxd extension.
```
```basic
'-----PREPROCESSED BY picaxepreprocess.py-----
'----UPDATED AT 12:05PM, March 13, 2021----
'----SAVING AS compiled.bas ----

'---BEGIN simple.bas ---
#picaxe 14m2      'CHIP VERSION PARSED
main:
;#sertxd("Hello World", cr, lf) 'Evaluated below
w0 = 0
w1 = 12
gosub print_table_sertxd
;#sertxd("That's a really annoying line!", cr,lf,"(because of all the characters that have to be ignored when in a string;",cr, lf, "such as ',', ''', ';', ')', '(', ']', '[', ':', '#', ...") 'Evaluated below
w0 = 13
w1 = 174
gosub print_table_sertxd
;#sertxd("This line contains dynamic content that cannot be printed", #w0) 'Evaluated below
w0 = 175
w1 = 232
gosub print_table_sertxd
    pause 5000
    goto main

'---Extras added by the preprocessor---
print_table_sertxd:
    for w0 = w0 to w1
    readtable w0, b4
    sertxd(b4)
next w0

    return

table 0, ("Hello World",cr,lf) ;#sertxd
table 13, ("That's a really annoying line!",cr,lf,"(because of all the characters that have to be ignored when in a string;",cr,lf,"such as ',', ''', ';', ')', '(', ']', '[', ':', '#', ...") ;#sertxd
table 175, ("This line contains dynamic content that cannot be printed","?") ;#sertxd
```
And should print something like:
```text
Hello World
That's a really annoying line!
(because of all the characters that have to be ignored when in a string;
such as ',', ''', ';', ')', '(', ']', '[', ':', '#', ... This line contains dynamic content that cannot be printed ?
```
</details>

### Usage with a makefile
See the Makefile for an example of advanced usage. When properly configured, the makefile can automatically handle preprocessing the code, compiling it, and uploading to a picaxe chip by simply invoking `make compile` and run a syntax check with `make syntax`. The makefile also demonstrates usage with multiple picaxe chips with separate programs in the same project directory.


## Other projects
If you're interested in this project, you may also like [this similar PICAXE Preprocessor implementation](https://github.com/jgOhYeah/PICAXE-Libraries-Extras), or  [this similar C-style preprocessor from ParksProjets](https://github.com/ParksProjets/C-Preprocessor).
