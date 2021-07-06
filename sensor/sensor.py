from numpy import lib
from yaml import load as yaml_load, dump as yaml_dump, Loader, dump_all as yaml_dump_all
from tabulate import tabulate
from functools import partial
from typing import Union
import numpy as np
import pandas as pd
from scipy.optimize import newton
from copy import deepcopy
import os
import sys
import ast
import importlib
from abc import ABC,abstractmethod
from uncertainties import unumpy

"""
Creation:
Author(s): Michael Lanahan 
Date: 06.16.2021

Last Edit: 
Editor(s): Michael Lanahan
Date: 07.02.2021

-- Description -- 
classes for working with sensor.yaml files specified format in the sensor_fmt.yaml file
"""

RESERVED_ARRAY_NAMES = ['diagram']

class Sensor(dict): 
    """ 
    Sensor

    Description
    ----------
    a sensor class. Essentially a dictionary that may be manipulated as an object

    Attributes
    ----------
    attributes are read from sensor files. Attributes specific in the class include:
    
    compiled_converter: the result of the _sensor_equation_compiler of the provided "equation" in the file


    Methods
    ----------
    to_md - return a textual representation of the sensor in a markdown list format
    convert - function that once called converts the input data file from signal units
              to measure units according to the equation property. Note that if the input is 
              already in measure units (judged by column name) then function will not be applied
    _check_signal - check to make sure sensor and signal are compatible
    convert - converts a supplied signal given as a Series based upon a matching equation in a Sensor class
    calculate_uncertainty - calculates the uncertainty in a signal based upon a supplied Series using the uncertainty property
    """
    PROPERTIES = ['_Sensor__compiled_converter']

    def __init__(self,input_dict:dict):
        
        dict.__init__(self,input_dict)
        self.__dict__ = input_dict
        self.__compiled_converter = None

    @property
    def compiled_converter(self):
        if self.__compiled_converter is None:
            try:
                self.__compiled_converter =  _sensor_equation_compiler(self.__dict__['equation'])
            except (KeyError,AttributeError):
                raise AttributeError('sensor: {} has failed to specify an equation and a converter may not be compiled'.format(str(self)))

        return self.__compiled_converter

    @compiled_converter.setter
    def compiled_converter(self,cc):
        self.__compiled_converter = cc

    def set_equation(self,eq:callable):

        if not callable(eq):
            raise TypeError('equation must be callable')
        
        self.compiled_converter = eq

    def __getattr__(self,name):
        try:
            return self.__dict__[name]
        except KeyError:
            raise AttributeError(name)

    def remove_properties(self):
        
        _dict = deepcopy(self.__dict__)
        for key in self.PROPERTIES:
            try:
                del _dict[key]
            except KeyError:
                pass
        
        return _dict

    def to_file(self, file = None, 
                      dict_representation = False):

        """
        return the dictionary representation suitable for writing to a file
        """

        _write_to_file = {self.__dict__['name']:self.remove_properties()}
        if dict_representation:
            return _write_to_file
        else:
            return _write_sensor_to_file(file,_write_to_file)
        
    def _check_signal(self,x:pd.Series) -> None:
        """ 
        checks to see if the signal and sensor are related by ensuring that x is a series
        and moreover that the name of the series is associated with either the id or the 
        name of the sensor
        """

        if not isinstance(x,pd.Series):
            raise TypeError('sensor conversion only applicable for pd.Series objects')

        _name,_ = _get_units(x.name,return_variable= True)
        _name = _name.strip()
        if self.id != _name and self.name != _name:
            raise ValueError('Cannot verify relationship between sensor with \nid: {} \nname: {} \nand input signal with \nname {}'.format(self.id,self.name,x.name))

    def convert(self,x: pd.Series,
                        root_finder = None) -> pd.Series:
        """
        convert an input signal x (a pd.Series) based upon the textual equation of the sensor
        checks to make sure that units are consistent, and also that a link between the name of the signal
        and the sensor can be established

        Parameters
        ----------
        x : pd.Series 
            the input signal, with a name with units i.e. "Temperature [C]" or "Current1 [A]"

        Returns
        ----------
        y: pd.Series
            the converted output signal, converted according to the "equation" field in the sensor
        """

        self._check_signal(x)
        input_unit,signal_unit,measure_unit = [_get_units(item) for item in [x.name,self.signal,self.measure_units]]
        if input_unit == measure_unit:
            #input already in correct units
            return x 
        elif input_unit == signal_unit:
            #convert input
            func = self.compiled_converter(x)
            if not callable(func):

                #function was determined to be explicit - return the evaluated result
                if isinstance(func,pd.Series):
                    return pd.Series(func.to_numpy(),index = x.index,name = x.name.replace(input_unit,measure_unit))
                    
                elif isinstance(func,np.ndarray):
                    return pd.Series(func,index = x.index,name = x.name.replace(input_unit,measure_unit))
                
                else:
                    return func

            else:
                #treating function as implicit - determine if a root finder needs to be supplied
                if root_finder is None:
                    def root_finder(f,shape):
                        return newton(f,np.zeros(shape))
    
            return pd.Series(root_finder(func,x.shape),
                             index = x.index,
                             name = x.name.replace(input_unit,measure_unit))

        else: 
            raise ValueError('Could not establish transformation between input units of {}, sensor measure units of {} and sensor signal units of {}'.format(input_unit,measure_unit,signal_unit))

    def calculate_uncertainty(self,x: pd.Series) -> pd.Series:

        """
        calculates the uncertainty of the signal based upon the uncertainty supplied by the sensor files
        checks to make sure that a relationship exists between the supplied signal x, and the uncertainty
        by verifying that either the signal or measure unit of the sensor matches the signal, and also that
        the name of the signal matches the id or the name of the sensor. Transforms input data to
        measure data if transformation has not been applied already. If an operator has been supplied
        applies the operator to the list of uncertainties before returning

        Parameters
        ----------
        x : pd.Series 
            the input signal, with a name with units i.e. "Temperature [C]" or "Current1 [A]"

        Returns
        ----------
        y: pd.Series
            the uncertainty of the input signal for each value of the input in the appropriate inputs
        """

        self._check_signal(x)
        operator = None
        uncertainty = _parse_uncertainty(self.uncertainty)
        if isinstance(uncertainty,tuple):
            operator,uncertainty = uncertainty

        output_name = x.name
        input_unit,signal_unit,measure_unit = [_get_units(item) for item in [x.name,self.signal,self.measure_units]]
        _useries = []
        for quantifier,unit in uncertainty:
            if unit == '%':
                series = x*quantifier/100
                _useries.append(series)
            else:
                if (unit == measure_unit and input_unit == measure_unit) or (unit == signal_unit and input_unit == signal_unit):
                    z = x
                elif unit == measure_unit and input_unit == signal_unit:
                    z = self.convert(x)
                    output_name = output_name.replace(input_unit,measure_unit)
                elif unit == signal_unit and input_unit == measure_unit:
                    raise ValueError('cannot calculate uncertainty for the signal unit: {} when the input unit of x is the measure unit: {}'.format(unit,input_unit))
                else:
                    raise ValueError('uncertainty unit {} does not match either input signal ({}) unit: {} or the measure unit '.format(unit,x.name,input_unit))
                
                if callable(quantifier):
                    uncertainty_quantification = quantifier(z)
                    if isinstance(uncertainty_quantification,pd.Series):
                        uncertainty_quantification  = uncertainty_quantification.to_numpy()
                    elif isinstance(uncertainty_quantification,np.ndarray):
                        pass
                    else:
                        raise TypeError('callable uncertainty quantification must return a numpy ndarray or a pandas series')

                else:
                    uncertainty_quantification = quantifier*np.ones(z.shape)

                _useries.append(uncertainty_quantification)

        df = pd.DataFrame(_useries)
        if operator is not None:
            out = np.array(operator(df,axis = 0))
        else:
            out =  np.squeeze(np.array(df))

        return pd.Series(out,index = x.index,name = output_name)

    def to_md(self, file = None) -> str:

        """
        Creates a bulleted markdown document containing the sensor information. Ignore "private" properties
        with _ the first character of the name
        
        Parameters
        ----------
        file : stream or path, optional
        the file to write the markdown summary to
        """

        txt_list = ['- ' + str(key) + ': ' + str(value) + '\n' for key,value in self.__dict__.items() if str(key)[0] != '_']
        txt = ''.join(txt_list)
        if file is not None:
            if isinstance(file,str):
                with open(file,'w') as f:
                    f.write(txt)
            else:
                file.write(txt)

        return txt

    def uSeries(self,x:pd.Series) -> pd.Series:

        """
        merging function between the computation of the sensor uncertainty and the uncertainties package
        """
        return pd.Series(self.uArray(x), 
                         index = x.index, name = x.name)

    def uArray(self,x:pd.Series) -> unumpy.uarray:
        
        return unumpy.uarray(x.to_numpy(),self.calculate_uncertainty(x).to_numpy())
        

