import numpy as np
import pandas as pd
from sklearn import manifold


datafile = u'D:\\paper\\DNA Binding protein\\data\\feature extraction\\S2\\combine.xlsx'
data = pd.read_excel(datafile,header = None)
data_fea = data.iloc[:, 0:]
data_fea = data_fea.fillna(0)

data_mean = data_fea.mean()
data_std = data_fea.std()
data_fea = (data_fea - data_mean) / data_std

trans_data = manifold.Isomap(n_neighbors=50, n_components=297).fit_transform(data_fea.values)
# n_neighbors：决定每个点的相邻点数
# n_components：决定流形的坐标数
# n_jobs = -1：使用所有可用的CPU核心

from sklearn import preprocessing

min_max_scaler = preprocessing.MinMaxScaler()
trans_data = min_max_scaler.fit_transform(trans_data)
pd.DataFrame(trans_data).to_csv('Isomap_BP594.csv', header = False, index = False)