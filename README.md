[PWAS] / [Mendelian Randomization]

Date: 2024.12.10

Author: Xin Ke & Shi Yao & Hao Wu


|=====================================================================================|
|  fnGWAS v1.0.1                                                                      |
|                                                                                     |
|  fnGWAS is an integrated analysis pipeline for dissecting molecular mechanisms      |
|  underlying noncoding GWAS SNPs through incorporating diverse functional            |
|  cell-specific multi-omics data which consists of five main analysis process        |
|  (named Step 1, Step 2, Step 3, Step 4 and Step 5).Specifically,fnGWAS begins with  |
|  functional SNP prioritization by combing epigenetic functional scoring pipeline    |
|  (Step1) and allele-specific analysis (Step2) using all susceptible SNPs associated |
|  with any interested diseases/traits as input, which outputs functional scores and  |
|  functionality support for all positive SNPs. Target gene prediction were then      |
|  employed for all SNPs with functionality support (Step 3). Downstream functional   |
|  analysis were then performed on predicted target genes,inlcuding gene function     |
|  analysis (Step 4) and gene drug application analysis (Step5). Alternatively, each  |
|  step of fnGWAS can be run independently, which support any user-defined input      |
|  data.The fnGWAS have provided built-in 1000 genome v3 genotype data in European    |
|  samples for functional analysis. However, genotype data from population of any     |
|  other ancestry (eg, European, African or Asian) was also applicable if user        |
|  provided them.                                                                     |
|                                                                                     |
|-------------------------------------------------------------------------------------|
|  Getting Started                                                                    |
|                                                                                     |
|  1) In order to download fnGWAS, you should clone this repository via the commands  |
|     git clone https://github.com/xjtugenetics/fnGWAS.git                            |
|  2) Reference LD and some genome annotation data are need for running fnGWAS, we    |
|     compressed them in advance which can be download from                           |
|     wget -c http://fngwas.online/download/download/fnGWAS.pipeline_data.tar.gz      |
|  3) Dcompression and copy data in 2) into the ./fnGWAS/data                         |
|  4) Some Python dependencies and R packages need are listed.                        |
|     Python     2.7.13  (package: numpy, scipy.stats, BioPython)                     |
|     R          3.3.2   (package: coloc, piccolo, clusterProfiler)                   |
|     PLINK      1.90                                                                 |
|     bedtools   2.25.0                                                               |
|     ANNOVAR    2018                                                                 |
|     fimo tool  4.11.0  (from meme suite toolkit)                                    |
|                                                                                     |
|  Once the above has completed, you can enter each constituent pipeline directory    |
|  (Step1-5) and run corresponding script like                                        |
|  ./sfGWAS/Step1_epigenetic.scoring/Epigenetic_scroing.feature.annotation-1.py -h    |
|  to print a list of all command-line options. See README file in each directory     |
|  for detail description and related example file for script test are also provided. |
|                                                                                     |
|-------------------------------------------------------------------------------------|
|  Support                                                                            |
|                                                                                     |
|  Any problems with fnGWAS?                                                          |
|  Email yangtielin@mail.xjtu.edu.cn                                                  |
|                                                                                     |
|-------------------------------------------------------------------------------------|
|  Authors                                                                            |
|                                                                                     |
|  Tie-Lin Yang    (Xi'an Jiaotong University)                                        |
|  Xiao-Feng Chen  (Xi'an Jiaotong University)                                        |
|                                                                                     |
|=====================================================================================|
