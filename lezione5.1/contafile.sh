# contafile che conta solo i file (non le directory)
files=$(ls)
conta=0
for file in $files; do
	if [ -f $file ]; then
		let conta=$conta+1
	fi
done

echo $conta
