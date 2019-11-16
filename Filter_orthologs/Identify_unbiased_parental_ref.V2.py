#!/usr/bin/env python

Usage = """
Identify_unbiased_parental_ref.V1.py
Usage:
	Identify_unbiased_parental_ref.V1.py input.csv
"""

import sys
import os
import pandas as pd
import numpy as np

def filter_csv(file_name):
    """Given flagged bayesian output in CSV format, isolate unbiased loci. 
    This is only meant for the parents, as the parent data can biasedly map to its own reference or exhibit no bias."""
##    import pandas as pd
##    import numpy as np
	## read a csv file into DataFrame; index_col: column to use as the row labels of the DataFrame
    df = pd.read_csv(file_name, index_col = "commonID")
    
    ## df.columns: the column labels of the DataFrame
    cols = list(df.columns)
    
    ## define the last column label as sig_col; e.g. flag_sig_tdu_tdu_tpr
    sig_col = cols[-1]
    
    ## the third elements of sig_col, which is separated by "_"
    reads=sig_col.split("_")[2]
    
    ## define an empty list unbiased_loci
    unbiased_loci = []
    
    ## print out the number of orthologous pairs before filtering
    print("\tDF pre-filter: " + str(len(df.index)))
    if reads == "tdu":
        # identify loci not biased toward Alt
        ## not biased = mapped equally well to both refs?
        not_biased = df[(df[sig_col] == 0) & (df["q5_mean_theta"] <= 0.75)]
        print("\t\tNot biased: " + str(len(not_biased.index)))
        ## including those biased to tdu
        df = pd.concat([df[(df["q5_mean_theta"] <= 0.5) & (df[sig_col] == 1)],not_biased])
    elif ((reads == "tpo") or (reads == "tpr")):
        # identify loci not biased toward TDU
        not_biased = df[(df[sig_col] == 0) & (df["q5_mean_theta"] >= 0.25)]
        print("\t\tNot biased: " + str(len(not_biased.index)))
        df = pd.concat([df[(df["q5_mean_theta"] >= 0.5) & (df[sig_col] == 1)], not_biased])
    print("\tDF post-filter: " + str(len(df.index)))
    
    OutFileName = os.path.splitext(file_name)[0] + '_Filtered.csv'
    
    df.to_csv(OutFileName, float_format = '%.3f')
    return df
    
filter_csv(sys.argv[1])
    
    