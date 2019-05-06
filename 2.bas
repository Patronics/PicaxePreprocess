
#define MAGIC_NUMBER "83838838"

#DEFINE SetBackLedOn	b0 =255 : toggle 2


#MACRO SerialMacro(leaf)

sertxd("this is a macro :)", leaf)

#ENDMACRO

#Macro Assign( var, expression )
  Let var = expression
#EndMacro

Assign( w0, 1 * 2 + 3 )

testloop:
	sertxd(MAGIC_NUMBER)
	SetBackLedOn
	SerialMacro("37")
	pause 1000
	toggle 1
return