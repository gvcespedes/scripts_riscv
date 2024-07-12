.global _main

.data

.text
_main:
beq zero, zero, _start

func_1:				# No importa lo que haga func_1, solo que llama a una subrutina dentro de el.
add a0, a3, a1
sub a1, a3, a1
				# Como se hace un llamado a una subrutina (dentro de una subrutina), se DEBE respaldar el registro ra
addi sp, sp, -4			# Primero alocamos la memoria. Como solo guardaremos un registro restaremos 4 al stack pointer.
sw ra, 0(sp)			# Se guarda el registro ra en donde indique el sp.

jal ra, func_2			# Se llama a la subrutina. Se guarda la direccion de retorno en ra (por eso lo respaldamos, no queremos sobreescribirla).

lw ra, 0(sp)			# Al retornar volvemos aca. Queremos recuperar el registro ra, buscamos en la memoria donde indique el sp.
addi sp, sp, 4			# Ya que "sacamos" el valor, incrementamos el stack pointer en 4. "Des-alocamos" la memoria.

jalr zero, 0(ra)		# Retornamos. Se hace un "jump and link register". Se salta a la direccion indicada por el registro ra 
				# y se guarda en el registro zero la direccion de retorno actual (PC + 4). Como no nos interesa volver a este punto,
				# guardamos en el registro zero el valor, como este registro es read-only, el valor es "quemado" y nos olvidamos de el :)

func_2:				# Nuevamente no nos importa que realice esta funcion, solo queriamos hacer un llamado anidado.
add a0, a0, a1
jalr zero, 0(ra)		# Retornamos a la direccion indicada por el registro ra.


_start:
addi a3, zero, 5		# Inicializamos los argumentos.
addi a1, zero, 3		# Inicializamos los argumentos.
jal ra, func_1			# Se llama a la subrutina. Se salta a func_1 y se guarda en ra la direccion de retorno (PC + 4).
addi a7, zero, 1		# Se imprime el resultado que se encuentra en el registro a0. Si no se sabe imprimir revisar ejemplo de ecalls.
ecall				# Se realiza la ECALL.
