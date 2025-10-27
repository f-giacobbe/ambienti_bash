# Conta il numero di file e cartelle contenuti nella cartella corrente

res=$(ls -l | wc -l)
let res=$res-1

echo $res
