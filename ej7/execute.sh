nasm -f elf64 ej7.asm
nasm -f elf64 is_prime.asm
ld is_prime.o ej7.o -o ej7
./ej7