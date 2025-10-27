# Effettuare il backup di tutti i file java contenuti in una cartella in un altra cartella
# (esempio: backup.sh <cartellaOrig> <cartellaDest> )

cartella_orig=$1
cartella_dest=$2

file_da_spostare=$(ls $cartella_orig/*.java)

for f in $file_da_spostare; do
    cp $f $cartella_dest/
done

