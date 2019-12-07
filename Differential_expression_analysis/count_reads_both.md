```python
import pandas as pd
import sys
import os
import glob
```


```python
os.chdir("/ufrc/soltis/shan158538/TragFL_NewAnalysis/OutPut/Filter_orthologs/Compare_SAM/ase_counts_rename/")
# change directory
FileList = glob.glob("*.csv")
# FileList contains all csv files
FileList
```


```python
for in_name in FileList:
    out_name = "both_" + "_".join(in_name.split("_")[1:])
    df = pd.read_csv(in_name)
    df["BOTH_ALL"]=df[["BOTH_EXACT","BOTH_INEXACT_EQUAL","SAM_A_EXACT_SAM_B_INEXACT","SAM_B_EXACT_SAM_A_INEXACT","SAM_A_INEXACT_BETTER","SAM_B_INEXACT_BETTER"]].sum(axis=1)
        # create a new column "BOTH_ALL", which is the sum of the row (axis=1) of those listed column
    df.rename(columns={"BOTH_ALL":"Count"}, inplace=True)
        # change the name of the column "BOTH_ALL" to "Count"; inplace=True means modifing the DataFrame in-place (do not reture a copy)
    df[["FUSION_ID","Count"]].to_csv(out_name, index=False)
        # save the df as csv file, including columns "FUSION_ID" and "Count"; without index

```


```python
df = pd.read_csv(in_name)
```


```python
df.head()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>FUSION_ID</th>
      <th>BOTH_EXACT</th>
      <th>BOTH_INEXACT_EQUAL</th>
      <th>SAM_A_ONLY_EXACT</th>
      <th>SAM_B_ONLY_EXACT</th>
      <th>SAM_A_EXACT_SAM_B_INEXACT</th>
      <th>SAM_B_EXACT_SAM_A_INEXACT</th>
      <th>SAM_A_ONLY_SINGLE_INEXACT</th>
      <th>SAM_B_ONLY_SINGLE_INEXACT</th>
      <th>SAM_A_INEXACT_BETTER</th>
      <th>SAM_B_INEXACT_BETTER</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>Tpr_TRINITY_DN11257_c2_g1|Tdu_TRINITY_DN16696_...</td>
      <td>58</td>
      <td>8</td>
      <td>51</td>
      <td>0</td>
      <td>8</td>
      <td>0</td>
      <td>3</td>
      <td>0</td>
      <td>11</td>
      <td>7</td>
    </tr>
    <tr>
      <th>1</th>
      <td>Tpr_TRINITY_DN10844_c2_g7|Tdu_TRINITY_DN25328_...</td>
      <td>124</td>
      <td>15</td>
      <td>7</td>
      <td>1</td>
      <td>6</td>
      <td>1</td>
      <td>9</td>
      <td>1</td>
      <td>8</td>
      <td>3</td>
    </tr>
    <tr>
      <th>2</th>
      <td>Tpr_TRINITY_DN15383_c4_g16|Tdu_TRINITY_DN14160...</td>
      <td>26</td>
      <td>4</td>
      <td>9</td>
      <td>0</td>
      <td>3</td>
      <td>0</td>
      <td>1</td>
      <td>0</td>
      <td>1</td>
      <td>2</td>
    </tr>
    <tr>
      <th>3</th>
      <td>Tpr_TRINITY_DN1451_c0_g1|Tdu_TRINITY_DN16990_c...</td>
      <td>65</td>
      <td>1</td>
      <td>10</td>
      <td>0</td>
      <td>23</td>
      <td>0</td>
      <td>7</td>
      <td>0</td>
      <td>6</td>
      <td>1</td>
    </tr>
    <tr>
      <th>4</th>
      <td>Tpr_TRINITY_DN10853_c1_g4|Tdu_TRINITY_DN21860_...</td>
      <td>524</td>
      <td>31</td>
      <td>1</td>
      <td>61</td>
      <td>97</td>
      <td>21</td>
      <td>16</td>
      <td>101</td>
      <td>81</td>
      <td>19</td>
    </tr>
  </tbody>
</table>
</div>




```python
df["BOTH_ALL"]=df[["BOTH_EXACT","BOTH_INEXACT_EQUAL","SAM_A_EXACT_SAM_B_INEXACT","SAM_B_EXACT_SAM_A_INEXACT","SAM_A_INEXACT_BETTER","SAM_B_INEXACT_BETTER"]].sum(axis=1)
# create a new column "BOTH_ALL", which is the sum of the row (axis=1) of those listed column
```


```python
df.head()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>FUSION_ID</th>
      <th>BOTH_EXACT</th>
      <th>BOTH_INEXACT_EQUAL</th>
      <th>SAM_A_ONLY_EXACT</th>
      <th>SAM_B_ONLY_EXACT</th>
      <th>SAM_A_EXACT_SAM_B_INEXACT</th>
      <th>SAM_B_EXACT_SAM_A_INEXACT</th>
      <th>SAM_A_ONLY_SINGLE_INEXACT</th>
      <th>SAM_B_ONLY_SINGLE_INEXACT</th>
      <th>SAM_A_INEXACT_BETTER</th>
      <th>SAM_B_INEXACT_BETTER</th>
      <th>BOTH_ALL</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>Tpr_TRINITY_DN11257_c2_g1|Tdu_TRINITY_DN16696_...</td>
      <td>58</td>
      <td>8</td>
      <td>51</td>
      <td>0</td>
      <td>8</td>
      <td>0</td>
      <td>3</td>
      <td>0</td>
      <td>11</td>
      <td>7</td>
      <td>92</td>
    </tr>
    <tr>
      <th>1</th>
      <td>Tpr_TRINITY_DN10844_c2_g7|Tdu_TRINITY_DN25328_...</td>
      <td>124</td>
      <td>15</td>
      <td>7</td>
      <td>1</td>
      <td>6</td>
      <td>1</td>
      <td>9</td>
      <td>1</td>
      <td>8</td>
      <td>3</td>
      <td>157</td>
    </tr>
    <tr>
      <th>2</th>
      <td>Tpr_TRINITY_DN15383_c4_g16|Tdu_TRINITY_DN14160...</td>
      <td>26</td>
      <td>4</td>
      <td>9</td>
      <td>0</td>
      <td>3</td>
      <td>0</td>
      <td>1</td>
      <td>0</td>
      <td>1</td>
      <td>2</td>
      <td>36</td>
    </tr>
    <tr>
      <th>3</th>
      <td>Tpr_TRINITY_DN1451_c0_g1|Tdu_TRINITY_DN16990_c...</td>
      <td>65</td>
      <td>1</td>
      <td>10</td>
      <td>0</td>
      <td>23</td>
      <td>0</td>
      <td>7</td>
      <td>0</td>
      <td>6</td>
      <td>1</td>
      <td>96</td>
    </tr>
    <tr>
      <th>4</th>
      <td>Tpr_TRINITY_DN10853_c1_g4|Tdu_TRINITY_DN21860_...</td>
      <td>524</td>
      <td>31</td>
      <td>1</td>
      <td>61</td>
      <td>97</td>
      <td>21</td>
      <td>16</td>
      <td>101</td>
      <td>81</td>
      <td>19</td>
      <td>773</td>
    </tr>
  </tbody>
