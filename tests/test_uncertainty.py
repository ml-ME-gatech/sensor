import unittest
import pandas as pd
import numpy as np
import sys
sys.path.append('..')
from sensor.sensor import Sensor, SensorArray,_parse_uncertainty

class TestUncertaintyParsing(unittest.TestCase):

    array = np.linspace(0,1,10)*1e-4
    expected_output = np.array([0, 0.28490028, 0.56980057, 0.85470085, 1.13611111, 1.41388889, 1.69166667,1.96944444,2.24722222,2.525])
    
    def test_float_uncertainty(self):

        uncertainty = _parse_uncertainty('2.2 [C]')

        self.assertEqual(uncertainty,[(2.2,'C')])

    def test_percentage_uncertainty(self):

        uncertainty = _parse_uncertainty('50 [%]')

        self.assertEqual(uncertainty,[(50,'%')])

    def test_equation_uncertainty(self):

        uncertainty = _parse_uncertainty('y = 50*x +1 [C]')[0]
        self.assertEqual(uncertainty[1],'C')
        self.assertEqual(uncertainty[0](2),101)
    
    def test_library_equation_uncertainty(self):

        uncertainty = _parse_uncertainty('<typeK_thermocouple> [C]')[0]
        self.assertEqual(uncertainty[1],'C')

        out = uncertainty[0](self.array)
        
        self.assertLess(np.linalg.norm(self.expected_output-out),1e-8)

    def test_multiple_uncertainty(self):

        string_list = ['2.2 [C]','50 [%]','y = 50*x + 1 [V]','<typeK_thermocouple> [C]']
        units = ['C','%','V','C']
        uncertainty = _parse_uncertainty(string_list)

        for unc,u in zip(uncertainty,units):
            self.assertEqual(unc[1],u)

        self.assertEqual(uncertainty[0][0],2.2)
        self.assertEqual(uncertainty[1][0],50)
        self.assertEqual(uncertainty[2][0](2),101)

        self.assertLess(np.linalg.norm(self.expected_output-uncertainty[3][0](self.array)),1e-8)

    def test_incorrect_equation(self):
        
        with self.assertRaises(NameError):
            _parse_uncertainty('equation_that_does_not_exist [A]')
        
    def test_no_units(self):

        uncertainty = _parse_uncertainty('2.2')[0]
        self.assertEqual(uncertainty[0],2.2)
        self.assertEqual(uncertainty[1],'')

    def test_with_operator(self):

        operator,uncertainty = _parse_uncertainty('max')
        self.assertEqual(uncertainty,[])
        self.assertEqual(operator([0,1]),1)
    
    def test_operator_with_other(self):

        operator,uncertainty = _parse_uncertainty(['2.2 [C]','min','4.7 [%]'])

        self.assertEqual(operator([0,1]),0)
        self.assertEqual(uncertainty[0][0],2.2)
        self.assertEqual(uncertainty[1][0],4.7)
        self.assertEqual(uncertainty[0][1],'C')
        self.assertEqual(uncertainty[1][1],'%')
    
    def test_multiple_operator(self):

        operator,_ = _parse_uncertainty(['2.2 [C]','min','4.7 [%]','median'])

        self.assertEqual(operator([0,1]),0.5)

    def test_multiple_letter_unit(self):

        uncertainty = _parse_uncertainty('3.4470e4 [PA]')
        self.assertEqual(uncertainty[0][0],34470.0)

    def test_zero_uncertainty(self):

        uncertainty = _parse_uncertainty('0 [PA]')
        self.assertEqual(uncertainty[0][0],0)

class TestApplyingUncertainty(unittest.TestCase):

    array = np.linspace(0,1,10)
    signal1 = pd.Series(array,name = 'T1 [C]')
    signal2 = pd.Series(array,name = 'T14 [C]')
    signal3 = pd.Series(array,name = 'T1 [V]')*1e-4
    signal4 = pd.Series(array,name = 'T1 [A]')
    signal5 = pd.Series(array,name = 'T11 [C]')
    signal6 = pd.Series(array,name = 'T12 [C]')
    signal7 = pd.Series(array,name = 'T13 [C]')
    signal8 = pd.Series(array*500,name = 'T2 [C]')
    
    SensorArray = SensorArray.from_file('input_files\\test_us.yml')
    sensor1 = SensorArray.HeaterInlet1
    sensor11 = SensorArray.HeaterInlet11
    sensor12 = SensorArray.HeaterInlet12
    sensor13 = SensorArray.HeaterInlet13
    sensor2 = SensorArray.HeaterInlet2

    def test_basic_uncertainty_calculation(self): 
        
        output = self.sensor1.calculate_uncertainty(self.signal1)
        self.assertEqual(np.linalg.norm(output.to_numpy()-np.ones(self.array.shape)*2.2),0)
        self.assertEqual(output.name, 'T1 [C]')

    def test_incorrect_name_uncertainty_calculation(self):
        
        with self.assertRaises(ValueError):
            output = self.sensor1.calculate_uncertainty(self.signal2)
        
    def test_unconverted_uncertainty_calculation(self):
        
        output = self.sensor1.calculate_uncertainty(self.signal3)
        self.assertEqual(np.linalg.norm(output.to_numpy()-np.ones(self.array.shape)*2.2),0)
        self.assertEqual(output.name,'T1 [C]')

    def test_incorrect_units_uncertainty_calculation(self):
        
        with self.assertRaises(ValueError):
            output = self.sensor1.calculate_uncertainty(self.signal4)
    
    def test_inverse_uncertainty(self):

        with self.assertRaises(ValueError):
            output = self.sensor11.calculate_uncertainty(self.signal5)

    def test_applying_uncertainty_equation(self):

        out = self.sensor12.calculate_uncertainty(self.signal6)
        self.assertEqual(np.linalg.norm(out - (self.signal6*2+1)),0)

    def test_applying_percentage_uncertainty(self):

        out = self.sensor13.calculate_uncertainty(self.signal7)
        self.assertLess(np.linalg.norm(out- self.signal7*0.4),1e-12)

    def test_applying_uncertainty_with_operator(self):

        out = self.sensor2.calculate_uncertainty(self.signal8)
        
        constant = np.ones(self.signal8.shape)*2.2
        percentage = self.signal8*0.75/100.0

        check = np.max([constant,percentage],axis = 0)
        self.assertEqual(np.linalg.norm(out.to_numpy()-check),0)

    

unittest.main()