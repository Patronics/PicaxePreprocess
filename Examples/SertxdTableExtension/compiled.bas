'-----PREPROCESSED BY picaxepreprocess.py-----
'----UPDATED AT 10:59PM, March 06, 2021----
'----SAVING AS compiled.bas ----

'---BEGIN TableSertxd.bas ---
; Testing for backing up variables using ;#sertxd
; The ';' at the start is so that this will be ignored by the built in picaxe compiler
; Jotham Gates
; Created 06/02/2021
; Modified 06/02/2021

#picaxe 18m2      'CHIP VERSION PARSED
; #DEFINE TABLE_SERTXD_BACKUP_VARS
; #DEFINE TABLE_SERTXD_BACKUP_LOC 121 ; 5 bytes from here
; #DEFINE TABLE_SERTXD_ADDRESS_VAR w0
; #DEFINE TABLE_SERTXD_ADDRESS_VAR_L b0
; #DEFINE TABLE_SERTXD_ADDRESS_VAR_H b1
; #DEFINE TABLE_SERTXD_ADDRESS_END_VAR w1
; #DEFINE TABLE_SERTXD_ADDRESS_END_VAR_L b2
; #DEFINE TABLE_SERTXD_ADDRESS_END_VAR_H b3
; #DEFINE TABLE_SERTXD_TMP_BYTE b4

init:
    setfreq m32
    sertxd(";#sertxd backup variable testing", cr, lf)
main:
    sertxd("Begin loop", cr, lf)
;     #rem [Commented out]
;     sertxd("Enter variables to load: ", cr, lf) [Commented out]
;     sertxd("b0: ") [Commented out]
;     serrxd #b0 [Commented out]
;     sertxd(#b0, cr, lf, "b1: ") [Commented out]
;     serrxd #b1 [Commented out]
;     sertxd(#b1, cr, lf, "b2: ") [Commented out]
;     serrxd #b2 [Commented out]
;     sertxd(#b2, cr, lf, "b3: ") [Commented out]
;     serrxd #b3 [Commented out]
;     sertxd(#b3, cr, lf, "b4: ") [Commented out]
;     serrxd #b4 [Commented out]
;     #endrem [Commented out]
    b0 = 34
    b1 = 35
    b2 = 36
    b3 = 37
    b4 = 38

    sertxd("Before: ")
    gosub debug_vars

gosub backup_table_sertxd ; Save the values currently in the variables
w0 = 0
w1 = 45
gosub print_table_sertxd

    sertxd("After: ")
    gosub debug_vars

    sertxd("Done", cr, lf, cr, lf, cr, lf)
    pause 12000
    goto main

debug_vars:
    sertxd("b0=", #b0, " b1=", #b1, " b2=", #b2, " b3=", #b3, " b4=", #b4, cr, lf)
    return

'---END TableSertxd.bas---


'---Extras added by the preprocessor---
backup_table_sertxd:
    poke 121, b4
    poke 122, b0
    poke 123, b1
    poke 124, b2
    poke 125, b3
    return

print_table_sertxd:

    for w0 = w0 to w1
        readtable w0, b4
        sertxd(b4)
    next w0

    peek 121, b4
    peek 122, b0
    peek 123, b1
    peek 124, b2
    peek 125, b3
    return

table 0, ("Hello. This is a test string stored in table",cr,lf) ;#sertxd
