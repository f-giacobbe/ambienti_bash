if [ $# -lt 4 -o $# -gt 4 ]; then
	echo "Incorrect number of arguments"
	exit 1
fi

res=1
let res=res*$1
let res=res*$2
let res=res*$3
let res=res*$4

echo "Il prodotto è $res"
exit 0
