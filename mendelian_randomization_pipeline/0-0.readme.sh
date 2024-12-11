echo "##############################################"
echo "#                                            #"
echo "#                    PWAS                    #"
echo "#                                            #"
echo "#  2024.12.10     Xin Ke & Shi Yao & Hao Wu  #"
echo "#                                            #"
echo "##############################################"

N_parallel='8'

touch 0.data.{all,exp,out}.list 0.data.all.pair ; rm 0.data.{all,exp,out}.list 0.data.all.pair

# Exposure / Outcpme
mkdir -p 0.data.exp. 0.data.out. zzz.log
echo ""

# list
wl_exp_list=`ls 0.data.exp./ | wc -l`
wl_out_list=`ls 0.data.out./ | wc -l`
wl_list=`echo ${wl_exp_list} ${wl_out_list} | awk '{print $1*$2}'`
if [ ${wl_list} -eq "0" ]; then
	echo "[Expusure / Outcome]"
	echo "- Please move the exp/out data into the folders."
	echo "- SNP,A1,A2,EAF,BETA,SE,P,N"
	echo ">>> 0.data.exp. | 0.data.out."
	echo ""
else
	# exp.list
	touch 0.data.exp.list ; rm 0.data.exp.list
	cd 0.data.exp. ; ls > ../0.data.exp.list ; cd ..
	wl_exp_data=`cat 0.data.exp.list | wc -l`

	# out.list
	touch 0.data.out.list ; rm 0.data.out.list
	cd 0.data.out. ; ls > ../0.data.out.list ; cd ..
	wl_out_data=`cat 0.data.out.list | wc -l`
	# all.list

	touch 0.data.all.list ; rm 0.data.all.list
	cat 0.data.exp.list | awk '{print "0.data.exp./"$1}' >> 0.data.all.list
	cat 0.data.out.list | awk '{print "0.data.out./"$1}' >> 0.data.all.list
	# all.pair
	touch 0.data.all.pair ; rm 0.data.all.pair
	for exp in `cat 0.data.exp.list`
	do
		for out in `cat 0.data.out.list`
		do
			echo "${exp}+${out}" >> 0.data.all.pair
		done
	done
	wl_all_pair=`cat 0.data.all.pair | wc -l`

	echo "Exp(${wl_exp_data}) x Out(${wl_out_data}) = ${wl_all_pair} pairs"
	echo ""
	echo "--------------------------------------------------------------------"
	echo "[1. clumped]"
	echo ">>> sh 1.clumped.work.sh [N_parallel]"
	echo ">>> nohup sh 1.clumped.work.sh ${N_parallel} > zzz.log/1.clumped.work.log 2>&1 &"
	echo ""
	echo "[2.data]"
	echo ">>> sh 2.data.work.sh [N_parallel]"
	echo ">>> nohup sh 2.data.work.sh ${N_parallel} > zzz.log/2.data.work.log 2>&1 &"
	echo "- check data -"
	echo ">>> cat 2.data.check | sed '1d' | cut -f6 | sort -u"
	echo ""
	echo "[3.Radial]"
	echo ">>> sh 3.Radial.work.sh [N_parallel]"
	echo ">>> nohup sh 3.Radial.work.sh ${N_parallel} > zzz.log/3.Radial.work.log 2>&1 &"
	echo "- check data -"
	echo ">>> cat 3.Radial.check | sed '1d' | cut -f6 | sort -u"
	echo ""
	echo "[4.MR]"
	echo ">>> sh 4.MR.work.sh [N_parallel] [BETA/OR]"
	echo ">>> nohup sh 4.MR.work.sh ${N_parallel} OR > zzz.log/4.MR.work.log 2>&1 &"
	echo ""
	echo "[5.table]"
	echo "sh 5.table.work.sh [N_parallel] [BETA/OR]"
	echo ">>> sh 5.table.work.sh ${N_parallel} OR"
	echo "--------------------------------------------------------------------"
	echo "sh 9.work_MR.sh [N_parallel] [BETA/OR]"
	echo ">>> nohup sh 9.work_MR.sh ${N_parallel} OR > 9.work_MR.log 2>&1 &"
	echo "--------------------------------------------------------------------"
	echo ""
fi
