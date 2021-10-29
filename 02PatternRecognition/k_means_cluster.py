# coding=utf-8

import math
from max_min_cluster import get_distance


def k_means_cluster(data, k):

    # 初始化k个聚类中心
    zs = [data[i] for i in range(k)]

    result = step2(data, zs)

    return result


def step2(data, zs):

    # 根据初始化聚类中心分类
    result = classify(data, zs)

    # 得到新的聚类中心向量值
    new_zs = get_newcluster(result)

    # 判断是否结束
    flag = is_end(zs, new_zs)
    if flag:
        return result
    else:
        return step2(data, new_zs)
        # step2(data, new_zs)
    # return step2(data, new_zs)


def is_end(zs, new_zs):

    # 判断是否结束

    # 遍历新老聚类中心是否相等，发现不相等的第一时间返回FALSE
    for i in range(len(zs)):
        for j in range(len(zs[i])):
            if math.fabs(float(zs[i][j]) - new_zs[i][j]) > 0.000000000000001:  # 浮点数比较大小不可以直接用'='号或者'is'
                return False
    return True


def get_newcluster(result):

    # 计算新的聚类中心向量值

    zs = []
    for aResult in result:
        z = []
        for i in range(len(aResult[0])):   #i的意思是第i维
            mean = 0
            for a in aResult:
                mean += a[i]
            mean /= float(len(aResult))
            z.append(mean)
        zs.append(z)
    return zs


def classify(data, zs):

    # 按最小距离原则分类

    result = [[] for i in range(len(zs))]

    for aData in data:
        min_distance = get_distance(aData, zs[0])
        index = 0
        for i in range(len(zs)):
            distance = get_distance(aData, zs[i])
            if distance < min_distance:
                min_distance = distance
                index = i
        result[index].append(aData)
    return result


# 测试k_means_cluster
# data = [[0, 0], [1, 0], [0, 1], [1, 1], [2, 1], [1, 2], [2, 2], [3, 2], [6, 6], [7, 6], [8, 6], [6, 7], [7, 7],
# [8, 7], [9, 7], [7, 8], [8, 8], [9, 8], [8, 9], [9, 9]]
# k = 2
# result = k_means_cluster(data, k)

# for i in range(len(result)):
#     print "----------第" + str(i+1) + "个聚类----------"
#     print result[i]
