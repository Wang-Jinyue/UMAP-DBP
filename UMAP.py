import numpy as np
import pandas as pd
import umap
from pandas import DataFrame as df

# 导入数据
datafile = u'D:\\paper\\DNA Binding protein\\data\\feature extraction\\S1\\combine.xlsx'
data = pd.read_excel(datafile,header = None)
print(data.shape)
data_fea = data.iloc[:, 0:]  # 取数据中指标所在的列
data_fea = data_fea.fillna(0)  # 填补缺失值

# 标准化
data_mean = data_fea.mean()
data_std = data_fea.std()
data_fea = (data_fea - data_mean) / data_std

# 降维
umap_data = umap.UMAP(n_neighbors=96, min_dist=0.1, n_components=871).fit_transform(data_fea.values)
# 归一化
from sklearn import preprocessing

min_max_scaler = preprocessing.MinMaxScaler()
umap_data = min_max_scaler.fit_transform(umap_data)
pd.DataFrame(umap_data).to_csv('871.csv', header = False, index = False)
