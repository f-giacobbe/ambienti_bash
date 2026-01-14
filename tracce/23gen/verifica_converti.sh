# Scrivere un programma shell (verifica_converti.sh) che riceve come parametri un file di testo e una cartella di output (il primo conterrà una serie di triple  <cartella>  <file> <estensione>, una per riga del file.
# Esempio d’uso sarà: verifica_converti.sh istruzioni.txt  cartella_output   (mentre una riga del file istruzioni.txt sarà del tipo: cartella1 pippo.txt doc  
# Per ogni tripla il programma dovrà verificare se il file (secondo elemento della tripla: pippo.txt nell’esempio) esiste nella cartella (primo elemento della tripla, cartella1 nell’esempio). Se il file esiste dovrà copiarlo nella cartella di output (secondo parametro del programma), cambiandogli il nome con la nuova estensione.
# Per maggiore chiarezza, nel caso dell’esempio, in cui la riga del file istruzioni.txt è: cartella1 pippo.txt doc il nostro programma dovrà copiare il file nella cartella cartella_output, rinominandolo in pippo.doc.
# Alla fine scrivere su output, il numero dei file rinominati e il numero dei file lasciati inalterati.
# Gestire anche il controllo degli errori (parametri insufficienti, file di output già esistente, cartella inesistente, ecc..).

if [ $# -ne 2 ]; then
    echo "Uso: $0 <file> <cartella>"
    exit 1
fi

fileInput="$1"   # <cartella> <file> <estensione>
cartOutput="$2"

if [ ! -f "$fileInput" ]; then
    echo "Errore, file $fileInput non esiste"
    exit 2
fi

if [ ! -d "$cartOutput" ]; then
    echo "Errore, cartella $cartOutput non esiste"
    exit 3
fi

fileRinominati=0
fileInalterati=0

contFile=$(cat "$fileInput")
count=0
for w in $contFile; do
    if [ $count -eq 0 ]; then
        cartFile="$w"
    elif [ $count -eq 1 ]; then
        file="$w"
    else
        ext="$w"

        # Verifico se il file esiste nella cartella. Se sì, lo copio con la nuova estensione, ma prima verifico se già esiste
        if [ -f "$cartFile/$file" ]; then
            nuovoNome=$(echo "$file" | sed 's/\..*/\.'$ext'/')

            if [ -f "$cartOutput/$nuovoNome" ]; then
                echo "Errore, file $cartOutput/$nuovoNome già esistente"
                exit 4
            fi

            cp "$cartFile/$file" "$cartOutput/$nuovoNome"
        fi

        # Verifico se ho rinominato oppure l'estensione era già quella corretta
        extOriginale=$(echo "$file" | sed 's/.*\.//')

        if [ $ext = $extOriginale ]; then
            let fileInalterati=$fileInalterati+1
        else
            let fileRinominati=$fileRinominati+1
        fi
    fi

    let count=($count+1)%3
done

echo "File rinominati: $fileRinominati"
echo "File inalterati: $fileInalterati"
