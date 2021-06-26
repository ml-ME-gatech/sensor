from yaml import load as yaml_load, dump as yaml_dump, Loader
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

"""
Creation:
Author(s): Michael Lanahan 
Date: 06.16.2021

Last Edit: 
Editor(s): Michael Lanahan
Date: 06.24.2021

-- Description -- 
classes for working with sensor.yaml files specified format in the sensor_fmt.yaml file
"""

class Sensor(dict): 
    """ 
    Sensor

    Description
    ----------
    a sensor class. Essentially a dictionary that may be manipulated as an object

    Attributes
    ----------
    attributes are read from sensor files

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

    def __init__(self,input_dict:dict):
        
        dict.__init__(self,input_dict)
        self.__dict__ = input_dict
        self.__compiled_converter = None

    @property
    def compiled_converter(self):
        if self.__compiled_converter is None:
            self.__compiled_converter =  _sensor_equation_compiler(self.__dict__['equation'])
       
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

    def _check_signal(self,x:pd.Series) -> None:
        """ 
        checks to see if the signal and sensor are related by ensuring that x is a series
        and moreover that the name of the series is associated with either the id or the 
        name of the sensor
        """

        if not isinstance(x,pd.Series):
            raise TypeError('sensor conversion only applicable for pd.Series objects')

        if self.id not in x.name and self.name not in x.name:
            raise ValueError('Cannot verify relationship between sensor with \nid: {} \nname: {} \nand input signal with \nname {}'.format(self.id,self.name,x.name))

    def convert(self,x: pd.Series,
                        root_finder = None) -> pd.Series:
        """
        convert an input signal x (a pd.Series) based upon the textual equation of the sensor
        checks to make sure that units are consistent, and also that a link between the name of the signal
        and the sensor can be established
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
                elif unit == signal_unit and input_unit == measure_unit:
                    raise ValueError('cannot calculate uncertainty for the signal unit: {} when the input unit of x is the measure unit: {}'.format(unit,input_unit))
                else:
                    raise ValueError('uncertainty unit {} does not match either input signal (x) unit: {} or the measure unit '.format(unit,input_unit))
                
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
            out =  np.squeeze(df)

        return pd.Series(out,index = x.index,name = x.name)

    def to_md(self, file = None) -> str:

        """
        Creates a bulleted markdown document containing the sensor information
        
        Parameters
        ----------
        file : stream or path, optional
        the file to write the markdown summary to
        """

        txt_list = []
        for key,value in self.__dict__.items():
            name = str(key)
            if name[0] != '_':
                txt_list.append('- ' + name + ': ' + str(value) + '\n')

        txt = ''.join(txt_list)
        if file is not None:
            if isinstance(file,str):
                with open(file,'w') as f:
                    f.write(txt)
            else:
                file.write(txt)

        return txt

class SensorArray(dict):
    """ 
    SensorArray

    Description
    ----------
    An array of sensors. Essentially a dictionary of Sensors with the key the name of the sensor. 
    Allows object access of the sensors

    Attributes
    ----------
    attributes are read from sensor files

    Methods
    ----------
    to_md - return a textual representation of the Sensor array as headed lists
    to_table - return a tabular representation of the Sensor array
    from_file - class method that reads in a SensorArray from a file - in yaml format
    convert- apply the conversion according to the sensor equation to all signals in a supplied DataFrame
    calculate_uncertainty- apply the uncertainty according to the uncertainty attribute of each sensor to all signals in a supplied DataFrame
    """

    def __init__(self,*args,**kwargs):

        dict.__init__(self,*args,**kwargs)

    @property
    def diagram(self):
        return self.__diagram

    @diagram.setter
    def diagram(self,d):
        self.__diagram = d

    def to_md(self,file = None) -> str:
        
        txt_list = []
        for key,value in self.__dict__.items():
            txt_list.append('# ' + str(key) + '\n' + value.to_md() + '\n')
        
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

        include: specifies sensor properties to include in table, 
        exclude: key word specifies properties to exclude from table.
        tablefmt: feeds into tabulate function from tabulate package
        headerfmt: specifies what property to use as the header from the sensor array. 
        kwargs: fed into the tabulate function
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
        return self.__dict__[name]

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
            for name in _read:
                if name not in sensor_names:
                    del read_[name]

            _read = read_

        d = dict.fromkeys(_read.keys())
        diagram = False
        for key,value in _read.items():
            if str(key).lower() != 'diagram':
                d[key] = Sensor(value)
            else:
                diagram = True
        
        if diagram:
            del d['diagram']

        _cls = cls(d)
        if diagram:
            _cls.diagram = _read['diagram']
        
        _cls.__dict__ = d
        return _cls

    def _map_columns_to_sensor_array(self,X:pd.DataFrame) -> dict:

        """
        maps all of the items in columns to the items in the sensor array. raises a ValueError
        if cannot find a relationship between the columns of X and the sensor array or if the relationshi is ambigious
        i.e. two sensors map to the same column of the data frame
        """

        mapped_columns = dict.fromkeys(X.columns)
        #initiaze mapped columns to all None
        for c in X.columns:
            mapped_columns[c] = None

        #determine the mapping from signal to sensors
        for column in X.columns:
            for sensor_name,sensor in self.__dict__.items():
                _sensor_name = sensor_name.strip()
                _column,_ = _get_units(column,return_variable = True)
                _column = _column.strip()
                if _sensor_name == _column or sensor.id == _column:
                    if mapped_columns[column] is None:
                        mapped_columns[column] = sensor
                    else:
                        raise ValueError("Sensors {} and {} both map to column {} in DataFrame".format(sensor_name,mapped_columns[column],column))

        
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

def _get_conversion_libs():

    libs = []
    path,_ = os.path.split(__file__)
    with open(os.path.join(path,'data\\conv_libs.txt'),'r') as file:
        for line in file.readlines():
            path = os.path.normpath(line)
            _,ext = os.path.splitext(path)
            if ext == '.py':
                if os.path.exists(path):
                    libs.append(path)
                else:
                    cwd = os.getcwd()
                    _path = os.path.join(path,cwd)
                    if os.path.exists(_path):
                        libs.append(_path)

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

def _read_sensor_array_from_file(file: str) -> dict:
    """
    light wrapping of the load function from pyyaml. may have to add more to this later
    if I decide to be more clever with the formatting of the sensor file
    """

    if isinstance(file,str):
        with open(file,'r') as f:
            data = yaml_load(f, Loader = Loader)

    else:
        data = yaml_load(file, Loader = Loader)

    return data

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
    """

    #get the equation name we are looking for 
    #and the libraries to look across
    equation_name = string.strip()[1:-1]
    libs = _get_conversion_libs()

    #parses the contents of a python module using the Abstract Syntax Tree Library
    def _ast_parser(fname):
        with open(fname,'rt') as file:
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