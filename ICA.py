import numpy as np
import pandas as pd
from sklearn.decomposition import FastICA

# 导入数据
datafile = u'D:\\paper\\DNA Binding protein\\data\\feature extraction\\S2\\combine.xlsx'
data = pd.read_excel(datafile,header = None)
data_fea = data.iloc[:, 0:]
data_fea = data_fea.fillna(0)

# 标准化
data_mean = data_fea.mean()
data_std = data_fea.std()
data_fea = (data_fea - data_mean) / data_std

ICA = FastICA(n_components=594)
X = ICA.fit_transform(data_fea.values)

from sklearn import preprocessing

min_max_scaler = preprocessing.MinMaxScaler()
X = min_max_scaler.fit_transform(X)
pd.DataFrame(X).to_csv('ICABP594.csv', header = False, index = False)