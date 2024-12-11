import os,sys

document1 = open ( sys.argv[1] , 'r' ) # 3.Radial./0.Radial/${exp}_${out}.Radial
document2 = open ( sys.argv[2] , 'r' ) # 2.data./${exp}_${out}.exp / 2.data./${exp}_${out}.out
document3 = open ( sys.argv[3] ,'w+' ) # 3.Radial./${exp}_${out}.exp 3.Radial./${exp}_${out}.out

Radial_snp = []
for i in document1:
	line = i.strip()
	Radial_snp.append(line)

title = document2.readline()
document3.write(title)
for i in document2:
	line = i.strip().split('\t')
	if line[0] in Radial_snp:
		continue
	else:
		document3.write(i)

document1.close()
document2.close()
document3.close()
