# coding=utf8

# initial_set为初始设置，依次代表如下：
# nc : 预选nc个聚类中心
# K：希望的聚类中心个数
# min_num：每个聚类中最少样本数
# s：聚类域中样本的标准差阈值
# c：两聚类中心之间的最短距离
# L：在一次迭代中允许合并的聚类中心的最大对数
# I：允许迭代的次数
# k：分裂系数,分裂时会用到该系数

import math
import matplotlib.pyplot as plt
import pandas as pd
from k_means_cluster import classify, get_newcluster
from max_min_cluster import get_distance
from mpl_toolkits.mplot3d import Axes3D

def get_dis_sta(df):
    # 获得某个cluster的距离标准差的最大分量
    sta = []
    for i in range(df.shape[1]):
        #print(df.iloc[:,i])
        sta.append(df.iloc[:,i].std())
    x = max(sta)
    return x

def get_cen_dis(list_cen):
    # 计算所有簇的中心点间的两两的距离
    dis_cen = []
    for i in range(len(list_cen) - 1):
        for j in range(i+1 , len(list_cen)):
            dis_cen.append(get_distance(list_cen[i] , list_cen[j]))
    return dis_cen

def data_show(result):
    # 将一个簇内的数据可视化输出展示
    plt.rcParams['font.sans-serif'] = ['SimHei']  #显示中文字符
    plt.rcParams['axes.unicode_minus']=False  # 用来正常显示负号
    plt.rcParams['figure.dpi'] = 70 #分辨率
    cluster_num = []   #记录各个簇的样本数量
    cluster_sta = []   #记录各个簇的标准差最大分量
    cluster_cen = []   #记录各个簇的簇中心点
    fig = plt.figure()
    ax = Axes3D(fig)
    ax.set_xlabel("Factor 1") ; ax.set_ylabel("Factor 2") ; ax.set_zlabel("Factor 3") 
    for cluster in result:
        df_clu = pd.DataFrame(cluster)
        df_clu.rename(columns = {0:'f1' , 1:'f2' , 2:'f3'} , inplace = True)
        cluster_num.append(df_clu.shape[0])
        cluster_sta.append(get_dis_sta(df_clu))
        cluster_cen.append([df_clu.mean()[0] , df_clu.mean()[1], df_clu.mean()[2]])
        ax.scatter(df_clu['f1'] , df_clu['f2'] , df_clu['f3'] , s = 1, c=None )

    dis_cen = get_cen_dis(cluster_cen)
    print("各个簇的样本个数:" , cluster_num)
    print("各个簇的标准差最大分量:" , cluster_sta)
    print("各个簇中心间的距离:" , dis_cen)
    plt.show()