class SensorArray(dict):
    """ 
    SensorArray

    Description
    ----------
    An array of sensors. Essentially a dictionary of Sensors with the key the name of the sensor. 
    Allows object access of the sensors

    Attributes
    ----------
    attributes are read from sensor files. Each Sensor that makes up the sensor array may be interpreted as an attribute.
    The only permanent attribute is the 'diagram' property which is intended to hold diagram files

    Methods
    ----------
    to_md - return a textual representation of the Sensor array as headed lists
    to_table - return a tabular representation of the Sensor array
    from_file - class method that reads in a SensorArray from a file - in yaml format
    convert- apply the conversion according to the sensor equation to all signals in a supplied DataFrame
    calculate_uncertainty- apply the uncertainty according to the uncertainty attribute of each sensor to all signals in a supplied DataFrame
    to_file - write the sensorarray to a file in yaml format
    fromkeys - class method that essentially does the same thing as the dictionary fromkeys method
                with conversion of the sensors to Sensor class
    """

    PROPERTIES = ['_SensorArray__diagram']

    def __init__(self,sensor_dict):
        
        if isinstance(sensor_dict,dict):
            d,_ = self.dictionary_to_sensor_array(sensor_dict)
        elif isinstance(sensor_dict,SensorArray):
            d = sensor_dict 
        else:
            raise TypeError('SensorArray may only be instantiated by a dictionary or another SensorArray')

        dict.__init__(self,d)
        self.__dict__ = d

    @property
    def diagram(self):
        return self.__diagram

    @diagram.setter
    def diagram(self,d):
        self.__diagram = d

    def to_md(self,file = None) -> str:
        
        """
        convert a sensorarray yaml information block into a markdown format. returns a string
        """

        txt_list = ['# ' + str(key) + '\n' + value.to_md() + '\n' for key,value in self.__dict__.items()]
        txt = ''.join(txt_list)
        
        if file is not None:
            if isinstance(file,str):
                with open(file,'w') as f:
                    f.write(txt)
            else:
                file.write(txt)

        return txt

    def sensor_columns(self,
                            table_dict:dict,
                            headerfmt: str) -> list:
        """
        return the sensorarray as a list that can be handled using the tabulate package
        using the different sensors as column headers with the heading attribute specified in
        headerfmt
        """

        rows = _get_unique_entries(table_dict)
        headers = [item[headerfmt] for item in self.__dict__.values()]
        headers.insert(0,'')

        table_list = [[] for _ in rows]
        for i,r in enumerate(rows):
            table_list[i].append(r)
            for key in table_dict:
                try:
                    table_list[i].append(table_dict[key][r])
                except KeyError:
                    table_list[i].append(None)

        return table_list,headers

    def attribute_columns(self,
                                table_dict:dict,
                                headerfmt:str) -> list:

        """
        return the sensorarray as a list that can be handled using the tabulate package, using the 
        different attributes specified in headermft as the column header
        """

        headers = list(_get_unique_entries(table_dict))
        table_list = []
        for i,key in enumerate(table_dict):
            table_list.append([self.__dict__[key][headerfmt]])
            for h in headers:
                try:
                    table_list[i].append(table_dict[key][h])
                except KeyError:
                    table_list[i].append(None)
        
        return table_list,headers

    def to_table(self, include = None,
                       exclude = None,
                       tablefmt = 'github',
                       headerfmt = 'name',
                       columns = 'sensor',
                       **kwargs) -> str:

        """
        convinience function to throw the sensor array into a table by sorting the underlying dictionary
        according to some limited parameters described below

        Parameters
        ----------
        include: specifies sensor properties to include in table, 
        exclude: key word specifies properties to exclude from table.
        tablefmt: feeds into tabulate function from tabulate package
        headerfmt: specifies what property to use as the header from the sensor array. 
        kwargs: fed into the tabulate function

        Returns
        ---------
        output from the tabulate function, a part of the tabulate package. this returns a string
        representation of the requested table
        """

        mydict = deepcopy(dict(self.__dict__))

        if include is None:
            table_dict = mydict
        else:
            table_dict = _get_included_keys(mydict,include)

        if exclude is not None:
            table_dict = _exclude_keys(table_dict,exclude)
        
        if columns == 'sensor':
            table_list,headers = self.sensor_columns(table_dict,headerfmt)
        elif columns == 'attribute':
            table_list,headers = self.attribute_columns(table_dict,headerfmt)
        else:
            raise ValueError('unrecognized column format: {}'.format(columns))

        return tabulate(table_list,headers = headers,tablefmt = tablefmt ,**kwargs)

    def __getattr__(self,name):
        try:
            return self.__dict__[name]
        except KeyError:
            raise AttributeError(name)

    @staticmethod
    def dictionary_to_sensor_array(idict:dict) -> dict:

        """
        parses a dictionary into a dictionary with the keys converted to Sensors
        """

        d = {key:Sensor(value) for key,value in idict.items() if str(key).lower() not in RESERVED_ARRAY_NAMES}
        if 'diagram' in d:
            return d,True
        else:
            return d,False
    
    def to_file(self, file = None,
                      sensor_names = None):

        """
        write a sensor array to a file
        """
        
        _to_file = self.remove_properties()
        if sensor_names is not None:
            _to_file = self._filter_sensor(_to_file,sensor_names)

        output = {key:value.to_file(dict_representation = True)[key] for key,value in _to_file.items()}
        _write_sensor_to_file(file,output)

    def remove_properties(self):
        """
        remove properties that are not supposed to be a part of the sensorarray to file representation
        """
        _dict = deepcopy(self.__dict__)
        for key in self.PROPERTIES:
            try:
                del _dict[key]
            except KeyError:
                pass
        
        return _dict
    
    @staticmethod
    def _filter_sensor(sensor_dict: dict,
                       names_to_filter: list) -> dict:
        """
        filter names of the sensor i.e. only select specific sensors from the representative dictionary
        """

        return {key:value for key,value in sensor_dict.items() if str(key) in names_to_filter}
        
    @classmethod
    def from_file(cls,file:str,
                  sensor_names = None):

        """
        reads a sensor array from a .yaml format. This is a class method that is intended to be the main instantiater of the SensorArrray class
        the file arument is either a file or buffer/stream , and the optional keyword argument sensor_names allows 
        specification of the sensors to be read. The default behaviour is to read all of the sensors in the file
        """
        _read = _read_sensor_array_from_file(file)
        if sensor_names is not None:
            read_ = deepcopy(_read)
            _read = cls._filter_sensor(read_,sensor_names)
        
        d,diagram = cls.dictionary_to_sensor_array(_read)
        _cls = cls(d)
        if diagram:
            _cls.diagram = _read['diagram']
        
        _cls.__dict__ = d
        return _cls

    @classmethod
    def fromkeys(cls,keys:list):

        """
        overrides the fromkeys method inherent in the dictionary class
        """

        idict = {key:{} for key in keys}
        d, _ = cls.dictionary_to_sensor_array(idict)
        _cls = cls(d)
        _cls.__dict__ = d
        return _cls

    def _map_columns_to_sensor_array(self,X:pd.DataFrame) -> dict:

        """
        maps all of the items in columns to the items in the sensor array. raises a ValueError
        if cannot find a relationship between the columns of X and the sensor array or if the relationshi is ambigious
        i.e. two sensors map to the same column of the data frame
        """

        def _sig_to_sense_filter(column, mapped_columns):
            """
            filter the mapping from signal to sensor
            """
            def _matching_comparison(column,sensor_name,sensor):
                """
                the condition to determine matching between signal and sensor
                """
                _sensor_name = sensor_name.strip()
                _column = _get_units(column,return_variable = True)[0].strip()
                if _sensor_name == _column or sensor.id == _column:
                    if mapped_columns[column] is None:
                        mapped_columns[column] = sensor
                    else:
                        raise ValueError("Sensors {} and {} both map to column {} in DataFrame".format(sensor_name,mapped_columns[column],column))
            
            #iterate over all the sensors
            for sensor_name,sensor in self.__dict__.items():
                _matching_comparison(column,sensor_name,sensor)
        
        #determine the mapping from signal to sensors
        mapped_columns = {c: None for c in X.columns}
        for column in X.columns:
            _sig_to_sense_filter(column,mapped_columns)

        
        #determine if there are extra signals
        for key,value in mapped_columns.items():
            if value is None:
                raise ValueError("signal: {} has no corresponding sensor".format(key))

        return mapped_columns

    def convert(self, X:pd.DataFrame,
                      root_finder = None) -> pd.DataFrame: 

        """
        applies the Sensor.convert method to every column in X - the array of signals where each column is a different signal
        """

        mc = self._map_columns_to_sensor_array(X)

        Y = []
        for column,sensor in mc.items():
            Y.append(sensor.convert(X[column],root_finder = root_finder))

        return pd.DataFrame(Y).T
    
    def calculate_uncertainty(self,X:pd.DataFrame) ->pd.DataFrame:
        
        """
        applies the Sensor.calculate_uncertainty method to every column in X - the array of signals where each column is a different signal
        """

        mc = self._map_columns_to_sensor_array(X)

        Y = []
        for column,sensor in mc.items():
            Y.append(sensor.calculate_uncertainty(X[column]))

        return pd.DataFrame(Y).T

    def uDataFrame(self,X:pd.DataFrame,**kwargs) -> pd.DataFrame:
        
        """
        hook from uncertainties package to pandas DataFrame object
        """

        return pd.DataFrame(self.uArray(X), 
                         index = X.index, columns = X.columns)


    def uArray(self,X:pd.DataFrame,**kwargs) -> pd.DataFrame:

        """
        cast signal into an uncertainties array
        """ 

        return unumpy.uarray(X.to_numpy(),self.calculate_uncertainty(X).to_numpy())


