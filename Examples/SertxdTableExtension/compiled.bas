'-----PREPROCESSED BY picaxepreprocess.py-----
'----UPDATED AT 12:05PM, March 13, 2021----
'----SAVING AS compiled.bas ----

'---BEGIN simple.bas ---
#picaxe 14m2      'CHIP VERSION PARSED
;#DEFINE TABLE_SERTXD_USE_EEPROM
;#DEFINE TABLE_SERTXD_MEM_OFFSET 10
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

; #rem [Commented out]
; ;sertxd(cr, lf) ; 8 bytes for a single [Commented out]
; ;'#sertxdnl ; 12 bytes for a single [Commented out]
; #endrem [Commented out]

; #rem 71 bytes for 16 [Commented out]
; sertxd(cr, lf) [Commented out]
; sertxd(cr, lf) [Commented out]
; sertxd(cr, lf) [Commented out]
; sertxd(cr, lf) [Commented out]
; sertxd(cr, lf) [Commented out]
; sertxd(cr, lf) [Commented out]
; sertxd(cr, lf) [Commented out]
; sertxd(cr, lf) [Commented out]
; sertxd(cr, lf) [Commented out]
; sertxd(cr, lf) [Commented out]
; sertxd(cr, lf) [Commented out]
; sertxd(cr, lf) [Commented out]
; sertxd(cr, lf) [Commented out]
; sertxd(cr, lf) [Commented out]
; sertxd(cr, lf) [Commented out]
; sertxd(cr, lf) [Commented out]
; #endrem [Commented out]

; #rem [Commented out]
; ; 62 for 16 [Commented out]
; ;#sertxdnl [Commented out]
; ;#sertxdnl [Commented out]
; ;#sertxdnl [Commented out]
; ;#sertxdnl [Commented out]
; ;#sertxdnl [Commented out]
; ;#sertxdnl [Commented out]
; ;#sertxdnl [Commented out]
; ;#sertxdnl [Commented out]
; ;#sertxdnl [Commented out]
; ;#sertxdnl [Commented out]
; ;#sertxdnl [Commented out]
; ;#sertxdnl [Commented out]
; ;#sertxdnl [Commented out]
; ;#sertxdnl [Commented out]
; ;#sertxdnl [Commented out]
; ;#sertxdnl [Commented out]
; #endrem [Commented out]

'---END simple.bas---


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
