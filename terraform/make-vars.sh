file=$1

for i in `cat $file grep -v '^#'| awk -F = '{print $1}'`; do 
    echo -e "variable \"$i\"" '{}'
done 


for i in `cat $file grep -v '^#'| awk -F = '{print $1}'`; do 
    echo -e "$i\t\t\t= \"\${var.$i}\" "
done |column -t 
