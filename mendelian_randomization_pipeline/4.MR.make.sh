
N_parallel=${1}
BETA_OR=${2}

mkdir -p 4.MR. ; rm -rf 4.MR. ; mkdir 4.MR.

mkdir -p 0.data.all.pair_split ; rm -rf 0.data.all.pair_split
spsn 0.data.all.pair ${N_parallel}

for i in $(seq 1 ${N_parallel})
do
	nohup sh 4.MR.work.sh 0.data.all.pair_split/0.data.all.pair_${i} ${BETA_OR} > zzz.log/4.MR.work_${i}.log 2>&1 &
#	sh 4.MR.work.sh 0.data.all.pair_split/0.data.all.pair_${i} ${BETA_OR}
done

wait
