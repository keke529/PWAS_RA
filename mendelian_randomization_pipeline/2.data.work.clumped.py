import os,sys

document1 = open ( sys.argv[1] , 'r' ) # 1.clumped.allsnp
document2 = open ( sys.argv[2] , 'r' ) # data/0.data.raw exp/out
document3 = open ( sys.argv[3] ,'w+' ) # 2.data./0.data.clumped/${data_name}.clumped

dic = {}

for i in document2:
	line = i.strip().split('\t')
	dic[ line[0] ] = i

for i in document1:
	line = i.strip()
	if dic.get( line , "NA_AN" ) == "NA_AN":
		continue
	else:
		document3.write( dic.get(line) )

document1.close()
document2.close()
document3.close()
