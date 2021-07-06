import numpy as np
from scipy.optimize import minimize
from matplotlib import pyplot as plt
from matplotlib import rc
rc('font',**{'family':'serif','serif':['Times New Roman']})
rc('text', usetex=True)

thermal_conductivity = lambda x: 3.37238e-5*x**2 - 1.14272e-1*x + 206.822
cs_temp_weights = np.array([0.5227,0.3181,0.1423,0.0169]) 


def cooled_surface_temp(T:np.ndarray) -> float:
    
    """
    calculates "T_c_bar" the area weighted average surface temperatures
    """
    
    return T.dot(cs_temp_weights)

def cooled_surface_temp_actual(T_r:np.ndarray,
                               q: float,
                               delta_tc:np.ndarray,
                               k_s:float) -> np.ndarray:
    
    """
    calculates the cooled surface actual temperature "T_{cr}" based upon:
    T_r : the thermo couple readings of the temperature
    q: the calculated heat flux
    delta_c: the distance to the thermo couple
    k_s: the thermal conductivity of the solid
    """
    
    return T_r - q*delta_tc/k_s


def temperature_diff_wrapped(q: float,
                             delta_tc: np.ndarray,
                             T_r:np.ndarray,
                             order = 1) -> callable:
    """
    the wrapping of the function to minimize. 
    q: control volume heat flux
    delta_tc: the distance of the thermocouples from the probe locations
    T_r: The measured temperature of the thermocouples
    """
    
    def objective_function(T_cr: np.ndarray) -> np.ndarray:

        """
        the function to minimize in order to get the non-linear
        relationship for the geometrically extrapolated cooled surface temperatures
        """
        
        Tm = (T_r + T_cr)/2.0
        ks = thermal_conductivity(Tm)
        T_cr_update = cooled_surface_temp_actual(T_r,q,delta_tc,ks)
        
        return np.linalg.norm(T_cr_update - T_cr,ord = 1)
    
    return objective_function

def legacy_brute_force(Tr_input,
                       HF: float,
                       delta_tc):

    """
    direct copy from the matlab legacy code in "GTEXPERIMENTCALCULATIONSLOOP.m"
    """

    Tcr = 500*np.ones(4)
    error = np.ones(4)
    n = 0

    TOL = 1e-4
    while np.any(error > TOL):
        print(n)
        Tm = (Tr_input + Tcr)/2.0
        ks = thermal_conductivity(Tm)
        temp_Tc = - HF*delta_tc/ks + Tr_input
        error = np.abs(temp_Tc - Tcr)/Tcr
        
        Tcr = temp_Tc.copy()
        n +=1
        
        if n > 1000:
            break

    return Tcr

heat_flux = 1151331.9285887682
delta_tc = np.array([0.0005730 ,0.0007468, 0.0008264, 0.000788]) 

def plot_minimal_function():
    Tr = np.array([710.29435577, 727.27760577, 723.67089904, 722.60172115])
    min_func = temperature_diff_wrapped(heat_flux,delta_tc,Tr,order = np.inf)
    Tcr = minimize(min_func,Tr,method = 'Powell').x
    Tmin = Tcr - 10
    Tmax = Tr + 10
    f_evals = []
    x = []
    step = 0.01
    T = Tmin
    while np.all(T < Tmax):
        x.append(T.mean())
        f_evals.append(min_func(T))
        T += step


    Tcr_legacy = legacy_brute_force(Tr,heat_flux,delta_tc)

    print('Solution using Powells method:')
    print(Tcr)

    print('Solution using Legacy Method:')
    print(Tcr_legacy)

    fig,ax = plt.subplots()
    ax.plot(x,f_evals,color = 'blue')
    ax.set_xlabel('Mean Cooled Surface Temperature [K]',fontsize = 14)
    ax.set_ylabel('Objective Function Value [K]',fontsize = 14)
    ax.scatter(Tcr_legacy.mean(),min_func(Tcr_legacy),marker = 's',facecolor = 'purple',edgecolor = 'k',s = 120,
    label = 'Legacy Solution')
    ax.scatter(Tcr.mean(),min_func(Tcr),facecolor = 'green',edgecolor = 'k',s = 120,
    label = 'Identified Minimum')
    ax.scatter(Tr.mean(),min_func(Tr),facecolor = 'red',edgecolor = 'k',s = 120,
    label = 'Thermocouple Temperatures')

    ax.legend(fontsize = 14)
    plt.show()


def main():
    plot_minimal_function()

if __name__ == '__main__':
    main()