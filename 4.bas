	toggle 2
	pause 500
	
#MACRO SetHeadingSpeed(H, S)
       w1 = H
	b0 = S
       Gosub SendHeadingSpeed
#ENDMACRO


SendHeadingSpeed:
	return