nasm -f elf64 ej6.asm
nasm -f elf64 div.asm
ld ej6.o div.o -o ej6
./ej6