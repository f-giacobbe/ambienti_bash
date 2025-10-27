#Scrivere un programma shell (verifica_duplicati.sh) che riceva come parametri due file di testo
# (il primo conterrà una serie di coppie cartellaA cartellaB, una per #riga del file, mentre il secondo
# dovrà essere creato dal programma.
#Esempio d'uso sarà : verifica_duplicati.sh file_cartelle.txt file_output.txt.
#Per ogni coppia di cartelle il programma dovrà verificare che per ogni file contenuto nella cartellaA, 
# non sia duplicato (cioè contenuto nella cartellaB).
#Se il file #risulta duplicato, il programma dovrà scrivere nel file file_output.txt il nome del file
# duplicato seguito dalla cartellaB in cui il file si trova.
#NOTA BENE Sviluppare anche la variante in cui i duplicati possono avere estensione diversa
#Verifica_duplicati.sh cartelle.txt file _output.txt
# Il file cartelle.txt sarà fatto così cartellaA cartellaB
# cartellaC cartellaD
# Origine altraCartella
# Per ogni rica (esempio per cartellaA e cartellaB)
# i file nella cartellaA sono duplicati nella cartellaB
#
# cartellaA -> pippo.txt topolino.docx paperino.xls
# cartellaB -> topolino.docx paperino.xls
#
# file_output.txt
#   topolino.docx cartellaB
#   paperino.xls cartellaB





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
        for file in $file_cartellaA; do
            if [ -f $cartellaB/$file ]; then    # È duplicato
                echo "$file $cartellaB" >> $file_output
            fi
        done
    fi
    let conta=($conta+1)%2
done