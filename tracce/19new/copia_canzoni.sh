# Scrivere un programma shell (copia_canzoni.sh) che riceve come parametri il nome di 2 cartelle (sorgente e destinazione) e il nome di un file che contiene l’elenco delle canzoni da copiare.
# Esempio d’uso sarà quindi: copia_canzoni.sh    origine dest canzoni.txt
# Per ogni nome di canzone (senza estensione) contenuta nel file canzoni.txt, il programma dovrà verificare se esiste con lo stesso nome (ma con qualsiasi estensione) e in caso positivo dovrà copiarla nella cartella destinazione.  Naturalmente, potrebbe esserci più di un file che verifichi questa proprietà e tutti vanno copiati.
# Alla fine dovranno essere stampati anche il numero delle canzoni copiate e quelle non copiate. Sarà gradito una loro suddivisone per estensione: esempi:   mp3  5 canzoni copiate,  aac: 6 canzoni copiate  ecc. Si può suppore per semplicità che ci siano solo alcune estensioni.
# Gestire anche il controllo degli errori (parametri insufficienti, file di output già esistente, cartella inesistente, ecc.).

if [ $# -ne 3 ]; then
    echo "Uso: $0 <dirOrigine> <dirDest> <file>"
    exit 1
fi

origine="$1"
dest="$2"
fileInput="$3"
contFile=$(cat "$fileInput")
output=""

# Verifico se esistono i file e cartelle passati in input
if [ ! -d "$origine" -o ! -d "$dest" -o ! -f "$fileInput" ]; then
    echo "Errore, file o cartella non esistente"
    exit 2
fi

# Ottengo tutte le estensioni di file audio nella cartella origine (si suppone ci siano solo file audio)
estensioni=""
contOrigine=$(ls "$origine")
for file in $contOrigine; do
    ext=$(echo "$file" | sed 's/.*\.//')
    estensioni="$estensioni\n$ext"
done
estensioni=$(echo "$estensioni" | sort -u)

# Per ogni estensione, mi copio i file con quella estensione dalla cartella origine alla cartella destinazione
for ext in $estensioni; do
    numFileCopiati=0

    for titolo in $contFile; do
        # Se esiste nella cartella origine il file titolo.ext, lo copio nella cartella destinazione
        if [ -f "$origine/$titolo.$ext" ]; then
            # Errore file di output già esistente
            if [ -f "$dest/$titolo.$ext" ]; then
                echo "Errore, file di output $dest/$titolo.$ext già esistente"
                exit 3
            fi

            cp "$origine/$titolo.$ext" "$dest/$titolo.$ext"
            let numFileCopiati=$numFileCopiati+1
        fi
    done

    output="$output\n$ext $numFileCopiati canzoni copiate"
done

echo -e "$output"
