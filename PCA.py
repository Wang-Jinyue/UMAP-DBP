import numpy as np
import pandas as pd
from sklearn.decomposition import PCA

# 导入数据
datafile = u'D:\\paper\\DNA Binding protein\\data\\feature extraction\\S2\\combine.xlsx'
data = pd.read_excel(datafile,header = None)
data_fea = data.iloc[:, 0:]  # 取数据中指标所在的列
data_fea = data_fea.fillna(0)  # 填补缺失值

# 标准化
data_mean = data_fea.mean()
data_std = data_fea.std()
data_fea = (data_fea - data_mean) / data_std

# 选取主成分的个数为25
pca = PCA(n_components=550)
pca_result = pca.fit_transform(data_fea.values)

from sklearn import preprocessing

min_max_scaler = preprocessing.MinMaxScaler()
PCA = min_max_scaler.fit_transform(pca_result)
pd.DataFrame(PCA).to_csv('PCABP594.csv', header = False, index = False)