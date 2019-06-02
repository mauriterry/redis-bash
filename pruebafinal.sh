#!/bin/bash
function verPersona {
	local var1=$(echo "$1")
	com=$(sudo echo "lrange $var1 0 -1" | redis-cli)
	if [ "$com" == "" ];
	then
		var1=$(echo "1")
	else
                var1=$(echo "0")
	fi
	echo $var1
}

function comidaCo {
	local var1=$(echo "$1")
	local var11=$(echo "$2")
	local var2=$[($var11+1)]
	local var3=$[((3*$var2)-2)] # indice donde se va a consultar la comida
	local var4=$[($var3+2)]
	com=$(sudo echo "lrange $var1 $var3 $var4" | redis-cli)
	echo "$com"
	read h
}

function fechaCo { 
	local var1=$(echo "$1") # valor key
        local var22=$(echo "$2") # valor tamaño lista
	local bus=$(echo "$3") # valor Busqueda
	local var3=$[(($var22+1)/3)] # valor cantidad de comida
	local var4=$[((3*$var3)-1)] #indice donde se va a eliminar la comida
	local val2=$[($var1+1)] # valor key +1
#-----------------------------------------------------------------
#	Guardar en key val2
	for i in $(seq 5 3 $var22)
	do
		var2=$[($i-1)]
		val1=$(sudo echo "LINDEX $var1 $var2" | redis-cli)
		com1=$(sudo echo "rpush $val2 $val1" | redis-cli)
	done
#-----------------------------------------------------------------
#	Mostrar Key val2
	com=$(sudo echo "lrange $val2 0 -1" | redis-cli)
#	echo "$com"
#-----------------------------------------------------------------
#	Buscar Por fecha
	TAM=$(sudo echo "LLEN $KEYS" | redis-cli)
	for i in $(seq 0 1 $TAM)
	do	
		vale1=$(sudo echo "LINDEX $val2 $i" | redis-cli)
		if [ "$vale1" == "$bus" ];then
			echo " Si tenemos en la lista $val2 el elemento $vale1"
			vale2=$[($i+1)]
			comidaCo "$var1" "$vale2"
			break
		else 	if [ "$i" == "$TAM" ];then
				echo " No se encuentra en la lista $val2 el elemento $bus"
				break
			fi
		fi

	done
#-----------------------------------------------------------------
#	Eliminar Key val2
	com2=$(sudo echo "DEL $val2" | redis-cli)
}

function conFecha {

	clear
	echo  "Digite la celuda de la persona a quien se le va a Consultar la comida por fecha"
	read KEYS
	com=$(verPersona "$KEYS")
	if [ "$com" == "0" ]; then
		echo "Digite la fecha que va a consultar DD/MM/AAAA "
		read busqueda
		TAMANIO=$(sudo echo "LLEN $KEYS" | redis-cli)
		fechaCo "$KEYS" "$TAMANIO" "$busqueda"
	else
		echo "La cedula digitada no se encuentra en la base de datos"
		echo "Oprimir tecla enter para volver al Menu Gestion Personas"
		read h
	fi
}
#	KEYS=00001 
#	TAMANIO=$(sudo echo "LLEN $KEYS" | redis-cli)
#	busqueda="27/09/2017"
#	echo "$KEYS" "$TAMANIO" "$busqueda"
#	fechaCo "$KEYS" "$TAMANIO" "$busqueda"
conFecha
