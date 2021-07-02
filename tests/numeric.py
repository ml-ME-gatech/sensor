from numpy import ndarray
from uncertainties import unumpy
from functools import wraps

def linear_uncertainty_propogation_coercer(ndfunc):

    @wraps(ndfunc)
    def wrapped_function(uarray: unumpy.uarray) -> callable:

        assert isinstance(uarray,unumpy.uarray),'input array must be of type unumpy.uarray not: {}'.format(type(uarray))






