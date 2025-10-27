# copia solo se il primo argomento è un file e il secondo una cartella

if [ $# -ne 1 ]; then
	echo "Uso: $0 <nomefile> poi leggo una cartella da input"
	exit 1
fi

nomefile=$1
echo -n "Inserisci il nome della cartella>"
read nomecart

if [ ! -f $nomefile ]; then
	echo "$nomefile non è un file"
	exit 2
elif [ ! -d $nomecart ]; then
	echo "$nomecart non è una cartella"
	exit 3
else
	echo "Sto copiando"
	cp $nomefile $nomecart
	exit 0
fi
