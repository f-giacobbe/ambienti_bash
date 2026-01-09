# Scrivere un programma shell (trova_film.sh) che riceva 2 parametri, il primo è il nome di una cartella (cartellaFilm per esempio) 
# e il secondo è il nome di un film.
# Esempio d’uso sarà quindi: trova_film.sh cartellaFilm elenco_nomi_film.txt.
# Il file elenco_nomi_film.txt conterrà una serie di triple, nome del film, anno, estensione (Esempio: Revenant 2015   avi)
# Per ognuno di questi nomi di film, il programma dovrà verificare se il film è  contenuto nella sottocartella anno della cartella 
# cartellaFilm. Se non lo trova dovrà cercare nelle altre sottocartelle della cartella   (cartellaFilm nell’esempio).
# Alla fine si scriverà in un file di testo output.txt, il nome del film con l’estensione seguito dall’anno in caso si trova il film, 
# altrimenti il messaggio Errore:  <nome_film_con_estensione> <cxartella_in_cui_si_trova> invece di <anno_reale>
# Esempio:  (Revenant 2015    avi).     Bisognerà cercare il file Revenant.avi nella cartella cartellaFilm/2015. Se non lo si trova 
# bisognerà cercarlo in tutte le sottocartelle. Immaginiamo di trovarlo nella sottocartella 2013, bisognerà scrivere nel file di testo:
# 	Errore:  Revenant.avi  2013 invece di 2015 
# Gestire anche il controllo degli errori (parametri insufficienti, file di output già esistente, cartella inesistente, ecc..).

if [ $# -ne 2 ]; then
    echo "Uso: $0 <cartFilm> <fileFilm>"
    exit 1
fi

cartFilm="$1"
fileFilm="$2"   # nomeFilm anno ext

if [ ! -d "$cartFilm" ]; then
    echo "Errore, cartella $cartFilm non esistente"
    exit 2
fi

if [ ! -f "$fileFilm" ]; then
    echo "Errore, file $fileFilm non esistente"
    exit 3
fi

# Errore se esiste già il file di output, se non esiste lo creo
if [ -f output.txt ]; then
    echo "Errore, file output.txt già esistente"
    exit 4
fi

touch output.txt

contFile=$(cat "$fileFilm")

count=0
for w in $contFile; do
    if [ $count -eq 0 ]; then
        nomeFilm=$w
    elif [ $count -eq 1 ]; then
        anno=$w
    else
        ext=$w

        # Controllo che esista la sottocartella con l'anno del film
        if [ ! -d "$cartFilm/$anno" ]; then
            echo "Errore, cartella $anno non presente in $cartFilm"
            exit 5
        fi

        # Ho tutte le informazioni sul film, posso iniziare con la verifica
        if [ -f "$cartFilm/$anno/$nomeFilm.$ext" ]; then
            echo "$nomeFilm.$ext $anno" >> output.txt
        else
            for sottocartella in "$cartFilm"/*/; do
                annoSbagliato=$(basename "$sottocartella")

                # Se il film esiste in questa sottocartella
                if [ -f "$sottocartella/$nomeFilm.$ext" ]; then
                    echo "$nomeFilm.$ext $annoSbagliato invece di $anno" >> output.txt
                fi
            done
        fi
    fi

    let count=($count + 1)%3
done
