#picaxe 14m2

;#sertxd("Hello World", cr, lf)
;#sertxd("That's a really annoying line!", cr,lf,"(because of all the characters that have to be ignored when in a string;",cr, lf, "such as ',', ''', ';', ')', '(', ']', '['m ':', '#', '\', ...")
;#sertxd("This line contains dynamic content that cannot be printed", #w0)

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