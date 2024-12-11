Args     <- commandArgs(TRUE)
input1   <- Args[1]  # 3.Radial./${exp}_${out}.exp
input2   <- Args[2]  # 3.Radial./${exp}_${out}.out

output1 <- Args[3] # Wald_Ratio

library(TwoSampleMR)

exp_dat <- read_exposure_data(
							  filename = input1,
							  sep = "\t",
							  snp_col = "SNP",
							  beta_col = "BETA",
							  se_col = "SE",
							  effect_allele_col = "A1",
							  other_allele_col = "A2",
							  eaf_col = "EAF",
							  pval_col = "P",
							  samplesize_col = "N"
							)
out_dat <- read_outcome_data(
								 filename = input2,
								 sep = "\t",
								 snps = exp_dat$SNP,
								 snp_col = "SNP",
								 beta_col = "BETA",
								 se_col = "SE",
								 effect_allele_col = "A1",
								 other_allele_col = "A2",
								 eaf_col = "EAF",
								 pval_col = "P",
								 samplesize_col = "N"
								 )
dat <- harmonise_data(
					  exposure_dat = exp_dat,
					  outcome_dat = out_dat
					  )

tsmr<-mr(dat, method_list=c("mr_wald_ratio"))

wr<-cbind(tsmr[1,7],(tsmr[1,7]-1.96*tsmr[1,8]),(tsmr[1,7]+1.96*tsmr[1,8]),tsmr[1,9])
write.table(wr,output1,quote=F,row.names=F,col.names=F,sep="\t") #Wald_Ratio
