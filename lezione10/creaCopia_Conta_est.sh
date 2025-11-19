if [ $# -ne 2 ];then
	echo "Uso $0 <cart><file_istruzioni"
	exit 1
fi
cartout=$1
istru=$2
if [ ! -d $cartout ];then
	echo "Cartella inesistente"
	exit 2
fi
if [ ! -f $istru ];then
	echo $istru non esiste
fi
params=$(cat $istru)
#creo un file in cui conto i temporanei
rm tmp

count=0
for  i in $params; do
	if [ $count -eq	 0 ];then
		cart_inp=$i
	else
		est=$i
		numfile=0
		echo "Faccio tutto $cart_inp $est"
		if [ ! -d $cart_inp ];then
			echo "cart $cart_inp non esiste!!"
		else
			cd $cart_inp
			mieifiles=$(ls *.$est 2>/dev/null)
			for file in $mieifiles;do
				let numfile=$numfile+1
				nuovonome=$(echo $file| sed 's/'\.$est'/\.bak/')
				cp $file ../$cartout/$nuovonome
			done
			#salvo i file contati con l'estensione nel file temporaneo tmp
			cd ..
			echo "$est $numfile" >> tmp
		fi
		
	fi	
	let count=($count+1)%2
done

estensioni=$(cat tmp | cut -d ' ' -f 1|sort |uniq)
for myest in $estensioni; do
	numfiles=0
	var=$(grep $myest tmp|cut -d ' ' -f 2)
	for num in $var;do
		let numfiles=$numfiles+$num
	done
	echo "copiati $numfiles files dell'estensione $myest "
	
done

