.global _main
.data

.text
_main:
beq zero, zero, _start

mult:				# Hacemos una subrutina que multiplique
add a3, a3, a0			# Se guarda en el resultado, el resultado mas el primer operando.
addi a2, a2, 1			# Se incrementa en 1 el iterador.
bne a2, a1, mult		# Si iterador es distinto al valor del segundo operando, se salta a mult y se sigue sumando.
add a0, zero, a3		# Si se termina la multiplicacion, se guarda el valor de la multiplicacion en el registro a0 para retornar.
jalr zero, 0(ra)		# Se retorna.


_start:
addi a0, zero, 5		# Se guarda en a0 el primer operando.
addi a1, zero, 3		# Se guarda en a1 el segundo operando.
addi a2, zero, 0 		# Se guarda en a2 el iterador.
addi a3, zero, 0		# Se guarda en a3 la suma.
jal ra, mult			# Se llama a la subrutina. Todos los registros a0-a3 los estamos usando de parametros.

print:
addi a7, zero, 1		# Imprimimos el resultado, este ya se encuentra en el registro a0.
ecall				# Se realiza la ECALL

