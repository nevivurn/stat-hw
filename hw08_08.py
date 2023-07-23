import numpy as np

data = np.array([
    [[12.5, 13.3], [12.6, 13.0], [12.9, 13.2], [13.0, 13.4]],
    [[12.6, 13.2], [12.5, 13.1], [13.1, 12.8], [12.9, 13.5]],
    [[11.9, 12.1], [12.0, 12.3], [12.7, 13.2], [14.2, 14.0]],
])

#data = np.array([
#    [[9, 14], [13, 16], [11, 12]],
#    [[14, 16], [18, 26], [11, 17]],
#    [[19, 22], [14, 18], [15, 16]],
#])

mean = data.mean()
mmeans = data.mean(2)
ameans = mmeans.mean(0)
bmeans = mmeans.mean(1)

sst = np.square(data-mean).sum()
ssa = data.shape[0] * data.shape[2] * np.square(ameans-mean).sum()
ssb = data.shape[1] * data.shape[2] * np.square(bmeans-mean).sum()
ssab = data.shape[2] * np.square(mmeans+mean - np.tile(ameans, (data.shape[0], 1)) - np.tile(bmeans, (data.shape[1], 1)).T).sum()
sse = np.square(data-np.dstack([mmeans]*2)).sum()
