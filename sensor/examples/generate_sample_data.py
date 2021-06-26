import pandas as pd
from scipy.special import expit
import numpy as np
from matplotlib import pyplot as plt

np.random.seed(5)

gains = {'T1 [C]':150,
         'T2 [C]':150,
         'T3 [V]':6.45e-3,
         'T4 [V]':6.51e-3}

rates = {'T1 [C]':20,
         'T2 [C]':12,
         'T3 [V]':7,
         'T4 [V]':10}

SAMPLE_RATE = 10 #s
data = dict.fromkeys(gains.keys())
columns = list(gains.keys()) + ['P1 [A]']
time = np.linspace(0,10*60*SAMPLE_RATE,10*60*SAMPLE_RATE)

#add thermocouple measurements
for key in data:
    data[key] = gains[key]*(expit(rates[key]/time.max()*(time-time.mean())) + np.random.normal(0,0.0125,size = 10*60*SAMPLE_RATE))

# add pressure measurements
data['P1 [A]'] = 16*expit(4/time.max()*(time-time.mean()))+ 16*np.random.normal(0,0.00625,size = 10*60*SAMPLE_RATE)

#add dp measurements
data['DP1 [A]'] = 1.6*expit(8/time.max()*(time-time.mean()))+ 1.6*np.random.normal(0,0.00625,size = 10*60*SAMPLE_RATE)

df = pd.DataFrame.from_dict(data)
df.to_csv('artificial_data.csv')