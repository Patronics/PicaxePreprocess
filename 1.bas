
goto init
#include "2.bas"    ;test
'the following line demonstrates absolute paths. uncomment and set to an absolute path that exists on your system to test.
'#include "/Users/patrickleiser/Documents/Programming/Robotics Club/PicaxeInclude/4.bas
#define testing
#define message sertxd("New Define")

'the following line demonstrates specifiying a picaxe variant in-line
'#picaxe 18M2

init:
toggle 1
main:
	gosub testloop
	toggle 2
	 SetHeadingSpeed(23, 7)
	 pause 500
	 SetHeadingSpeed(92,34)
	 
	 #ifdef testing
	 	sertxd("Old Defines Still Work")
	 #endif
	 message
	 
goto main
