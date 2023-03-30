#picaxe 08m2
#DEFINE TABLE_SERTXD_USE_EEPROM
#DEFINE TABLE_SERTXD_MEM_OFFSET 10
;symbols representing constants can be printed without issue
symbol c5 = $c5
main:
    ;#sertxd("Hello World", cr, lf)
    ;#sertxd("That's an annoying line!", cr,lf,"(because of all the characters that can be in a string;",cr, lf, "such as ',', ''', ';', ')', '(', ']', '[', ':', '#', ...")
    ;#sertxd("This line contains dynamic content that can't be printed", #w0)
    ;#sertxd("more:", w0, b12, c5)
    ;#sertxd("a bit more:", bit4)
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
