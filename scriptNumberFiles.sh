#!/bin/bash
# Script creado por David Peña
# Fecha: 17/05/2017
# Motivo: Script que cuenta el numero de ficheros en una ubicacion, si supera un número dado de ficheros, l 
# envía un correo indicando e estado.

correo=correo@correo.com
directorio=directorio
numFicherosDirectorio=$(cd $directorio && ls -l | wc -l)
max=15 #ES un ejemplo

if [$numFicherosDirectorio - ge $max]; then
        echo "Tenemos $numFicherosDirectorio ficheros en $directorio" | mail -s "Ficheros acumulados" $correo
        exit 0
    else
        echo "El estado de la ubicacion $directorio es correcto" | mail -s "Ficheros acumulados" $ correo
        exit 1
fi
