N_parallel=${1}

# 1.sumstats_test
touch 1.sumstats_test ; rm 1.sumstats_test*
ls *.ma | rev | cut -d\. -f2- | rev | while read disease_name
do
	echo "sh 1.sumstats_work.sh ${disease_name}" >> 1.sumstats_test
done

spsnf 1.sumstats_test ${N_parallel} ; rm 1.sumstats_test
ls 1.sumstats_test_* | while read i ; do mv ${i} ${i}.sh ; done
for i in $(seq 1 ${N_parallel})
do
	sh 1.sumstats_test_${i}.sh > zzz.log/1.sumstats_test_${i}.log 2>&1 &
done

wait

echo "1.sumstats_test finished"
