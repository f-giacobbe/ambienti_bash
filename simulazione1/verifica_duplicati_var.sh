# NOTA BENE Sviluppare anche la variante in cui i duplicati possono avere estensione diversa
# Verifica_duplicati.sh cartelle.txt file _output.txt


# Input
file_cartelle=$1    # Ogni riga contiene una coppia cartellaA cartellaB
file_output=$2

# Genero il file di output
echo -n "" > $file_output

contenuto_file_cartelle=$(cat $file_cartelle)

# Pro tip: usare un contatore quando è pari prendo cartellaA, quando è dispari prendo cartellaB
conta=0
for cart in $contenuto_file_cartelle; do
    if [ $conta -eq 0 ]; then
        cartellaA=$cart
        # Non faccio altro
    else
        cartellaB=$cart
        # Ho tutto -> posso verificare i duplicati

        # Verifico duplicati
        file_cartellaA=$(ls $cartellaA)
        file_cartellaB=$(ls $cartellaB)

        for fileA in $file_cartellaA; do
            fileA_noExt=${fileA%.*}

            for fileB in $file_cartellaB; do
                fileB_noExt=${fileB%.*}

                if [ $fileA_noExt == $fileB_noExt ]; then    # È duplicato (anche a meno dell'estensione)
                    echo "$fileA $cartellaB" >> $file_output
                fi
            
            done
        done
    fi
    let conta=($conta+1)%2
done