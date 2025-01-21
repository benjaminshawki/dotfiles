# Compiler

# Fetch execute cycle

# C

## Commands

- `gcc -E main.c -o main.i` - Preprocess
- `gcc -S main.i -o main.s` - Compile
- `as main.s -o main.o` - Assemble
<!-- - `gcc -c main.s -o main.o` - Assemble -->
- `objdump -d main.o` - Disassemble

## Link step

- `ld /usr/lib/crti.o /usr/lib/crtn.o /usr/lib/crt1.o -lc main.o -dynamic-linker /lib64/ld-linux-x86-64.so.2 -o main`

## TODO
Look up man for `gcc -E main.c -o main.i` and `gcc -S main.i -o main.s` and `gcc -c main.s -o main.o` and `gcc main.o -o main`

Look up the crti.o, crtn.o, crt1.o, ld-linux-x86-64.so.2

Look up `Tree shaking` and `Dead code elimination`

