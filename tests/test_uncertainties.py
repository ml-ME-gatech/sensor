import unittest
import numpy as np
import pandas as pd
import sys
sys.path.append('..')
from sensor.sensor import Sensor, SensorArray
from uncertainties import unumpy

np.random.seed(30)

class TestUncertaintiesArrayGeneration(unittest.TestCase):

    def test_uncertainty_series(self):
        
        signal = np.linspace(40,500,1000) 
        std_deviation = np.max(np.array([np.ones(signal.shape)*2.2,signal*0.75/100]),axis = 0)
        signal  += np.random.normal(0,std_deviation)
        signal = pd.Series(signal,name = 'T1 [C]')

        sensor = SensorArray.from_file('input_files\\test_sensor.yml').HeaterInlet1

        x = sensor.uArray(signal)
        #print(x.mean())
        x = sensor.uSeries(signal)


    def test_basic_operaations(self):

        signal = np.linspace(40,500,1000) 
        std_deviation = np.max(np.array([np.ones(signal.shape)*2.2,signal*0.75/100]),axis = 0)
        signal  += np.random.normal(0,std_deviation)
        signal1 = pd.Series(signal,name = 'T1 [C]')
        
        tsignal = np.ones(1000)*16e-3
        std_deviation = np.random.normal(0,0.2/100*18e-3)
        signal2 = pd.Series(signal + std_deviation,name = 'P1 [A]')

        sensor_array =SensorArray.from_file('input_files\\test_sensor.yml')
        thermocouple = sensor_array.HeaterInlet1
        static_pressure = sensor_array.StaticPressureVenturi

        T1 = thermocouple.uArray(signal1)
        P1 = static_pressure.uArray(signal2)

        PT = P1*T1

        T1 = thermocouple.uSeries(signal1)
        P1 = static_pressure.uSeries(signal2)
        
        PT = T1*P1
        print(PT)

    def test_frame_manipulation(self):

        signal = np.linspace(40,500,1000) 
        std_deviation = np.max(np.array([np.ones(signal.shape)*2.2,signal*0.75/100]),axis = 0)
        signal  += np.random.normal(0,std_deviation)
        signal1 = pd.Series(signal,name = 'T1 [C]')
        
        tsignal = np.ones(1000)*16e-3
        std_deviation = np.random.normal(0,0.2/100*18e-3)
        signal2 = pd.Series(signal + std_deviation,name = 'P1 [A]')

        df = pd.concat([signal1,signal2],axis = 1)
        sensor_array =SensorArray.from_file('input_files\\test_sensor.yml')

        uarr = sensor_array.uArray(df)

        uFrame = sensor_array.uDataFrame(df)
        #print(uFrame)


unittest.main()