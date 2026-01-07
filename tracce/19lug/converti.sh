# Scrivere un programma shell (converti.sh) che riceve come parametri un file di testo e una cartella di output (il primo conterrà una serie di triple  <cartella>  <file> <estensione>, una per riga del file, mentre il secondo dovrà essere creato dal programma.
# Esempio d’uso sarà: converti.sh istruzioni.txt  cartella_output   (mentre una riga del file iustruzioni.txt potra essere: cartella1 pippo.txt doc  
# Per ogni tripla il programma dovrà verificare se il file (secondo elemento della tripla) esiste nella cartella (primo elemento della tripla). Se il file esiste, il programma dovrà verificare che la sua estensione sia uguale ad estensione (il terzo elemento della tripla). Se non è uguale dovrà copiarlo nella cartella di output (secondo parametro del programma), cambiandogli il nome con la nuova estensione.
# Per maggiore chiarezza, nel caso dell’esempio, in cui la riga del file istruzioni.txt è: cartella1 pippo.txt doc il nostro programma dovrà copiare il file nella cartella cartella_output, rinominandolo in pippo.doc.
# Alla fine scrivere su output, il numero dei file rinominati e il numero dei file lasciati inalterati.
# Gestire anche il controllo degli errori (parametri insufficienti, file di output già esistente, cartella inesistente, ecc.).

if [ $# -ne 2 ]; then
    echo "Uso: $0 <file.txt> <cartella_output>"
    exit 1
fi

fileInput="$1"      # <cartella> <file> <estensione>
cartOutput="$2"

if [ ! -f "$fileInput" ]; then
    echo "File $fileInput inesistente"
    exit 2
fi

if [ -d "$cartOutput" ]; then
    echo "Cartella $cartOutput già esistente"
    exit 3
fi

mkdir "$cartOutput"

fileInalterati=0
fileRinominati=0

contFileInput=$(cat "$fileInput")
count=0
for w in $contFileInput; do
    if [ $count -eq 0 ]; then
        cartella="$w"
    elif [ $count -eq 1 ]; then
        file="$w"
    else
        ext="$w"

        # Verifico se il file esiste nella cartella con estensione ext. Se esiste non faccio nulla e incremento solo il contatore.
        if [ -f "$cartella/$file.$ext" ]; then
            let fileInalterati=$fileInalterati+1

        # Secondo caso: il file esiste ma con un'altra estensione -> lo copio in cartOutput cambiandogli estensione
        elif [ -f "$cartella/$file.* ]; then
            # Verifico prima se esiste già il file $nomeFile.$ext nella cartella di output
            if [ -f "$cartOutput/$file.$ext" ]; then
                echo "Errore. File $cartOutput/$file.$ext già esistente"
                exit 4
            fi

            # Se non esiste, lo copio e incremento il contatore dei file rinominati.
            # ATTENZIONE: si assume che nella cartella $cartella ci sia un solo file con nome $file, a prescindere dall'estensione
            cp "$cartella/$file.*" "$cartOutput/$file.$ext"
            let fileRinominati=$fileRinominati+1
    fi

    let count=($count+1)%3
done

echo -e "File rinominati = $fileRinominati\nFile inalterati = $fileInalterati"
