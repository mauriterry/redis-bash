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

function personaIn {
	g=$(echo -e "$1")
	echo " "
	echo "Digite el Nombre"
	n=Nombre
	read f
	echo "Digite a edad "
	h=Edad
	read s
	sudo echo "rpush $g $n $f $h $s" | redis-cli
	echo "TERMINA"
	read h
}

function insPersona {
	clear
	echo "Digite la cedula de la persona a insertar"
	read g
	com=$(verPersona "$g")
	if [ "$com" == "1" ];
	then
		personaIn "$g"
	else
		echo "La cedula ya se encuentra en la base de datos"
		echo "Oprimir tecla enter para volver al Menu Gestion Personas"
		#antes de salir mostrar esto
		read h
	fi
}

function personaMo {
	g=$(echo -e "$1")
	limit=10
	while [ $limit != 1 ]
	do
	clear
	echo " "
	echo "------ MENU MODIFICAR PERSONA ------"
	echo "1) Nombre"
	echo "2) Edad"
	echo "3) Volver al menu anterior"
	echo "4) Salir"
	read x
	case $x in
		1)
			clear
			echo "--MODIFICAR NOMBRE--"
			g=$(echo -e "$1")
		        echo " "
		        echo "Digite el Nombre"
		        read nom
		        sudo echo "lset $g 1 $nom" | redis-cli
		        echo "TERMINA"
			read h
		;;
		2)
			clear
			echo "--MODIFICAR EDAD--"
			g=$(echo -e "$1")
                        echo " "
                        echo "Digite la Edad"
                        read ed
                        sudo echo "lset $g 3 $ed" | redis-cli
                        echo "TERMINA"
			read h
		;;
		3)
			break
		;;
		4)
			exit
		;;
	esac
	done
}

function modPersona {
	clear
	echo  "Digite la celuda de la persona a modificar"
	read g
	com=$(verPersona "$g")
	if [ "$com" == "0" ]; then
		personaMo "$g"
	else
		echo "La cedula digitada no se encuentra en la base de datos"
		echo "Oprimir tecla enter para volver al Menu Gestion Personas"
		read h
	fi
}

function personaDe {
	g=$(echo -e "$1")
	echo " "
	sudo echo "DEL $g" | redis-cli
	echo "Persona $g ELiminada de la base de datos"
	echo "TERMINA"
	read h	
}

function delPersona {
	clear
	echo  "Digite la celuda de la persona a Eliminar"
	read g
	com=$(verPersona "$g")
	if [ "$com" == "0" ]; then
		personaDe "$g"
	else
		echo "La cedula digitada no se encuentra en la base de datos"
		echo "Oprimir tecla enter para volver al Menu Gestion Personas"
		read h
	fi
}

function personaCo {
	local var1=$(echo "$1")
	com=$(sudo echo "lrange $var1 0 -1" | redis-cli)
	echo "$com"
	read h
}

function conPersona {
	clear
	echo  "Digite la celuda de la persona a Consultar"
	read g
	com=$(verPersona "$g")
	if [ "$com" == "0" ]; then
		personaCo "$g"
	else
		echo "La cedula digitada no se encuentra en la base de datos"
		echo "Oprimir tecla enter para volver al Menu Gestion Personas"
		read h
	fi
}

function comidaIn {
	g=$(echo -e "$1")
	echo " "
	echo "Digite la fecha DD/MM/AAAA"
	read f
	echo "Digite la hora 00:00 am/pm"
	read s
	echo "Digite la comida"
	read co
	sudo echo "rpush $g $f $s $co" | redis-cli
	echo "TERMINA"
	read h
}

function insComida {
	clear
	echo "Digite la cedula de la persona a quien va añadir la comida"
	read g
	com=$(verPersona "$g")
	if [ "$com" == "0" ];
	then
		comidaIn "$g"
	else
		echo "La cedula no se encuentra en la base de datos"
		echo "Oprimir tecla enter para volver al Menu Gestion Personas"
		#antes de salir mostrar esto
		read h
	fi
}


