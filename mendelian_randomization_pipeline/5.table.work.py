import os,sys

exp = sys.argv[1] # exposure
out = sys.argv[2] # outcome
file = sys.argv[1] + "_" + sys.argv[2]
table = open( sys.argv[3] , 'w+' ) # 5.table./${exp}_${out}.result

# IVW
IVW_l = []
IVW = open( "4.MR./" + file + ".IVW" , 'r' )
for i in IVW:
	IVW_l.append( i.strip() )

# Weighted_Median
Weighted_Median_l = []
Weighted_Median = open( "4.MR./" + file + ".Weighted_Median" , 'r' )
for i in Weighted_Median:
	Weighted_Median_l.append( i.strip() )

# Weighted_Mode
Weighted_Mode_l = []
Weighted_Mode = open( "4.MR./" + file + ".Weighted_Mode" , 'r' )
for i in Weighted_Mode:
	Weighted_Mode_l.append( i.strip() )

# MR_Egger
MR_Egger_l = []
MR_Egger = open( "4.MR./" + file + ".MR_Egger" , 'r' )
for i in MR_Egger:
	MR_Egger_l.append( i.strip() )

# Wald_Ratio
Wald_Ratio_l = []
Wald_Ratio = open( "4.MR./" + file + ".Wald_Ratio" , 'r' )
for i in Wald_Ratio:
	Wald_Ratio_l.append( i.strip() )

# MR_RAPS
MR_RAPS_l = []
MR_RAPS = open( "4.MR./" + file + ".MR_RAPS" , 'r' )
for i in MR_RAPS:
	MR_RAPS_l.append( i.strip() )

# MR_Egger_Intercept
MR_Egger_Intercept_l = []
MR_Egger_Intercept = open( "4.MR./" + file + ".MR_Egger_Intercept" , 'r' )
for i in MR_Egger_Intercept:
	MR_Egger_Intercept_l.append( i.strip() )

# Q_Q
Q_Q_l = []
Q_Q = open( "4.MR./" + file + ".Q_Q_P" , 'r' )
for i in Q_Q:
	Q_Q_l.append( i.strip() )

# IVW_Q
IVW_Q_l = []
IVW_Q = open( "4.MR./" + file + ".IVW_Q" , 'r' )
for i in IVW_Q:
	IVW_Q_l.append( i.strip() )

# MR_Egger_Q
MR_Egger_Q_l = []
MR_Egger_Q = open( "4.MR./" + file + ".MR_Egger_Q" , 'r' )
for i in MR_Egger_Q:
	MR_Egger_Q_l.append( i.strip() )

# Steiger
Steiger_l = []
Steiger = open( "4.MR./" + file + ".Steiger" , 'r' )
for i in Steiger:
	Steiger_l.append( i.strip() )

# IVs_N
SNPs_l = []
SNPs = open( "3.Radial./" + file + ".snp" , 'r' )
for i in SNPs:
	SNPs_l.append( i.strip() )
line_count = len(SNPs_l)

# F
F_l = []
F = open( "4.MR./" + file + ".F" , 'r' )
for i in F:
	F_l.append( i.strip() )

table.write( exp + "\t" + out + "\t" + \
																# Exposure\tOutcome\t
		"\t".join(IVW_l) + "\t" + \
																# IVW_${BETA_OR}\tIVW_CI_L\tIVW_CI_R\tIVW_P\t
		"\t".join(Weighted_Median_l) + "\t" + \
																# Weighted_Median_${BETA_OR}\tWeighted_Median_CI_L\tWeighted_Median_CI_R\tWeighted_Median_P\t
		"\t".join(Weighted_Mode_l) + "\t" + \
																# Weighted_Mode_${BETA_OR}\tWeighted_Mode_CI_L\tWeighted_Mode_CI_R\tWeighted_Mode_P\t
		"\t".join(MR_Egger_l) + "\t" + \
																# MR_Egger_${BETA_OR}\tMR_Egger_CI_L\tMR_Egger_CI_R\tMR_Egger_P\t
		"\t".join(Wald_Ratio_l) + "\t" + \
																# Wald_Ratio_${BETA_OR}\tWald_Ratio_CI_L\tWald_Ratio_CI_R\tWald_Ratio_P\t
		"\t".join(MR_RAPS_l) + "\t" + \
																# MR_RAPS_${BETA_OR}\tMR_RAPS_CI_L\tMR_RAPS_CI_R\tMR_RAPS_P\t
		"\t".join(MR_Egger_Intercept_l) + "\t" + \
																# MR_Egger_Intercept_${BETA_OR}\tMR_Egger_Intercept_CI_L\tMR_Egger_Intercept_CI_R\tMR_Egger_Intercept_P\t
		"\t".join(Q_Q_l) + "\t" + \
																# Q_Q\tQ_Q_P\t
		"\t".join(IVW_Q_l) + "\t" + \
																# IVW_Q_Q\tIVW_Q_Q_df\tIVW_Q_P\t
		"\t".join(MR_Egger_Q_l) + "\t" + \
																# MR_Egger_Q_Q\tMR_Egger_Q_Q_df\tMR_Egger_Q_P\t
		"\t".join(Steiger_l) + "\t" + \
																# Exp_explain\tOut_explain\tSteiger_T_F\tSteiger_P\t
        str(line_count) + "\t" + "snp:" + ",".join(SNPs_l) + "\t" + \
																# IVs_N\tSNPs\t
		"\t".join(F_l) + \
																# F\n
		"\n" )
