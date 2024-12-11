import os,sys

document1 = open ( sys.argv[1] , 'r' ) # clumped.snp
document2 = open ( sys.argv[2] , 'r' ) # 2.data./0.data.clumped/${exp}.clumped
document3 = open ( sys.argv[3] , 'r' ) # 2.data./0.data.clumped/${out}.clumped
document4 = open ( sys.argv[4] ,'w+' ) # 2.data./${exp}_${out}.exp
document5 = open ( sys.argv[5] ,'w+' ) # 2.data./${exp}_${out}.out
document6 = open ( sys.argv[6] ,'w+' ) # 2.data./${exp}_${out}.snp

dic_exp = {}
dic_out = {}

for i in document2:
	line = i.strip().split('\t')
	dic_exp[ line[0] ] = "_".join( line[0:] )

for i in document3:
	line = i.strip().split('\t')
	dic_out[ line[0] ] = "_".join( line[0:] )

document4.write('SNP\tA1\tA2\tEAF\tBETA\tSE\tP\tN\n')
document5.write('SNP\tA1\tA2\tEAF\tBETA\tSE\tP\tN\n')
for i in document1:
	snp = i.strip()
	if dic_exp.get(snp,"NA_AN") == "NA_AN" or dic_out.get(snp,"NA_AN") == "NA_AN":
		continue
	else:
		exp_alle = dic_exp.get(snp).split('_')[1] + dic_exp.get(snp).split('_')[2]
		out_alle = dic_out.get(snp).split('_')[1] + dic_out.get(snp).split('_')[2]
		out_allr = dic_out.get(snp).split('_')[2] + dic_out.get(snp).split('_')[1]
		if exp_alle == out_alle:
			document4.write( "\t".join(dic_exp.get(snp).split('_')) + "\n" )
			document5.write( "\t".join(dic_out.get(snp).split('_')) + "\n" )
			document6.write( snp + "\n" )
		elif exp_alle == out_allr:
			document4.write( "\t".join(dic_exp.get(snp).split('_')) + "\n" )

			SNP  = snp
			A1   = dic_out.get(snp).split('_')[2]
			A2   = dic_out.get(snp).split('_')[1]
			EAF  = str( 1 - float(dic_out.get(snp).split('_')[3]) )
			BETA = str( - float(dic_out.get(snp).split('_')[4]) )
			SE   = dic_out.get(snp).split('_')[5]
			P    = dic_out.get(snp).split('_')[6]
			N    = dic_out.get(snp).split('_')[7]
			out_line = [SNP,A1,A2,EAF,BETA,SE,P,N]
			document5.write( "\t".join(out_line) + "\n" )
			document6.write( snp + "\n" )

document1.close()
document2.close()
document3.close()
document4.close()
document5.close()
document6.close()
