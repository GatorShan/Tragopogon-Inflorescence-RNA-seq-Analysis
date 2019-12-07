#!/usr/bin/env python
# coding: utf-8

# In[14]:


import pandas as pd
import sys
import os
import glob


# In[ ]:


os.chdir("/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/Filter_orthologs/Compare_SAM/ase_counts_rename/")
# change directory
FileList = glob.glob("*.csv")
# FileList contains all csv files
FileList


# In[22]:


for in_name in FileList:
    out_name = "both_" + "_".join(in_name.split("_")[1:])
    df = pd.read_csv(in_name)
    df["BOTH_ALL"]=df[["BOTH_EXACT","BOTH_INEXACT_EQUAL","SAM_A_EXACT_SAM_B_INEXACT","SAM_B_EXACT_SAM_A_INEXACT","SAM_A_INEXACT_BETTER","SAM_B_INEXACT_BETTER"]].sum(axis=1)
        # create a new column "BOTH_ALL", which is the sum of the row (axis=1) of those listed column
    df.rename(columns={"BOTH_ALL":"Count"}, inplace=True)
        # change the name of the column "BOTH_ALL" to "Count"; inplace=True means modifing the DataFrame in-place (do not reture a copy)
    df[["FUSION_ID","Count"]].to_csv(out_name, index=False)
        # save the df as csv file, including columns "FUSION_ID" and "Count"; without index





