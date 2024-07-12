.global _main

.data

.text 
_main: 

####################################################
#### Revisemos las instrucciones de la ALU
####################################################

addi t1, zero, 10	# Partimos cargando los valores en los registros t1 y t2
addi t2, zero, 3

add:
add t0, t1, t2		# Se puede hacer la suma entre dos registros
addi t0, t1, 6		# Se puede hacer la suma entre un registro y literal

sub:
sub t0, t1, t2		# Se puede hacer la resta entre dos registros
neg t3, t2		# Tambien esta la opcion de calcular el complemento de 2 de un registro
add t0, t2, t3
addi t0, t1, -4		# No se puede realizar la resta con un literal, 
			# pero si la suma con un literal negativo
and:
and t0, t1, t2		# Se puede hacer un and entre dos registros
andi t0, t1, 8		# Se puede hacer un and entre un registro y literal

or:
or t0, t1, t2		# Se puede hacer un or entre dos registros
ori t0, t1, 5		# Se puede hacer un or entre un registro y literal

xor:
xor t0, t1, t2		# Se puede hacer un xor entre dos registros
xori t0, t1, 5		# Se puede hacer un xor entre un registro y literal

not:
not t0, t1		# Se puede hacer un not a un registro

shift_right_logico:
srl t0, t1, t2		# Se puede hacer shift right logico, se hace shift t2 veces a t1
srli t0, t1, 1		# Se puede hacer shift right logico, se hace shift
			# la cantidad indicada por el literal a t1
shift_left_logico:
sll t0, t1, t2		# Se puede hacer shift left logico, se hace shift t2 veces a t1
slli t0, t1, 1		# Se puede hacer shift left logico, se hace shift
			# la cantidad indicada por el literal a t1
shift_right_aritmetico:
sra t0, t1, t2		# Se puede hacer shift right aritmstico, se hace shift t2 veces a t1
srai t0, t1, 1		# Se puede hacer shift right aritmstico, se hace shift
			# la cantidad indicada por el literal a t1

####################################################
#### BONUS!!!!
####################################################

multiplicacion:
mul t0, t1, t2		# Se puede calcular la multiplicacion de dos registros

division:
div t0, t1, t2		# Se puede hacer la division entre dos registros, recordar que son numeros enteros, por lo que los resultados estaran truncados.
divu t0, t1, t2		# Se puede hacer la division entre dos registros sin signo.

resto:
rem t0, t1, t2		# Tambien se puede calcular el resto de una division entre dos registros.
remu t0, t1, t2		# Tambien se puede calcular el resto de una division entre dos registros sin signo.