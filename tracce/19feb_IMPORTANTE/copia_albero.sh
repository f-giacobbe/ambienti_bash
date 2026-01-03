# Scrivere un programma shell (copia_albero.sh) che riceva come parametri due cartelle e copia tutte le cartelle e sottocartelle fino al secondo livello dalla prima cartella alla seconda cartella. Ricreerà quindi lo stesso albero delle directory, con un’unica eccezione, se trova un file con estensione .exe, deve cambiare la sua estensione in .sh 
# Esempio d’uso sarà : copia_albero.sh cartella_sorgente cartella_destinazione.
# Gestire anche il controllo degli errori (parametri insufficienti, file di output già esistente, cartella inesistente, ecc..).
# Esempio: copia_albero.sh Build1 BuildPackage  (nella figura non sono visualizzati i file per semplicità)


if [ $# -ne 2 ]; then
    echo "Uso: $0 <cartella> <cartella>"
    exit 1
fi

cartella1=$1
cartella2=$2

if [ ! -d "$1" -o ! -d "$2" ]; then
    echo "Hai inserito una cartella non esistente"
    exit 1
fi


for el in "$cartella1"/*; do
    base=$(basename "$el")

    # È un file
    if [ -f "$el" ]; then
        estensione=$(echo "$base" | sed 's/.*\.//')

        # Se è un file .exe lo copio cambiando la sua estensione in .sh
        if [ "$estensione" = "exe" ]; then
            nuovoNome=$(echo "$base" | sed 's/\.exe/\.sh/')

            # Controllo se esiste già il file, se sì lancio un errore
            if [ -f "$cartella2/$nuovoNome" ]; then
                echo "Errore! File "$cartella2"/"$nuovoNome" già esistente"
                exit 1
            fi
            
            cp "$el" "$cartella2/$nuovoNome"
        else
            # Controllo se esiste già il file, se sì lancio un errore
            if [ -f "$cartella2/$base" ]; then
                echo "Errore! File "$cartella2/$base" già esistente"
                exit 1
            fi

            cp "$el" "$cartella2/$base"
        fi
    
    # È una directory
    elif [ -d "$el" ]; then
        if [ -d "$cartella2/$base" ]; then
                echo "Errore! Directory "$cartella2/$base" già esistente"
                exit 1
        fi

        vecchio=$PWD
        cd "$cartella2"
        mkdir "$base"
        cd "$vecchio"

        # Essendo el una directory, ci entro e ripeto il tutto
        for el2 in "$el"/*; do
            base2=$(basename "$el2")

            if [ -f "$el2" ]; then
                estensione=$(echo "$base2" | sed 's/.*\.//')

                # Se è un file .exe lo copio cambiando la sua estensione in .sh
                if [ "$estensione" = "exe" ]; then
                    nuovoNome=$(echo "$base2" | sed 's/\.exe/\.sh/')

                    # Controllo se esiste già il file, se sì lancio un errore
                    if [ -f "$cartella2/$base/$nuovoNome" ]; then
                        echo "Errore! File $cartella2/$base/$nuovoNome già esistente"
                        exit 1
                    fi
                    
                    cp "$el2" "$cartella2/$base/$nuovoNome"
                else
                    # Controllo se esiste già il file, se sì lancio un errore
                    if [ -f "$cartella2"/"$base/$base2" ]; then
                        echo "Errore! File $cartella2/$base/$base2 già esistente"
                        exit 1
                    fi

                    cp "$el2" "$cartella2/$base/$base2"
                fi
            
            # Se è una directory, la creo senza copiarne il contenuto controllando prima se esiste
            elif [ -d "$el2" ]; then
                if [ -d "$cartella2/$base/$base2" ]; then
                        echo "Errore! Directory "$cartella2/$base/$base2" già esistente"
                        exit 1
                fi

                vecchio=$PWD
                cd "$cartella2/$base"
                mkdir "$base2"
                cd "$vecchio"
            fi
        done
    fi
done