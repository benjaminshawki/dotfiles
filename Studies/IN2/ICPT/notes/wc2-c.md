# Notes van Ron in het WC

# General notes

## 2 types of systemc, Compiled languages and interperted languages
In a compiled language the source code is transformed into machine code before the program is run.
This means that the program is run directly from the machine code.
This makes the program run faster than an interpreted language.
The downside is that the program has to be compiled before it can be run.
This means that the program has to be compiled for every system it has to run on.
This makes it harder to run the program on multiple systems.

### Compiled languages
Code -> Compiler -> Binary, Assembly -> CPU

Preprocessor -> Compiler -> Assembler -> Linker ( -> Loader -> CPU)

#### Preprocessor
The preprocessor is used to include libraries and other files in the source code.
It also removes comments and other things that are not needed in the source code.

In C this is the `main.i` file.

1. `gcc -E main.c -o main.i`

#### Compiler
The compiler is used to transform the source code into machine code.
The compiler checks the source code for errors and warnings.

In C this is the `main.s` file.

2. `gcc -S main.i -o main.s`

#### Assembler
The assembler is used to transform the machine code into assembly code.
The assembly code is a human readable version of the machine code.

`as main.s -o main.o`

#### Linker

#### Step by step commands in C
- `gcc -E main.c -o main.i` - Preprocess
- `gcc -S main.i -o main.s` - Compile
- `as main.s -o main.o` - Assemble
<!-- - `gcc -c main.s -o main.o` - Assemble -->
- `objdump -d main.o` - Disassemble

#### List of compiled languages
- C
- Pascal
- Go

### Interpreted languages
Code -> Interpreter -> CPU

Interpreted languages sometimes use P-code.
P-code is a intermediate language that is used by the interpreter.

Interpreted is done in Runtime

#### List of interpreted languages
- Python
- JavaScript
- Lua
- PHP
- Java
- C#


# C

# Processors

# 1'en en nullen

# Compilers

# Opdracht
Maak hoofdstuk 2 en beschrijf en maak de stappen van het compileren van een programma in C.