class EquationLibraryPath(ABC):

    """
    Class for handling the adding of paths to the equation library
    """
    
    def __init__(self,paths: Union[str,list]):

        #initialize variables
        self.paths = self.validate_libary_paths(paths)
        self.pathlibs = None
        self.path_to_path_libs = os.path.join(os.path.split(__file__)[0],'data\\conv_libs.txt')
        
    @staticmethod
    def validate_libary_paths(libpaths: Union[str,list]):

        """
        make sure the library paths are valid by checking if they exist, and that they are python modules
        """

        #check data types
        if isinstance(libpaths,str):
            paths = [libpaths]
        elif isinstance(libpaths,list):
            paths = libpaths

        #check to make sure paths exist, and make sure that it is a python module
        for path in paths:
            if not os.path.exists(path):
                raise FileNotFoundError('could not find library associated with path: {}'.format(path))
            _,ext = os.path.splitext(path)
            if ext != '.py':
                raise ValueError('libary must be a python module with a .py extension, you have specified the following module: {}'.format(path))
    
        return paths

    def filter_paths_from_file(self,pathlibs_to_exclude):
        """
        filter paths from the list of libraries contained in the conv_libs.txt file
        """

        path_to_path_libs,_ = os.path.split(__file__)
        write_paths = []
        with open(self.path_to_path_libs,'r') as file:
            for line in file.readlines():
                _f = True
                for path in pathlibs_to_exclude:
                    if line.strip('\n') == path:
                        _f = False
                
                if _f:
                    write_paths.append(line)
        
        return write_paths
                
    def __enter__(self):
        self.add_path()

    @abstractmethod
    def __exit__(self,exc_type, exc_val, exc_tb):
        pass

    def remove_path(self, lib_paths = None):
        """
        remove paths from the path lib. If the previous contents of the file have been recored in the pathlibs variable,
        just wrtie this. Otherwise, record the lines that need to be removed from the existing file
        """

        if self.pathlibs is None:
            if lib_paths is not None:
                self.paths += self.validate_libary_paths(lib_paths)
            
            write_paths = self.filter_paths_from_file(self.paths)
        else:
            write_paths = self.pathlibs
        
        with open(self.path_to_path_libs,'w') as file:
            file.write(''.join(write_paths))

    def add_path(self):

        """
        add paths to the libpath file. check to make sure that the paths are not already in the file
        and then append each new path to the end of the file
        """
        
        self.pathlibs = []
        _write = dict.fromkeys(self.paths)
        for key in _write:
            _write[key] = True
        
        with open(self.path_to_path_libs,'r') as file:
            for line in file.readlines():
                for path in self.paths:
                    if line.strip('\n') == path:
                        _write[path] = False
                else:
                    self.pathlibs.append(line)

        with open(self.path_to_path_libs,'a') as file:
            for key in _write:
                if _write[key]:
                    file.writelines(str(key)+'\n')
        
