
#!/bin/bash

function operacion {

	echo "Digite un numero"
	read h
	val=$[((3*$h)-1)]
	val2=$[($val+1)]
	val3=$[($val+2)]
	echo $val $val2 $val3
}

operacion

