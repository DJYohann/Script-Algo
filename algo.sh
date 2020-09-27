#!/bin/zsh 

nom1="$(echo $1 | cut -c 1 | tr "[:lower:]" "[:upper:]")" 
nom2="$(echo $1 | cut -c 2-)"

nom="test$nom1$nom2"

if [ $# -ne 1 ] ; then
	echo "Erreur - paramètre manquant"
	exit 1
fi 

ficC="$1.c"
ficH="$1.h"
ficTestC="$nom.c"

touch $ficC
touch $ficH 
touch $ficTestC

# Fichier .h
echo "#include <stdio.h>" > $ficH

# Fichier .c
echo "#include \"$1.h\"" > $ficC

# Fichier test .c
echo "#include \"$1.h\"" > $ficTestC
echo " " >> $ficTestC
echo "int main(int argc, char *argv[]) { " >> $ficTestC
echo " " >> $ficTestC
echo "	return 0;" >> $ficTestC
echo "}" >> $ficTestC

exit 0