class TemporaryEquationLibraryPath(EquationLibraryPath):

    """
    Inherited class for handling the tempory adding of paths to the equation library
    as we can see, the added path is removed upon exit of the contextmanager 
    """

    def __init__(self,path):

        super().__init__(path)

    def __exit__(self,exc_type, exc_val, exc_tb):
        self.remove_path()

class PermanentEquationLibraryPath(EquationLibraryPath):

    """
    Inherited class for handling the permanent adding of paths to the equation library. No action is taken
    upon exit of the contextmanager
    """

    def __init__(self,path):

        super().__init__(path)

    def __exit__(self,exc_type, exc_val, exc_tb):
        pass

def add_conversion_library(library_name) -> None:

    """
    convenience function for adding an equation library
    """
    
    with PermanentEquationLibraryPath(library_name) as file:
        pass

def remove_conversion_library(library_name) -> None:

    """
    conveinience function for removing an equation library
    """
    
    TemporaryEquationLibraryPath([]).remove_path(lib_paths = library_name)

def _get_conversion_libs():

    """
    get available conversion libraries listed in:
    .data/conv_libs.txt

    check to make sure the libraries are python modules, and that they exist
    """

    libs = []
    path,_ = os.path.split(__file__)
    with open(os.path.join(path,'data\\conv_libs.txt'),'r') as file:
        for line in file.readlines():
            library_path = os.path.normpath(line.strip('\n'))
            if os.path.exists(library_path):
                library_path = os.path.abspath(library_path)
            else:
                library_path = os.path.join(path,library_path)

            _,ext = os.path.splitext(library_path)
            if ext == '.py' and os.path.exists(library_path):
                libs.append(library_path)
    
    return libs

