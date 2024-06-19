build:
	nasm -f elf64 -o ./aread.o ./aread.asm
	ld ./aread.o -o aread

install:
	cp ./aread /usr/bin

clean:
	rm ./aread.o ./aread

