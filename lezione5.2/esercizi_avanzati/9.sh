# Come l'8, ma fare il backup solo delle prime 50 righe di ogni file

# costanti
num_righe=50

cartella_orig=$1
cartella_dest=$2

file_da_spostare=$(ls $cartella_orig/*.java)

for f in $file_da_spostare; do
    nome_file=$(basename $f)
    head -n $num_righe $f > $cartella_dest/$nome_file
done