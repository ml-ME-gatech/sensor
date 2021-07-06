import pandas as pd
import os
import sys
sys.path.append('..')
from sensor.sensor import SensorArray
import CoolProp as cp
import json
import numpy as np
from uncertainties import ufloat
from uncertainties_wrapped_propsSI import uPropsSI
from uncertainties.unumpy import sqrt as usqrt,nominal_values,std_devs,pow as upower,umatrix
from scipy.optimize import minimize

#Turn off annoying warnings.
pd.options.mode.chained_assignment = None

#Constants
pressure_atmosphere = 14.7    #pressure of the atmosphere in [PSI]
PSI_TO_PASCAL = 6894.76       #conversion from psi to pascal
#there is a seperate data file that keeps track of some engineering
#data needed for the computation
with open('constants.json','r') as file:
    Constants = json.load(file)

C_d = Constants['Cd']
A1 = Constants['A1']
A2 = Constants['A2']
Aj = Constants['Aj']
Dj = Constants['Dj']
Ah = Constants['Ah']
Ac = Constants['Ac']

uDj = ufloat(Dj,Constants['eDj'])
uAc = ufloat(Ac,Constants['eAc'])
uAh = ufloat(Ah,Constants['eAh'])
uAj = ufloat(Aj,Constants['eAj'])

#Functions neccessary for later calculation
def correct_venturi_pressure_differential(dP:pd.Series,
                                          P:pd.Series) -> pd.Series:
    
    """
    correct the differential pressure reading on the venturi using 
    the differential measurement and the static pressure
    """
    
    denominator = 0.019969+ 0.131*P*1e-6-0.003967
    return 23.867*((dP+5.9175)/1491.69 - 0.0003967)/denominator
    
def correct_main_pressure_differential(dP:pd.Series,
                                       P:pd.Series) -> pd.Series:
    
    """
    correct the differential pressure reading on the main line
    using the differential measurement and the static pressure
    """
    
    denominator = 0.02 + 0.285*P*1e-6 - 0.004
    return 5972.16*((dP+1493)/373250 - 0.004)*1/denominator

#lambda function for thermal conductivity: very similar to the concept of the 
#"anonymous function" in MatLab
thermal_conductivity = lambda x: 3.37238e-5*x**2 - 1.14272e-1*x + 206.822
uthermal_conductivity =lambda x:  3.37238e-5*np.power(x,2) - 1.14272e-1*x + 206.822

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


#Database accessing
db_path = 'example_db'
files = os.listdir(db_path)
#these are the only columns we are interested in. 
columns_of_interest = ['Tvent [K]', 'Tl8 [C]', 'T6 [C]', 'T4 [C]', 'T2 [C]',
       'Pbypass [PSI]', 'dPbypass [PA]', 'dPtest [PSI]', 'Pvent [PSI]',
       'Tbypass [K]', 'Treturn [K]', 'Tout [C]', 'Tin [C]', 'Preturn [PSI]',
       'dPreturn [PA]', 'dPvent [PA]', 'Ptest [PSI]']

