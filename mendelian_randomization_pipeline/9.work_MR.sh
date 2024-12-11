
N_parallel=${1}
BETA_OR=${2}

sh 1.clumped.make.sh ${N_parallel}
echo "--- [1.clumped] ---"

sh 2.data.make.sh ${N_parallel}
echo "--- [2.data] ---"

sh 3.Radial.make.sh ${N_parallel}
echo "--- [3.Radial] ---"

sh 4.MR.make.sh ${N_parallel} ${BETA_OR}
echo "--- [4.MR] ---"

sh 5.table.make.sh ${N_parallel} ${BETA_OR}
echo "--- [5.table] ---"
