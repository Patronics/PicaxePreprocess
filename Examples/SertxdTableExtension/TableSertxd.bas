; Testing for backing up variables using ;#sertxd
; The ';' at the start is so that this will be ignored by the built in picaxe compiler
; Jotham Gates
; Created 06/02/2021
; Modified 06/02/2021

#picaxe 18m2
#DEFINE TABLE_SERTXD_BACKUP_VARS
#DEFINE TABLE_SERTXD_BACKUP_LOC 121 ; 5 bytes from here
#DEFINE TABLE_SERTXD_ADDRESS_VAR w0
#DEFINE TABLE_SERTXD_ADDRESS_VAR_L b0
#DEFINE TABLE_SERTXD_ADDRESS_VAR_H b1
#DEFINE TABLE_SERTXD_ADDRESS_END_VAR w1
#DEFINE TABLE_SERTXD_ADDRESS_END_VAR_L b2 
#DEFINE TABLE_SERTXD_ADDRESS_END_VAR_H b3
#DEFINE TABLE_SERTXD_TMP_BYTE b4
#DEFINE TABLE_SERTXD_USE_EEPROM
#DEFINE TABLE_SERTXD_MEM_OFFSET 10

init:
    setfreq m32
    sertxd(";#sertxd backup variable testing", cr, lf)
main:
    sertxd("Begin loop", cr, lf)
    #rem
    sertxd("Enter variables to load: ", cr, lf)
    sertxd("b0: ")
    serrxd #b0
    sertxd(#b0, cr, lf, "b1: ")
    serrxd #b1
    sertxd(#b1, cr, lf, "b2: ")
    serrxd #b2
    sertxd(#b2, cr, lf, "b3: ")
    serrxd #b3
    sertxd(#b3, cr, lf, "b4: ")
    serrxd #b4
    #endrem
    b0 = 34
    b1 = 35
    b2 = 36
    b3 = 37
    b4 = 38

    sertxd("Before: ")
    gosub debug_vars

    ;#sertxd("Hello. This is a test string stored in table", cr, lf)

    sertxd("After: ")
    gosub debug_vars

    sertxd("Done", cr, lf, cr, lf, cr, lf)
    pause 12000
    goto main

debug_vars:
    sertxd("b0=", #b0, " b1=", #b1, " b2=", #b2, " b3=", #b3, " b4=", #b4, cr, lf)
    return
