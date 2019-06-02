#!/usr/bin/env bash
source "./funcion.sh"

# Funcion Menu

function _menu {
echo "------ MENU ------"
echo "0 Salir"
echo "1 Gestion Personas"
echo "2 Gestion Comidas"
echo "3 Mostrar Todo"
}

function _menu2 {
echo "------ MENU GESTION PERSONAS ------"
echo "0 Volver"
echo "1 Insertar"
echo "2 Modificar"
echo "3 Eliminar"
echo "4 Consultar"
echo "5 Ver todas"
}

function _menu3 {
echo "------ MENU GESTION COMIDAS ------"
echo "0 Volver"
echo "1 Insertar"
echo "2 Modificar"
echo "3 Eliminar"
echo "4 Consultar"
echo "5 Ver todas"
echo "6 Consultar por fecha"
}

limit=10
while [ $limit != 1 ]
do
clear
_menu
read x
case $x in
	0)
		exit
	;;
	1)
		limit1=10
		while [ $limit1 != 1 ]
		do
		clear
		_menu2
		read x
		case $x in
		0)
			limit1=1
			break
			break
		;;
		1)
			insPersona
		;;
		2)
			modPersona
		;;
		3)
			delPersona
		;;
		4)
			conPersona
		;;
		5)
			com=$(sudo echo "Keys *" | redis-cli)
			echo "$com"
			read h
		;;
		*)
	        echo"Este es el asterisco"
		;;

		esac
		done
	;;
	2)
		limit1=10
		while [ $limit1 != 1 ]
		do
		clear
		_menu3
		read x
		case $x in
		0)
			limit1=1
			break
			break
		;;
		1)
			insComida
		;;
		2)
			modComida
		;;
		3)
			delComida
		;;
		4)
			conComida
		;;
		5)
			com=$(sudo echo "Keys *" | redis-cli)
			echo "$com"
			read h
		;;
		6)
			conFecha
		;;

		*)
		        echo "Este es el asterisco"
		;;

		esac
		done
	;;
	3)
		clear
		echo "Mostrar Todo"
	;;
	*)
		_menu
	;;
esac
done
