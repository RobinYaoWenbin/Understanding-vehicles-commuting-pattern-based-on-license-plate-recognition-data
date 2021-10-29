# -*- coding: utf-8 -*-
"""
Created on Mon Mar 25 15:28:32 2019

@author: Administrator
"""

import scipy
import scipy.cluster.vq
import scipy.spatial.distance
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
EuclDist = scipy.spatial.distance.euclidean
import mpl_toolkits.mplot3d.axes3d as p3

def gapStat(data, resf=None, nrefs=10, ks=range(1,10)):
    '''
    Gap statistics
    '''
    # MC
    shape = data.shape
    if resf == None:
        x_max = data.max(axis=0)
        x_min = data.min(axis=0)
        dists = np.matrix(np.diag(x_max-x_min))
        rands = np.random.random_sample(size=(shape[0], shape[1], nrefs))
        for i in range(nrefs):
            rands[:,:,i] = rands[:,:,i]*dists+x_min
    else:
        rands = resf
    gaps = np.zeros((len(ks),))
    gapDiff = np.zeros(len(ks)-1,)
    sdk = np.zeros(len(ks),)
    for (i,k) in enumerate(ks):
        (cluster_mean, cluster_res) = scipy.cluster.vq.kmeans2(data = data, k = k , iter = 15)
        Wk = sum([EuclDist(data[m,:], cluster_mean[cluster_res[m],:]) for m in range(shape[0])])
        WkRef = np.zeros((rands.shape[2],))
        for j in range(rands.shape[2]):
            (kmc,kml) = scipy.cluster.vq.kmeans2(data = rands[:,:,j], k = k , iter = 15)
            WkRef[j] = sum([EuclDist(rands[m,:,j],kmc[kml[m],:]) for m in range(shape[0])])
        gaps[i] = scipy.log(scipy.mean(WkRef))-scipy.log(Wk)
        sdk[i] = np.sqrt((1.0+nrefs)/nrefs)*np.std(scipy.log(WkRef))

        if i > 0:
            gapDiff[i-1] = gaps[i-1] - gaps[i] + sdk[i]
    return gaps, gapDiff

'''
# 测试案例(csdn博主的源码里给出的case)
mean = (1, 2)
cov = [[1, 0], [0, 1]]
#np.random.multivariate_normal(1.1, [[0,1],[1,0]])
Nf = 1000;
dat1 = np.zeros((3000,2))
dat1[0:1000,:] = np.random.multivariate_normal(mean, cov, 1000)
mean = [5, 6]
dat1[1000:2000,:] = np.random.multivariate_normal(mean, cov, 1000)
mean = [3, -7]
dat1[2000:3000,:] = np.random.multivariate_normal(mean, cov, 1000)
plt.plot(dat1[::,0], dat1[::,1], 'b.', linewidth=1)
plt.legend()

gaps,gapsDiff = gapStat(dat1)
print("data:" , dat1)
print("gaps:" , gaps)
print("gaps_diff:",gapsDiff)

x_axis = range(1 , 10)
f, (a1,a2) = plt.subplots(2,1)
a1.plot(x_axis , gaps, 'g-o')
a2.bar(np.arange(1 , len(gapsDiff) + 1),gapsDiff)
f.show()
'''
