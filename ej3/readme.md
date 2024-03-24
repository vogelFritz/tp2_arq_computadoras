```nasm -f elf64 ej3.asm -o ej3.o```
```ld ej3.o -o ej3```

# Compile and execute in one command
```nasm -f elf64 ej3.asm -o ej3.o && ld ej3.o -o ej3 && ./ej3```

# vmt command
```wine ./vmt.exe aux.asm ej3.vmx -o```