</table>
</div>




```python
df.rename(columns={"BOTH_ALL":"Count"}, inplace=True)
# change the name of the column "BOTH_ALL" to "Count"; inplace=True means modifing the DataFrame in-place (do not reture a copy)
```


```python
df.head()
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>FUSION_ID</th>
      <th>BOTH_EXACT</th>
      <th>BOTH_INEXACT_EQUAL</th>
      <th>SAM_A_ONLY_EXACT</th>
      <th>SAM_B_ONLY_EXACT</th>
      <th>SAM_A_EXACT_SAM_B_INEXACT</th>
      <th>SAM_B_EXACT_SAM_A_INEXACT</th>
      <th>SAM_A_ONLY_SINGLE_INEXACT</th>
      <th>SAM_B_ONLY_SINGLE_INEXACT</th>
      <th>SAM_A_INEXACT_BETTER</th>
      <th>SAM_B_INEXACT_BETTER</th>
      <th>Count</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>0</th>
      <td>Tpr_TRINITY_DN11257_c2_g1|Tdu_TRINITY_DN16696_...</td>
      <td>58</td>
      <td>8</td>
      <td>51</td>
      <td>0</td>
      <td>8</td>
      <td>0</td>
      <td>3</td>
      <td>0</td>
      <td>11</td>
      <td>7</td>
      <td>92</td>
    </tr>
    <tr>
      <th>1</th>
      <td>Tpr_TRINITY_DN10844_c2_g7|Tdu_TRINITY_DN25328_...</td>
      <td>124</td>
      <td>15</td>
      <td>7</td>
      <td>1</td>
      <td>6</td>
      <td>1</td>
      <td>9</td>
      <td>1</td>
      <td>8</td>
      <td>3</td>
      <td>157</td>
    </tr>
    <tr>
      <th>2</th>
      <td>Tpr_TRINITY_DN15383_c4_g16|Tdu_TRINITY_DN14160...</td>
      <td>26</td>
      <td>4</td>
      <td>9</td>
      <td>0</td>
      <td>3</td>
      <td>0</td>
      <td>1</td>
      <td>0</td>
      <td>1</td>
      <td>2</td>
      <td>36</td>
    </tr>
    <tr>
      <th>3</th>
      <td>Tpr_TRINITY_DN1451_c0_g1|Tdu_TRINITY_DN16990_c...</td>
      <td>65</td>
      <td>1</td>
      <td>10</td>
      <td>0</td>
      <td>23</td>
      <td>0</td>
      <td>7</td>
      <td>0</td>
      <td>6</td>
      <td>1</td>
      <td>96</td>
    </tr>
    <tr>
      <th>4</th>
      <td>Tpr_TRINITY_DN10853_c1_g4|Tdu_TRINITY_DN21860_...</td>
      <td>524</td>
      <td>31</td>
      <td>1</td>
      <td>61</td>
      <td>97</td>
      <td>21</td>
      <td>16</td>
      <td>101</td>
      <td>81</td>
      <td>19</td>
      <td>773</td>
    </tr>
  </tbody>
</table>
</div>




```python
df[["FUSION_ID","Count"]].to_csv(out_name, index=False)
# save the df as csv file, including columns "FUSION_ID" and "Count"; without index
```


```python

```
