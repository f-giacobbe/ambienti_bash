if [ $# -lt 1 ]; then
	echo "Occorre inserire almeno un file"
	exit 1
fi

lista_file=$@

read -p "Inserisci directory dove far avvenire il backup: " bak_dir

eval $(cp $lista_file $bak_dir)
