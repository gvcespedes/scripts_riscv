###############################
### Calculo de factorial recursivo
###############################
.global _main
.data
fact: 		.word 0
n:		.word 5

.text

_main:
beq zero, zero, _start

factorial:
addi t2, zero, 1
beq a0, t2, retornar
addi sp, sp, -8
sw ra, 0(sp)
sw a0, 4(sp)
addi a0, a0, -1
jal ra, factorial
lw ra, 0(sp)
lw a1, 4(sp)
addi sp, sp, 8
mul a0, a0, a1
jalr zero, 0(ra)

retornar:
jalr zero, 0(ra)


_start:
la t0, n
lw a0, 0(t0)
jal ra, factorial
sw a0, fact, t0