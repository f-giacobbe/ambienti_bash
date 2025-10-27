if [ $# -gt 1 ]; then
	echo "Incorrect number of args"
	exit 1
fi

dir=$1
numfile=$(ls -l $dir | grep -E -- ^- | wc -l)

echo "Il numero di file presenti nella directory $dir è $numfile"
exit 0
