
wl_all_pair=`cat 0.data.all.pair | wc -l`

echo "[4.MR]"
echo ""
echo "----------------------------------------------------------------------"
echo "- Pair: ${wl_all_pair} exp/out"
echo ""
echo "sh 4.MR.make.sh [N_parallel] [BEETA/OR]"
echo ">>> nohup sh 4.MR.make.sh 7 OR > zzz.log/4.MR.make.log 2>&1 &"
echo "----------------------------------------------------------------------"
echo ""