function comidaMo {
	g=$(echo -e "$1")
	g1=$(echo -e "$2")
	g2=$[($g1+1)]
        local   var1=$[((3*$g2)-2)]
	var2=$[($var1+1)]
        var3=$[($var1+2)]
	limit=10
	while [ $limit != 1 ]
	do
	clear
	echo " "
	echo "------ MENU MODIFICAR PERSONA ------"
	echo "1) Fecha"
	echo "2) Hora"
	echo "3) Comida"
	echo "4) Volver al menu anterior"
	echo "5) Salir"
	read x
	case $x in
		1)
			clear
			echo "--MODIFICAR FECHA--"
			g=$(echo -e "$1")
		        echo " "
		        echo "Digite la fecha DD/MM/AAAA"
		        read f
		        sudo echo "lset $g $var1 $f" | redis-cli
		        echo "TERMINA"
			read h
		;;
		2)
			clear
			echo "--MODIFICAR HORA--"
			g=$(echo -e "$1")
                        echo " "
                        echo "Digite la hora 00:00 am/pm"
                        read ed
                        sudo echo "lset $g $var2 $ed" | redis-cli
                        echo "TERMINA"
			read h
		;;
		3)
			clear
			echo "--MODIFICAR COMIDA--"
			g=$(echo -e "$1")
                        echo " "
                        echo "Digite la COMIDA"
                        read co
                        sudo echo "lset $g $var3 $co" | redis-cli
                        echo "TERMINA"
			read h
		;;
		4)
			break
		;;
		5)
			exit
		;;
	esac
	done
}

function comPersona {
	local var1=$(echo "$1")
        local var11=$(echo "$2")
        local var2=$[($var11+1)]
        local var3=$[((3*$var2)-2)] # indice donde se va a consultar la comida
        local var4=$[($var3+2)]
        com=$(sudo echo "lrange $var1 $var3 $var4" | redis-cli)
        if [ "$com" == "" ];
        then
                var1=$(echo "1")
        else
                var1=$(echo "0")
        fi
        echo $var1
}

function modComida {
	clear
	echo  "Digite la celuda de la persona a que va modificar"
	read g
	com=$(verPersona "$g")
	if [ "$com" == "0" ]; then
		echo  "Digite que # de comida es la que va a modifcar"
		read g1
		com1=$(comPersona "$g" "$g1")
		if [ "$com1" == "0" ]; then
			comidaMo "$g" "$g1"
		else
			echo "La comida digitada no se encuentra en la base de datos"
	                echo "Oprimir tecla enter para volver al Menu Gestion Personas"
	                read h
		fi
	else
		echo "La cedula digitada no se encuentra en la base de datos"
		echo "Oprimir tecla enter para volver al Menu Gestion Personas"
		read h
	fi
}

function comidaDe {
	g=$(echo -e "$1")
	g1=$(echo -e "$2")
	g2=$[($g1+1)]
	local   var1=$[((3*$g2)-2)] #indice donde se va a eliminar la comida
	local	var2=$[($var1+1)]
	local   var3=$[($var1+2)]
	echo " "
	val1=$(sudo echo "LINDEX $g $var1" | redis-cli)
	val2=$(sudo echo "LINDEX $g $var2" | redis-cli)
	val3=$(sudo echo "LINDEX $g $var3" | redis-cli)
	sudo echo "LREM $g $var1 $val1 " | redis-cli
	sudo echo "LREM $g $var2 $val2 " | redis-cli
	sudo echo "LREM $g $var3 $val3 " | redis-cli
	echo "Comida #$g1 ELiminada de la base de datos"
	echo "TERMINA"
	read h	
}

function delComida {
	clear
	echo  "Digite la celuda de la persona a quien va a eliminar la comida"
	read g
	com=$(verPersona "$g")
	if [ "$com" == "0" ]; then
		echo  "Digite que # de comida es la que va a eliminar"
		read g1
		com1=$(comPersona "$g" "$g1")
		if [ "$com1" == "0" ]; then
			comidaDe "$g" "$g1"
		else
			echo "La comida digitada no se encuentra en la base de datos"
	                echo "Oprimir tecla enter para volver al Menu Gestion Personas"
	                read h
		fi
	else
		echo "La cedula digitada no se encuentra en la base de datos"
		echo "Oprimir tecla enter para volver al Menu Gestion Personas"
		read h
	fi
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

function conComida {
	clear
	echo  "Digite la celuda de la persona a quien se le va a Consultar la comida"
	read g
	com=$(verPersona "$g")
	if [ "$com" == "0" ]; then
		echo  "Digite que # de comida es la que va a consultar"
		read g1
		com1=$(comPersona "$g" "$g1")
		if [ "$com1" == "0" ]; then
			comidaCo "$g" "$g1"
		else
			echo "La comida digitada no se encuentra en la base de datos"
	                echo "Oprimir tecla enter para volver al Menu Gestion Personas"
	                read h
		fi
	else
		echo "La cedula digitada no se encuentra en la base de datos"
		echo "Oprimir tecla enter para volver al Menu Gestion Personas"
		read h
	fi
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
				read h
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
