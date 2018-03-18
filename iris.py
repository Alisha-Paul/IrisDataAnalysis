from sklearn import datasets
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

from pandas.plotting import scatter_matrix
plt.style.use('ggplot')
iris = datasets.load_iris()
#print(type(iris))
#print(iris.keys())
#print(type(iris.data), type(iris.target))
#print(iris.data.shape)
#print(iris.target_names)
x = iris.data
y = iris.target
df = pd.DataFrame(x, columns=iris.feature_names)
print(df.head())
scatter_matrix(df, c=y, figsize=[16,16], s=150, marker = 'D')
plt.show()