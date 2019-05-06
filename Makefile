prog_port = $(shell ls /dev/tty.usbserial-*)

all: syntax slavesyntax


syntax: preprocess
	tr -d '\r' < compiled.bas > ./compilers/compiled.bas
	./compilers/c/picaxe28x2 -s ./compilers/compiled.bas

preprocess: fireFighter.bas include/40X2Symbols.bas include/sensorRoutines.bas
	./picaxepreprocess.py -i fireFighter.bas

compile: preprocess
	tr -d '\r' < compiled.bas > ./compilers/compiled.bas
	./compilers/c/picaxe28x2 -c$(prog_port) ./compilers/compiled.bas

slave: slave.bas include/28X2Symbols.bas
	./picaxepreprocess.py -i slave.bas -o slavecompiled.bas

slavesyntax: slave
	tr -d '\r' < slavecompiled.bas > ./compilers/slavecompiled.bas
	./compilers/c/picaxe28x2 -s ./compilers/slavecompiled.bas

slavecompile: slave
	tr -d '\r' < slavecompiled.bas > ./compilers/slavecompiled.bas
	./compilers/c/picaxe28x2 -c$(prog_port) ./compilers/slavecompiled.bas

clean:
	-rm compiled.bas
	-rm compilers/compiled.bas
	-rm slavecompiled.bas
	-rm compilers/slavecompiled.bas
	-rm *.err
	-rm compilers/*.err
