from scipy.io import loadmat
from scipy.interpolate import interp1d
import pandas as pd
import numpy as np
from typing import Union

DATA = loadmat('GASPROPTABLE3')
DF = pd.DataFrame(DATA['PropData'], columns = [p[0] for p in DATA['Prop'][0]])

gas_row_index = {'air':[0,35],
                'he': [35,316],
                'ar':[316,347],
                'co2':[347,383], 
                'h2o':[383,-1]}

def get_property(T: Union[np.ndarray,float],
                prop: str,
                gas: str):

    """
    get the property specified by property of the gas specified by "gas" at the temperature specified by "T"
    """

    gas = gas.lower()
    if gas not in gas_row_index:
        raise ValueError('You have specified a gas that is not in the data base')

    return interp1d(DF['T'][gas_row_index[gas][0]:gas_row_index[gas][1]],
                    DF[prop][gas_row_index[gas][0]:gas_row_index[gas][1]])(T)

