
wl_all_pair=`cat 0.data.all.pair | wc -l`

echo "[2.data]"
echo ""
echo "----------------------------------------------------------------------"
echo "- Pair: ${wl_all_pair} exp/out"
echo ""
echo "sh 2.data.make.sh [N_parallel]"
echo ">>> nohup sh 2.data.make.sh 7 > zzz.log/2.data.make.log 2>&1 &"
echo "----------------------------------------------------------------------"
echo ""
