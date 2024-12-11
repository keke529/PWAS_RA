
list=${1}

cat ${list} | while read i
do
	exp=`echo ${i} | cut -d\+ -f1`
	out=`echo ${i} | cut -d\+ -f2`
	
	python ${pw_MR}/2.data.work.filter.py \
		1.clumped./${exp}.snp \
		2.data./0.data.clumped/${exp}.clumped 2.data./0.data.clumped/${out}.clumped \
		2.data./${exp}_${out}.exp 2.data./${exp}_${out}.out 2.data./${exp}_${out}.snp
done