def _get_unique_entries(table:dict) -> set:
    rows = []
    for key in table:
        for item in table[key]:
            rows.append(item)

    return set(rows)

def _get_included_keys(input_dict:dict,
                       keys: list) -> dict:

    """
    intended for a dictionary of dictionaries. For each item in the dictionary, pick from the subdictionaries
    only the keys specified by the second arguments, the list "keys"
    """

    output_dict = dict.fromkeys(input_dict.keys())
            
    for key in output_dict:
        output_dict[key] = {}
        for item in keys:
            output_dict[key][item] = input_dict[key][item]

    return output_dict

def _exclude_keys(input_dict:dict,
                  keys: list) -> dict:

    """
    intended for a dictionary of dictionaries. For each item in the dictionary, eclude from each subdictionaries
    all of the items specified by the second argument, the list "keys"
    """
    for key in input_dict:
        for item in keys:
            try:
                del input_dict[key][item]
            except KeyError:
                pass

    return input_dict

def yaml_file_handler(function: callable,
                      *args,
                      **kwargs) -> callable:

    """ 
    wrapper function for wrapping a yaml module to more easily handle the different cases of 
    str file paths or streams ect...
    """
    
    def yaml_wrapped(file: str,
                    access_mode: str,
                    data):

        def _yaml_handler(f):
            if data is None and f is not None:
                output = function(f,*args,**kwargs)
            elif data is not None and f is None:
                output = function(data,*args,**kwargs)
            else:
                output = function(data,f,*args,**kwargs)
            
            return output
        
        if isinstance(file,str):
            with open(file,access_mode) as f:
                return _yaml_handler(f)
        else:
            return _yaml_handler(file)

    return yaml_wrapped

