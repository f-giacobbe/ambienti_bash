# Lezione 6
insieme in linux -> stringa con caratteri separati da spazio
    es. X="ciao pippo.txt a.txt"

PRO TIP: aggiungere il . al PATH, in modo da avere sempre la directory corrente


## Condizioni sui file
-f se esiste ed è un file
-d se esiste ed è una cartella
-x -r -w -> per la verifica dei permessi




posso eseguire dei comandi da un file sh a partire da una variabile
    eval $comando       (sconsigliato per sicurezza,
                         a scopi didattici va bene)

con sleep x il programma si freeza per x secondi



$@ indica tutti gli argomenti passati




Come si va a capo con l'echo?       si usa echo -e, in modo che prenda anche i caratteri speciali (es. \n)
