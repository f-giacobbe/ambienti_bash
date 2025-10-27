# copia solo se il primo argomento è un file e il secondo una cartella

if [ $# -ne 2 ]; then
	echo "Uso: $0 <nomefile> <nomecartella>"
	exit 1
fi

nomefile=$1
nomecart=$2

if [ ! -f $nomefile ]; then
	echo "$nomefile non è un file"
	exit 2
fi

if [ ! -d $nomecart ]; then
	echo "$nomecart non è una cartella"
	exit 3
fi


esito="y"
# se esiste già il file nomefile nella cartella nomecart
if [ -f $nomecart/$nomefile ]; then
	read -p "Il file $nomefile è già presente in $nomecart, sei sicuro di voler sovrascrivere? [y/n]" esito
fi


if [ $esito == "y" ]; then
	echo "Sto copiando $nomefile in $nomecart"
	cp $nomefile $nomecart
fi

exit 0
