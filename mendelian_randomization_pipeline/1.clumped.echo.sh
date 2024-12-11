
wl_exp_data=`cat 0.data.exp.list | wc -l`

echo "[1.clumped]"
echo ""
echo "----------------------------------------------------------------------"
echo "- Exposure: ${wl_exp_data} file(s)"
echo ""
echo "sh 1.clumped.make.sh [N_parallel]"
echo ">>> nohup sh 1.clumped.make.sh 7 > zzz.log/1.clumped.make.log 2>&1 &"
echo "----------------------------------------------------------------------"
echo ""
