pw_tissue='/your/local/path/PWAS_weight'
pw_PWAS='/your/local/path/PWAS_pipeline'
disease_name=${1}
tissue=${2}
chr=${3}
number=${4}

if [ "${tissue}" = "ARIC" ]; then
	Rscriptopt ${pw_PWAS}/2.PWAS.assoc_Plasma_Protein_weights_ARIC_EA.R \
		--sumstats ${disease_name}.sumstats.gz \
		--weights ${pw_tissue}/Plasma_Protein_weights_EA.pos \
		--weights_dir ${pw_tissue} \
		--GWASN ${number} \
		--coloc_P 1 \
		--chr ${chr} \
		--ref_ld_chr /home/WJH/data/LDREF/1000G.EUR. \
		--out ${disease_name}/${disease_name}.ARIC.${chr}.dat
else
	Rscriptopt ${pw_PWAS}/2.PWAS.assoc_tissues.R \
		--sumstats ${disease_name}.sumstats.gz \
		--weights ${pw_tissue}/${tissue}.pos \
		--weights_dir ${pw_tissue} \
		--GWASN ${number} \
		--coloc_P 1 \
		--chr ${chr} \
		--ref_ld_chr /home/WJH/data/LDREF/1000G.EUR. \
		--out ${disease_name}/${disease_name}.${tissue}.${chr}.dat
fi
