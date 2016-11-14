#!/bin/bash
# ./trombi photos.tgz

# S'il a déjà été exécuté une première fois, penser à supprimer les répertoires
# précédemment créés, sans quoi le fichier filières.txt sera vide.
# Exécuter donc les commandes suivantes :
# rm EISE?
# rm MAIN?

fic=$1
txt="filieres.txt"
index="index.html"

`tar xvfz $fic`

jpegs=`ls | grep ".jpg"`

#	nombres de répertoires créés
nbF=0
if test -f $txt; then
	`rm $txt`;
fi
`touch $txt`

for jpg in $jpegs; do
	nbF=`expr $nbF + 1`
#	echo $nbF

	old=$jpg
	jpg=`echo $jpg | sed s/.jpg$//`
	dir=""
	new=""
	while read prenom nom spe annee
	do
		dir=$spe$annee
		if ! test -d $spe$annee; then
			`echo $spe$annee >> $txt`
		fi
		`mkdir -p $dir`
		new="$dir/$nom.$prenom.jpg"
		`convert $old -resize 90x120 $new`
	done < <(echo $jpg | tr '_' ' ')
done

dirs=`ls -d */ | sed s/[\/]$//`
#echo $dirs

for dir in $dirs; do
	path_index="$dir/$index"
	if test -f $path_index; then
		`rm $path_index`
	fi
	`touch $path_index`
	echo "<html><head><title> Trombinoscope $dir</title></head>" >> $path_index
	echo "<body>" >> $path_index
	echo "<h1 align='center'>Trombinoscope $dir</h1>" >> $path_index
	echo "<table cols=2 align='center'>" >> $path_index
	echo "<tr>" >> $path_index
	while read nom prenom
	do
		echo "<td><img src=\"$nom.$prenom.jpg\" width=90 height=120/><br/>$prenom $nom</td>" >> $path_index
	done < <(ls $dir | grep ".jpg" | sed s/\.jpg$// | tr '.' ' ')
	echo "</tr>" >> $path_index
	echo "</table>" >> $path_index
	echo "</body></html>" >> $path_index
done
