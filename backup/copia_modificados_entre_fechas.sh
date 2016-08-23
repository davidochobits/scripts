#!/bin/bash

# Autor: davidochobits, basado en idea original de karpoke
# Calcula el número de día desde una fecha en el formato anglosajón %Y%m%d
# o entre dos fechas, desde la más antigua hasta la más reciente
# Ejemplo entre fechas 20070430 [20070530]

#Declaración de variable IFS para los espacio
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

# Today
TODAY=$(date +%Y%m%d)
echo "Today in YYYYmmdd format: $TODAY"

# Fichero de backup
fichero="Backup_$(date +%Y-%m-%d).tar"

# Timestamp of today
TS_TODAY=$(date +%s)
echo "Today timestamp: $TS_TODAY"

# Seconds per day
SEC_PER_DAY=86400

# Timestamp of the first given date
TS_DATE1=$(date --date="$1" +%s)
echo "First given date timestamp: $TS_DATE1"

# Timestamp of the second, if any, given date
if [ $2 ]
then
        DATE2=$2
        TS_DATE2=$(date --date="$DATE2" +%s)
        echo "Second given date timestamp: $TS_DATE2"
else
        DATE2=$(date +%Y%m%d)
        TS_DATE2=$(date +%s)
fi

# Number of days between the given date and today
let "MAX_DAYS = ($TS_TODAY - $TS_DATE1) / $SEC_PER_DAY"
let "MIN_DAYS = ($TS_TODAY - $TS_DATE2) / $SEC_PER_DAY"
echo "Assert: $1 = $(date --date="$MAX_DAYS days ago" +%Y%m%d) & $TODAY - $1 = $MAX_DAYS ?"
if [ $2 ]
then
        echo "Assert: $2 = $(date --date="$MIN_DAYS days ago" +%Y%m%d) & $TODAY - $2 = $MIN_DAYS ?"
fi

# List the files modified between MAX_DAYS and MIN_DAYS
echo "Files modified between $(date --date="$1") and $(date --date="$DATE2")"
echo "Inicia la copia de seguridad"
find /home/samba -mtime -$MAX_DAYS ! -mtime -$MIN_DAYS -type f -exec tar -rvf $fichero {} \; > out.log
gzip -9 $fichero
IFS=$SAVEFIS





