
wl_all_pair=`cat 0.data.all.pair | wc -l`

echo "[5.table]"
echo ""
echo "----------------------------------------------------------------------"
echo "- Pair: ${wl_all_pair} exp/out"
echo ""
echo "sh 5.table.make.sh [N_parallel] [BETA/OR]"
echo ">>> sh 5.table.make.sh 7 OR"
echo "----------------------------------------------------------------------"
echo ""