class IsoData(object):

    def __init__(self, initial_set, data):
        # initial_set 为初始设置集合，依次为nc,K,min_num,s,c,L,I,k
        self.nc = initial_set[0]
        self.K = initial_set[1]
        self.min_num = initial_set[2]
        self.s = initial_set[3]
        self.c = initial_set[4]
        self.L = initial_set[5]
        self.I = initial_set[6]
        self.k = initial_set[7]

        self.current_i = 1  # 目前迭代的次数
        self.data = data  # 数据集
        self.cluster_center = []  # 聚类中心list
        self.result = []  # 聚类结果
        self.inner_mean_distance = []  # 类内平均距离
        self.all_mean_distance = 0  # 全部样本的总体平均距离

        self.step1()

    def step1(self):

        # 预选nc个聚类中心

        for i in range(self.nc):
            self.cluster_center.append(self.data[i])
            self.result.append([self.data[i]])
        self.step2()

    def step2(self):

        # 最近邻规则分类

        # self.result = []
        self.result = classify(self.data, self.cluster_center)
        #print("聚类结果:" , self.result)
        self.step3()

    def step3(self):

        # 判断Sj中样本数Nj是否小于min_num,小于的话就去掉这个中心
        small_index = []
        for i in range(len(self.result)):
            if len(self.result[i]) < self.min_num:
                #self.result.pop(i)
                #self.cluster_center.pop(i)
                small_index.append(i)
                #self.nc -= 1
        small_index.sort( reverse = True)
        if small_index != []:
            for need_pop in small_index:
                self.result.pop(need_pop)
                self.cluster_center.pop(need_pop)
                self.nc -= 1
        #print("small_index:" , small_index)
        self.step4()

    def step4(self):

        # 修正各聚类中心值

        self.cluster_center = get_newcluster(self.result)
        #print("各个聚类中心值:" ,self.cluster_center)
        self.step5_6()

    def step5_6(self):

        # 计算类内平均距离以及全部样本的总体平均距离
        self.inner_mean_distance = []
        self.all_mean_distance = 0
        for i in range(len(self.result)):
            inner_dis = 0
            for j in range(len(self.result[i])):
                inner_dis += get_distance(self.result[i][j], self.cluster_center[i])
            self.all_mean_distance += inner_dis
            inner_dis = inner_dis / len(self.result[i])
            self.inner_mean_distance.append(inner_dis)
            #print("每个簇内的平均距离:" , self.inner_mean_distance)
        self.all_mean_distance = self.all_mean_distance / len(self.data)
        #print("所有聚类的平均距离:",self.all_mean_distance)
        self.step7()

    def step7(self):

        # 判断是进行分裂还是合并

        if self.current_i >= self.I:
            self.c = 0
            self.step11_12_13_14()
        elif self.nc <= self.K / 2:    #进行分裂操作
            self.step8_9_10()
        elif (self.current_i % 2 is 0) or self.nc >= 2 * self.K:    #进行合并操作
            self.step11_12_13_14()
        else:
            self.step8_9_10()

    def step8_9_10(self):

        # 第八、九、十步：计算每个聚类中样本的标准差向量；求每个标准差向量的最大分量；
        # 在最大分量集中，根据条件判断下一步

        index_list = [0 for i in range(len(self.result))]  # 对应最大分量的分量序号
        max_standard_dev = [0 for i in range(len(self.result))]  # 最大分量集

        for i in range(len(self.result)):
            temp = 0
            # 记录标准差向量的最大分量及对应分量序号
            max_index = 0
            index = 0

            for j in range(len(self.data[0])):   #j是第几维的意思
                for k in range(len(self.result[i])):
                    temp += math.pow(self.result[i][k][j]- self.cluster_center[i][j], 2)
                temp = math.sqrt(temp / len(self.result[i]))
                if temp > max_index:
                    max_index = temp
                    index = j
                    index_list[i] = index
                    max_standard_dev[i] = max_index
                temp = 0
            #print("最大分量对应的序号:" , index_list)
            #print("最大分量集:" , max_standard_dev)

        # 第十步：判断,是否需要分裂
        tag = 0   #用来判别是否已经进行分裂,0未进行分裂,而1是已经进行分裂
        for i in range(len(max_standard_dev)):
            new_cluster1 = [0 for m in range(len(self.data[0]))]   #分裂后的第一个cluster
            new_cluster2 = [0 for m in range(len(self.data[0]))]   #分裂后的第二个cluster
            if max_standard_dev[i] > self.s and \
                    ((self.inner_mean_distance[i] > self.all_mean_distance and len(self.result[i]) > 2 * (self.min_num + 1)) or self.nc <= self.K / 2):
                for j in range(len(self.cluster_center[i])):  #j是第j维的意思
                    if j is not index_list[i]:
                        new_cluster1[j] = self.cluster_center[i][j]
                        new_cluster2[j] = self.cluster_center[i][j]
                    else:
                        new_cluster1[j] = self.cluster_center[i][index_list[i]] + self.k * max_standard_dev[i]
                        new_cluster2[j] = self.cluster_center[i][index_list[i]] - self.k * max_standard_dev[i]
                self.cluster_center.append(new_cluster1)
                self.cluster_center.append(new_cluster2)
                self.cluster_center.pop(i)
                self.current_i += 1
                self.nc += 1
                #print("分裂后的中心:" , self.cluster_center)
                tag = 1  #已进行分裂
                self.step2()
                break

        if tag == 0:
            self.step11_12_13_14()


    def step11_12_13_14(self):

        # 第十一、十二步：计算所有聚类中心之间的距离，并将小于c的值存入list按升序排列
        # 储存小于c的距离以及对应聚类中心下标的map

        dis_index = {}
        for i in range(0, self.nc - 1):
            for j in range(i+1, self.nc):
                indexes = [0, 0]  # 下标数组
                dis_temp = get_distance(self.cluster_center[i], self.cluster_center[j])
                #print(self.cluster_center)
                #print(i ,j ,self.cluster_center[i] , self.cluster_center[j] , dis_temp)
                if dis_temp < self.c:
                    indexes[0] = i
                    indexes[1] = j
                    dis_index[dis_temp] = indexes

        # 距离按升序排列后的list
        dis_list = list(dis_index.keys())
        dis_list.sort(reverse=False)    #升序排列
        #print(dis_list)
        #print(dis_index)

        #判断一下dist_list中有多少个元素,if 元素数量少于L,就需要进行调整
        if len(dis_list) < self.L:
            L_temp = len(dis_list)
        else:
            L_temp = self.L

        # 第十三步：合并

        # 已经合并过的聚类的标号
        already_index = []
        for i in range(L_temp):   #最多只能合并L对中心
            # 即将合并的聚类的标号
            index = dis_index.get(dis_list[i])    #取出第i小距离的两个簇的中心的标号,分别为index[0] and index[1]
            #print(index)
            # 判断是否合并过
            if not (index[0] in already_index  or index[1] in already_index):
                # 新聚类中心
                #print(self.cluster_center)
                #print(self.cluster_center[index[1]])
                new_cluster = [0 for i in range(len(self.data[0]))]
                for j in range(len(new_cluster)):    #计算合并后的cluter的坐标值
                    new_cluster[j] = (len(self.result[index[0]]) * self.cluster_center[index[0]][j]
                                      + len(self.result[index[1]]) * self.cluster_center[index[1]][j]) \
                                     / (len(self.result[index[0]]) + len(self.result[index[1]]))
                #print(new_cluster)
                self.cluster_center.append(new_cluster)
                #self.cluster_center.pop(index[0])
                #self.cluster_center.pop(index[1] - 1)
                already_index.append(index[0])
                already_index.append(index[1])
                self.nc -= 1
                #print(self.cluster_center)
        if already_index != []:
            already_index.sort(reverse=True)    #升序排列
            for need_pop in already_index:
                self.cluster_center.pop(need_pop)
        #print("合并后的簇中心:" , self.cluster_center)

        # 第十四步：判断
        #print("循环次数:" , self.current_i)
        data_show(self.result)
        if self.current_i < self.I:
            flag = input("是否需要修改参数,输入“y”确认修改,“n”取消\n")
            if flag == "y":
                self.nc = int(input("nc:"))
                self.K = int(input("K:"))
                self.min_num = int(input("min_num:"))
                self.s = float(input("s:"))
                self.c = float(input("c:"))
                self.L = int(input("L:"))
                self.I = int(input("I:"))
                self.k = float(input("k:"))
                self.current_i += 1
                self.step1()
            else:
                self.current_i += 1
                self.step2()
