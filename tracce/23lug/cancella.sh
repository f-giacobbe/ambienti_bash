# Scrivere un programma shell che riceve da linea di comando tre argomenti, come segue:  Cancella.sh   <lettera> <cartella> <file_estensioni>.   (Esempio:    Cancella  B   cartfilm    est.txt). Il programma dovrà cancellare i file che iniziano con una certa lettera da una cartella (e che hanno un’estensione prefissata). 
# In pratica, per ogni estensione (esempio txt), il programma prima eliminerà tutti i file che iniziano  con quella lettera  dalla cartella e con quell’estensione.   Nell’esempio (Esempio:    Cancella  B   cartfilm    est.txt), dovrà eliminare i file che iniziano con B dalla cartella cartFilm e che hanno l’estensione txt).  Prima di eliminarli però dovrà copiare questi file nella cartella backup, cambiando l’estensione in .bak (esempio, se il file si chiama pippo.txt diventerà pippo.bak).
# Il programma deve gestire i casi d’eccezione (numero di argomenti diverso da tre, file già esistente, ecc.) interrompendo l’esecuzione con un messaggio all’utente.
# Alla fine si stamperò in output, il numero di file eliminati per estensione.

if [ $# -ne 3 ]; then
    echo "Uso: $0 <lettera> <cartella> <file_estensioni>"
    exit 1
fi

lettera=$1
cartella=$2
file_estensioni=$3

if [ ! -d "$cartella" ]; then
    echo "Cartella $cartella non esistente"
    exit 1
fi

if [ ! -f "$file_estensioni" ]; then
    echo "File $file_estensioni non esistente"
    exit 1
fi

if [ ! -d ./backup ]; then
    echo "Cartella di backup non esistente"
    exit 1
fi

estensioni_da_cancellare=$(cat "$file_estensioni")
output="File eliminati:"
for ext in $estensioni_da_cancellare; do
    numFile=0
    files=$(ls "$cartella"/$lettera* 2> /dev/null)
    for file in $files; do
        let numFile=$numFile+1

        fileBak=$(echo $file | sed 's/'\.$ext'/\.bak')

        if [ -f "./backup/$fileBak" ]; then
            echo "Attenzione! File già esistente nella cartella di backup"
            exit 1
        fi

        cp "$cartella"/"$file" "./backup/$fileBak"
        rm "$cartella"/"$file"
    done;
    
    output=$(echo -e "$output\n$ext=$numFile")
done;

echo $output