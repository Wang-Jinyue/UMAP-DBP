import numpy as np
import pandas as pd
from sklearn.decomposition import FactorAnalysis


datafile = u'D:\\paper\\DNA Binding protein\\data\\feature extraction\\S2\\combine.xlsx'
data = pd.read_excel(datafile,header = None)
print(data.shape)
data_fea = data.iloc[:, 0:]
data_fea = data_fea.fillna(0)


data_mean = data_fea.mean()
data_std = data_fea.std()
data_fea = (data_fea - data_mean) / data_std

FA = FactorAnalysis(n_components=1915).fit_transform(data_fea.values)

from sklearn import preprocessing

min_max_scaler = preprocessing.MinMaxScaler()
FA = min_max_scaler.fit_transform(FA)
pd.DataFrame(FA).to_csv('factor_analysisBP594.csv', header = False, index = False)
