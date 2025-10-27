# Contare le occorrenze di una parola in un file
# contaocc.sh pippo prova.txt


if [ $# -ne 2 ]; then
	echo "USO: $0 < parola_da_cerc><nomefile>"
	exit 1
fi

parola_da_cercare=$1
nomefile=$2

if [ ! -f $nomefile ]; then
	echo "File non esiste"
	exit 2
fi

echo "Cerco $parola_da_cercare in $nomefile"


parole=$(cat $nomefile)
conta=0

for par in $parole; do
	if [ $par = $parola_da_cercare ]; then
		let conta=$conta+1
	fi
done

echo "Trovate $conta occorrenze di $parola_da_cercare"
