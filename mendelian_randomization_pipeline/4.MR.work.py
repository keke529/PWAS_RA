import os,sys,math

document1 = open ( sys.argv[1] , 'r' ) # 3.Radial./${exp}_${out}.exp
document2 = open ( sys.argv[2] ,'w+' ) # 4.MR./${exp}_${out}.F

PVE_l = []
N_l = []
document1.readline()
for i in document1:
	l = i.strip().split('\t')
	PVE=( float(l[4])*float(l[4]) )/( float(l[4])*float(l[4]) + float(l[5])*float(l[5])*float(l[7]) )
	PVE_l.append( PVE )
	N_l.append( float(l[7]) )
R2 = sum( PVE_l )
k = len( PVE_l )
n = sum( N_l )/k
F = ( (n-k-1)/k )*( R2/(1-R2) )

document2.write( str(F) + "\n" )
