import os,sys
document1 = open ( sys.argv[1]                   , 'r' ) # pw_tissue/tissue.pos
document2 = open ( sys.argv[2]                   , 'r' ) # ${disease_name}.gene_5e8.known
document3 = open ( sys.argv[3] + ".table.all"    , 'r' ) # data.table.all
document4 = open ( sys.argv[3] + ".table.anno"   ,'w+' ) # data.table.anno

dic_pos = {} # ID = gene + chr + P0 + P1

if "INTERVAL" in sys.argv[1]:
	document1.readline()
	for i in document1:
		line = i.strip().split('\t')
		dic_pos[ line[2] ] = line[4] + "\t" + line[5] + "\t" + line[6] + "\t" + line[7]
elif "ARIC" in sys.argv[1]: # Plasma_Protein_weights_EA
	document1.readline()
	for i in document1:
		line = i.strip().split('\t')
		dic_pos[ line[2] ] = line[2] + "\t" + line[3] + "\t" + line[4] + "\t" + line[5]
elif "BANNER" in sys.argv[1] or "ROSMAP" in sys.argv[1]:
	document1.readline()
	for i in document1:
		line = i.strip().split('\t')
		dic_pos[ line[2] ] = line[2].split('.')[1] + "\t" + line[3] + "\t" + line[4] + "\t" + line[5]
elif "UKB_Olink" in sys.argv[1]: # WJH_UKB_pQTL
	document1.readline()
	for i in document1:
		line = i.strip().split('\t')
		dic_pos[ line[2] ] = line[2] + "\t" + line[3] + "\t" + line[4] + "\t" + line[5]

dic_novel = {}
for i in document2:
	line = i.strip()
	dic_novel[ line ] = "Known"

document3.readline()
title='PANEL\tProbeID\tGene\tChr\tP0\tP1\tPWAS_Z\tPWAS_P\tNovel\tPP0\tPP1\tPP2\tPP3\tPP4\n'
document4.write(title)
for i in document3:
	line = i.strip().split('\t')
	gene = dic_pos.get(line[2],"NA_AN\tNA_AN\tNA_AN\tNA_AN").split('\t')[0]
	document4.write(line[0] + "\t" + ".".join(line[1].split('/')[-1].split('.')[0:-2]) + "\t" + dic_pos.get(line[2],"NA_AN\tNA_AN\tNA_AN\tNA_AN") + "\t" + line[18] + "\t" + line[19] + "\t" + dic_novel.get( gene , "Novel" ) + "\t" + "\t".join(line[20:]) + "\n")

document1.close()
document2.close()
document3.close()
document4.close()