for i in range(len(files)):

    print('')
    print('')
    print('-----------------------')
    print(files[i])
    print('')
    #read in the raw data
    df = pd.read_csv(os.path.join(db_path,files[i],'raw.csv'),index_col = 0,
                            parse_dates = True,infer_datetime_format = True)

    #take the quantities we are interested in
    df = df[columns_of_interest]

    #read in the sensor array information from the file and print out the information we are concerned with
    #namely the measure units and the uncertainty
    sensors = SensorArray.from_file('example_db\sensor.yaml')
    table = sensors.to_table(include = ['measure_units','uncertainty'],columns = 'attribute',tablefmt = 'fancy')
    udf = sensors.uDataFrame(df)

    #The next several lines do the following:
    #1. Correct the venturi and return differential pressures. 
    #2. Calculate the inlet, outlet, and venturi absolute pressures (in absolute terms)
    #3. Calculate the average temperature and pressure
    df.loc[:,'dPvent [PA]'] = correct_venturi_pressure_differential(df.loc[:,'dPvent [PA]'],
                                                                    df.loc[:,'Pvent [PSI]'])

    udf.loc[:,'dPvent [PA]']  = correct_venturi_pressure_differential(udf.loc[:,'dPvent [PA]'],
                                                            udf.loc[:,'Pvent [PSI]'])

    df.loc[:,'dPreturn [PA]'] = correct_main_pressure_differential(df.loc[:,'dPreturn [PA]'],
                                                                    df.loc[:,'Preturn [PSI]'])

    udf.loc[:,'dPreturn [PA]'] = correct_main_pressure_differential(udf.loc[:,'dPreturn [PA]'],
                                                                    udf.loc[:,'Preturn [PSI]'])

    df.loc[:,'Pinlet [PSI]'] = df.loc[:,'Ptest [PSI]'] + df.loc[:,'dPtest [PSI]'] + pressure_atmosphere
    df.loc[:,'Poutlet [PSI]'] = df.loc[:,'Ptest [PSI]'] + pressure_atmosphere
    df.loc[:,'Pvent [PSI]'] += pressure_atmosphere

    udf.loc[:,'Pinlet [PSI]'] = udf.loc[:,'Ptest [PSI]'] + udf.loc[:,'dPtest [PSI]'] + pressure_atmosphere
    udf.loc[:,'Poutlet [PSI]'] = udf.loc[:,'Ptest [PSI]'] + pressure_atmosphere
    udf.loc[:,'Pvent [PSI]'] += pressure_atmosphere

    df.loc[:,'Taverage [C]'] = (df.loc[:,'Tin [C]'] + df.loc[:,'Tout [C]'])/2
    df.loc[:,'Paverage [PSI]'] = (df.loc[:,'Pinlet [PSI]'] + df.loc[:,'Poutlet [PSI]'])/2

    udf.loc[:,'Taverage [C]'] = (udf.loc[:,'Tin [C]'] + udf.loc[:,'Tout [C]'])/2
    udf.loc[:,'Paverage [PSI]'] = (udf.loc[:,'Pinlet [PSI]'] + udf.loc[:,'Poutlet [PSI]'])/2

    #get the viscosity
    mu = cp.CoolProp.PropsSI('V',
                            'T',df.loc[:,'Taverage [C]'].to_numpy() + 273.15,
                            'P',df.loc[:,'Paverage [PSI]'].to_numpy()*PSI_TO_PASCAL,
                            'He') 

    #get the specific heat
    Cp = cp.CoolProp.PropsSI('CPMASS',
                            'T',df.loc[:,'Taverage [C]'].to_numpy() + 273.15,
                            'P',df.loc[:,'Paverage [PSI]'].to_numpy()*PSI_TO_PASCAL,
                            'He') 

    #get the density
    rho_he = cp.CoolProp.PropsSI('D',
                                'T',df.loc[:,'Tvent [K]'].to_numpy(),
                                'P',df.loc[:,'Pvent [PSI]'].to_numpy()*PSI_TO_PASCAL,
                                'He') 

    #calculate mass flow rate
    df.loc[:,'m_dot [kg/s]'] = C_d*A1*np.sqrt((2*rho_he*df.loc[:,'dPvent [PA]'])/((A1/A2)**2 -1))

    #calculate reynolds number
    df.loc[:,'Re [-]'] = df.loc[:,'m_dot [kg/s]']*Dj/(Aj*mu)

    #calculate the heat flux using a control volume on the test section
    df.loc[:,'q [W/m^2]'] = df.loc[:,'m_dot [kg/s]']*Cp*(df.loc[:,'Tout [C]'] - df.loc[:,'Tin [C]'])/Ah

    #This step deals with determining the appropriate window for the data using the time index of the data
    df.index = pd.to_datetime(df.index,format = '%m/%d/%Y %H:%M:%S:%f')
    average_frequency = np.median((df.index[1:] - df.index[0:-1]).total_seconds().to_numpy())
    sample_time = 180
    num_samples = int(np.ceil(sample_time/average_frequency))

    #get the window that minimizes averaged data variance
    rm = df.rolling(num_samples).mean()
    coefficient_variation = df.rolling(num_samples).std()/rm

    var_min_index = coefficient_variation['Re [-]'].argmin()
    min_var_window = [var_min_index - num_samples,var_min_index]
    index = int(var_min_index -num_samples/2)

    #get the windowed data
    wdf = df.iloc[min_var_window[0]:min_var_window[1],:]
    wudf = udf.iloc[min_var_window[0]:min_var_window[1],:]

    #the data frame of steady-state values
    ss_df = wdf.mean()

    #compute the uncertainty derived values for m_dot, Re, and q - this repeats
    #steps above done for the mean data once we have windowed the data, because
    #this step is extremely expensive. The implementation for wrapping vector functions
    #in uncertainties is not very efficient and estimating the jacobian on large 
    #arrays can take prohibitive amounts of time

    #get the viscosity
    umu = uPropsSI('V',
                'T',np.array(wudf.loc[:,'Taverage [C]']) + 273.15,
                'P',np.array(wudf.loc[:,'Paverage [PSI]'])*PSI_TO_PASCAL,
                'He') 

    #get the specific heat
    uCp = uPropsSI('CPMASS',
                'T',np.array(wudf.loc[:,'Taverage [C]']) + 273.15,
                'P',np.array(wudf.loc[:,'Paverage [PSI]'])*PSI_TO_PASCAL,
                'He') 

    #get the density
    urho_he = uPropsSI('D',
                        'T',np.array(wudf.loc[:,'Tvent [K]']),
                        'P',np.array(wudf.loc[:,'Pvent [PSI]'])*PSI_TO_PASCAL,
                        'He') 

    #calculate mass flow rate
    wudf.loc[:,'m_dot [kg/s]'] = C_d*A1*usqrt((2*urho_he*wudf.loc[:,'dPvent [PA]'])/((A1/A2)**2 -1))

    #calculate reynolds number
    wudf.loc[:,'Re [-]'] = wudf.loc[:,'m_dot [kg/s]']*uDj/(uAj*umu)

    #calculate the heat flux using a control volume on the test section
    wudf.loc[:,'q [W/m^2]'] = wudf.loc[:,'m_dot [kg/s]']*uCp*(wudf.loc[:,'Tout [C]'] - wudf.loc[:,'Tin [C]'])/uAh

    #get the mean uncertainty values
    ss_udf = pd.Series(np.mean(np.array(wudf),axis = 0),index =ss_df.index)

    #calculate average coooled surface temperature and the conductivity of the WL10
    delta_tc = np.array([0.0005730 ,0.0007468, 0.0008264, 0.000788]) 
    u_delta_tc = umatrix(delta_tc,np.ones(delta_tc.shape)*0.1e-3)
    Tr = np.array([ss_df['T2 [C]'],ss_df['T4 [C]'],ss_df['T6 [C]'],ss_df['Tl8 [C]']]) + 273.15
    objective_function = temperature_diff_wrapped(ss_df['q [W/m^2]'],delta_tc,Tr)
    Tcr = minimize(objective_function,Tr,method = 'Powell').x

    #### APPROXIMATION HERE of uTr. 
    #Unfortunately, we do NOT know the uncertainty of T_cr when getting the 
    #uncertainty of ks, so we must approximate it to get the uncertainty of ks. 
    #We approximate it with the uncertainty Tr
    uTr = np.array([ss_udf['T2 [C]'],ss_udf['T4 [C]'],ss_udf['T6 [C]'],ss_udf['Tl8 [C]']]) + 273.15 
    _uTcr = umatrix(Tcr,std_devs(uTr))
    Tm = (uTr+_uTcr)/2.0
    ks = uthermal_conductivity(Tm)
    uTcr = cooled_surface_temp_actual(uTr,ss_udf['q [W/m^2]'],u_delta_tc,ks)

    Tc = cooled_surface_temp(Tcr)
    uTc = cooled_surface_temp(uTcr)
    #get the fluid thermal conductivity
    k_f = cp.CoolProp.PropsSI('L',
                    'T',np.array(ss_df.loc['Taverage [C]'])+ 273.15,
                    'P',np.array(ss_df.loc['Paverage [PSI]'])*PSI_TO_PASCAL,
                    'He') 

    uk_f = uPropsSI('L',
                    'T',np.array(ss_udf.loc['Taverage [C]'])+ 273.15,
                    'P',np.array(ss_udf.loc['Paverage [PSI]'])*PSI_TO_PASCAL,
                    'He') 

    rho_L = cp.CoolProp.PropsSI('D',
                    'T',np.array(ss_df.loc['Taverage [C]'])+ 273.15,
                    'P',np.array(ss_df.loc['Paverage [PSI]'])*PSI_TO_PASCAL,
                    'He') 

    urho_L = uPropsSI('D',
                    'T',np.array(ss_udf.loc['Taverage [C]']) + 273.15,
                    'P',np.array(ss_udf.loc['Paverage [PSI]'])*PSI_TO_PASCAL,
                    'He') 
    #calculate the average HTC
    h_bar = ss_df['q [W/m^2]']/(Tc - ss_df['Tin [C]'] - 273.15)*Ah/Ac
    Nu_bar = h_bar*Dj/k_f

    #calculate the loss coefficient
    v_bar = ss_df['m_dot [kg/s]']/(Aj*rho_L)
    K_L = 2*PSI_TO_PASCAL*(ss_df['Pinlet [PSI]'] - ss_df['Poutlet [PSI]'])/(rho_L*v_bar**2)

    #calculate the average HTC
    u_hbar = ss_udf['q [W/m^2]']/(uTc - ss_udf['Tin [C]'] - 273.15)*np.array(uAh/uAc)
    uNu_bar = u_hbar*np.array(uDj/uk_f)
    #uncertainties array behavior is acting unpredictably in this case
    #so I had to hack this together
    uNu_bar = ufloat(nominal_values(uNu_bar[0][0]),std_devs(uNu_bar[0][0]))
    u_hbar = ufloat(nominal_values(u_hbar[0][0]),std_devs(u_hbar[0][0]))


    #calculate the loss coefficient
    uv_bar = ss_udf['m_dot [kg/s]']/(uAj*urho_L)
    uK_L = 2*PSI_TO_PASCAL*(ss_udf['Pinlet [PSI]'] - ss_udf['Poutlet [PSI]'])/(urho_L*uv_bar**2)

    ss_df['Nu [-]'] = Nu_bar
    ss_df['h [W/(m^2 K)'] = h_bar
    ss_df['K_L [-]'] = K_L

    ss_udf['Nu [-]'] = uNu_bar
    ss_udf['h [W/(m^2 K)'] = u_hbar
    ss_udf['K_L [-]'] = uK_L

    print(ss_udf)
    ss_uncertainty = pd.Series(std_devs(np.array(ss_udf)),index = ss_udf.index)
    print(ss_uncertainty)
    ss_df.to_csv(os.path.join(db_path,files[i],'processed.csv'))
    ss_uncertainty.to_csv(os.path.join(db_path,files[i],'processed_uncertainty.csv'))

    print('')
    print("Averaged Results with uncertainty")
    print('----------------------')
    print('')
    print('Average Nusselt Number: {}'.format(uNu_bar))
    print('Averge Heat Transfer Coefficient: {}'.format(u_hbar))
    print('Heat Flux [W/m^2]:{}'.format(ss_udf['q [W/m^2]']))
    print('Average Reynolds Number: {}'.format(ss_udf['Re [-]']))
    print('Average Loss Coefficient: {}'.format(uK_L))