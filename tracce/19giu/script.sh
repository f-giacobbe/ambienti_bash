# Scrivere un programma shell che riceva da linea di comando tre argomenti: il primo è il nome di un 
# file ris_elezioni.txt, il secondo ed il terzo sono due cartelle Origine e Dest.
# Il programma dovrà leggere il file ris_elezioni.txt che conterrà delle righe del tipo:  
# Rossi.cand   Lega.part, cioè nome_candidato.cand e nome_partito.part.
# Per ogni riga, il programma dovrà scorrere i file della cartella Origine/nome_partito  
# (Origine/Lega nell’esempio) e verificare se nella cartella esista un file nome_candidato.txt (Rossi.txt nell’esempio). 
# Nel caso esista dovrà copiarlo nella cartella Dest/nome_partito, insieme a un file voti_nome_candidato.txt che conterrà 
# il numero di righe del file nome_candidato.txt (che rappresentano i voti). Se non esiste tale file, dovrà comunque 
# creare un file nome_candidato.txt  inserendo 0 come voti.
# Il programma deve gestire i casi d’eccezione (numero di argomenti diverso da tre, file F già esistente, ecc.) 
# interrompendo l’esecuzione con un messaggio all’utente.

if [ $# -ne 3 ]; then
    echo "Uso: $0 <file> <cartOrigine> <cartDest>"
    exit 1
fi

fileInput="$1"      # <nome_candidato>.cand     <nome_partito>.part
cartOrigine="$2"
cartDest="$3"

if [ ! -f "$fileInput" ]; then
    echo "Errore, file $fileInput non esistente"
    exit 4
fi

if [ ! -d "$cartOrigine" ]; then
    echo "Errore, cartella $cartOrigine non esistente"
    exit 5
fi

if [ ! -d "$cartDest" ]; then
    echo "Errore, cartella $cartDest non esistente"
    exit 6
fi

contFileInput=$(cat "$fileInput")
count=0
for w in $contFileInput; do
    if [ $count -eq 0 ]; then
        nomeCandidato="$w"
    else
        nomePartito="$w"

        nomeCandidato=$(echo "$nomeCandidato" | sed 's/\.cand//')
        nomePartito=$(echo "$nomePartito" | sed 's/\.part//')

        if [ -f "$cartOrigine"/"$nomePartito"/"$nomeCandidato".txt ]; then
            if [ -f "$cartDest"/"$nomePartito"/"$nomeCandidato".txt ]; then
                echo "Errore! File $cartDest/$nomePartito/$nomeCandidato.txt già esistente"
                exit 2
            fi

            cp "$cartOrigine"/"$nomePartito"/"$nomeCandidato".txt "$cartDest"/"$nomePartito"/"$nomeCandidato".txt

            numVoti=$(wc -l "$cartOrigine"/"$nomePartito"/"$nomeCandidato".txt)

            if [ -f "$cartDest"/"$nomePartito"/voti_"$nomeCandidato".txt ]; then
                echo "Errore! File $cartDest/$nomePartito/voti_$nomeCandidato.txt già esistente"
                exit 3
            fi
            
            echo $numVoti > "$cartDest"/"$nomePartito"/voti_"$nomeCandidato".txt
        else
            echo 0 > "$cartDest"/"$nomePartito"/voti_"$nomeCandidato".txt
        fi
    fi

    let count=($count+1)%2
done