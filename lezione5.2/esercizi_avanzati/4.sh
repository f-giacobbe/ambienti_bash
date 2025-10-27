read -p "Digita (INVIO per fermarsi): " input
max=$input

while [ -n "$input" ]; do
	read -p "Digita (INVIO per fermarsi): " input

	if [[ -n "$input" && $input -gt $max ]]; then
		max=$input
	fi
done

echo "Max=$max"
