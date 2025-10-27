dir=$1
files=$(ls $dir)

for f in $files; do
	echo $f
	echo $(cat $f | wc -l)
done