def _read_sensor_array_from_file(file: str) -> dict:
    
    """
    light wrapping of the load function from pyyaml. may have to add more to this later
    if I decide to be more clever with the formatting of the sensor file
    """

    function = yaml_file_handler(yaml_load,Loader =Loader)
    return function(file,'r', None)

def _write_sensor_to_file(file:str,
                          data: dict) -> None:

    """
    light wrapping of the dump function pyyaml. May have to add more to this later
    """

    function = yaml_file_handler(yaml_dump, indent = 4,line_break = 2)
    return function(file,'w',data)


def _sensor_equation_compiler(string: str) -> callable:
    """
    Compile the equation string of the sensor.
    
    Explicit equation: expects y = f(x) or f(x) = y
    returns a callable item that returns a number or array-like item when called

    Implicit Equation: if not an explicit equation then converts expression
    h(x,y) = g(x,y) to f(x,y) = g(x,y) - h(x,y) then returns a callable that returns another callable. 
    The first callable expects the input "x". The second callable is then strictly a function of 
    y and may be solved using an optimization algorithm for y 

    Library equation: this is invoked if the equation specified is specified by <equation_name>
    in this case refer to the _library_sensor_equation below
    """

    #parser if it is explicit form
    def explicit_sensor_equation(eq_string):
        eq_string = 'lambda x: ' + eq_string        
        return eval(eq_string)

    #parser if it is implicit
    def implicit_sensor_equation(eq_string):
        eq_string = 'lambda x,y:' + eq_string 
        func = eval(eq_string)
        def eq(x):
            return partial(func,x)

        return eq

    _string = string.strip()
    #check to see if we need to be looking in python modules
    if _string[0] == '<' and _string[-1] == '>':
        return  _library_sensor_equation(_string)

    #check to see if this is even interpretable
    if '=' not in string:
        raise ValueError('Cannot interpret sensor equation with no equals sign')

    #clean up the text 
    lhs,rhs = [side.strip() for side in _string.split('=')]
    if lhs == 'y' and 'y' not in rhs:
        return explicit_sensor_equation(rhs)
    elif rhs == 'y' and 'y' not in lhs:
        return explicit_sensor_equation(lhs)
    else:
        return implicit_sensor_equation(rhs + ' - ' + lhs)

