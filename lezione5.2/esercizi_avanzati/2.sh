file=$1
elenco=$(cat $file)
cnt=0


for f in $elenco; do	
	if [ -f $f ]; then
		let cnt=$cnt+1
	fi
done

echo $cnt
