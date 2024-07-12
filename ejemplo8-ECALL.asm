.global _main 

.data

 area: .word 0
 altura: .word 0
 base: .word 0

.text 
_main:

####################################################
#### ECALLS
###########################
# Veremos ahora un ejemplo en donde se utilicen ecalls 
####################################################

addi a7, zero, 5 		# Guardamos en a7 un 5. Este valor en una ecall indica que queremos recibir un input por consola.
ecall				# Se realiza la ecall, el valor dado por la consola se guarda en el registro a0.
la t0, altura			# Se guarda la dirrecion de altura en t0.
sw a0, 0(t0)			# Se guarda el valor del registro a0 (input), en la memoria (altura).

ecall				# Se pide nuevamente un input, el valor dado por la consola se guarda en el registro a0.
la t0, base			# Se guarda la dirrecion de base en t0.
sw a0, 0(t0)			# Se guarda el valor del registro a0 (input), en la memoria (base).


calcular_area:			# Ahora a calcular el area
lw t0, altura			# Traemos de memoria el valor de la altura, lo guardamos en t0.
lw t1, base			# Traemos de memoria el valor de la base, lo guardamos en t1.

mul t3, t0, t1			# Multiplicamos la base por la altura y lo guardamos en t3.
addi t1, zero, 2		# La division solo se puede hacer entre registros, por lo que guardamos el 2 en el registro t1.
div t0, t3, t1			# Se divide el resultado de la multiplicacion en 2 y se guarda en t0.

la t1, area			# Se guarda la dirrecion de area en t1.
sw t0, 0(t1)			# Se guarda el valor del registro t0, en la memoria (area).

print:				# Ahora hagamos un print en consola
addi a7, zero, 1		# Guardamos en a7 el codigo del print (1).
add a0, zero, t0		# Guardamos en a0 el numero que queremos imprimir, en este caso nuestra area esta en t0
ecall				# Realizamos la ecall

