import unittest
import pandas as pd
import numpy as np
import sys
sys.path.append('..')
from sensor.sensor import Sensor, SensorArray

class TestSensorMarkdown(unittest.TestCase):

    sensor_file = 'input_files\\test_sensor.yml'
    check_md_output_file = 'check_files\\test_sensor.md'
    dummy_md_writing_file = 'check_files\\test_sensor_dumy.md'
    check_md_heaterintlet1_output_file = 'check_files\\test_sensor_HeaterInlet1.md'

    def test_basic_writing_to_md(self):

        #check that the to_md output returns previously verified results
        sensor_array = SensorArray.from_file(self.sensor_file)
        with open(self.check_md_output_file,'r') as file:
            check_txt = file.read()
            self.assertEqual(check_txt,sensor_array.to_md(self.check_md_output_file))

        #check that the write function to a file works as epxected
        sensor_array.to_md(self.check_md_output_file)

    def test_single_sensor_md_function(self):
        sensor_array = SensorArray.from_file(self.sensor_file)
        md = sensor_array.HeaterInlet1.to_md()
        #check previously verified results
        with open(self.check_md_heaterintlet1_output_file,'r') as file:
            self.assertEqual(md,file.read())

class TestSensorTables(unittest.TestCase):
    """
    At the moment this pretty much just makes sure that no errors are thrown using diffreent kwargs and such
    and the actual testing of the desired output is pretty limited.
    """
    sensor_file = 'input_files\\test_table.yaml'
    basic_tbl_check = 'check_files\\basic_table.txt'

    def test_basic_to_table(self):

        sensor_array = SensorArray.from_file(self.sensor_file)
        table = sensor_array.to_table()
        
    def test_include_kwarg(self):
        
        sensor_array = SensorArray.from_file(self.sensor_file)
        table = sensor_array.to_table(include = ['id','part_number','name'])

        #test that the required items are in the table
        for name in ['id','part_number','name']:
            self.assertIn(name,table)
        
        #check a couple of the other items to ensure they are not in the table
        for name in ['date','equation','measure_units']:
            self.assertNotIn(name,table)
    
    def test_exclude_kwarg(self):

        sensor_array = SensorArray.from_file(self.sensor_file)
        names = ['location','measure_min','measure_max','voltage_min','voltage_max','current_max','current_min']
        table = sensor_array.to_table(exclude = names)

        for n in names:
            self.assertNotIn(n,table)
    
    def test_different_table_fmts(self):

        sensor_array = SensorArray.from_file(self.sensor_file)
        table = sensor_array.to_table(include = ['id','part_number','name'],tablefmt = 'grid')
    
        table = sensor_array.to_table(include= ['id','part_number','name'],tablefmt = 'asdgasdg')

    def test_header_fmt(self):

        sensor_array = SensorArray.from_file(self.sensor_file)
        table = sensor_array.to_table(include = ['id','part_number','name'],tablefmt = 'grid',headerfmt = 'id')
    
    def test_attribute_columns(self):

        sensor_array = SensorArray.from_file(self.sensor_file)
        table = sensor_array.to_table(include = ['id','part_number','name'],tablefmt = 'grid',headerfmt = 'id',columns = 'attribute')

unittest.main()