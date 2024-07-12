# ManuOS
A hobby os written in C and asm.
## Features
- Two editions, C and asm
- C edition is written in C and asm, full version
- Asm edition is written only in asm, minimal version
- 16-bit operating system
- Real Mode
## Programs
- Wuf++ interpreter
- Text editor

## Wuf++ language
**Wuf++**(wuf plus plus) is a low-level programming language. Can be interpreted or compiled.
### Registers:
- **bx** - main register, bl mainly used
- **cx** - main pointer
- **sp** - stack pointer
- **dx** - temp register
- **pc** - program counter, instruction pointer
### Syntax:
- **+** - increment main register, *bx = bx + 1*
- **-** - decrement main register, *bx = bx - 1*
- **}** - push main register to stack, *[sp+2] = bx*
- **{** - pop main register from stack, *bx = [sp-2]*
- **.** - print main register as ascii character
- **,** - read ascii character to main register
- **&** - jump to location pointed by pointer, *pc = cx*
- **]** - jump to location pointed by instruction pointer + main pointer, *pc = pc + cx*
- **[** - jump to location pointed by instruction pointer - main pointer, *pc = pc - cx*
- **!** - invert main register, *bx = ~bx*
- **>** - increment pointer, *cx = cx + 1*
- **<** - decrement pointer, *cx = cx - 1*
- **$** - print pointer as ascii character
- **#[char]** - load char to main register
- **(** - loop start, loads dx with loop start address, *dx = pc*
- **)** - loop end, decrement pointer and loop until pointer = 0, *cx = cx - 1, if cx != 0 jump to dx*
- **"** - swap registers, *bx = dx, dx = bx*
- **%[char]** - compare main register with char, jump if equal to location pointed by pointer, *if bx == char jump to cx*
- **=** - halt program, *halt = 1*
- **/** - add main register and pointer, *bx = bx + cx*
- **\\** - sub main register and pointer, *bx = bx - cx*
- **@** - load zero to main register, *bx = 0*
- **^** - swap bl with bh, *bx = bh, bh = bl*

### Code examples:
#### Hello World
```wpp
#H.#e.l.#l.#o.# #W.#o.#r.#l.#d.=
```

## WIC
**WIC**(wuf++ interpreter compiler) is a compiler and interpreter for the Wuf++ language. A file can be compiled or interpreted. Nasm is used for compilation. C++ is used for interpretation.
### Command line arguments:
- **-s** - source file
- **-o** - output file
- **-c** - compile
- **-i** - interpret
- **-h** - help
- **-v** - version

An example of using the compiler:
```bash
wic -c -s example.wpp -o example
```
An example of using the interpreter:
```bash
wic -i -s example.wpp
```
