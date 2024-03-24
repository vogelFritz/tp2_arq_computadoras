nasm -f elf64 ej5.asm
nasm -f elf64 multiply.asm
nasm -f elf64 print_unsigned_int.asm
ld ej5.o multiply.o print_unsigned_int.o -o ej5
./ej5