# Computer Architecture Assembly Tasks (IY497)

## Overview
This repository contains my **Computer Architecture (IY497)** practical assignment implemented in **x86 Assembly (NASM)** for **Linux 32-bit**, using `int 0x80` system calls.

The assignment demonstrates:
- Floating-point arithmetic (x87 FPU)
- Subroutines (procedures)
- Loops and multiplication-based factorial logic
- Integer to string conversion for console output

> Note: The original assignment specification references MIPS registers, but my implementation is written in NASM x86 for Linux.

---

## Files

### 1) `Project_task1.asm` — Formula Calculation
Implements the computation:

**A = (π × R² × b) / 2**

- Uses x87 FPU instructions (`fld`, `fmul`, `fdiv`)
- Converts the final float result to an integer using `fistp`
- Prints the result to the console

---

### 2) `Project_task2Q2.asm` — Prime Factorials (Primer)
Implements:
- `factorial` subroutine to compute n!
- `Primer` subroutine to compute prime factorials for a set of primes (2, 3, 5, 7, 11)
- Prints each factorial result

---

### 3) `Project_task2Q3.asm` — Polynomial Solver
Solves a 4-term polynomial using variables derived from my name:

**Result = A² + T + (R × A) + 5**

- Demonstrates exponentiation (square), multiplication between two variables, and multiple terms
- Prints the final result

---

## Requirements
- Linux environment capable of running **32-bit executables**
- NASM assembler
- `ld` linker

On Ubuntu/Debian, you may need:
- `nasm`
- 32-bit support packages (if required)

---

## How to Build and Run

### Task 1
```bash
nasm -f elf32 Project_task1.asm -o task1.o
ld -m elf_i386 task1.o -o task1
./task1
