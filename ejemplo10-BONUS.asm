.global _main 

.data 
len: .word 11
notes: .word 79, 78, 83, 76, 74, 79, 72, 71, 76, 69, 74
times: .word 2000, 1000, 1000, 2000, 1000, 1000, 2000, 1000, 1000, 2000, 1500

.text 
_main: 
addi a7, zero, 31
addi a0, zero, 79
addi a1, zero, 500
addi a2, zero, 0
addi a3, zero, 0
ecall
addi a1, zero, 500
jal ra, Sleep
beq zero, zero, _play

Sleep: 				
sw a7, 0(sp)
addi a7, zero, 32		
addi a0, a1, -100
ecall				
lw a7, 0(sp)
jalr zero, 0(ra)		


_play:
addi a7, zero, 31
addi a2, zero, 0
addi a3, zero, 127
la t0, notes
la t1, times
add t2, zero, zero
lw t3, len

loop:
lw a0, 0(t0)	
lw a1, 0(t1)		
ecall	
jal ra, Sleep
addi t0, t0, 4
addi t1, t1, 4
addi t2, t2, 1
bne t2, t3, loop

beq zero, zero, _play
