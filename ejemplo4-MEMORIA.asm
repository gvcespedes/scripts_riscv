
.global _main 

.data 

n: .word 4
arr: .word 10, 12, 5, 3 # Un word corresponde a un valor de 4 bytes (32 bits)

.text 

_main: 

####################################################
#### Memoria + offset
###########################
# Vamos a empezar a ver codigmo mas complejo en que les puede ser mas util, en particular, como recorrer una lista almacenada en memoria
####################################################


# Veamos como recorrer una lista de varias formas

la t0, arr	# Guardamos la direccion base de la lista en el registro t0
lw t1, n	# Guardamos el valor del largo de la lista en el registro t1

#########################
## OJO!!!
# Aca se esta usando dos instrucciones distintas.
# - la: Guarga la direccion de memoria a la que equivale ese label.
# - lw: Guarda el valor almacenado en memoria en la direccion indicada por el label.
#########################


###########################################################
### Veamos como acceder a un elemento especifico del arreglo
# Para esto haremos uso de los offsets.
# El offset indica cuantas direcciones me debo mover desde la direccion base, la cual esta entre los parentesis.
# Como cada palabra es de 4 bytes, nos debemos mover 4 direcciones para leer la siguiente palabra almacenada en memoria.
###########################################################

# Primero traigamos el primer elemento del arreglo
lw t2, (t0)	# Se puede traer el valor sin indicar el offset
lw t2, 0(t0)	# Es mejor que siempre indiquen el offset, aunque este sea 0.

# Ahora traigamos el segundo elemento del arreglo
lw t2, 4(t0)	# El offset debe ir de 4 en 4, entonces debe ser 4 * 1

# Ahora el terder elemento del arreglo
lw t2, 8(t0)	# El offset debe ser 4 * 2

# Ahora el cuarto elemento del arreglo
lw t2, 12(t0)	# El offset debe ser 4 * 3

###########################################################
### Veamos como acceder a un elemento especifico del arreglo
### (sin saber la direccion a priori)
# No siempre vamos a saber el largo del arreglo, puede ser variable, por lo que el metodo especificado anteriormente
# puede no ser muy util para todos los casos. 
# Podemos recorrer un arreglo de largo variable sumando 4 a la direccion anterior hasta llegar al largo maximo.
###########################################################

add t3, zero, zero	# Inicializamos el registro t3, este sera nuestro iterador
loop:
lw t2, 0(t0)		# Se guarda en t2 el valor almacenado en la memoria en la direccion t0 + 0.
addi t3, t3, 1		# Se incrementa el contador en 1
addi t0, t0, 4		# Se suma 4 a la direccion.
bne t3, t1, loop	# Si el contador no es igual al largo de la lista, se salta a loop y se sigue recorriendo.
