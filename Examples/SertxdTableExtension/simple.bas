#picaxe 08m2
#DEFINE TABLE_SERTXD_USE_EEPROM
#DEFINE TABLE_SERTXD_MEM_OFFSET 10
main:
    ;#sertxd("Hello World", cr, lf)
    ;#sertxd("That's a really annoying line!", cr,lf,"(because of all the characters that have to be ignored when in a string;",cr, lf, "such as ',', ''', ';', ')', '(', ']', '[', ':', '#', '\\', ...")
    ;#sertxd("This line contains dynamic content that cannot be printed", #w0)
    pause 5000
    goto main

#rem
;sertxd(cr, lf) ; 8 bytes for a single
;'#sertxdnl ; 12 bytes for a single
#endrem

#rem 71 bytes for 16
sertxd(cr, lf)
sertxd(cr, lf)
sertxd(cr, lf)
sertxd(cr, lf)
sertxd(cr, lf)
sertxd(cr, lf)
sertxd(cr, lf)
sertxd(cr, lf)
sertxd(cr, lf)
sertxd(cr, lf)
sertxd(cr, lf)
sertxd(cr, lf)
sertxd(cr, lf)
sertxd(cr, lf)
sertxd(cr, lf)
sertxd(cr, lf)
#endrem

#rem
; 62 for 16
;#sertxdnl
;#sertxdnl
;#sertxdnl
;#sertxdnl
;#sertxdnl
;#sertxdnl
;#sertxdnl
;#sertxdnl
;#sertxdnl
;#sertxdnl
;#sertxdnl
;#sertxdnl
;#sertxdnl
;#sertxdnl
;#sertxdnl
;#sertxdnl
#endrem