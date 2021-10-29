# -*- coding: utf-8 -*-
"""
Created on Sat Apr 27 17:05:55 2019

@author: Administrator
"""
import math
import pandas as pd
import matplotlib.pyplot as plt
import copy
import numpy as np
from mpl_toolkits.mplot3d import Axes3D

def get_data():
    df = pd.read_csv("example.csv")
    return df

# 计算两个模式样本之间的欧式距离
def dist(data1, data2):
    #计算x , y的欧氏距离,也可以通过此函数来达到使用不同度量距离的目的,输入时两个坐标值[x0 , y0] , [x1 , y1]
    distance = 0
    for i in range(len(data1)):
        distance += pow((data1[i]-data2[i]), 2)
    return math.sqrt(distance)

def cal_density(data , n , dc):
    '''
    #该函数用来计算各个样本点的密度,并返回密度值
    data:所有的样本点二维矩阵
    n:本函数计算第n个样本点的密度
    dc:截断距离
    返回值:第n个样本点的密度p
    注:个数是从0开始计数的
    '''
    count_den = 0  #密度值初始化为0
    sample_n = data[n]
    for index in range(len(data)):
        if index != n:
            dis = dist(sample_n , data[index])
            if dis < dc:
                count_den += 1
    return count_den

def get_biggest_index(density_list):
    #本函数获取list中的最大值的下标,并返回(若该list中有多个相同的最大值,则返回第一个最大值的下标)
    max_ele = -1
    max_index = -1
    for index in range(len(density_list)):
        if density_list[index] > max_ele:
            max_ele = density_list[index]
            max_index = index
    return max_index

def step1(data , t):
    '''
    初始化及预处理
    data:需要处理的数据,是二维数组的形式
    t为确定阶段距离dc的参数t,意为平均每个点的邻居个数为总点数的t
    返回值:升序排序后的距离矩阵,截断距离dc , 各个样本点的密度数组 , 密度降序排序后的元素下标序列 , 密度更大的最近元素下标序 , 
    各元素离比它密度更大的最近元素的距离
    '''
    N = len(data)
    M = 0.5 * N * (N - 1)
    k = round(M * t)  #dij从小到大排序后,dc所在的元素的下标
    dist_sample = []
    for i in range(N - 1):
        for j in range(i + 1 , N):
            dist_sample.append(dist(data[i] , data[j]))
    dist_sample.sort(reverse = False)  #对各样本点间的距离按照升序排列
    dc = dist_sample[k]  #获取阶段距离
    sample_density = []  #各个样本点的密度数组
    for i in range(N):
        sample_density.append(cal_density(data , i , dc))
    sample_density_copy = copy.deepcopy(sample_density)  #对密度数组进行深拷贝
    density_rank = []  #各个样本点的密度按照降序排列后的各个密度值对应的原样本点序列的下标值数组,即算法中的q数组
    for i in range(N):
        density_rank.append(get_biggest_index(sample_density_copy))
        sample_density_copy[density_rank[i]] = -1
    n_list =  [ -1 for i in range(N)]  #算法中的ni组成的数组 , 意为每个元素的比它密度更大的元素中离其最近的那个元素的下标
    dmax = max(dist_sample)  #获取各样本点间的最大距离
    delta_sample = [ -1 for i in range(N)]  #算法中的delta数组,记录的是各元素离比它密度更大的样本点的最近距离
    for i in range(1 , N):
        delta_sample[density_rank[i]] = dmax + 0.000000001
        for j in range(0 , i):
            if dist(data[ density_rank[i] ] , data[ density_rank[j] ]) < delta_sample[ density_rank[i] ]:
                delta_sample[density_rank[i]] = dist(data[ density_rank[i] ] , data[ density_rank[j] ])
                n_list[ density_rank[i] ] = density_rank[j]
    delta_sample[ density_rank[0] ] = max( delta_sample )
    return dist_sample , dc , sample_density , density_rank , n_list , delta_sample

def show_data(data):
    #本代码用来展示原来的数据分布
    if len(data[0]) == 2:
        plt.scatter(data[:,0] , data[:,1])
        plt.show()
    elif len(data[0]) == 3:
        fig = plt.figure()
        ax = Axes3D(fig)
        ax.scatter(data[: , 0] , data[: , 1] , data[: , 2] , s = 1, c=None )
        ax.set_xlabel("Factor 1") ; ax.set_ylabel("Factor 2") ; ax.set_zlabel("Factor 3") 
        plt.show()
    else:
        print("数据维数不是2维或3维,无法可视化展示!")

