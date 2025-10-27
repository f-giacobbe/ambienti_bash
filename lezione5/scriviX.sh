if [ $# -ne 1 ]; then
	echo "si usa $0 <num_volte>"
	exit 1
fi

volte=$1
conta=0

echo "" > fileConX.txt
while [ $conta -lt $volte ]; do
	echo -n x >> fileConX.txt
	let conta=$conta+1
done