def _get_units(unit_containing_item: str,
               return_variable = False) -> Union[str,tuple]:

    """
    determine units from either the result of reading from a .yaml file or a string. Expects the units to be [U] in the string
    where U is the unit associated with the item. Imposes no restrictions on the proceeding value but returns it in a string
    format. Can return the variable or item in front of the unit if return_variable is set to True
    """

    if isinstance(unit_containing_item,str):
        if '[' not in unit_containing_item:
            if return_variable:
                return unit_containing_item, ''
            else:
                return ''

        start = unit_containing_item.find('[')
        end = unit_containing_item.find(']')
        if return_variable:
            return unit_containing_item[0:start],unit_containing_item[start+1:end]
        else:
            return unit_containing_item[start+1:end]

    elif isinstance(unit_containing_item,list):
        if len(unit_containing_item) != 1:
            raise ValueError('Must be a list of length 1')
        return unit_containing_item[0]
    else:
        raise TypeError("units may only be detected from list or string")

def _library_sensor_equation(string:str) -> callable:

    """
    if the string containing the equation in the sensor file has a leading < and trailing >
    so that it is specified as <equation_name> this function will parse through all conv_libs.txt
    python modules and attempt to find a matching function to this name. If not matching function is
    found, an error will be raised

    Parameters
    ----------
    string: str
            a string specifying the equation in <equation_name> format. The location of this
            equation MUST be specified in the conv_libs.txt file otherwise the compiler will 
            not be able to find it

    Returns
    ----------
    callable:
            a callable item 
    """

    #get the equation name we are looking for 
    #and the libraries to look across
    equation_name = string.strip()[1:-1]
    libs = _get_conversion_libs()

    #parses the contents of a python module using the Abstract Syntax Tree Library
    def _ast_parser(fname):
        with open(fname,'r') as file:
            return ast.parse(file.read(),filename = fname)

    #the importer function if the supplied equation is found
    def _importer(func_name,module_path):
        _,name = os.path.split(module_path)
        spec = importlib.util.spec_from_file_location(name, module_path)
        module = importlib.util.module_from_spec(spec)
        spec.loader.exec_module(module)
        return getattr(module,func_name)

    #the search logic across the libraries contained within the conversion libraries file
    for lib in libs:
        tree = _ast_parser(lib)
        top_level_functions = [f for f in tree.body if isinstance(f,ast.FunctionDef)]
        for func in top_level_functions:
            if equation_name == func.name:
                return _importer(equation_name,lib)
    
    raise FileNotFoundError('could not find function: {} in of the libaries listed in conv_libs.txt'.format(equation_name))


