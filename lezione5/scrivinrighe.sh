if [ $# -gt 2 ]; then
	echo "Unexpected number of args"
	exit 1
fi

numrighe=$1
file=$2

echo $(head -n $1 $2)
