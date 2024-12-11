if [ ${#} -eq "1" ]; then
	N_parallel=${1}
else
	N_parallel=3
fi

echo ""
echo ">>>"
echo "-----------------------------------------------------------------------------------"
echo "Please choose N_parallel to run all ma file(s)."
echo ""
echo "sh 1.sumstats_make.sh N"
echo ">>> nohup sh 1.sumstats_make.sh ${N_parallel} > zzz.log/1.sumstats_make.log 2>&1 &"
echo "-----------------------------------------------------------------------------------"
echo ""
