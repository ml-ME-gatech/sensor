import numpy as np
import pandas as pd
import os
from scipy.interpolate import interp1d

TCDB = {'B':[0,1],
        'E':[2,3],
        'J':[4,5],
        'K':[6,7],
        'N':[8,9],
        'R':[10,11],
        'S':[12,13],
        'T':[14,15]}

def thermocouple_conversion(voltage_input: np.ndarray,
                            ttype: str) -> np.ndarray:

    """
    Converts input voltage array into celcius units using linear interpolation
    and the data contained in the file: tcdat.csv, which should be contained
    in the same directory as this file
    """

    if not isinstance(voltage_input,np.ndarray) and not isinstance(voltage_input,pd.Series) and not isinstance(voltage_input, pd.DataFrame):
        raise TypeError('voltage input must be a numpy ndarray, pandas Series, or pandas DataFrame')

    if not isinstance(ttype,str):
        raise TypeError('thermocouple type must be a string')

    if ttype not in TCDB:
        raise ValueError('thermocouple type: {} not recognized'.format(ttype))

    path,_ = os.path.split(__file__)
    df = pd.read_csv(os.path.join(path,'tcdat.csv'),
                     sep = ',', skiprows = 2,
                     names = ['Temperature','Voltage'],usecols = TCDB[ttype])

    df.dropna(inplace = True)
    df['Voltage']*=1e-3
    
    if df['Voltage'].max() < voltage_input.max():
        raise ValueError('input voltage is greater than allowable input for data tables')

    if df['Voltage'].min() > voltage_input.min():
        raise ValueError('input voltage is less than allowable input')

    return interp1d(df['Voltage'].to_numpy(),
                    df['Temperature'].to_numpy())(voltage_input)

def typeK_thermocouple(array):

    return thermocouple_conversion(array,'K')

def main():

    from matplotlib import pyplot as plt

    k_type = np.linspace(-6.458,54.886,1643*10)
    temperature = typeK_thermocouple(k_type*1e-3)
    print(temperature)
    fig,ax = plt.subplots()
    ax.set_xlabel('Voltage [mV]',fontsize = 14)
    ax.set_ylabel('Temperature [C]',fontsize = 14)
    ax.plot(k_type,temperature,color = 'blue')
    plt.show()

if __name__ == '__main__':
    main()


