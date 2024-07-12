.global _main

.data

.text

_main:
beq zero, zero, call

####################################################
#### Subrutinas + Stack
###########################
# Veremos como hacer llamados a subrutinas y uso del stack.
####################################################


#########################
## CALL
# Veamos como se implementa el CALL. En RISC-V el CALL es equivalente a un salto en donde se recuerda la dirrecion (PC + 4) en donde fue llamado.
# A diferencia del assembly del computador basico, la direccion de retorno NO es almacenado en el stack de manera automatica.
# Si queremos respaldar la direccion de retorno en el stack debemos hacerlo nosotros.
#########################

addi a0, zero, 3
addi a1, zero, 2

call:
jal ra, func_1      # Salta a func_1 y guarda la direccion de retorno en ra. La direccion de retorno sera PC+4 porque queremos volver a la siguiente instruccion.
add t0, a0, zero    # Si retornamos bien, entonces se cargara en t0 el valor resultado de la subrutina.

func_1:
add a0, a0, a1      # Se guarda en a0 el valor de a0 mas a1.


######
# La funcion nunca retorna por lo que nunca se llega a guardar en t0 el valor de la suma. Ahora veremos como retornar.
######

#########################
## RET
# Veamos como se implementa el RET. En RISC-V el RET es equivalente a un salto a la direccion de retorno.
# La direccion de retorno se encuentra almacenada en el registro ra, pero no existe un salto (branch) que deje dar como argumento un registro para la direccion.
# Que hacemos? "Jump and link register". Este guarda la direccion de retorno, pero como no nos interesa la podemos almacenar en el registro zero. 
# Como el registro zero es read-only el valor se pierde.
#########################

addi a0, zero, 3
addi a1, zero, 2

ret:
jal ra, func_1_v2      # Salta a func_1 y guarda la direccion de retorno en ra. La direccion de retorno sera PC+4 porque queremos volver a la siguiente instruccion.
add t0, a0, zero    # Si retornamos bien, entonces se cargara en t0 el valor resultado de la subrutina.
beq zero, zero, push

func_1_v2:
add a0, a0, a1      # Se guarda en a0 el valor de a0 mas a1.
jalr zero, 0(ra)    # Salta a la direccion almacenda por el registro ra. El valor de retorno actual se "guarda" en zero.

######
# Ahora si, el t0 toma el valor que queriamos. Logramos retornar.
######


#########################
## PUSH
# Veamos como se implementa el PUSH. Para esto, debemos manualmente manejar el stack.
# Primero decrementamos el stack pointer segun la cantidad de registros a guardar. Esto es con el fin de alocar memoria.
# Se guarda desde la direccion del stack pointer los registros por guardar.
#########################

push:

push_un_registro:
addi t1, zero, 10       # Inicializamos el registro t1
addi sp, sp, -4         # Alocamos 4 bytes (un word) en la memoria del stack.
sw t1, 0(sp)            # Guardamos t1 en el stack. Es importante que tenga offset 0.

push_dos_registros:
addi t1, zero, 10       # Inicializamos el registro t1
addi t2, zero, 15       # Inicializamos el registro t2
addi sp, sp, -8         # Alocamos 8 bytes (dos words) en la memoria del stack.
sw t1, 0(sp)            # Guardamos t1 en el stack. Es importante que tenga offset 0.
sw t2, 4(sp)            # Ahora guardamos t2 en el stack. Este debe estar despues de t1, por lo que el offset debe ser 4.

push_tres_registros:
addi t1, zero, 10       # Inicializamos el registro t1
addi t2, zero, 15       # Inicializamos el registro t2
addi t3, zero, 20       # Inicializamos el registro t3
addi sp, sp, -12        # Alocamos 12 bytes (tres words) en la memoria del stack.
sw t1, 0(sp)            # Guardamos t1 en el stack. Es importante que tenga offset 0.
sw t2, 4(sp)            # Ahora guardamos t2 en el stack. Este debe estar despues de t1, por lo que el offset debe ser 4.
sw t3, 8(sp)            # Ahora guardamos t3 en el stack. Este debe estar despues de t2, por lo que el offset debe ser 8.

######
# La cantidad de espacio que hay que alocar depende de la cantidad de registros que se deben guardar.
# Espacio por alocar : 4 * cantidad_de_registros
######

#########################
## POP
# Veamos como se implementa el POP. Para esto, debemos manualmente manejar el stack.
# Primero recuperamos los registros. Hay que hacer un load word hacia los registros desde lo que indique el stack pointer.
# Por cada registro incrementamos el offset en 4.
# Despues de recuperar los registros, des-alocamos la memoria. Incrementamos el stack pointer segun la cantidad de registros que se "sacaron" del stack.
#########################

pop:


pop_un_registro:
lw t1, 0(sp)            # Guardamos el valor que indica sp en t1. Es importante que tenga offset 0.
addi sp, sp, 4          # Des-alocamos 4 bytes (un word) en la memoria del stack.

pop_dos_registros:
lw t1, 0(sp)            # Guardamos el valor que indica sp en t1. Es importante que tenga offset 0.
lw t2, 4(sp)            # Ahora guardamos el valor que indica sp+4 en t2. El offset debe ser 4.
addi sp, sp, 8          # Des-alocamos 8 bytes (dos words) en la memoria del stack.

pop_tres_registros:
lw t1, 0(sp)            # Guardamos el valor que indica sp en t1. Es importante que tenga offset 0.
lw t2, 4(sp)            # Ahora guardamos el valor que indica sp+4 en t2. El offset debe ser 4.
lw t3, 8(sp)            # Ahora guardamos el valor que indica sp+8 en t3. El offset debe ser 8.
addi sp, sp, 12         # Des-alocamos 12 bytes (tres words) en la memoria del stack.


######
# La cantidad de espacio que hay que des-alocar depende de la cantidad de registros que se deben guardar.
# Espacio por des-alocar : 4 * cantidad_de_registros
#
# Es el proceso inverso al PUSH. Primero recuperamos los registros y despues se des-aloca.
######

#########################
#### RESUMEN
## CALL
# jal ra, label
#
## RET
# jalr zero, 0(ra)
#
## PUSH
# addi sp, sp, -4
# sw reg, 0(sp)
#
## POP
# lw reg, 0(sp)
# addi sp, sp, 4
#########################
