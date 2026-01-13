# Scrivere un programma shell riordina_file.sh che riceva 3 parametri, i nomi di due cartelle e il nome di un file.
# Esempio d’uso sarà quindi: riordina_file.sh cartellaA cartellaB istruzioni.txt.
# Il file istruzioni.txt sarà formato da una serie di righe, ognuna fatta così:    <nome_file> <num_righe> <fine | inizio> (fine oppure inizio)   
# (esempio: pippo.txt 5 fine).
# Il programma dovrà verificare se il file esiste nella cartella cartellaA e nel caso dovrà copiarlo nella cartella cartellaB, ma solo le prime num_righe (5 nell’esempio) righe, se nelle istruzioni c’è la parola inizio e solo le ultime num_righe righe se c’è  la parola fine.
# Inoltre, il programma dovrà verificare se esistono nella cartella cartellaA altri file con lo stesso nome, ma diversa estensione (esempio pippo.doc, pippo.avi, ecc.) e nel caso eliminarli.
# Alla fine il programma dovrà stampare il numero totale di file copiati e il numero di file eliminati.
# Gestire anche il controllo degli errori (parametri insufficienti, file di output già esistente, cartella inesistente, ecc..).

if [ $# -ne 3 ]; then
    echo "Uso: $0 <cartA> <cartB> <file>"
    exit 1
fi

cartA="$1"
cartB="$2"
fileInput="$3"      # <nomeFile> <numRighe> <fine/inizio>

if [ ! -d "$cartA" ]; then
    echo "Errore, $cartA inesistente"
    exit 2
fi

if [ ! -d "$cartB" ]; then
    echo "Errore, $cartB inesistente"
    exit 3
fi

if [ ! -f "$fileInput" ]; then
    echo "Errore, $fileInput inesistente"
    exit 4
fi

contFileInput=$(cat "$fileInput")

fileCopiati=0
fileEliminati=0

count=0
for w in $contFileInput; do
    if [ $count -eq 0 ]; then
        nomeFile="$w"
    elif [ $count -eq 1 ]; then
        numRighe=$w
    else
        operazione=$w

        if [ $operazione != "inizio" -o $operazione != "fine" ]; then
            echo "Errore, operazione non valida"
            exit 5
        fi

        # Se il file non esiste nella cartella A, lancio errore
        if [ ! -f "$cartA"/"$nomeFile" ]; then
            echo "Errore, file $cartA/$nomeFile non esistente"
            exit 2
        fi

        # Verifico se esiste già l'eventuale file di output
        if [ -f "$cartB"/"$nomeFile" ]; then
            echo "Errore, file $cartB/$nomeFile già esistente"
            exit 3
        fi

        # In base all'operazione da fare, estraggo il contenuto del file da copiare 
        contDaCopiare=""
        if [ $operazione = "inizio" ]; then
            contDaCopiare=$(head -n $numRighe "$cartA"/"$nomeFile")
        else
            contDaCopiare=$(tail -n $numRighe "$cartA"/"$nomeFile")
        fi

        # "Copio" nella cartella B
        echo "$contDaCopiare" > "$cartB"/"$nomeFile"
        let fileCopiati=$fileCopiati+1



        # Verifico se esistono nella cartella A file con stesso nome ma diversa estensione e in caso li elimino
        nomeFileNoExt=$(echo "$nomeFile" | sed 's/\..*//')

        for f in "$cartA/$nomeFileNoExt".*; do
            nomeBase=$(basename "$f")

            # Se è il file con estensione originale, non faccio nulla, altrimenti elimino
            if [ ! "$nomeBase" = "$nomeFile" ]; then
                rm "$f"
                let fileEliminati=$fileEliminati+1
            fi
        done
    fi

    let count=($count+1)%3
done

echo "File eliminati: $fileEliminati"
echo "File copiati: $fileCopiati"
