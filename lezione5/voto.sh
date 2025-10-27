voto=$1

if [ $voto -ge 18 ];then
	echo "Promosso con $voto"
else
	echo "Respinto con $voto"
fi
