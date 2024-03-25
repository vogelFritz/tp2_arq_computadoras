nasm -f elf64 ej8.asm
nasm -f elf64 get_array.asm
nasm -f elf64 string_to_int.asm
nasm -f elf64 turned_bits_amount.asm
nasm -f elf64 print_unsigned_int.asm
ld ej8.o get_array.o string_to_int.o turned_bits_amount.o print_unsigned_int.o -o ej8
./ej8