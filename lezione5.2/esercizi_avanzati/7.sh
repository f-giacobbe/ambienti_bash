# Sostituire le occorrenze di una parola in un file passato come parametro 
# (esempio: sostituisciParole.sh <file> <parola_cerc> <parola_sost> ) Attenzione: usare = per il confronto di stringhe.

file=$1
parola_cerc=$2
parola_sost=$3

vecchio_testo=$(cat $file)
nuovo_testo=""

for parola in $vecchio_testo; do
    if [ $parola == $parola_cerc ]; then
        nuovo_testo="$nuovo_testo $parola_sost"
    else
        nuovo_testo="$nuovo_testo $parola"
    fi
done

echo $nuovo_testo > nuovo_testo.txt