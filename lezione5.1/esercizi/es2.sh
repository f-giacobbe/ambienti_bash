if [ $# -lt 1 ]; then
	echo "è necessario passare un file contenente i nomi dei file da copiare"
	exit 1
fi

read -p "directory where backup should go: " bak_dir

input_file=$1
files_to_copy=$(cat $input_file)

cp $files_to_copy $bak_dir
