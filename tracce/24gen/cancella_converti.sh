# Scrivere un programma shell (cancella_converti.sh) che riceve come parametri un file di testo e una cartella di output (il primo file di testo conterrà una serie di triple    <file><cartella_files> <estensione>, una per riga del file.
# Esempio d’uso sarà: cancella_converti.sh istruzioni.txt cartella_output  (mentre una riga del file istruzioni.txt sarà del tipo: prova  cartellaOrigine  docx) 
# Per ogni tripla, il programma dovrà verificare se il file (primo elemento della tripla: prova nell’esempio) esiste nella cartella (secondo elemento della tripla, cartellaOrigine nell’esempio) con un’estensione qualsiasi. Se il file esiste nella cartella <cartella_files> con l’estensione specificata (esempio: prova.docx), dovrà cancellarlo; se esiste ma con estensione diversa (esempio prova.xls, prova.bak, ecc.), dovrà invece copiarlo nella cartella di output, cambiandogli il nome con la nuova estensione (cioè prova.docx).
# Alla fine, bisogna scrivere su output, il numero dei file rinominati e il numero dei file cancellati, meglio ancora se divisi per estensione.
# Gestire anche il controllo degli errori (parametri insufficienti, file di output già esistente, cartella inesistente, ecc..).


if [ $# -ne 2 ]; then
    echo "Uso: $0 <file> <cartella_output>"
    exit 1
fi

fileInput=$1
cartella_output=$2

if [ ! -f $fileInput ]; then
    echo "Errore, $fileInput non esistente"
    exit 1
fi

if [ ! -d $cartella_output ]; then
    echo "Errore, $cartella_output non esistente"
    exit 1
fi

numFileCopiati=0
numFileCancellati=0

input=$(cat $fileInput)

count=0
for w in $input; do
    if [ $count -eq 0 ]; then
        nomeFile=$w
    elif [ $count -eq 1 ]; then
        cartellaFile=$w
    else
        ext=$w

        # Ho tutte le informazioni sulla tripla -> inizio quello che devo fare
        if [ ! -d $cartellaFile ]; then
            echo "Errore, cartella $cartellaFile non esistente"
            exit 1
        fi

        if [ ! -e $cartellaFile/$nomeFile.* ]; then
            echo "Errore, file $nomeFile non esistente"
            #exit 1
        fi

        # Caso 1: il file esiste con l'estensione specificata -> lo cancello
        if [ -f $cartellaFile/$nomeFile.$ext ]; then
            rm "$cartellaFile/$nomeFile.$ext"
            let numFileCancellati=($numFileCancellati + 1)

        # Caso 2: il file esiste con una qualsiasi altra estensione -> lo copio
        elif [ -f $cartellaFile/$nomeFile.* ]; then
            cp $cartellaFile/$nomeFile.* $cartella_output/$nomeFile.$ext
            let numFileCopiati=($numFileCopiati + 1)
        fi
    fi

    let count=($count + 1)%3
done

echo "Il numero di file cancellati è $numFileCancellati"
echo "Il numero di file copiati è $numFileCopiati"