.global _main 

.data 
text1: .string "Hola! Vamos a aprender como usar ECALL! Yayyyy!"
text2: .string "\nAhora leeremos un input desde consola.\nIngrese un numero: "
text3: .string "\nAhora imprimiremos un numero entero.\nImprimiremos el numero ingresado anteriormente -> "
text4: .string "\nAhora leeremos el directorio actual -> "
text5: .string "\nSeteamos una seed para generar numeros random."
text6: .string "\nAhora generamos un numero random -> "

current_directory: .space 100 # Reservo 100 bytes de espacio en memoria para el buffer de directorio

.text 
_main: 

beq zero, zero, _start

####################################################
#### ECALLS
###########################
# OJO!!! La mayoria de las ECALLS que se ven no son necesarias pero pense que quedarian bonitas jijiji
# Recomiendo "saltarse" las primeras ECALLS definidas y verlas cuando se entienda mejor como funcionan y el uso del stack.
# Idealmente partir en _start.
####################################################

#########################
## PrintString	-> Codigo = 4
# Se imprime un string en consola.
#########################

printString: 			# Aprendamos como imprimir un string, realmente no lo vamos a usar, pero quedara mas bonito :)
addi a7, zero, 4		# Para imprimir un string debemos guardar en a7 un 4 y en a0 la direccion en donde se encuentra el string.
ecall				# Se realiza la ECALL.
addi ra, ra, -4			# Cada vez que hagamos un printString queremos dormir el programa por lo que llamaremos a la subrutina Sleep.
sw ra, 0(sp)			# Se respalda ra en el stack
jal ra, Sleep			# Se llama a la subrutina.
lw ra, 0(sp)			# Se trae nuevamente el valor original de ra.
addi ra, ra, 4			# Se "des-aloca" la memoria del stack.
jalr zero, 0(ra)		# Se retorna.

#########################
## Sleep	-> Codigo = 32
# Duerme el programa por a0 milisegundos.
#########################

Sleep: 				# Aprendamos a dormir el programa, realmente no lo vamos a usar, pero quedara beio beio
addi a7, zero, 32		# Para dormir el programa guardamos en a7 un 32.
addi a0, zero, 2000		# En a0 se guarda la cantidad de milisegundos que debe dormir el programa. En este caso 2.
ecall				# Se realiza la ECALL.
jalr zero, 0(ra)		# Retornamos



_start:
la a0, text1			# Cargamos la direccion del mensaje de bienvenida.
jal ra, printString		# Llamamos a la subrutina que imprime strings.


#########################
## ReadInt	-> Codigo = 5
# Se toma como input en consola un numero entero.
#########################

la a0, text2			# Cargamos la direccion del segundo mensaje.
jal ra, printString		# Llamamos a la subrutina que imprime strings.
ReadInt:
addi a7, zero, 5		# Para leer inputs debemos cargar un 5 en el registro a7.
ecall				# Se realiza la ECALL. El input ingresado es guardado en el registro a0.
add t0, zero, a0		# Guardaremos temporalmente el valor en t0


#########################
## PrintInt	-> Codigo = 1
# Se imprime un numero entero en consola.
#########################

la a0, text3			# Cargamos la direccion del tercer mensaje.
jal ra, printString		# Llamamos a la subrutina que imprime strings.
printInt:
addi a7, zero, 1		# Para imprimir numeros en consola debemos cargar un 1 en el registro a7.
add a0, zero, t0		# Guardamos el numero que queremos imprimir en el registro a0.
ecall				# Se realiza la ECALL.

#########################
## GetCWD	-> Codigo = 17
# Obtiene el directorio actual en donde se ejecuta el programa.
#########################

la a0, text4			# Cargamos la direccion del cuarto mensaje.
jal ra, printString		# Llamamos a la subrutina que imprime strings.
GetCWD:
addi a7, zero, 17		# Para obtener el directorio debemos cargar un 17 en el registro a7.
la a0, current_directory	# Guardamos en a0 la ubicacion en donde queremos que se escriba el directorio.
addi a1, zero, 100		# Damos un largo maximo de 100 bytes al nombre del directorio.
ecall				# Se realiza la ECALL. Guardará el nombre en la memoria indicado por a0.
jal ra, printString		# Llamamos a la subrutina que imprime strings para imprimir el directorio.



#########################
## RandSeed	-> Codigo = 40
# Setea una seed para generar numeros pseudo random.
#########################

la a0, text5			# Cargamos la direccion del quinto mensaje.
jal ra, printString		# Llamamos a la subrutina que imprime strings.
SetSeed:
addi a7, zero, 40		# Se guarda el codigo 40 en a7 para setear la seed.
addi a0, zero, 100 		# Se guarda en a0 el indice para generar los numeros.
addi a1, zero, 100		# Se guarda en a1 el seed para generar los numeros random.
ecall				# Se realiza la ECALL.

#########################
## RandInt	-> Codigo = 41
# Genera un numero random.
#########################

la a0, text6			# Cargamos la direccion del sexto mensaje.
jal ra, printString		# Llamamos a la subrutina que imprime strings.
random:
addi a7, zero, 41		# Se guarda el codigo 41 en a7 para generar un numero random.
addi a0, zero, 40 		# Se guarda en a0 el indice para generar los numeros.
ecall				# Se realiza la ECALL. Guardará en a0 el entero generado.
addi a7, zero, 1		# Imprimimos el numero.
ecall


#########################
## MidiOut	-> Codigo = 31
# Emite un sonido MIDI. No espera.
#########################

MIDI:
addi a7, zero, 31		# Para hacer sonar una nota hay que guardar un 31 en el registro a7.
addi a0, zero, 62		# Se guarda el tono en a0.
addi a1, zero, 2000		# Se guarda la cantidad de milisegundos que la nota debe sonar.
addi a2, zero, 1		# Se elige el instrumento.
addi a3, zero, 127		# Se elige el volumen.
ecall				# Se realiza la ECALL.

jal ra, Sleep			# Dormimos el programa para que alcance a sonar.

#########################
## MidiOutSync	-> Codigo = 33
# Se imprime un string en consola. Espera.
#########################

MIDISync:
addi a7, zero, 33		# Para hacer sonar una nota hay que guardar un 31 en el registro a7.
addi a0, zero, 79		# Se guarda el tono en a0.
addi a1, zero, 2000		# Se guarda la cantidad de milisegundos que la nota debe sonar.
addi a2, zero, 1		# Se elige el instrumento.
addi a3, zero, 127		# Se elige el volumen.
ecall				# Se realiza la ECALL.	
