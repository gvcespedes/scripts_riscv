###############################
### Calculo de moda en arreglo ordenado
###############################
.global _mode
.data

moda: .word 0
len: .word 10
arr: .word 1, 2, 2, 4, 5, 5, 7, 7, 7, 10

.text
_mode:














la t0, arr		# Guardo la direccion base del arreglo
add t1, zero, zero	# Contador de iteraciones
lw t3, len		# Contador de iteraciones
add s0, zero, zero	# Contador de repeticiones de la moda
add s1, zero, zero	# Moda actual
add s2, zero, zero	# Contador de repeticiones de la moda actual

loop:
lw t2, 0(t0)
beq t2, s1, incrementar_moda_actual
bgt s2, s0, cambiar_moda
add s1, zero, t2
add s2, zero, zero

incrementar_moda_actual:
addi s2, s2, 1

addi t0, t0, 4
addi t1, t1, 1
blt t1, t3, loop
beq zero, zero, _end

cambiar_moda:
la t6, moda
sw s1, 0(t6)
add s0, zero, s1
add s1, zero, t2
add s2, zero, zero
beq zero, zero, incrementar_moda_actual

_end: