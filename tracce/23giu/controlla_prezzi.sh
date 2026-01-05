# Scrivere un programma shell controllaPrezzi.sh che riceve da linea di comando tre argomenti: i primi 2 sono due cartelle CartA e CartB e il terzo è un file (esempio hotel.txt).
# Il programma dovrà leggere dal file hotel.txt i dati, ripetuti per ogni riga:  il nome dell’hotel ed il nome di un file relativo ai prezzi dell’hotel (un hotel può essere ripetuto più volte). Quest’ultimo file contiene i prezzi dell’hotel, magari riferiti a un certo anno o stagione. (Esempio: Splendor prezziSplendorAgosto23.txt). 
# Per ogni riga, il programma dovrà verificare se esiste nella cartella CartA un file con estensione doc chiamato nome_hotel.doc (esempio: Splendor.doc) ed il file con il prezzo (prezziSplendorAgosto23.txt  nell’esempio). Nel caso esistano i 2 file dovrà inserire nella cartella CartB un file Splendor.txt (se non esiste) in cui inserire i prezzi dell’hotel nelle varie stagioni (appendendoli in coda). Si suppone per semplicità che il file prezziSplendorAgosto23.txt contenga solo un prezzo (esempio: 100, vale a dire 100 euro a notte). Alla fine, per ogni Hotel, dovrà essere stampato il prezzo medio.  
# Il programma deve gestire i casi d’eccezione (numero di argomenti diverso da tre, file già esistente, ecc.) interrompendo l’esecuzione con un messaggio all’utente.

if [ $# -ne 3 ]; then
    echo "Uso: $0 <cartA> <cartB> <file>"
    exit 1
fi

cartA=$1
cartB=$2
fileInput=$3    # <hotel> <filePrezzo>
output=""

if [ ! -d $cartA -o ! -d $cartB -o ! -f $fileInput ]; then
    echo "Errore. File o cartella non esistente"
    exit 2
fi

contFileInput=$(cat "$fileInput")

# Prima mi creo una lista di hotel distinti per nome
hotelDistinti=""
count=0
for w in $contFileInput; do
    if [ $count -eq 0 ]; then
        hotelDistinti=$(echo -e "$w\n$hotelDistinti")
    fi

    let count=($count + 1)%2
done
count=0
hotelDistinti=$(echo "$hotelDistinti" | sort -u)

# Per ogni hotel distinto
for hotel in $hotelDistinti; do
    sommaPrezzi=0
    numPrezzi=0
    fileB="$cartB/$hotel.txt"

    # Verifico se esiste in cartA il file nomeHotel.doc
    if [ ! -f "$cartA/$hotel.doc" ]; then
        echo "Errore, file $cartA/$nomeHotel.doc non esiste"
        exit 4
    fi

    for w in $contFileInput; do
        if [ $count -eq 0 ]; then
            # Nome hotel
            nomeHotel="$w"
        else
            # File prezzo
            filePrezzo="$w"

            # Se la riga si riferisce all'hotel che sto considerando
            if [ "$nomeHotel" = "$hotel" ]; then
                # Verifico se esiste in cartA il file con il prezzo. 
                if [ ! -f "$cartA/$filePrezzo" ]; then
                    echo "Errore, file $cartA/$filePrezzo non esistente"
                    exit 3
                fi

                # Aggiungo il prezzo nel file in cartB, oltre che alla somma dei prezzi, incrementando numPrezzi
                prezzo=$(cat "$cartA/$filePrezzo")
                echo $prezzo >> "$fileB"
                let sommaPrezzi=$sommaPrezzi+$prezzo
                let numPrezzi=$numPrezzi+1
            fi
        fi

        let count=($count + 1)%2
    done

    # Calcolo il prezzo medio dell'hotel e lo aggiungo alla stringa di output
    let prezzoMedio=$sommaPrezzi/$numPrezzi
    output=$(echo -e "$output$hotel prezzo medio: $prezzoMedio\n")
done

echo "$output"