def decition_graph(sample_density , delta_sample):
    '''
    本函数用来绘制决策图
    sample_density:各样本的密度数组,当做横坐标
    delta_sample:各样本的距离数组,当做纵坐标
    本函数无返回值,将决策图存为png格式至本地
    '''
    plt.scatter(sample_density , delta_sample)
    # plt.savefig("决策图.png")
    plt.show()

def identify_cluster_num(N , density_delta_multi):
    '''
    #本函数用来识别聚类的簇的数目
    N:样本数据的个数
    density_delta_multi:各个样本的密度和距离数组的对应元素的乘积得到的系数对应的数组
    '''
    density_delta_multi_copy = copy.deepcopy(density_delta_multi)  #对density_delta_multi数组进行深拷贝
    density_delta_multi_copy.sort(reverse = True)  #对系数按照降序排列
    x_axis = [ i for i in range(N)]
    plt.scatter(x_axis , density_delta_multi_copy)
    plt.show()

def step2(data , sample_density , delta_sample , n_cluster):
    '''
    确定聚类中心,并初始化数据点归属类标记
    sample_density:样本点的密度值数组
    delta_sample:样本点的距离数组
    n_cluster:簇的数目(刚开始可以预估一个,然后利用step2中的簇个数识别函数来得到最优的簇数目,后更改该变量即可)
    返回值:cluster_center_index(聚类中心的下标数组) , tag_list(各个样本的属性标签数组)
    '''
    density_delta_multi = np.multiply(np.array(sample_density),np.array(delta_sample))
    density_delta_multi = density_delta_multi.tolist()  #样本的密度数组与样本的距离数组中的对应元素相乘,生成density_delta_multi数组
    # identify_cluster_num(len(data) , density_delta_multi)  #识别簇的数目
    cluster_center_index = []  #该数组存放聚类中心的编号,分别为第0个聚类中心的编号,第1个聚类中心的编号```,即算法中的mi
    density_delta_multi_copy = copy.deepcopy(density_delta_multi)  #对density_delta_multi数组进行深拷贝
    for i in range(n_cluster):
        cluster_center_index.append(get_biggest_index(density_delta_multi_copy))
        density_delta_multi_copy[cluster_center_index[i]] = -1
    tag_list = [ -1 for i in range(len(data))]  #初始化样本的属性标记数组,即算法中的ci
    for i in range(len(cluster_center_index)):
        tag_list[ cluster_center_index[i] ] = i
    return cluster_center_index , tag_list

def step3(data , tag_list , density_rank , n_list):
    '''
    对非聚类中心点进行归类
    data:原样本
    tag_list:各个样本的属性标签数组
    density_rank:各样本点的密度降序的下标数组
    n_list: 密度更大的最近元素下标序
    返回值:更新后的各样本点属性标签下标数组
    '''
    for i in range(1 , len(data)):
        if tag_list[ density_rank[i] ] == -1:
            tag_list[ density_rank[i] ] = tag_list[ n_list[ density_rank[i] ] ]
    return tag_list


def step4(data , cluster_center_index , tag_list , dc , sample_density):
    '''
    若nc>1,则将每一个簇中的数据都分成cluster core 和cluster halo
    cluster_center_index:聚类中心的下标数组
    tag_list:各样本的属性标签数组
    dc:截断距离
    sample_density:各样本的密度数组
    返回值:各样本点的核心or光晕标签,每个簇的平均密度上界
    '''
    N = len(data)
    #step4.1
    tag_core_halo = [ 0 for i in range(N)]  #step4.1,初始化核心or边界标记

    #step4.2,为每一个cluster生成一个平均局部密度上届density_peak数组
    density_peak = [0 for i in range(len(cluster_center_index))]  #初始化平均局部密度上界数组
    for i in range(0 , (N - 1) ):
        for j in range((i+1) , N):
            if tag_list[i] != tag_list[j] and dist(data[i] , data[j]) < dc:
                avg_density = 0.5*(sample_density[i] + sample_density[j])
                if avg_density > density_peak[ tag_list[i] ]:
                    density_peak[ tag_list[i] ] = avg_density
                if avg_density > density_peak[ tag_list[j] ]:
                    density_peak[ tag_list[j] ] = avg_density

    #step4.3, 标记cluster halo , tag_core_halo值为1就是halo,  0就是core
    for i in range(N):
        if sample_density[i] < density_peak[ tag_list[i] ]:
            tag_core_halo[i] = 1

    return tag_core_halo , density_peak

