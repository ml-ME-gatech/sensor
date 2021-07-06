from matplotlib import pyplot as plt
import numpy as np
from gasprop3 import get_property
from CoolProp import CoolProp as cp
from matplotlib import rc
rc('font',**{'family':'serif','serif':['Times New Roman']})
rc('text', usetex=True)

properties = ['rho','cp','mu','k','R']
cp_properties = ['D','CPMASS','V','L','GAS_CONSTANT']
titles = [r'$\rho \ [\frac{kg}{m^3}]$',r'$C_p \ [\frac{J}{kg \cdot K}]$',
         r'$\mu \ [Pa \cdot s]$',r'k $[\frac{W}{m \cdot K}]$',
         r'R $[\frac{J}{kg \cdot K}]$']

gas = ['air','he','ar','co2','h2o']
temperature_limits = {'air':[100,3000],
                     'he':[273.15+25.0,900+273.15],
                     'ar':[100,700],
                      'co2':[225,1100],
                      'h2o':[275,365]}

fig,ax = plt.subplots(nrows = 2,ncols = 3,figsize = (12,8))

T = np.linspace(temperature_limits['he'][0],temperature_limits['he'][1],int(1e4))
Pressures = [9e6,10e6,10.5e6]
lstyles = ['--','-',':']
ii = 0
kk = 0
for p,cp_p,title in zip(properties,cp_properties,titles):

    ymin = np.inf
    ymax = -np.inf
    for P,linestyle in zip(Pressures,lstyles):
        coolprop_property = cp.PropsSI(cp_p,'T',T,'P',P,'He')
        gas_property = get_property(T,p,'he')
        if cp_p == 'GAS_CONSTANT':
            coolprop_property = coolprop_property/(cp.PropsSI('M','He'))
            coolprop_property = coolprop_property.astype(float)
        
        if coolprop_property.max() > ymax:
            ymax = coolprop_property.max()
        if coolprop_property.min() < ymin:
            ymin = coolprop_property.min()
        
        ax[ii,kk].plot(T,coolprop_property,color = 'blue',linewidth = 2,
        label = 'CoolProp: P = {} [MPa]'.format(int(np.round(P/1e6,1))),
        linestyle = linestyle)
    
    xlim = [T.min()/1.2,T.max()*1.1]
    ylim = [np.min([gas_property.min(),ymin]),
    np.max([gas_property.max(),ymax])]

    ydiff = ylim[1] - ylim[0]
    pad = (0.1*ydiff)**2 + 0.05
    ylim[0] -= pad
    ylim[1] += pad

    ax[ii,kk].plot(T,gas_property,color = 'red',linewidth = 3,label = 'GASPROP3')
    ax[ii,kk].set_ylabel(title,fontsize = 14)
    ax[ii,kk].set_xlabel('Temperature [K]',fontsize = 14)
    ax[ii,kk].legend()
    ax[ii,kk].ticklabel_format(axis = 'both',style = 'plain')
    ax[ii,kk].autoscale(False)
    ax[ii,kk].set_xlim(xlim)
    ax[ii,kk].set_ylim(ylim)

    kk +=1

    if kk == 3:
        kk = 0
        ii+=1


ax[1,2].axis('off')
plt.tight_layout()
plt.show()