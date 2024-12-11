[PWAS]

Date: 2024.12.10

Author: Xin Ke & Shi Yao & Hao Wu

$ sh 1.sumstats_echo.sh
$ sh 2.PWAS.assoc_echo.sh
$ sh 3.table.sh

$ nohup sh 9.work_PWAS.sh > 9.work_PWAS.log 2>&1 &
$ nohup sh 9.work_PWAS.sh 5 > 9.work_PWAS.log 2>&1 &



[Mendelian Randomization]
Date: 2024.12.10
Author: Xin Ke & Shi Yao & Hao Wu

[1. clumped]
$ sh 1.clumped.work.sh [N_parallel]
$ nohup sh 1.clumped.work.sh 8 > zzz.log/1.clumped.work.log 2>&1 &

[2.data]
$ sh 2.data.work.sh [N_parallel]
$ nohup sh 2.data.work.sh 8 > zzz.log/2.data.work.log 2>&1 &
- check data -
$ cat 2.data.check | sed '1d' | cut -f6 | sort -u

[3.Radial]
$ sh 3.Radial.work.sh [N_parallel]
$ nohup sh 3.Radial.work.sh 8 > zzz.log/3.Radial.work.log 2>&1 &
- check data -
$ cat 3.Radial.check | sed '1d' | cut -f6 | sort -u

[4.MR]
$ sh 4.MR.work.sh [N_parallel] [BETA/OR]
$ nohup sh 4.MR.work.sh 8 OR > zzz.log/4.MR.work.log 2>&1 &

[5.table]
sh 5.table.work.sh [N_parallel] [BETA/OR]
$ sh 5.table.work.sh 8 OR

sh 9.work_MR.sh [N_parallel] [BETA/OR]
$ nohup sh 9.work_MR.sh 8 OR > 9.work_MR.log 2>&1 &
