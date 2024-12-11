
N_parallel=${1}

mkdir -p 2.data. ; rm -rf 2.data. ; mkdir 2.data.

mkdir -p 0.data.all.list_split ; rm -rf 0.data.all.list_split
spsn 0.data.all.list ${N_parallel}

mkdir 2.data./0.data.clumped
for i in $(seq 1 ${N_parallel})
do
	nohup sh 2.data.work.clumped.sh 0.data.all.list_split/0.data.all.list_${i} > zzz.log/2.data.work.clumped_${i}.log 2>&1 &
done

wait

mkdir -p 0.data.all.pair_split ; rm -rf 0.data.all.pair_split
spsn 0.data.all.pair ${N_parallel}

for i in $(seq 1 ${N_parallel})
do
	nohup sh 2.data.work.filter.sh 0.data.all.pair_split/0.data.all.pair_${i} > zzz.log/2.data.work.filter_${i}.log 2>&1 &
done

wait

# rm -rf 2.data./0.data.clumped

printf "Exp\tOut\tsnp\texp\tout\tcheck\n" > 2.data.check
for exp in `cat 0.data.exp.list`
do
	for out in `cat 0.data.out.list`
	do
		wl_snp=`cat 2.data./${exp}_${out}.snp | wc -l`
		wl_exp=`cat 2.data./${exp}_${out}.exp | sed '1d' | wc -l`
		wl_out=`cat 2.data./${exp}_${out}.out | sed '1d' |  wc -l`
		if [ ${wl_snp} = ${wl_exp} ]; then
			ch_exp=1
		else
			ch_exp=0
		fi
		if [ ${wl_out} = ${wl_exp} ]; then
			ch_out=1
		else
			ch_out=0
		fi

		check=`echo ${ch_exp} ${ch_out} | awk '{print $1*$2}'`
		if [ ${check} -eq "1" ]; then
			check_name="Same"
		else
			check_name="Diff"
		fi

		printf "${exp}\t${out}\t${wl_snp}\t${wl_exp}\t${wl_out}\t${check_name}\n" >> 2.data.check
	done
done
