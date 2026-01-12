# Scrivere un programma shell che riceva da linea di comando tre argomenti: il primo è il nome di una cartella C, il secondo ed il terzo sono due numeri interi non negativi A e B.
# Il programma calcola il risultato dell’operazione “A moltiplicato B” calcolato come somma ripetuta (ovvero non usando l’operatore di moltiplicazione), e lo inserisce alla fine di tutti i file con estensione .txt contenuti nella cartella C. Successivamente, dovrà cambiare il nome di tali file con l’estensione .bak (cioè se il file si chiama pippo.txt dovrà essere rinominato in pippo.bak). 
# Il programma deve gestire i casi d’eccezione (numero di argomenti diverso da tre, file F già esistente, secondo o terzo argomento negativi) interrompendo l’esecuzione con un messaggio all’utente.
# Ad esempio, se il programma si chiama esercizio, l’invocazione di:
# esercizio 2 5 temp
# aggiunge il numero 10 alla fine di tutti i file .txt contenuti nella cartella temp.

if [ $# -ne 3 ]; then
    echo "Uso: $0 <C> <A> <B>"
    exit 1
fi

C="$1"
A=$2
B=$3

# Controllo che A e B non siano negativi
if [ $A -lt 0 -o $B -lt 0 ]; then
    echo "Errore, A e B devono essere non negativi"
    exit 2
fi

# Controllo che esista la cartella C
if [ ! -d "$C" ]; then
    echo "Errore, cartella $C non esiste"
    exit 3
fi

# Calcolo A*B tramite somma ripetuta (aggiungo A a sé stesso B volte)
moltiplicazione=0
count=$B

if [ $count -eq 0 ]; then
    moltiplicazione=0
fi

while [ $count -gt 0 ]; do
    let moltiplicazione=$moltiplicazione+$A
    let count=$count-1
done

# Adesso ho il risultato della moltiplicazione nella variabile A

fileTxtInC=$(ls "$C" *.txt)
for file in $fileTxtInC; do
    # Aggiungo il risultato della moltiplicazione in coda al file
    echo $A >> "$file"

    # Modifico l'estensione in .bak, controllando prima se esiste già tale file
    nuovoFile=$(echo "$file" | sed 's/\.txt$/\.bak/')

    if [ -f "$nuovoFile" ]; then
        echo "Errore, file $nuovoFile già esistente"
        exit 4
    fi

    mv "$file" "$nuovoFile"
done