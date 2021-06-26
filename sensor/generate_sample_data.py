import pandas as pd
from scipy.special import expit
import numpy as np
from matplotlib import pyplot as plt

np.random.seed(5)

gains = {'T1 [C]':1.5,
         'T2 [C]':1.55,
         'T3 [V]':1.45e-4,
         'T4 [V]':1.51e-4}

SAMPLE_RATE = 10 #s
data = dict.fromkeys(gains.keys())
columns = list(gains.keys()) + ['P1']
time = np.linspace(0,10*60*SAMPLE_RATE,10*60*SAMPLE_RATE)

for key in data:
    data[key] = gains[key]*expit(time)

fig,ax = plt.subplots()
ax.plot(data['T1 [C]'])
plt.show()