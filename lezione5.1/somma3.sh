if [ $# -ne 1 ]; then
	echo "uso: $0 <nomefile>"
	exit 1
fi

nomefile=$1

if [ ! -f $nomefile ]; then
	echo "non è un file"
	exit 2
fi

somma=0
numeri=$(cat $nomefile)

for num in $numeri; do
	let somma=$somma+$num
done

echo "somma=$somma"
