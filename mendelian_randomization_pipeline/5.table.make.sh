
N_parallel=${1}
BETA_OR=${2}

mkdir -p 5.table. ; rm -rf 5.table. ; mkdir 5.table.

mkdir -p 0.data.all.pair_split ; rm -rf 0.data.all.pair_split
spsn 0.data.all.pair ${N_parallel}

for i in $(seq 1 ${N_parallel})
do
	sh 5.table.work.sh 0.data.all.pair_split/0.data.all.pair_${i}
done

printf \
	"Exposure\tOutcome\tIVW_${BETA_OR}\tIVW_CI_L\tIVW_CI_R\tIVW_P\tWeighted_Median_${BETA_OR}\tWeighted_Median_CI_L\tWeighted_Median_CI_R\tWeighted_Median_P\tWeighted_Mode_${BETA_OR}\tWeighted_Mode_CI_L\tWeighted_Mode_CI_R\tWeighted_Mode_P\tMR_Egger_${BETA_OR}\tMR_Egger_CI_L\tMR_Egger_CI_R\tMR_Egger_P\tWald_Ratio_${BETA_OR}\tWald_Ratio_CI_L\tWald_Ratio_CI_R\tWald_Ratio_P\tMR_RAPS_${BETA_OR}\tMR_RAPS_CI_L\tMR_RAPS_CI_R\tMR_RAPS_P\tMR_Egger_Intercept_${BETA_OR}\tMR_Egger_Intercept_CI_L\tMR_Egger_Intercept_CI_R\tMR_Egger_Intercept_P\tQ_Q\tQ_Q_P\tIVW_Q_Q\tIVW_Q_Q_df\tIVW_Q_P\tMR_Egger_Q_Q\tMR_Egger_Q_Q_df\tMR_Egger_Q_P\tExp_explain\tOut_explain\tSteiger_T_F\tSteiger_P\tIVs_N\tSNPs\tF\n" > 5.table.all.raw

cat 5.table./* >> 5.table.all.raw


wl_n=`cat 5.table.all.raw | sed '1d' | wc -l`
wl_p=`echo 0.05 ${wl_n} | awk '{print $1/$2}'`
PP4="0.8"

python 5.table.make.py ${wl_p} ${PP4}

# cat 5.table.all.select.txt | sort | md5sum

# title
cat 5.table.all.select.txt | head -1 > 5.table.all.select.txt_new
# MR - sig - P.sort
cat 5.table.all.select.txt | sed '1d' | awk '$55=="Yes"' | sort -gk 54,54 >> 5.table.all.select.txt_new
# MR - nosig - P.sort
cat 5.table.all.select.txt | sed '1d' | awk '$55=="No" && $54!="NA_AN"' | sort -gk 54,54 >> 5.table.all.select.txt_new
# MR - NA_AN - PP4.rsort
cat 5.table.all.select.txt | sed '1d' | awk '$55=="No" && $54=="NA_AN"' | sort -grk 56,56 >> 5.table.all.select.txt_new
mv 5.table.all.select.txt_new 5.table.all.select.txt

# cat 5.table.all.select.txt | sort | md5sum

outcome=`cat 5.table.all.raw | sed '1d' | cut -f2 | sort -u | tr "\n" "," | rev | cut -c2- | rev`

touch 5.table.all.select.log ; rm 5.table.all.select.log
echo "--------------------------"  >> 5.table.all.select.log
echo ">>> MR - ${outcome}"         >> 5.table.all.select.log
echo "Bonf_P=0.05/${wl_n}=${wl_p}" >> 5.table.all.select.log
echo "PP4=${PP4}"                  >> 5.table.all.select.log
echo "--------------------------"  >> 5.table.all.select.log
