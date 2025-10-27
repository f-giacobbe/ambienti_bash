input="0"
while [ ! $input == "" ]; do
	read -p "Inserisci estensione da eliminare, per fermarti premi INVIO: " input
	
	if [ ! $input == "" ]; then
		rm *.$input
	fi
done
