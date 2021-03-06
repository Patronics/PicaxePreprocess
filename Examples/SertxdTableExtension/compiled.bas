'-----PREPROCESSED BY picaxepreprocess.py-----
'----UPDATED AT 03:40PM, March 06, 2021----
'----SAVING AS compiled.bas ----

'---BEGIN simple.bas ---
#picaxe 14m2      'CHIP VERSION PARSED

w0 = 0
w1 = 12
gosub print_table_sertxd
w0 = 13
w1 = 179
gosub print_table_sertxd
w0 = 180
w1 = 237
gosub print_table_sertxd

'---END simple.bas---


'---Extras added by the preprocessor---
print_table_sertxd:

    for w0 = w0 to w1
        readtable w0, b4
        sertxd(b4)
    next w0

    return

table 0, ("Hello World",cr,lf) ;#sertxd
table 13, ("That's a really annoying line!",cr,lf,"(because of all the characters that have to be ignored when in a string;",cr,lf,"such as ',', ''', ';', ')', '(', ']', '['m ':', '#', '\', ...") ;#sertxd
table 180, ("This line contains dynamic content that cannot be printed","?") ;#sertxd
