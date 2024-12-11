
list=${1}

cat ${list} | while read i
do
	plink1.9 --bfile eur.merge \
		--clump 0.data.exp./${i} \
		--clump-field p --clump-kb 1000 --clump-p1 5e-8 --clump-p2 0.01 --clump-r2 0.001 \
		--out 1.clumped./${i}
	cat 1.clumped./${i}.clumped | awk '{print $3}' | sed '/SNP/d' | sed '/^$/d' | sort > 1.clumped./${i}.snp
done
