from uncertainties.core import wrap, Variable
from uncertainties.unumpy.core import wrap_array_func
from functools import wraps
from uncertainties.unumpy import uarray,nominal_values
from CoolProp import CoolProp as cp
import numpy as np
from uncertainties import ufloat

def uPropsSI(output_string: str,
            first_input_string: str,
            first_input_vector: np.ndarray,
            second_input_string:str,
            second_input_vector:np.ndarray,
            fluid_string: str):

    try:
        @wrap_array_func
        def props_si_wrapped(mat: np.ndarray):

            return cp.PropsSI(output_string,
                            first_input_string,
                            mat[:,0],
                            second_input_string,
                            mat[:,1],
                            fluid_string)
        
        return props_si_wrapped(np.array([first_input_vector,second_input_vector]).T)

    except IndexError:

        @wrap
        def props_si_wrapped(*args):

            return cp.PropsSI(output_string,
                            first_input_string,
                            args[0],
                            second_input_string,
                            args[1],
                            fluid_string)

        return props_si_wrapped(first_input_vector,second_input_vector)

def test_general_vector():
    """ 
    basic test to ensure that the wrapped PropsSI function returns the same mean values 
    as the regular PropsSI
    """
    sz = 100
    uT = uarray(np.linspace(500,520,sz),1.1*np.ones(sz))
    uP = uarray(np.linspace(1e6,1.1e6,sz),1e3*np.ones(sz))

    #test the uncertainty property
    uK = uPropsSI('L','T',uT,'P',uP,'He')
    
    #normal
    k = cp.PropsSI('L','T',nominal_values(uT),'P',nominal_values(uP),'He')

    print(uK[0])
    print(nominal_values(uK) - k)


def test_single_values():

    """
    basic test to deal with the issue when there is only 1 value in each mat spot
    """

    uT = ufloat(500,1.1)
    uP = ufloat(1e6,1e3)

    uk = uPropsSI('L','T',uT,'P',uP,'He')
    print(uk)


def main():
    test_general_vector()
    test_single_values()

if __name__ == '__main__':
    main()