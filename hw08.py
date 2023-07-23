import numpy as np

data = np.matrix([
    [26, 28, 31, 36],
    [30, 33, 27, 31],
    [30, 32, 28, 33],
    [29, 28, 32, 30],
    [32, 27, 31, 26],
])

T = data.sum()
CT = (T**2) / (data.shape[0] * data.shape[1])
Ti = data.sum(1).T
Tj = data.sum(0)

sst = np.square(data).sum() - CT
ssa = (np.square(Ti)/data.shape[1]).sum() - CT
ssb = (np.square(Tj)/data.shape[0]).sum() - CT
sse = sst-ssa-ssb
