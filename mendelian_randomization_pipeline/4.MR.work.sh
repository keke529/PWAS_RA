
list=${1}
BETA_OR=${2}

cat ${list} | while read i
do
	exp=`echo ${i} | cut -d\+ -f1`
	out=`echo ${i} | cut -d\+ -f2`
	file=`echo 4.MR./${exp}_${out}`

	# F
	wl_snp=`cat 3.Radial./${exp}_${out}.snp | wc -l`
	if [ ${wl_snp} -eq "0" ]; then
		echo "NA_AN" > ${file}.F
		echo "--- [F] IV_N = 0, F score skip. [Exp: ${exp} / Out: ${out}] ---"
	else
		python ${pw_MR}/4.MR.work.py 3.Radial./${exp}_${out}.exp ${file}.F
		echo "--- [F] IV_N > 0, [F] F score have finished. [Exp: ${exp} / Out: ${out}] ---"
	fi

	wl_snp=`cat 3.Radial./${exp}_${out}.snp | wc -l`
	if [ ${wl_snp} -eq "0" ]; then
		# continue
		echo "--- [MR] IV_N = 0, skip. [Exp: ${exp} / Out: ${out}] ---"
	elif [ ${wl_snp} -eq "1" ]; then
		# Wald_Ratio
		Rscriptopt ${pw_MR}/4.MR.work.method.Wald_Ratio.r \
			3.Radial./${exp}_${out}.exp 3.Radial./${exp}_${out}.out ${file}.Wald_Ratio
		echo "--- [MR] IV_N = 1, Wald_Ratio method have finished. [Exp: ${exp} / Out: ${out}] ---"
	else
		# IVW
		Rscriptopt ${pw_MR}/4.MR.work.method.MRs.r \
			3.Radial./${exp}_${out}.exp 3.Radial./${exp}_${out}.out \
			${file}.IVW ${file}.Weighted_Median ${file}.MR_Egger ${file}.Weighted_Mode ${file}.MR_RAPS ${file}.MR_Egger_Intercept \
			${file}.MR_Egger_Q ${file}.IVW_Q ${file}.Steiger ${file}.Q_Q_P
		echo "--- [MR] IV_N > 1, MR methods have finished. [Exp: ${exp} / Out: ${out}] ---"
	fi

	# NA_AN 2
	method='Q_Q_P'
	if [ -f ${file}.${method} ]; then
		echo "--- [Exist] ${method} exist. [Exp: ${exp} / Out: ${out}] ---"
	else
		printf "NA_AN\tNA_AN\n" > ${file}.${method}
		echo "--- [NA_AN] ${method} no file, NA_AN have finished. [Exp: ${exp} / Out: ${out}] ---"
	fi

	# NA_AN 3
	for method in `echo IVW_Q,MR_Egger_Q | sed 's/,/\n/g'`
	do
		if [ -f ${file}.${method} ]; then
			echo "--- [Exist] ${method} exist. [Exp: ${exp} / Out: ${out}] ---"
		else
			printf "NA_AN\tNA_AN\tNA_AN\n" > ${file}.${method}
			echo "--- [NA_AN] ${method} no file, NA_AN have finished. [Exp: ${exp} / Out: ${out}] ---"
		fi
	done

	# NA_AN 4
	for method in `echo IVW,Weighted_Median,MR_Egger,Weighted_Mode,MR_RAPS,MR_Egger_Intercept,Steiger,Wald_Ratio | sed 's/,/\n/g'`
	do
		if [ -f ${file}.${method} ]; then
			echo "--- [Exist] ${method} exist. [Exp: ${exp} / Out: ${out}] ---"
		else
			printf "NA_AN\tNA_AN\tNA_AN\tNA_AN\n" > ${file}.${method}
			echo "--- [NA_AN] ${method} no file, NA_AN have finished. [Exp: ${exp} / Out: ${out}] ---"
		fi
	done

	# BETA_OR
	if [ ${BETA_OR} = "BETA" ]; then
		echo "--- [BETA] ${file}.${method} keep BETA. [Exp: ${exp} / Out: ${out}] ---"
	else
		for method in `echo IVW,Weighted_Median,MR_Egger,Weighted_Mode,MR_RAPS,MR_Egger_Intercept,Steiger,Wald_Ratio | sed 's/,/\n/g'`
		do
			cat ${file}.${method} | awk 'BEGIN{FS=OFS="\t"}{if($1~/NA/){print $0}else{print exp($1),exp($2),exp($3),$4}}' > ${file}.${method}_OR
			mv ${file}.${method}_OR ${file}.${method}
			echo "--- [OR] ${file}.${method} have changed OR finished. [Exp: ${exp} / Out: ${out}] ---"
		done
	fi
		
	echo "--- All finished. [Exp: ${exp} / Out: ${out}] ---"
	echo ""
done

# cat ../0.data.all.pair | sed 's/+/_/g' | while read i; do la ${i}* ; echo "" ; done
# cat ../0.data.all.pair | sed 's/+/_/g' | while read i; do echo ${i} ; ls ${i}* | wl ; echo "" ; done
# ls * | cut -d\. -f2 | sort -u | while read i ; do lsNF ${i} | sort -u ; echo "" ; done
