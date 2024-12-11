if [ ${#} -eq "1" ]; then
	N_parallel=${1}
else
	N_parallel=11
fi

echo ""
echo ">>>"
echo "-----------------------------------------------------------------------------------"
echo "Please choose N_parallel to run all scripts."
echo ""
echo "sh 2.PWAS.assoc_make.sh N"
echo ">>> nohup sh 2.PWAS.assoc_make.sh ${N_parallel} > zzz.log/2.PWAS.assoc_make.log 2>&1 &"
echo "-----------------------------------------------------------------------------------"
echo ""
