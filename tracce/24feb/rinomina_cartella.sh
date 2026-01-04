# Scrivere un programma shell che riceve da linea di comando tre argomenti, come segue:  RinominaCancella.sh    <cartella> <file>.   (Esempio:    RinominaCancella.sh  cartLibri    Libri.txt). 
# Nel file passato come parametro ci sarà una serie di triple del tipo <nome_libro> <est1> <cartella_backup>. (Esempio: PiccoleDonne  cartRomanzi epub)
# In pratica, per ogni tripla contenuta nel file passato come parametro, il programma prima cercherà nella cartella passato come parametro (cartLibri nell’esempio).   Nell’esempio (Esempio:    Cancella  B   cartfilm    est.txt), dovrà eliminare i file che iniziano con B dalla cartella cartFilm e che hanno l’estensione txt).  Prima di eliminarli però dovrà copiare questi file nella cartella backup, cambiando l’estensione in .bak (esempio, se il file si chiama pippo.txt diventerà pippo.bak).
# Alla fine si stamperò in output, il numero di file eliminati per estensione.
# Il programma deve gestire i casi d’eccezione (numero di argomenti diverso da tre, file già esistente, ecc.) interrompendo l’esecuzione con un messaggio all’utente.


if [ $# -ne 2 ]; then
    echo "Uso: $0 <cartella_sorgente> <file_istr>"
    exit 1
fi

cartellaSorgente=$1
fileInput=$2        # <nome_libro> <est> <cartella_backup>

if [ ! -d "$cartellaSorgente" -o ! -f "$fileInput" ]; then
    echo "Errore! File o directory non esistente"
    exit 1
fi

contenutoFile=$(cat "$fileInput")

output="File cancellati per estensione:\n"
estensioni=""
count=0
for w in $contenutoFile; do
    if [ $count -eq 1 ]; then
        estensioni=$(echo -e $w\n$estensioni)
    fi
    let count=($count+1)%3
done
estensioni=$(echo $estensioni | sort -u)

for ext in $estensioni; do
    fileExtCancellati=0

    count=0
    for w in $contenutoFile; do
        if [ $count -eq 0 ]; then
            nomeFileNoExt="$w"
        elif [ $count -eq 1 ]; then
            extFile="$w"
        else
            cartBackup="$w"

            # Ho tutte le informazioni, se l'estensione coincide con ext posso iniziare
            if [ "$ext" = "$extFile" ]; then
                nomeCompletoFile="$nomeFileNoExt.$extFile"

                # Esiste nella cartella sorgente?
                if [ -f "$cartellaSorgente/$nomeCompletoFile" ]; then
                    # Copio nella cartella di backup rinominandolo in .bak e lo elimino dalla cartella sorgente
                    if [ -f "$cartBackup/$nomeFileNoExt.bak" ]; then
                        echo "Errore. File $cartBackup/$nomeFileNoExt.bak già esistente."
                        exit 1
                    fi

                    cp "$cartellaSorgente/$nomeCompletoFile" "$cartBackup/$nomeFileNoExt.bak"
                    rm "$cartellaSorgente/$nomeCompletoFile"

                    let fileExtCancellati=$fileExtCancellati+1
                fi
            fi
        fi

        let count=($count+1)%3
    done

    output=$(echo -e "$output\n$ext : $fileExtCancellati")
done

echo "$output"
