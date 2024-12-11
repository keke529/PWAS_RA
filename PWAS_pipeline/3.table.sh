# [Prob Uniq]
# :35,41 s/^/#/g
# :35,41 s/^#//g

pw_tissue='/your/local/path/PWAS_weight'
pw_PWAS='/your/local/path/PWAS_pipeline'

ls *.ma | rev | cut -d\. -f2- | rev | while read disease_name
do
	touch ${disease_name}.gene_test_test ; rm ${disease_name}.gene_*
	touch ${disease_name}.pwas.test_test ; rm ${disease_name}.pwas.*
	echo "-----------------------------------------"  >> ${disease_name}.pwas.table.log
	echo ""                                           >> ${disease_name}.pwas.table.log
	echo ">>> Data: ${disease_name}"                  >> ${disease_name}.pwas.table.log

#	Gene_5e-8
	range=5e5 # 2e3(2-Kb) , 5e5(500-Kb) , 1e6(1-Mb)
	echo "    - [Novel range]: ${range}"              >> ${disease_name}.pwas.table.log
	echo "    - [Prob Uniq]:"                         >> ${disease_name}.pwas.table.log
	cat ${disease_name}.posma | sed '1d' | awk '$6>0.01 && $6<0.99 && $9<5e-8{print "chr"$1"\t"$2-"'"${range}"'""\t"$2+"'"${range}"'""\t"$3}' > ${disease_name}.gene_5e8 # 500-Kb
	bed_region ${disease_name}.gene_5e8 ${disease_name}.gene_5e8.anno
	rm ${disease_name}.gene_5e8
	bedtools intersect -a ${disease_name}.gene_5e8.anno -b /home/WH/data/gene/gencode/v19/gencode.v19.bed -wo | cut -f8 | sort -u > ${disease_name}.gene_5e8.known

#	PWAS table.all - table.anno
 	cat ${disease_name}.tissue | while read tissue
#	cat 0.tissue.list | while read tissue
	do
		cat ${disease_name}/${disease_name}.${tissue}.*.dat | awk '$20!="NA"' | sort -gk 20,20 | uniq | sed 's/Plasma_Protein/ARIC/1' > ${disease_name}.pwas.${tissue}.table.all

#		table.all - table.anno
		python ${pw_PWAS}/3.table.py ${pw_tissue}/${tissue}.pos ${disease_name}.gene_5e8.known ${disease_name}.pwas.${tissue} # ${disease_name}.pwas.${tissue}.table.anno

#		table.anno - uniq
		echo "                   ${tissue} Prob Uniq"     >> ${disease_name}.pwas.table.log
		cat ${disease_name}.pwas.${tissue}.table.anno | head -1 > ${disease_name}.pwas.${tissue}.table.anno.uniq
		cat ${disease_name}.pwas.${tissue}.table.anno | sed '1d' | cut -f3 | grep -v "|" | sort -u | while read gene
		do
			cat ${disease_name}.pwas.${tissue}.table.anno | awk '$3=="'${gene}'"' | sort -gk 8,8 | head -1 >> ${disease_name}.pwas.${tissue}.table.anno.uniq
		done
		cat ${disease_name}.pwas.${tissue}.table.anno.uniq | sort -gk 8,8 > ${disease_name}.pwas.${tissue}.table.anno ; rm ${disease_name}.pwas.${tissue}.table.anno.uniq
	done

#	Table
#	all
	cat ${disease_name}.pwas.*.table.anno | head -1 > ${disease_name}.pwas.table.anno
	cat ${disease_name}.pwas.*.table.anno | sed '/PWAS_P/d' | sort -gk 8,8 >> ${disease_name}.pwas.table.anno

#	filter - bonf
	wl_n=`cat ${disease_name}.pwas.table.anno | sed '1d' | wc -l`
	wl_p=`echo 0.05 ${wl_n} | awk '{print $1/$2}'`
	cat ${disease_name}.pwas.table.anno | head -1 > ${disease_name}.pwas.table.filter
	cat ${disease_name}.pwas.table.anno | sed '1d' | awk '$8<'"${wl_p}"'' | sort -gk 8,8 | sed 's/Plasma_Protein/ARIC/g' >> ${disease_name}.pwas.table.filter
	wl_f=`cat ${disease_name}.pwas.table.filter | sed '1d' | wc -l`
	wl_g=`cat ${disease_name}.pwas.table.filter | sed '1d' | cut -f3 | sort -u | wc -l`

#	filter - FDR
	FDR=0.05
	echo "    - [FDR]: ${FDR}"                        >> ${disease_name}.pwas.table.log
	cat ${disease_name}.pwas.table.anno | head -1 | awk '{print $0"\tFDR"}' > ${disease_name}.pwas.table.anno_FDR
	cat ${disease_name}.pwas.table.anno | sed '1d' | awk 'BEGIN{FS=OFS="\t"}{print $0,$8*"'${wl_n}'"/FNR}' >> ${disease_name}.pwas.table.anno_FDR
	cat ${disease_name}.pwas.table.anno_FDR | head -1 > ${disease_name}.pwas.table.filter_FDR
	cat ${disease_name}.pwas.table.anno_FDR | awk '$NF<'"${FDR}"'' >> ${disease_name}.pwas.table.filter_FDR

#	log - tissue files
	echo ""                                           >> ${disease_name}.pwas.table.log
	echo "-----------------------------------------"  >> ${disease_name}.pwas.table.log
	echo ""                                           >> ${disease_name}.pwas.table.log

	cat ${disease_name}.tissue | while read tissue
	do
		wl_anno_n=`cat ${disease_name}.pwas.${tissue}.table.anno | sed '1d' | wc -l`
		wl_anno_p=`echo 0.05 ${wl_anno_n} | awk '{print $1/$2}'`
		wl_filter=`cat ${disease_name}.pwas.${tissue}.table.anno | sed '1d' | awk '$8<'"${wl_anno_p}"'' | wc -l`
		wl_geneun=`cat ${disease_name}.pwas.${tissue}.table.anno | sed '1d' | awk '$8<'"${wl_anno_p}"'' | cut -f3 | sort -u | wc -l`
		echo ">>> ${disease_name} - ${tissue}"                  >> ${disease_name}.pwas.table.log
		echo "Bonf_P=0.05/${wl_anno_n}=${wl_anno_p}"            >> ${disease_name}.pwas.table.log 
		echo "Filter_pair=${wl_filter}, Uniq_gene=${wl_geneun}" >> ${disease_name}.pwas.table.log
		echo ""                                                 >> ${disease_name}.pwas.table.log
	done
	
	echo ">>> ${disease_name} - All_mrege"            >> ${disease_name}.pwas.table.log
	echo "Bonf_P=0.05/${wl_n}=${wl_p}"                >> ${disease_name}.pwas.table.log
	echo "Filter_pair=${wl_f}, Uniq_gene=${wl_g}"     >> ${disease_name}.pwas.table.log
	echo ""                                           >> ${disease_name}.pwas.table.log
	echo "-----------------------------------------"  >> ${disease_name}.pwas.table.log

	Now_wl=`ls *.ma | rev | cut -d\. -f2- | rev | sed 's/^/grep_&/g' | sed 's/$/_grep/g' | awk '{print FNR"\t"$0}' | grep -w grep_${disease_name}_grep | awk '{print $1}'`
	All_wl=`ls *.ma | wc -l`
	echo "${Now_wl}/${All_wl} - ${disease_name} - finished."
done
