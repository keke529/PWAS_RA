echo "##############################################"
echo "#                                            #"
echo "#                    PWAS                    #"
echo "#                                            #"
echo "#  2024.12.10     Xin Ke & Shi Yao & Hao Wu  #"
echo "#                                            #"
echo "##############################################"

echo ""
echo "[GWAS.ma]"
echo "Please move the GWAS summary data in this folder."
echo ">>> data.ma data.posma"

echo ""
echo "[Tissue.list]"
echo "Please create a file about tissue need."
echo ">>> 0.tissue.list.blood / 0.tissue.list.brain"

wl_ma=`ls * | grep "\.ma" | wc -l`
if [ ${wl_ma} -eq "0" ]; then
	continue
else
	ls *.ma | rev | cut -d\. -f2- | rev | while read disease_name
	do
		if [ -f ${disease_name}.tissue ]; then
			continue
		else
			echo "ln -s 0.tissue.list.blood ${disease_name}.tissue"
#			echo "ln -s 0.tissue.list.brain ${disease_name}.tissue"
		fi
	done
fi

mkdir -p zzz.log

echo ""
echo "----------------------------------------------------"
echo ">>> sh 1.sumstats_echo.sh"
echo ">>> sh 2.PWAS.assoc_echo.sh"
echo ">>> sh 3.table.sh"
echo "----------------------------------------------------"
echo ">>> nohup sh 9.work_PWAS.sh > 9.work_PWAS.log 2>&1 &"
echo ">>> nohup sh 9.work_PWAS.sh 5 > 9.work_PWAS.log 2>&1 &"
echo "----------------------------------------------------"
echo ""
