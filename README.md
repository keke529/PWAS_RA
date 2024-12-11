# PWAS_RA  

## Contact  

### Author  
> **Xin Ke**, **Zhao-Hui Zheng**, **Ping Zhu**  
> Department of Clinical Immunology, Xijing Hospital, and National Translational Science Center for Molecular Medicine, Fourth Military Medical University, Xi'an, Shaanxi, P. R. China, 710032.  
> :email:zhuping@fmmu.edu.cn  

### Maintainer  
> **Xin Ke**, **Hao Wu**  
> You can contact :email:kexin520290@163.com or :email:h1877uvx@stu.xjtu.edu.cn when you have any questions, suggestions, comments, etc.  
> Please describe in details, and attach your command line and log messages if possible.  

## Requirements
> - [**GCTA**](http://cnsgenomics.com/software/gcta/)
> - [**Bedtools**](http://quinlanlab.org/tutorials/bedtools/bedtools.html)
> - [**Python**](https://www.python.org/downloads/)
> - [**Plink**](http://zzz.bwh.harvard.edu/plink/epidetails.shtml)
> - [**FUSION**](http://gusevlab.org/projects/fusion/)
> - [**LDSC**](https://github.com/bulik/ldsc)
> - [**R**](https://www.r-project.org/)
>   - R packages:  
>   - [PWAS]: plink2R, coloc(version 5.1.0), jlimR, optparse  
>   - [MR]: TwoSampleMR, MRPRESSO, RadialMR, MendelianRandomization

## Pipeline  
### PWAS pipeline  
```
------------------------------------------------------
[1.sumstats]
>>> sh 1.sumstats_echo.sh

[2.PWAS.assoc]
>>> sh 2.PWAS.assoc_echo.sh

[3.table]
>>> sh 3.table.sh

------------------------------------------------------
>>> nohup sh 9.work_PWAS.sh > 9.work_PWAS.log 2>&1 &  
>>> nohup sh 9.work_PWAS.sh 5 > 9.work_PWAS.log 2>&1 &
------------------------------------------------------
```

### Mendelian Randomization pipeline
```
--------------------------------------------------------------------
[1. clumped]
>>> sh 1.clumped.work.sh [N_parallel]
>>> nohup sh 1.clumped.work.sh 8 > zzz.log/1.clumped.work.log 2>&1 &

[2.data]
>>> sh 2.data.work.sh [N_parallel]
>>> nohup sh 2.data.work.sh 8 > zzz.log/2.data.work.log 2>&1 &
- check data -
>>> cat 2.data.check | sed '1d' | cut -f6 | sort -u

[3.Radial]
>>> sh 3.Radial.work.sh [N_parallel]
>>> nohup sh 3.Radial.work.sh 8 > zzz.log/3.Radial.work.log 2>&1 &
- check data -
>>> cat 3.Radial.check | sed '1d' | cut -f6 | sort -u

[4.MR]
>>> sh 4.MR.work.sh [N_parallel] [BETA/OR]
>>> nohup sh 4.MR.work.sh 8 OR > zzz.log/4.MR.work.log 2>&1 &

[5.table]
sh 5.table.work.sh [N_parallel] [BETA/OR]
>>> sh 5.table.work.sh 8 OR
--------------------------------------------------------------------
sh 9.work_MR.sh [N_parallel] [BETA/OR]
>>> nohup sh 9.work_MR.sh 8 OR > 9.work_MR.log 2>&1 &
--------------------------------------------------------------------
```
