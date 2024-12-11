#!/bin/bash

if [ ${#} -eq "1" ]; then
	N_parallel=${1}
else
	N_parallel=3
fi

sh 1.sumstats_make.sh ${N_parallel} > zzz.log/1.sumstats_make.log 2>&1

sh 2.PWAS.assoc_make.sh 11 > zzz.log/2.PWAS.assoc_make.log 2>&1

sh 3.table.sh
