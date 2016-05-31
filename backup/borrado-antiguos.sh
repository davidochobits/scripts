#!/bin/bash
##Autor: davidochobits
##Guión para el borrado de ficheros antiguos modificados
##utilizando el comando find

echo "¿Cuantos días hacia atrás quieres eliminar los ficheros?"
#Lee el valor del teclado
read var1

if [ -z "$var1" ];
then
	echo "No ha introducido un valor numérico"
	exit;
fi


find $HOME/* -mtime +$var1 -exec rm {} \;
