
N_parallel=${1}

mkdir -p 1.clumped. ; rm -rf 1.clumped. ; mkdir 1.clumped.

mkdir -p 0.data.exp.list_split ; rm -rf 0.data.exp.list_split
spsn 0.data.exp.list ${N_parallel}

for i in $(seq 1 ${N_parallel})
do
	nohup sh 1.clumped.work.sh 0.data.exp.list_split/0.data.exp.list_${i} > zzz.log/1.clumped.work_${i}.log 2>&1 &
done

wait

cat 1.clumped./*.snp | sort -u > 1.clumped.allsnp
