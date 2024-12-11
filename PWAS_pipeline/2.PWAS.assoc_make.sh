N_parallel=${1}

# 2.PWAS.assoc_test
touch 2.PWAS.assoc_test ; rm 2.PWAS.assoc_test*
ls *.ma | rev | cut -d\. -f2- | rev | while read disease_name
do
	mkdir -p ${disease_name} ; rm -rf ${disease_name} ; mkdir ${disease_name}
#	number=`zcat ${disease_name}.sumstats.gz | awk '{sum+=$5}END{print sum/NR}'` # Average
	number=`cat ${disease_name}.ma | sed '1d' | cut -f8 | awk 'BEGIN {max = 0} {if ($1+0 > max+0) max=$1} END {print max}'` # Max
	cat ${disease_name}.tissue | while read tissue
	do
		for chr in $(seq 1 22)
		do
			echo "sh 2.PWAS.assoc_work.sh ${disease_name} ${tissue} ${chr} ${number}" >> 2.PWAS.assoc_test
		done
	done
done

spsnf 2.PWAS.assoc_test ${N_parallel} ; rm 2.PWAS.assoc_test
ls 2.PWAS.assoc_test_* | while read i ; do mv ${i} ${i}.sh ; done
for i in $(seq 1 ${N_parallel})
do
	sh 2.PWAS.assoc_test_${i}.sh > zzz.log/2.PWAS.assoc_test_${i}.log 2>&1 &
done

wait

echo "2.PWAS.assoc_test finished"