def test():
    #编写过程中检验正确性的代码
    df = get_data()
    data = df.values
    # print(data)
    dist_sample , dc , sample_density , density_rank , n_list , delta_sample = step1(data , 0.2)
    '''
    #检验下step1的正确性,已经检验,step1正确
    print("dist_sample:" , dist_sample)
    print("dc:" , dc)
    print("sample_density:" , sample_density)
    print("density_rank:" , density_rank)
    print("n_list:" , n_list)
    print("delta_sample:" , delta_sample)
    '''
    show_data(data)
    decition_graph(sample_density , delta_sample)
    cluster_center_index , tag_list = step2(data , sample_density , delta_sample , 2)
    print("cluster_center_index:" , cluster_center_index)
    print("tag_list:" , tag_list)
    tag_list = step3(data , tag_list , density_rank , n_list)
    print("tag_list:" , tag_list)
    tag_core_halo , density_peak = step4(data , cluster_center_index , tag_list , dc , sample_density)
    print("tag_core_halo:" , tag_core_halo)
    print("density_peak:" , density_peak)

def plot_final_result(data , tag_list):
    #本函数用来绘制最后聚类后的结果
    #data:原样本数据 , tag_list:各样本的标签列表
    if len(data[0]) == 2:
        df = pd.DataFrame(data, columns=['x', 'y'])
        df['tag'] = tag_list
        plt.scatter(df[df['tag'] == 0]['x'] , df[df['tag'] == 0]['y'])
        plt.scatter(df[df['tag'] == 1]['x'] , df[df['tag'] == 1]['y'])
        plt.show()
    elif len(data[0]) == 3:
        df = pd.DataFrame(data, columns=['f1', 'f2' , 'f3'])
        df['tag'] = tag_list
        fig = plt.figure()
        ax = Axes3D(fig)
        ax.scatter(df[df['tag'] == 0]['f1'] , df[df['tag'] == 0]['f2'] ,df[df['tag'] == 0]['f3'], s = 1, c=None )
        ax.scatter(df[df['tag'] == 1]['f1'] , df[df['tag'] == 1]['f2'] ,df[df['tag'] == 1]['f3'], s = 1, c=None )
        ax.scatter(df[df['tag'] == 2]['f1'] , df[df['tag'] == 2]['f2'] ,df[df['tag'] == 2]['f3'], s = 1, c=None )
        ax.set_xlabel("Factor 1") ; ax.set_ylabel("Factor 2") ; ax.set_zlabel("Factor 3") 
        plt.show()


def main():
    #tag_list就是最后各个样本点的簇归属属性,cluster_center_index为聚类中心的下标
    df = get_data()
    data = df.values
    # print(data)
    dist_sample , dc , sample_density , density_rank , n_list , delta_sample = step1(data , 0.2)  #0.2为一个参数,每个点领域范围内的点个数占总样本的个数的比例
    cluster_center_index , tag_list = step2(data , sample_density , delta_sample , 3)  #2是聚类中心的个数,可以交互确定
    tag_list = step3(data , tag_list , density_rank , n_list)
    tag_core_halo , density_peak = step4(data , cluster_center_index , tag_list , dc , sample_density)

    plot_final_result(data , tag_list)

def fast_search_and_find_density_peaks(data , cluster_num , t_percent):
    '''
    本函数用来封装前面的各个函数,作为一个调用函数
    data:输入二维数组
    cluster_num:要分成几个簇
    输出:聚类中心的下标数组,各样本的所属中心的标签数组,各样本为中心or光晕数组
    '''
    dist_sample , dc , sample_density , density_rank , n_list , delta_sample = step1(data , t_percent)  #0.2为一个参数,每个点领域范围内的点个数占总样本的个数的比例
    cluster_center_index , tag_list = step2(data , sample_density , delta_sample , cluster_num)  #2是聚类中心的个数,可以交互确定
    tag_list = step3(data , tag_list , density_rank , n_list)
    tag_core_halo , density_peak = step4(data , cluster_center_index , tag_list , dc , sample_density)
    print("dc:" , dc)
    return cluster_center_index , tag_list , tag_core_halo

if __name__ == "__main__":
    main()
    # test()



    
    # df = get_data()
    # data = df.values
    # cluster_center_index , tag_list , tag_core_halo = fast_search_and_find_density_peaks(data)
    # plot_final_result(data , tag_list)
