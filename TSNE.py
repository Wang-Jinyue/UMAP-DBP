import numpy as np
import pandas as pd
from sklearn.manifold import TSNE

datafile = u'D:\\paper\\DNA Binding protein\\data\\feature extraction\\S2\\combine.xlsx'
data = pd.read_excel(datafile,header = None)
data_fea = data.iloc[:, 0:]
data_fea = data_fea.fillna(0)

data_mean = data_fea.mean()
data_std = data_fea.std()
data_fea = (data_fea - data_mean) / data_std

tsne = TSNE(n_components=3, n_iter=1000).fit_transform(data_fea.values)

from sklearn import preprocessing

min_max_scaler = preprocessing.MinMaxScaler()
tsne = min_max_scaler.fit_transform(tsne)
pd.DataFrame(tsne).to_csv('TSNE_BP594.csv', header = False, index = False)
