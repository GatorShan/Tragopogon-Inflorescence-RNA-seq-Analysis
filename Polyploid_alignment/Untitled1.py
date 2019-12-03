#!/usr/bin/env python
# coding: utf-8

# In[44]:


import pandas as pd
df_Tml_bias_Tdu=pd.read_csv("/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/Polyploid_alignment/empirical_bayesian_hybrids_output/bayes_flag_sig_Tml_for_UR_bias_Tdu.csv", header=None)
df_Tml_bias_Tdu.columns = ['commonID','q4_mean_theta','q4_q025','q4_q975','q5_mean_theta','q5_q025','q5_q975','q6_mean_theta','q6_q025','q6_q975','flag_q4_sig','flag_q5_sig','flag_q6_sig','flag_sig_Tml_tdu_tpr']
# import csv file as dataframe, without header line
# add header lines for different columns


# In[45]:


df_Tml_bias_Tdu.shape # display the shape of the df, (number of raws, number of column)


# In[46]:


df_Tml_bias_Tdu.head() #show the head of the dataframe


# In[47]:


df_Tms_bias_Tdu=pd.read_csv("/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/Polyploid_alignment/empirical_bayesian_hybrids_output/bayes_flag_sig_Tms_for_UR_bias_Tdu.csv", header=None)
df_Tms_bias_Tdu.columns = ['commonID','q4_mean_theta','q4_q025','q4_q975','q5_mean_theta','q5_q025','q5_q975','q6_mean_theta','q6_q025','q6_q975','flag_q4_sig','flag_q5_sig','flag_q6_sig','flag_sig_Tml_tdu_tpr']


# In[48]:


df_Tms_bias_Tdu.shape


# In[49]:


df_Tms_bias_Tdu.head() 


# In[50]:


intersected_df_bias_Tdu = pd.merge(df_Tms_bias_Tdu, df_Tml_bias_Tdu, how='inner', on=['commonID'])
# This identify the intersection betweeen two dataframe, based on 'commonID'


# In[55]:


intersected_df_bias_Tdu.shape


# In[53]:


intersected_df_bias_Tdu.head()


# In[60]:


intersected_df_bias_Tdu.to_csv('/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/Polyploid_alignment/empirical_bayesian_hybrids_output/Tms_Tml_intersected_bias_Tdu.csv', index=False, header=False, columns=['commonID'])


# In[ ]:




