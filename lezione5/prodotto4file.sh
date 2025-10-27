if [ $# -lt 5 -o $# -gt 5 ]; then
	echo "Incorrect number of arguments"
	exit 1
fi

file=$5

res=1
let res=res*$1
let res=res*$2
let res=res*$3
let res=res*$4

echo $res > $file
exit 0
