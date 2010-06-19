#!/bin/bash
# Verificar status de servidores
# es necesario tener la llave publica en el server
# y descripcion en ~/.ssh/config
servers="caid nahuelbuta"
for server in $(echo $servers)
do
	status=$(ssh $server cat /proc/uptime)
	numero=$(echo $status | wc -w)
	if [ $numero -ne 2 ]
	then 
		echo "$server down"
	#else
	#	dias=$(echo "scale=1;$(echo $status | awk '{print $1}')/86400" | bc)
	#	echo -e "$server\t$dias"
	fi 
done
