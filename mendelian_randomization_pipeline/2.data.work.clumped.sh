
list=${1}

cat ${list} | while read i
do
	data=`echo ${i} | cut -d\/ -f2`
	python ${pw_MR}/2.data.work.clumped.py 1.clumped.allsnp ${i} 2.data./0.data.clumped/${data}.clumped
done
