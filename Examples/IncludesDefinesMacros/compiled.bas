'-----PREPROCESSED BY picaxepreprocess.py-----
'----UPDATED AT 12:27AM, December 27, 2020----
'----SAVING AS compiled.bas ----

'---BEGIN main.bas ---
'main.bas is the default file included if no input argument passed
'---BEGIN 1.bas ---

goto init
'---BEGIN 2.bas ---

; #define MAGIC_NUMBER "83838838"

; #DEFINE SetBackLedOn	b0 =255 : toggle 2

'---BEGIN 4.bas ---
	toggle 2
	pause 500
	
'PARSED MACRO SetHeadingSpeed
#cOm /dev/null      'SERIAL PORT PARSED

SendHeadingSpeed:
	return
'---END 4.bas---

'PARSED MACRO SerialMacro
'PARSED MACRO Assign
'--START OF MACRO: Assign
  Let var = 1 * 2 + 3
'--END OF MACRO: Assign( w0, 1 * 2 + 3 )

testloop:
	sertxd("83838838")
	b0 =255 : toggle 2
	'--START OF MACRO: SerialMacro

sertxd("this is a macro :)", "37")

'--END OF MACRO: SerialMacro("37")
	pause 1000
	toggle 1
return
'---END 2.bas---
'the following line demonstrates absolute paths. uncomment and set to an absolute path that exists on your system to test.
'#include "/Users/patrickleiser/Documents/Programming/Robotics Club/PicaxeInclude/4.bas
; #define testing
; #define message sertxd("New Define")

'the following line demonstrates specifiying a picaxe variant in-line
'#picaxe 18M2

init:
toggle 1
main:
	gosub testloop
	toggle 2
	 '--START OF MACRO: SetHeadingSpeed
       w1 = 23
	b0 = 7
       Gosub SendHeadingSpeed
'--END OF MACRO: SetHeadingSpeed(23, 7)
	 pause 500
	 '--START OF MACRO: SetHeadingSpeed
       w1 = 92
	b0 = 34
       Gosub SendHeadingSpeed
'--END OF MACRO: SetHeadingSpeed(92,34)
	 
; 	 #ifdef testing
	 	sertxd("Old Defines Still Work")
; 	 #endif
	 sertxd("New Define")
	 
goto main

'---END 1.bas---
sertxd ("ending main.bas")

'---END main.bas---