def _parse_uncertainty(ustring: Union[str, list]) -> Union[tuple,float]: 
    
    """
    parses the uncertainty input from a sensor file. The four considered cases are
    1. The string possibility where the input will be  a floating number with string unit attatched to it in brackets. 
    2. the string possible where the input will be a callable interpretable by _sensor_equation_compiler, with string unit attatched to it in brackets
    3. The third is a list of such strings in (1) & (2) for multiple definitions of uncertainty. 
    4. If (3) this is the case, then the third case is applied, there may be an operator associated with this list such that 
    some value of uncertainty may be chosen from the list such as the "maximum of" one of the listed uncertainties. 

    note that if multiple operators are passed, the LAST operator in the list will be returned. Feature? Bug?

    The function tries pretty hard not to allow weird inputs into this list, and also lets you know if it doesn't like something

    Parameters
    ----------
    ustring: str or list (of strings) 
            specifies the uncertainty to be parsed according to the rules listed above

    Returns
    ---------
    uncertainties: list
            a list of tuples of the parsed uncertainties where the tuples take the form (float,unit) or (callable,unit) 
            where float is a floating point number, callable is a callable item, and unit is the str specifying the unit of the uncertainty

    operator,uncertainties: o
            if an operator is found, returns the operator as the first output with the uncertainties as the second
    """

    errormsg = 'You have defined a function that does not exist or cannot be evaluated by python eval function: {}'

    def _operator_eval(ostr):
        _o = eval(ostr)
        if callable(_o):
            return _o
        else:
            raise NameError(errormsg.format(ostr))


    if isinstance(ustring,str):
        ustring = [ustring]

    operator = None
    uncertainty = []
    for u in ustring:
        try:
            #try to convert the uncertainty to a float
            variable,unit = _get_units(u,return_variable = True)
            try:
                uncertainty.append((float(variable),unit))
            except ValueError:
                #perhaps the uncertainty is a function inertpretable by _sensor_equation_compiler
                if unit is not None:
                    equation = _sensor_equation_compiler(variable)
                    uncertainty.append((equation,unit))

        except ValueError:
            #cannot convet uncertainty to a float, try and see
            #if it is an operator             
            if 'np.' not in u:
                try:
                    #maybe the function exists in the numpy library such as np.max
                    operator = _operator_eval('np.'+u)
                except (NameError,SyntaxError,AttributeError):
                    try:
                        operator = _operator_eval(u)
                    except (NameError,SyntaxError) as n:
                        raise NameError(str(n) + '\n'  + errormsg.format(u))

            else:
                try:
                    operator = _operator_eval(u)
                except (NameError,SyntaxError) as n:
                    raise NameError(str(n) + '\n'  + errormsg.format(u))

    if operator is None:
        return uncertainty
    else:
        return operator,uncertainty