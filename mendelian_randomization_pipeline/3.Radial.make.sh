
N_parallel=${1}

mkdir -p 3.Radial. ; rm -rf 3.Radial. ; mkdir 3.Radial.

mkdir -p 0.data.all.pair_split ; rm -rf 0.data.all.pair_split
spsn 0.data.all.pair ${N_parallel}

for i in $(seq 1 ${N_parallel})
do
	nohup sh 3.Radial.work.sh 0.data.all.pair_split/0.data.all.pair_${i} > zzz.log/3.Radial.work_${i}.log 2>&1 &
done

wait

printf "Exp\tOut\tRadial\texp\tout\tcheck\n" > 3.Radial.check
for exp in `cat 0.data.exp.list`
do
	for out in `cat 0.data.out.list`
	do
		wl_snp=`cat 3.Radial./${exp}_${out}.Radial | wc -l`
		wl_exp=`cat 3.Radial./${exp}_${out}.exp | sed '1d' | wc -l`
		wl_out=`cat 3.Radial./${exp}_${out}.out | sed '1d' |  wc -l`
		if [ ${wl_exp} = ${wl_out} ]; then
			check_name="Same"
		else
			check_name="Diff"
		fi

		printf "${exp}\t${out}\t${wl_snp}\t${wl_exp}\t${wl_out}\t${check_name}\n" >> 3.Radial.check
	done
done
