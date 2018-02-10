sufsort: sufsort.o asm_io.o
	gcc -m32 -o sufsort sufsort.o driver.c asm_io.o
asm_io.o: asm_io.asm
	nasm -f elf32 -d ELF_TYPE asm_io.asm
sufsort.o: sufsort.asm
	nasm -f elf32 sufsort.asm
clean:
	rm sufsort.o sufsort	
