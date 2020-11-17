#!/bin/bash

# Documentation du script
doc() {
cat << EOF
Description : Script de création de fichiers C

Options : 
  -help 	affiche l'aide
  -addLibrary 	ajoute les librairies dans le programme C

Exemples : 
  algo -help 
  algo nomFic [-addLib librairies] 
EOF
}

# Utilisation du script
usage() {
	doc ; exit 0
}

# Fonction d'erreur
erreur() {
	echo "Erreur $1" >&2
}

# Gestion arguments
if [ $# -eq 0 ] ; then
	usage
fi

creationFichiers() {
	nom1="$(echo $1 | cut -c 1 | tr "[:lower:]" "[:upper:]")"
	nom2="$(echo $1 | cut -c 2-)"
	nom="test$nom1$nom2"

	ficC="$1.c"
	ficH="$1.h"
	ficTestC="$nom.c"

	touch $ficC $ficH $ficTestC

# Fichier .h
cat << EOF > $ficH
#include <stdio.h>
#include <stdlib.h>
EOF

# Fichier .c
cat << EOF > $ficC
#include "$1.h"
EOF

# Fichier test .c
cat << EOF > $ficTestC
#include "$1.h"

int main(int argc, char *argv[]) {

	return 0;
}
EOF
}

ajouterLibrairies() {
	while [ $# -ne 0 ] ; do 
		echo "#include <$1.h>" >> $ficH
		shift
	done
}

if [ $1 = "-help" ] ; then
	usage
fi

creationFichiers $1

if [ $2 = "-addLib" ] ; then
	shift ; ajouterLibrairies $*
fi

exit 0
