#!/bin/sh
##Programar copia de seguridad base de datos MYSQL o MariaDB
##Con MYSQLDUMP


#Debemos crear un fichero de crendenciales
echo 'Introduzca nombre de usuario de la base de datos:'
#Lee el valor del teclado
read var1

if [ -z "$var1" ];
then
	echo "No ha introducido un nombre de usuario"
        exit;
fi

#Preguntamos la credencial
echo 'Introduzca la credencial del usuario:'
#Lee el valor del techado
read var2

if [ -z "$var2" ];
then
	echo "No ha introducido una credencial"
	exit;
fi

touch $HOME/.credenciales.cnf
chmod 600 $HOME/.credenciales.cnf
echo "[mysqldump]" > $HOME/.credenciales.cnf
echo "user=$var1" >> $HOME/.credenciales.cnf
echo "password=$var2" >> $HOME/.credenciales.cnf

#Preguntamos sobre la base de datos
echo "¿Cuál es el nombre de la base de datos?
#Se lee el valor
read var3


if [ -z "$var3" ];
then
        echo "No ha introducido una credencial"
        exit;
fi

mysqldump --defaults-file=$HOME/.credenciales.cnf $var3 >$HOME/"backup-$(date+ "%d%m%Y").sql"

echo "Se ha creado la copia de seguridad de la base de datos $var3 "
echo ""



