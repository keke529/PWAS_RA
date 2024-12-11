
list=${1}

cat ${list} | while read i
do
	exp=`echo ${i} | cut -d\+ -f1`
	out=`echo ${i} | cut -d\+ -f2`

	python ${pw_MR}/5.table.work.py ${exp} ${out} 5.table./${exp}_${out}.result
done
