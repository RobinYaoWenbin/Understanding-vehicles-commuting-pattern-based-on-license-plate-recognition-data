# -*- coding: utf-8 -*-
"""
Created on Sun Jan 12 14:25:53 2020

@author: Administrator
"""

"""
定义一些DBSCAN相关的函数,包括初始参数获取,DBSCAN的实现等等
"""

import pandas as pd
import matplotlib.pyplot as plt
from matplotlib.dates import AutoDateLocator, DateFormatter 
import numpy as np
from sklearn import metrics,datasets,manifold
import sklearn.cluster as skc  # 密度聚类
from multiprocessing import Process
from multiprocessing import Manager
from mpl_toolkits.mplot3d import Axes3D

def calculate_distance_matrix(x,y):   #1-两个向量的余弦相似度
    d = metrics.pairwise_distances(x,y)
    return d

def GetEps(df):
    # get DBSCAN's initial parameter of eps, and display the eps array by the boxplot and histogram
    # df: the input df is the array of features
    D = calculate_distance_matrix(df.values , df.values)
    D = np.sort(D) #对每一行进行从小到大的排序
    eps_array = D.sum(axis=0)  #对二维矩阵按列求和
    eps_array = eps_array / len(eps_array)  # 取平均
    
    # 使用箱型图可视化展示eps数组
    plt.rcParams['font.sans-serif'] = ['SimHei']  #显示中文字符
    plt.rcParams['axes.unicode_minus']=False  # 用来正常显示负号
    # plt.rcParams['savefig.dpi'] = 300 #图片像素
    plt.rcParams['figure.dpi'] = 150 #分辨率
    ax1 = plt.subplot()  # 创建作图区域
    plt.boxplot(eps_array)
    ax1.set_xticklabels([r"$eps$"])
    ax1.grid(True)
    # plt.savefig('eps分布图.png')
    plt.show()

    # 使用直方图可视化展示eps数组
    ax2 = plt.subplot()  # 创建作图区域
    plt.hist(eps_array)
    ax2.set_ylabel("The number of vehicles")
    plt.show()

    return eps_array

def testGetEps():
    # test the correct of the function GetEps
    df = pd.DataFrame([[1 , 2 , 3],
                        [2 , 3 , 6]])
    print("The input df is : ")
    print(df)
    eps_array = GetEps(df)
    print("The eps array is : " , eps_array)

def GetMinPts(df , eps):
    #该函数获取最优的MinPts值
    D = calculate_distance_matrix(df.values , df.values)
    length = len(D[np.where(D <= eps)] )
    MinPts = length / len(D) - 1
    return MinPts

def testGetMinPts():
    # test the correct of the function GetMinPts
    df = pd.DataFrame([[1 , 2 , 3],
                        [2 , 3 , 6]])
    print("The input df is : ")
    print(df)
    minPts = GetMinPts(df , 4)
    print("The minPts is : ", minPts)

def DBSCAN(df , eps_set , MinPts ):
    #该函数对df中的数据进行DBSCAN聚类,并输出相应的信息和可视化结果
    # df is the dataframe where one column is a feature, eps_set and MinPts is the initial parameter of the DBSCAN 
    db = skc.DBSCAN(eps = eps_set, min_samples = MinPts, metric = 'euclidean').fit(df.values) #DBSCAN聚类方法 还有参数，matric = ""距离计算方法
    labels = db.labels_  #和X同一个维度,labels对应索引序号的值 为她所在簇的序号。若簇编号为-1则表示为噪声
    n_clusters_ = len(set(labels)) - (1 if -1 in labels else 0)  # 获取分簇的数目
    print('每个样本的簇标号:')
    print(labels)

    raito = len(labels[labels[:] == -1]) / len(labels)  #计算噪声点个数占总数的比例
    print('噪声比:', format(raito, '.2%'))

    print('分簇的数目: %d' % n_clusters_)

    # calculate the silhoutte value
    if -1 in labels:
        DataWithoutOutliers = df.values[labels != -1]
        LabelsWithoutOutliers = labels[labels != -1]
        silhouettevalue = metrics.silhouette_score(DataWithoutOutliers, LabelsWithoutOutliers , metric='euclidean')
    else:
        silhouettevalue = metrics.silhouette_score(df.values , labels , metric='euclidean')
    print("轮廓系数: %0.3f" %silhouettevalue ) #轮廓系数评价聚类的好坏

    # 绘制出样本的聚类结果中的各个簇
    plt.rcParams['font.sans-serif'] = ['SimHei']  #显示中文字符
    plt.rcParams['axes.unicode_minus']=False  # 用来正常显示负号
    # plt.rcParams['savefig.dpi'] = 300 #图片像素
    plt.rcParams['figure.dpi'] = 150 #分辨率
    fig = plt.figure()
    ax = Axes3D(fig)
    ax.set_xlabel('Factor 1')
    ax.set_ylabel('Factor 2')
    ax.set_zlabel('Factor 3')
    for i in range(n_clusters_):
        one_cluster = df.values[labels == i]
        ax.scatter(one_cluster[:,0],one_cluster[:,1],one_cluster[:,2] , s = 1 , c = None)
    # plt.savefig("不包含噪声的样本数据分簇情况.png")
    plt.show()

    fig = plt.figure()
    ax = Axes3D(fig)
    ax.set_xlabel('Factor 1')
    ax.set_ylabel('Factor 2')
    ax.set_zlabel('Factor 3')
    for i in range(n_clusters_ + 1):
        one_cluster = df.values[labels == i-1]
        ax.scatter(one_cluster[:,0],one_cluster[:,1],one_cluster[:,2] , s = 1 , c = None)
    # plt.savefig("所有样本数据分簇情况.png")
    plt.show()

    return labels

def testDBSCAN():
    # test the correct of the function DBSCAN
    df = pd.DataFrame([[1 , 2 , 3],
                    [2 , 3 , 6],
                    [4 , 2 , 5],
                    [2 , 2 , 5],
                    [4 , 3 , 5]])
    labels = DBSCAN(df , 2 , 1)


if __name__ == "__main__":
    # testGetEps()
    # testGetMinPts()
    testDBSCAN()