
list=${1}

cat ${list} | while read i
do
	exp=`echo ${i} | cut -d\+ -f1`
	out=`echo ${i} | cut -d\+ -f2`
	
	Rscript ${pw_MR}/3.Radial.work.r 2.data./${exp}_${out}.exp 2.data./${exp}_${out}.out 3.Radial./${exp}_${out}.Radial

	if [ -f 3.Radial./${exp}_${out}.Radial ]; then
		sed -i '/outliers/d' 3.Radial./${exp}_${out}.Radial
	else
		touch 3.Radial./${exp}_${out}.Radial
	fi

	python ${pw_MR}/3.Radial.work.py 3.Radial./${exp}_${out}.Radial 2.data./${exp}_${out}.exp 3.Radial./${exp}_${out}.exp
	python ${pw_MR}/3.Radial.work.py 3.Radial./${exp}_${out}.Radial 2.data./${exp}_${out}.out 3.Radial./${exp}_${out}.out
	
	cat 3.Radial./${exp}_${out}.exp | sed '1d' | cut -f1 > 3.Radial./${exp}_${out}.snp
done
