if [ $# -lt 1 ]; then
	exit 1
fi

somma=0
for num in $@; do
	let somma=$somma+$num
done

echo "Somma=$somma"
