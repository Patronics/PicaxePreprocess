#picaxe 20m2
#DEFINE TABLE_SERTXD_MEM_OFFSET 10
#DEFINE TABLE_SERTXD_ADDRESS_VAR w10
#DEFINE TABLE_SEROUT_BAUD N4800
#DEFINE TABLE_SEROUT_PIN C.0


;symbols representing constants can be printed without issue
symbol c5 = $c5
b0=0
main:
    inc b0
    ;#sertxd("Hello World", cr, lf)
    ;#sertxd("That's an annoying line!", cr,lf,"(because of all the characters that can be in a string;",cr, lf, "such as ',', ''', ';', ')', '(', ']', '[', ':', '#', ...")
    sertxd(#b0)
    ;#serout(254, 1)
    pause 50
    ;#serout(254, 128)
    serout C.0, N4800, (#b0)
    ;#serout(" can use other pins too")
    ;#serout(254,192,"using serout instead of sertxd")
    pause 5000
    goto main

