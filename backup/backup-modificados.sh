#!/bin/bash
##Copias de seguridad de modificados
##Para sistemas operativos GNU Linux

#Declaración de variable IFS
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

#Utilizamos el comando find para buscar los ficheros modificados en el último día
#La salida se almacenará en el fichero resultado.txt

find /home/usuario/ -type f -mtime +0  -mtime -1  > resultado.txt

#Hemos buscando los ficheros modificados dentro de la carpeta de usuario en el 
#último día.

#A continuación leemos el fichero y generamos un ficheros comprimido con los 
#ficheros modificados.

tar cvf /home/usuario/scripts/backup.tar resultado.txt

for i in $(cat resultado.txt); do
          tar rvf /home/usuario/scripts/backup.tar "$i"
done

IFS=$SAVEIFS

#Utilizando la variabe i leemos el fichero txt, utilizando for, para guardar
#cada fichero y comprimirlo en backup.tar , por último reseteamos la variable
#IFS

