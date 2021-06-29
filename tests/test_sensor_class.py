import unittest
import sys
sys.path.append('..')
from sensor.sensor import Sensor, SensorArray,_parse_uncertainty, _read_sensor_array_from_file
from yaml import Loader

class TestClassInstantation(unittest.TestCase):

    file = 'input_files\\test_sensor.yml'

    def test_from_file_method(self):

        expected_names = ['HeaterInlet1','HeaterInlet2','HeaterInlet3','HeaterInlet4','StaticPressureVenturi','PressureDifferential']
        sensor_array = SensorArray.from_file(self.file)
        for sensor in sensor_array.values():
            self.assertIn(sensor.name,expected_names)
    
    def test_initialization_from_dict(self):

        sensor_dict = _read_sensor_array_from_file(self.file)

        sensor_array = SensorArray(sensor_dict)
        self.assertEqual(sensor_array.HeaterInlet1.id,'T1')

    def test_initialization_from_sensor_array(self):

        input_array = SensorArray.from_file(self.file)

        sensor_array = SensorArray(input_array)

        for key in input_array:
            for item in input_array[key]:
                if item != '_Sensor__compiled_converter':
                    self.assertIn(item,list(sensor_array[key].keys()))

    def test_from_keys_method(self):

        keys = ['HeaterInlet1','HeaterInlet2']
        sensor_array = SensorArray.fromkeys(keys)
        self.assertEqual(sensor_array.HeaterInlet1,{'_Sensor__compiled_converter': None})

    def test_write_method(self):
        check_sensor_write = 'check_files\\check_write_sensor.yaml'
        sensor_array = SensorArray.from_file(self.file)
        sensor = sensor_array.HeaterInlet1
        data = sensor.to_file(check_sensor_write)
        check_sensor_array = SensorArray.from_file(check_sensor_write)

    def test_write_array_method(self):

        check_write_array = 'check_files\\check_write_sensor.yaml'
        sensor_array = SensorArray.from_file(self.file)
        print(sensor_array)
        sensor_array.to_file(check_write_array)
        check_sensor_array = SensorArray.from_file(check_write_array)

        for sensor in sensor_array:
            self.assertEqual(sensor_array[sensor],check_sensor_array[sensor])
        

        



unittest.main()