numeri="10 20 30 40 50"
somma=0

for num in $numeri; do
	let somma=$somma+$num
done

echo $somma
