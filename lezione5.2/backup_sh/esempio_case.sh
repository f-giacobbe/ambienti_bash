# Esempio di utilizzo del "case"
# Backup di tutti i file nella cartella corrente
# Il doppio ;; sarebbe il break


files=$(ls)
for file in $files; do
	if [ -f $file ]; then
		case $file in
			*.docx) cp $file backup_word;;
			*.sh) cp $file backup_sh;;
			*.txt) cp $file backup_txt;;
			*) echo "$file non eseguito il backup"
		esac
	fi
done
