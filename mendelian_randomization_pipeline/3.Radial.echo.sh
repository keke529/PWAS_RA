
wl_all_pair=`cat 0.data.all.pair | wc -l`

echo "[3.Radial]"
echo ""
echo "----------------------------------------------------------------------"
echo "- Pair: ${wl_all_pair} exp/out"
echo ""
echo "sh 3.Radial.make.sh [N_parallel]"
echo ">>> nohup sh 3.Radial.make.sh 7 > zzz.log/3.Radial.make.log 2>&1 &"
echo "----------------------------------------------------------------------"
echo ""
