disease_name=${1}

touch ${disease_name}.sumstats.gz ; rm ${disease_name}.sumstats.gz

/home/WH/software/ldsc/munge_sumstats.py \
	--sumstats ${disease_name}.ma \
	--N-col N \
	--out ${disease_name}
