#!/bin/bash

ESTADO=$(docker node ls | sed 's/\*//' | grep -v "*" |awk 'NR>1{print $4}')
NODO=$(docker node ls | sed 's/\*//' | grep -v "*" |awk 'NR>1{print $2}')
ESTADOYNODO=$(docker node ls | sed 's/\*//' | grep -v "*" |awk 'NR>1{print $2,$3,$4}'|tr '\n' ',')
VALOR=$(docker node ls | sed 's/\*//' | grep -v "*" |awk 'NR>1{print $2}'|wc -l )
ENERGIA=$(docker node ls | sed 's/\*//' | grep -v "*" |awk 'NR>1{print $3}')
SUMA=0
SUMA1=0

for i in $ESTADO;do
        if [ $i == "Active" ];then
                SUMA=$(($SUMA + 1))
        else
                SUMA=$(($SUMA - 1))
        fi;
done

if [ $SUMA -eq $VALOR ];then
                SEMAFORO1=1
        else
                SEMAFORO1=0
fi

for i in $ENERGIA; do
        if [ $i == "Ready" ];then
                SUMA1=$(($SUMA1 + 1))
        else
                SUMA1=$(($SUMA1 - 1))
        fi;
done

if [ $SUMA1 -eq $VALOR ];then
                SEMAFORO2=1
        else
                SEMAFORO2=0
fi

RESULTADOSUMA=$((SEMAFORO1 + $SEMAFORO2))

if [ $RESULTADOSUMA -eq 2 ];then
        echo "El estado de los nodos es OK (Ready, Active)"
        exit 0
else
        echo "El estado de alguno de los nodos es diferente de Ready y/o Active: $ESTADOYNODO"
        exit 1
fi
