
.global _main 

.data 

.text 

_main: 

####################################################
#### SALTOS!!!!
####################################################

salto_incondicional:			# No existen los saltos incondicionales, pero se pueden realizar a partir de otros saltos.	
beq zero, zero, branch_if_equal		# Si hacemos un salto branch if equal entre el mismo registro, siempre sera cierto.
addi t0, zero, 1

branch_if_equal:
addi t1, zero, 4			# Guardamos en t1 = 4
add t2, t1, zero			# Guardamos en t2 = t1= 4
beq t1, t2, branch_if_not_equal		# Saltamos si t1 = t2 a branch_if_not_equal, como son igual deberia saltar.
addi t0, zero, 2			# Si no salta, ejecuta este codigo
beq zero, zero, end

branch_if_not_equal:
addi t2, t2, 1				# Guardamos en t2 = t2 + 1 = 5
bne t1, t2, branch_if_less_than		# Saltamos si t1 != t2 a branch_if_less_than. Deberiamos saltar.
addi t0, zero, 3			# Si no salta, ejecuta este codigo
beq zero, zero, end

branch_if_less_than:
blt t1, t2, branch_if_greater_equal	# Saltamos si t1 < t2 a branch_if_greater_equal. Deberiamos saltar.
addi t0, zero, 4			# Si no salta, ejecuta este codigo
beq zero, zero, end

branch_if_greater_equal:
addi t1, t1, 4				# Guardamos en t1 = t1 + 4 = 8
bge t1, t2, branch_if_less_equal	# Saltamos si t1 >= t2 a branch_if_less_equal. Deberiamos saltar.
addi t0, zero, 5			# Si no salta, ejecuta este codigo
beq zero, zero, end

branch_if_less_equal:
add t1, t2, zero			# Guardamos en t1 = t2 + 0 = 5
ble t1, t2, branch_if_greater_than	# Saltamos si t1 <= t2 a branch_if_greater_than. Deberiamos saltar
addi t0, zero, 6			# Si no salta, ejecuta este codigo
beq zero, zero, end

branch_if_greater_than:
addi t1, t1, 4				# Guardamos en t1 = t1 + 4 = 9
bgt t1, t2, end				# Saltamos si t1 > t2 a end. Deberiamos saltar
addi t0, zero, 7			# Si no salta, ejecuta este codigo
beq zero, zero, end

end:
