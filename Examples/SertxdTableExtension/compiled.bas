'-----PREPROCESSED BY picaxepreprocess.py-----
'----UPDATED AT 12:03AM, March 08, 2021----
'----SAVING AS compiled.bas ----

'---BEGIN simple.bas ---
#picaxe 08m2      'CHIP VERSION PARSED
; #DEFINE TABLE_SERTXD_USE_EEPROM
; #DEFINE TABLE_SERTXD_MEM_OFFSET 10
main:
;#sertxd("Hello World", cr, lf) 'Evaluated below
w0 = 10
w1 = 22
gosub print_table_sertxd
;#sertxd("That's a really annoying line!", cr,lf,"(because of all the characters that have to be ignored when in a string;",cr, lf, "such as ',', ''', ';', ')', '(', ']', '[', ':', '#', '\\', ...") 'Evaluated below
w0 = 23
w1 = 190
gosub print_table_sertxd
;#sertxd("This line contains dynamic content that cannot be printed", #w0) 'Evaluated below
w0 = 191
w1 = 248
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
    read w0, b4
    sertxd(b4)
next w0

    return

eeprom 10, ("Hello World",cr,lf) ;#sertxd
eeprom 23, ("That's a really annoying line!",cr,lf,"(because of all the characters that have to be ignored when in a string;",cr,lf,"such as ',', ''', ';', ')', '(', ']', '[', ':', '#', '\\', ...") ;#sertxd
eeprom 191, ("This line contains dynamic content that cannot be printed","?") ;#sertxd
