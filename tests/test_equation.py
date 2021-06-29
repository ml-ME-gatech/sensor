import unittest
import sys
import numpy as np
sys.path.append('..')
from sensor.sensor import PermanentEquationLibraryPath, Sensor, SensorArray,_sensor_equation_compiler,TemporaryEquationLibraryPath, _get_conversion_libs,add_conversion_library, remove_conversion_library
from scipy.optimize import newton
import os

class TestEquationParsing(unittest.TestCase):

    def test_explicit_equation1(self):
        equation1 = 'y = 7*x**2 + 1'
        function = _sensor_equation_compiler(equation1)
        self.assertEqual(function(2),7*2**2+1)

    def test_explicit_equation2(self):

        func = lambda x: x**2 + np.sqrt(x)
        equation2 = 'x**2 + np.sqrt(x) = y'
        function = _sensor_equation_compiler(equation2)
        for i in range(0,10):
            self.assertEqual(func(i),function(i))
    
    """
    def test_implicit_equation1(self):

        equation1 = 'y = y**(1/2) + 14'
        func = lambda y: y**(1/2) - y + 14

        output = newton(func,0)
        function = _sensor_equation_compiler(equation1)
        print(function(np.zeros([1])))
        self.assertEqual(function(0),output)

    """

class TestEquationLibraryManagement(unittest.TestCase):

    def test_reading_equation_from_default_library(self):

        equation = '<test_equation_for_library_management_check_12305912350981235>'
        function = _sensor_equation_compiler(equation)
        self.assertEqual(function(1),1)


    def test_reading_equation_from_default_library_that_does_not_exit(self):

        equation = '<test_equation_for_library_management_check_434523462346>'
        with self.assertRaises(FileNotFoundError):
            function = _sensor_equation_compiler(equation)


    def test_temporarily_adding_library_and_reading_equation(self):

        libpath = os.path.join(os.getcwd(),'input_files\\test_equation_library.py')
        equation = '<test_equation_for_library_management_check_434523462346>'
        with TemporaryEquationLibraryPath(libpath):
            libs = _get_conversion_libs()
            self.assertIn(libpath,libs)
            function = _sensor_equation_compiler(equation)
        
        self.assertEqual(function(3),3)

    def test_permanent_adding_library_and_reading_equation(self):
        
        libpath = os.path.join(os.getcwd(),'input_files\\test_permanent_adding_library.py')
        equation = '<test_equation_for_library_management_check_2345982345>'

        add_conversion_library(libpath)

        function = _sensor_equation_compiler(equation)
        libs = _get_conversion_libs()
        self.assertIn(libpath,libs)

        self.assertEqual(function(4),4)
        
        remove_conversion_library(libpath)
        libs = _get_conversion_libs()
        self.assertNotIn(libpath,libs)
        
        
unittest.main()
