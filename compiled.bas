'-----PREPROCESSED BY picaxepreprocess.py-----
'----UPDATED AT 10:01PM, December 17, 2020----
'----SAVING AS compiled.bas ----

'---BEGIN main.bas ---
'main.bas is the default file included if no input argument passed
'---BEGIN 1.bas ---

goto init
'---BEGIN 2.bas ---

#define MAGIC_NUMBER "83838838"      'DEFINITION PARSED

#DEFINE SetBackLedOn	b0 =255 : toggle 2      'DEFINITION PARSED

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
  Let w0 = 1 * 2 + 3 
'--END OF MACRO: Assign( w0, 1 * 2 + 3 )

testloop:
	sertxd("83838838")      'DEFINE: "83838838" SUBSTITUTED FOR MAGIC_NUMBER
	b0 =255 : toggle 2      'DEFINE: b0 =255 : toggle 2 SUBSTITUTED FOR SetBackLedOn
	'--START OF MACRO: SerialMacro

sertxd("this is a macro :)", "37")

'--END OF MACRO: SerialMacro("37")
	pause 1000
	toggle 1
return
'---END 2.bas---
'the following line demonstrates absolute paths. uncomment and set to an absolute path that exists on your system to test.
'#include "/Users/patrickleiser/Documents/Programming/Robotics Club/PicaxeInclude/4.bas
#define testing      'DEFINITION PARSED
#define message sertxd("New Define")      'DEFINITION PARSED

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
	 
	 #ifdef testing
	 	sertxd("Old Defines Still Work")
	 #endif
	 sertxd("New Define")      'DEFINE: sertxd("New Define") SUBSTITUTED FOR message
	 
goto main

'---END 1.bas---
sertxd ("ending main.bas")

'---END main.bas---
