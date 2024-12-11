import os,sys
document1 = open ( "5.table.all.raw"                             , 'r' ) # MR.raw
document2 = open ( "0.data.exp.select/exp.pwas.table.filter.PP4" , 'r' ) # PP4
document3 = open ( "5.table.all.select.txt"                      , 'w+') # MR.select
# sys.argv[1] : Bonf_P of MR
# sys.argv[2] : PP4 select

dic_PP4 = {}
for i in document2:
    line = i.strip().split('\t')
    dic_PP4[ line[1] ] = line[0]

title = document1.readline().strip()
document3.write( title + "\tPP4\t"  "-\t" + \
        "Exp\tIVs_N\tmethod\tBETA_OR\tCI_L\tCI_R\tP\tMR_Causal\tPP4\tColoc_Causal\tAll_Causal\n" )
for i in document1:
    MRMR = i.rstrip('\n')
    line = i.rstrip('\n').split('\t')
    Exp                  = line[0]
    Out                  = line[1]
    IVs_N                = line[42]
    MR_Egger_Intercept_P = line[29]
    IVW_Q_P              = line[34]

    IVW_r                = line[2] + "\t" + line[3] + "\t" + line[4] + "\t" + line[5]
    MR_Egger_r           = line[14]+ "\t" + line[15]+ "\t" + line[16]+ "\t" + line[17]
    Weighted_Median_r    = line[6] + "\t" + line[7] + "\t" + line[8] + "\t" + line[9]
    Wald_Ratio_r         = line[18]+ "\t" + line[19]+ "\t" + line[20]+ "\t" + line[21]

    PP4_r                = dic_PP4.get(Exp)

    if float(IVs_N) > 1.0: # IVW
        if "NA" in MR_Egger_Intercept_P or "NA" in IVW_Q_P:
            Method_r = "IVW\t" + IVW_r
        elif float(MR_Egger_Intercept_P) > 0.05 and float(IVW_Q_P) > 0.05:
            Method_r = "IVW\t" + IVW_r
        elif float(MR_Egger_Intercept_P) < 0.05 and float(IVW_Q_P) > 0.05:
            Method_r = "MR_Egger\t" + MR_Egger_r
        elif float(MR_Egger_Intercept_P) < 0.05 and float(IVW_Q_P) < 0.05:
            Method_r = "Weighted_Median\t" + Weighted_Median_r
        else:
            Method_r = "NA_AN\tNA_AN\tNA_AN\tNA_AN\tNA_AN"
    elif float(IVs_N) == 1.0: # Wald_Ratio
        Method_r = "Wald_Ratio\t" + Wald_Ratio_r
    else:
        Method_r = "NA_AN\tNA_AN\tNA_AN\tNA_AN\tNA_AN"

    # MR_Causal
    if "NA" in Method_r.split('\t')[4]:
        MR_Causal = "No"
    elif float( Method_r.split('\t')[4] ) > float( sys.argv[1] ):
        MR_Causal = "No"
    elif float( Method_r.split('\t')[4] ) < float( sys.argv[1] ):
        MR_Causal = "Yes"

    # Coloc_Causal
    if float(PP4_r) >= float( sys.argv[2] ):
        Coloc_Causal = "Yes"
    else:
        Coloc_Causal = "No"

    if MR_Causal == "Yes" or Coloc_Causal == "Yes":
        All_Causal = "Yes"
    else:
        All_Causal = "No"

    document3.write( MRMR + "\t" + PP4_r + "\t-\t" + \
            Exp + "\t" + IVs_N + "\t" + Method_r + "\t" + MR_Causal + "\t" + PP4_r + "\t" + Coloc_Causal + "\t" + All_Causal +  "\n" )

document1.close()
document2.close()
document3.close()
