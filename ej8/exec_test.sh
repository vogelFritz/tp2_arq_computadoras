nasm -f elf64 print_turned_bits_test.asm
nasm -f elf64 turned_bits_amount.asm
nasm -f elf64 print_unsigned_int.asm
ld turned_bits_amount.o print_turned_bits_test.o print_unsigned_int.o -o print_turned_bits_test
./print_turned_bits_test