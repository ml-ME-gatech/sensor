%% Steady-State Averaging for Helium Loop Divertor Experiments
% M.E. Ph.D. Research
% Updated by: Bailey Zhao (2015)

tic, clc, clear, close all
Main='Q:\HEMJ Data Processing\Programs';
BaseData='Q:\HEMJ Data Processing\Programs\Database';

cd(BaseData);
%% Constants
clear

% Venturi Constants
Cd = 0.8828;                            % Venturi meter discharge coefficient
A1 = (0.622*0.0254)^2*pi/4;             % Large Venturi Area
A2 = (0.228*0.0254)^2*pi/4;             % Small Venturi Area

% HEMJ Constants
LTC = 0.0005;                           % Ideal Distance to Cooled Surface for TCs [m]
Dj = 0.00104;                           % Center Jet Diameter [m]
Dj2 = 0.0006;                           % Other Jet Diameter [m]
Dflat = 0.00118;                        % Flat Jet Diameter (FR1H07) [m]
Di = 0.00954;                           % Inner Tube Diameter [m]
Aj = Dj^2*pi/4 + 24*Dj2^2*pi/4;         % Total Jet Cross Sectional Area [m^2]
Ah = 0.0169926^2*pi/4;                  % Heated Surface Area [m^2]
% Ac = 0.00647^2*pi;                      % Cooled Surface Area (Projected) [m^2]
Ac = 184.21e-6;
Ai = Di^2*pi/4;                         % Inner Tube Cross-sectional area [m^2]
P = Dj*pi + 24*Dj2*pi;                  % Total Jet Perimeter [m^2]
Dh = 4*Aj/P;                            % Hydraulic Diameter [m]

% Geometry Error
eLTC = 0.0001;
LTC8=0.0008; LTC6=0.00084; LTC4=0.0008; LTC2=0.0006;        % Based on extrapolation of CFD TC & Avg CS Temps
eLTC8 = 0.2*LTC8; eLTC6 = 0.2*LTC6; eLTC4 = 0.2*LTC4; eLTC2 = 0.2*LTC2;
eDj = 0.00005;
eDj2 = 0.00005;
eDflat = 0.00005;
eAj = pi/4*sqrt((2*Dj*eDj)^2+(2*Dj2*eDj2)^2);
eAh = pi/2*0.017*0.00005;
eAc = 2*pi*0.00647*0.00005;
eP = eDj*pi + 24*eDj2*pi;
eDh = sqrt((4/P*eAj)^2+(-4*Aj/P^2*eP)^2);

save LoopConstants
%% Helium Loop 4_2_2013 15_15_52
% Initial Test - Steady-State Experiment  
% Using Tip # 6 / Oxygen/Fuel Pressure - 6 psig 
% Did not reach steady-state. Rise time only.
% 0.75 scan/second  
for m=1:0
clear
load LoopData
A040213=xlsread('Helium Loop 4_2_2013 15_15_52.csv', 1, 'C30:Y20000');
save A040213 A040213
save LoopData HEMJ
end
%% Helium Loop 4_2_2013 16_09_48
% Initial Test - Steady-State Experiment  
% Using Tip # 6 / Oxygen/Fuel Pressure - 6 psig 
% Two SS Experiments - ~6 and ~4 g/s
% 0.75 scan/second  
for m=1:1
clear
load LoopData
B040213=xlsread('Helium Loop 4_2_2013 16_09_48.csv', 1, 'C30:Y20000');
for i=1:15
    HEMJ(1,i)=mean(B040213(700:900,i)); %#ok<*SAGROW>
end
for i=1:15
    HEMJ(2,i)=mean(B040213(4000:4300,i));
end
HEMJ(1:2,16)=99000;
HEMJ(1:2,17)=0;
save B040213 B040213
save LoopData HEMJ
end
%% Helium Loop 4_4_2013 13_15_19
% Initial Test - Steady-State Experiment  
% Using Tip # 6 / Oxygen/Fuel Pressure - 6 psig 
% One SS Experiment - ~6, Heater on 100C Ti
% 0.75 scan/second  
for m=1:0
clear
load LoopData
A040413=xlsread('Helium Loop 4_4_2013 13_15_19.csv', 1, 'C30:Y20000');
for i=1:15
    HEMJ(3,i)=mean(A040413(7300:7600,i));
end
HEMJ(3,16)=99000;
HEMJ(3,17)=0;
save A040413 A040413
save LoopData HEMJ
end
%% Helium Loop 4_9_2013 12_09_28
% Initial Test - Steady-State Experiment  
% Using Tip # 6 / Oxygen/Fuel Pressure - 6 psig 
% One SS Experiment - ~4.3, Heater on 170C Ti
% 0.75 scan/second  
for m=1:0
clear
load LoopData
A040913=xlsread('Helium Loop 4_9_2013 12_09_28.csv', 1, 'C30:Y20000');
for i=1:15
    HEMJ(4,i)=mean(A040913(6900:7300,i));
end
HEMJ(4,16)=99000;
HEMJ(4,17)=0;
save A040913 A040913
save LoopData HEMJ
end
%% Helium Loop 4_9_2013 13_43_22
% Initial Test - Steady-State Experiment  
% Using Tip # 6 / Oxygen/Fuel Pressure - 6 psig 
% One SS Experiment - ~3.9, Heater on 190C Ti
% 0.75 scan/second  
for m=1:0
clear
load LoopData
B040913=xlsread('Helium Loop 4_9_2013 13_43_22.csv', 1, 'C30:Y20000');
for i=1:15
    HEMJ(5,i)=mean(B040913(4500:4800,i));
end
HEMJ(5,16)=99000;
HEMJ(5,17)=0;
save B040913 B040913
save LoopData HEMJ
end
%% Helium Loop 4_15_2013 12_49_55
% Initial Test - Steady-State Experiment  
% Using Tip # 7 / Oxygen/Fuel Pressure - >8 psig 
% One SS Experiment - ~4.5, Heater off, High q" Attempt, 2.05 MW/m^2
% 0.75 scan/second  
for m=1:0
clear
load LoopData
A041513=xlsread('Helium Loop 4_15_2013 12_49_55.csv', 1, 'C30:Y20000');
for i=1:15
    HEMJ(6,i)=mean(A041513(400:700,i));
end
HEMJ(6,16)=99000;
HEMJ(6,17)=0;
save A041513 A041513
save LoopData HEMJ
end
%% Helium Loop 4_16_2013 11_32_00
% Initial Test - Steady-State Experiment  
% Using Tip # 7 / Oxygen/Fuel Pressure - >8 psig 
% One SS Experiment - Heater on ~30 W , Low mdot attempt, ~3 g/s
% 0.75 scan/second  
for m=1:0
clear
load LoopData
A041613=xlsread('Helium Loop 4_16_2013 11_32_00.csv', 1, 'C30:Y20000');
for i=1:15
    HEMJ(7,i)=mean(A041613(4700:5000,i));
end
HEMJ(7,16)=99000;
HEMJ(7,17)=0;
save A041613 A041613
save LoopData HEMJ
end
%% Helium Loop 4_16_2013 12_35_52
% Initial Test - Steady-State Experiment  
% Using Tip # 7 / Oxygen/Fuel Pressure - >8 psig 
% One SS Experiment - Heater on ~230 W , Attempt Re~3.2e4
% 0.75 scan/second  
for m=1:0
clear
load LoopData
B041613=xlsread('Helium Loop 4_16_2013 12_35_52.csv', 1, 'C30:Y20000');
for i=1:15
    HEMJ(8,i)=mean(B041613(2100:2400,i));
end
HEMJ(8,16)=99000;
HEMJ(8,17)=0;
save B041613 B041613
save LoopData HEMJ
end
%% Helium Loop 5_1_2013 15_00_20
% Initial Test - Steady-State Experiment  
% Using Tip # 7 / Oxygen/Fuel Pressure - >8 psig 
% One SS Experiment - Heater on ~160 W , Attempt Re~2.5e4
% 0.75 scan/second  
for m=1:0
clear
load LoopData
A050113=xlsread('Helium Loop 5_1_2013 15_00_20.csv', 1, 'C30:Y20000');
for i=1:15
    HEMJ(9,i)=mean(A050113(1650:1950,i));
end
HEMJ(9,16)=99000;
HEMJ(9,17)=0;
save A050113 A050113
save LoopData HEMJ
end
%% Helium Loop 5_1_2013 16_19_44
% Initial Test - Steady-State Experiment  
% Using Tip # 7 / Oxygen/Fuel Pressure - >8 psig 
% One SS Experiment - Heater on ~850 W , Attempt Re~3.0e4
% 0.75 scan/second  
for m=1:0
clear
load LoopData
B050113=xlsread('Helium Loop 5_1_2013 16_19_44.csv', 1, 'C30:Y20000');
for i=1:15
    HEMJ(10,i)=mean(B050113(1350:1550,i));
end
HEMJ(10,16)=99000;
HEMJ(10,17)=0;
save B050113 B050113
save LoopData HEMJ
end
%% Helium Loop 5_9_2013 15_02_23
% Initial Test - Steady-State Experiment  
% Using Tip # 7 / Oxygen/Fuel Pressure - >8 psig 
% One SS Experiment - Heater on ~1 kW , Attempt 250 C inlet
% 0.75 scan/second  
for m=1:0
clear
load LoopData
A050913=xlsread('Helium Loop 5_9_2013 15_02_23.csv', 1, 'C30:Y20000');
for i=1:15
    HEMJ(11,i)=mean(A050913(300:600,i));
end
HEMJ(11,16)=99000;
HEMJ(11,17)=0;
save A050913 A050913
save LoopData HEMJ
end
%% Helium Loop 5_14_2013 14_52_00
% Initial Test - Steady-State Experiment  
% Using Tip # 7 / Oxygen/Fuel Pressure - >8 psig 
% One SS Experiment - Heater on ~1.14 kW , Attempt 300 C inlet
% 0.75 scan/second  
for m=1:0
clear
load LoopData
A051413=xlsread('Helium Loop 5_14_2013 14_52_00.csv', 1, 'C30:Y20000');
for i=1:15
    HEMJ(12,i)=mean(A051413(3100:3400,i));
end
HEMJ(12,16)=99000;
HEMJ(12,17)=0;
save A051413 A051413
save LoopData HEMJ
end
%% Helium Loop 5_16_2013 15_08_28
% Initial Test - Steady-State Experiment  
% Using Tip # 7 / Oxygen/Fuel Pressure - >8 psig 
% One SS Experiment - Heater off, Attempt low inlet temp
% 0.75 scan/second  
for m=1:0
clear
load LoopData
A051613=xlsread('Helium Loop 5_16_2013 15_08_28.csv', 1, 'C30:Y20000');
for i=1:15
    HEMJ(13,i)=mean(A051613(4950:5250,i));
end
HEMJ(13,16)=99000;
HEMJ(13,17)=0;
save A051613 A051613
save LoopData HEMJ
end
%% Helium Loop 5_22_2013 11_38_07
% Initial Test - Steady-State Experiment  
% Using Tip # 7 / Oxygen/Fuel Pressure - >8 psig 
% One SS Experiment - Heater off, Attempt low inlet temp, diff Re
% 0.75 scan/second  
for m=1:0
clear
load LoopData
A052213=xlsread('Helium Loop 5_22_2013 11_38_07.csv', 1, 'C30:Y20000');
for i=1:15
    HEMJ(14,i)=mean(A052213(3350:3600,i));
end
HEMJ(14,16)=99000;
HEMJ(14,17)=0;
save A052213 A052213
save LoopData HEMJ
end
%% Helium Loop 5_29_2013 13_30_42
% Steady-State Experiments
% Five SS Experiment - Heater/torch off, Measuring K_L only
% 0.75 scan/second  
for m=1:0
clear
load LoopData
A052913=xlsread('Helium Loop 5_29_2013 13_30_42.csv', 1, 'C30:Y20000');
for i=1:15
    HEMJ(15,i)=mean(A052913(800:1100,i));
end
HEMJ(15,16)=99000;
HEMJ(15,17)=0;
for i=1:15
    HEMJ(16,i)=mean(A052913(1400:1700,i));
end
HEMJ(16,16)=99000;
HEMJ(16,17)=0;
for i=1:15
    HEMJ(17,i)=mean(A052913(2150:2450,i));
end
HEMJ(17,16)=99000;
HEMJ(17,17)=0;
for i=1:15
    HEMJ(18,i)=mean(A052913(2850:3150,i));
end
HEMJ(18,16)=99000;
HEMJ(18,17)=0;
for i=1:15
    HEMJ(19,i)=mean(A052913(3450:3750,i));
end
HEMJ(19,16)=99000;
HEMJ(19,17)=0;
save A052913 A052913
save LoopData HEMJ
end
%% Helium Loop 6_4_2013 13_20_10
% Steady-State Experiments
% Two SS Experiment - torch off, Heater on 200 C inlet, Measuring K_L only
% 0.75 scan/second  
for m=1:0
clear
load LoopData
A060413=xlsread('Helium Loop 6_4_2013 13_20_10.csv', 1, 'C30:Y20000');
for i=1:15
    HEMJ(20,i)=mean(A060413(50:350,i));
end
HEMJ(20,16)=99000;
HEMJ(20,17)=0;
for i=1:15
    HEMJ(21,i)=mean(A060413(2800:3100,i));
end
HEMJ(21,16)=99000;
HEMJ(21,17)=0;
save A060413 A060413
save LoopData HEMJ
end
%% Helium Loop 6_5_2013 13_27_59
% Steady-State Experiments
% Two SS Experiment - torch off, Heater on 200 C inlet, Measuring K_L only
% 0.75 scan/second  
for m=1:0
clear
load LoopData
A060513=xlsread('Helium Loop 6_5_2013 13_27_59.csv', 1, 'C30:Y20000');
for i=1:15
    HEMJ(22,i)=mean(A060513(5600:5900,i));
end
HEMJ(22,16)=99000;
HEMJ(22,17)=0;
for i=1:15
    HEMJ(23,i)=mean(A060513(7700:8000,i));
end
HEMJ(23,16)=99000;
HEMJ(23,17)=0;
save A060513 A060513
save LoopData HEMJ
end
%% Helium Loop 7_1_2013 12_09_19
% Steady-State Experiments
% Two SS Experiment - torch off, Heater off, Measuring K_L only
% 0.75 scan/second  
for m=1:0
clear
load LoopData
A070113=xlsread('Helium Loop 7_1_2013 12_09_19.csv', 1, 'C30:Y20000');
for i=1:15
    HEMJ(24,i)=mean(A070113(400:700,i));
end
HEMJ(24,16)=99000;
HEMJ(24,17)=0;
for i=1:15
    HEMJ(25,i)=mean(A070113(900:1200,i));
end
HEMJ(25,16)=99000;
HEMJ(25,17)=0;
for i=1:15
    HEMJ(26,i)=mean(A070113(1450:1750,i));
end
HEMJ(26,16)=99000;
HEMJ(26,17)=0;
save A070113 A070113
save LoopData HEMJ
end
%% Helium Loop 7_3_2013 16_09_12
% Steady-State Experiments
% Two SS Experiment - torch off, Heater on ~200 C, Measuring K_L only
% 0.75 scan/second  
for m=1:0
clear
load LoopData
A070313=xlsread('Helium Loop 7_3_2013 16_09_12.csv', 1, 'C30:Y20000');
for i=1:15
    HEMJ(27,i)=mean(A070313(200:500,i));
end
HEMJ(27,16)=99000;
HEMJ(27,17)=0;
save A070313 A070313
save LoopData HEMJ
end
%% Helium Loop 7_5_2013 12_18_53
% Steady-State Experiments
% Two SS Experiment - torch off, Heater on ~200 C, Measuring K_L only
% 0.75 scan/second  
for m=1:0
clear
load LoopData
A070513=xlsread('Helium Loop 7_5_2013 12_18_53.csv', 1, 'C30:Y20000');
for i=1:15
    HEMJ(28,i)=mean(A070513(100:400,i));
end
HEMJ(28,16)=99000;
HEMJ(28,17)=0;
for i=1:15
    HEMJ(29,i)=mean(A070513(3100:3400,i));
end
HEMJ(29,16)=99000;
HEMJ(29,17)=0;
save A070513 A070513
save LoopData HEMJ
end
%% Helium Loop 7_9_2013 13_58_46
% Steady-State Experiment - New Cartridge
% Using Tip # 7 / Oxygen/Fuel Pressure - >8 psig 
% One SS Experiment - Heater on ~4 W
% 0.75 scan/second  
for m=1:0
clear
load LoopData
A070913=xlsread('Helium Loop 7_9_2013 13_58_46.csv', 1, 'C30:Y20000');
for i=1:15
    HEMJ(30,i)=mean(A070913(1850:2150,i));
end
HEMJ(30,16)=99000;
HEMJ(30,17)=0;
save A070913 A070913
save LoopData HEMJ
end
%% Helium Loop 7_9_2013 14_27_31
% Steady-State Experiment - New Cartridge
% Using Tip # 7 / Oxygen/Fuel Pressure - >8 psig 
% One SS Experiment - Heater on ~4 W
% 0.75 scan/second  
for m=1:0
clear
load LoopData
B070913=xlsread('Helium Loop 7_9_2013 14_27_31.csv', 1, 'C30:Y20000');
for i=1:15
    HEMJ(31,i)=mean(B070913(2800:3100,i));
end
HEMJ(31,16)=99000;
HEMJ(31,17)=0;
save B070913 B070913
save LoopData HEMJ
end
%% Helium Loop 7_10_2013 15_17_14
% Steady-State Experiment - New Cartridge/Fixed Tcs
% Using Tip # 7 / Oxygen/Fuel Pressure - >8 psig 
% Two SS Experiments - Heater on ~80 W/off
% 0.75 scan/second  
for m=1:0
clear
load LoopData
A071013=xlsread('Helium Loop 7_10_2013 15_17_14.csv', 1, 'C30:Y20000');
for i=1:15
    HEMJ(32,i)=mean(A071013(550:850,i));
end
HEMJ(32,16)=99000;
HEMJ(32,17)=0;
for i=1:15
    HEMJ(33,i)=mean(A071013(4900:5200,i));
end
HEMJ(33,16)=99000;
HEMJ(33,17)=0;
save A071013 A071013
save LoopData HEMJ
end
%% Helium Loop 7_11_2013 13_31_06
% Steady-State Experiment - New Cartridge/Fixed Tcs
% Using Tip # 7 / Oxygen/Fuel Pressure - >8 psig 
% One SS Experiments - Heater on ~80 W, ~6 g/s
% 0.75 scan/second  
for m=1:0
clear
load LoopData
A071113=xlsread('Helium Loop 7_11_2013 13_31_06.csv', 1, 'C30:Y20000');
for i=1:15
    HEMJ(34,i)=mean(A071113(5700:6000,i));
end
HEMJ(34,16)=99000;
HEMJ(34,17)=0;
save A071113 A071113
save LoopData HEMJ
end
%% Helium Loop 7_11_2013 14_47_12
% Steady-State Experiment - New Cartridge/Fixed Tcs
% One SS Experiments - Heater on 1066 W, ~6 g/s
% 0.75 scan/second  
for m=1:0
clear
load LoopData
B071113=xlsread('Helium Loop 7_11_2013 14_47_12.csv', 1, 'C30:Y20000');
for i=1:15
    HEMJ(35,i)=mean(B071113(2050:2250,i));
end
HEMJ(35,16)=99000;
HEMJ(35,17)=0;
save B071113 B071113
save LoopData HEMJ
end
%% Helium Loop 7_12_2013 14_25_38
% Steady-State Experiment - New Cartridge/Fixed Tcs
% Using Tip # 7 / Oxygen/Fuel Pressure - >8 psig 
% One SS Experiments - Heater on ~60 W, ~5.8 g/s
% 0.75 scan/second  
for m=1:0
clear
load LoopData
A071213=xlsread('Helium Loop 7_12_2013 14_25_38.csv', 1, 'C30:Y20000');
for i=1:15
    HEMJ(36,i)=mean(A071213(1200:1400,i)); 
end
HEMJ(36,16)=99000;
HEMJ(36,17)=0;
save A071213 A071213
save LoopData HEMJ
end
%% Helium Loop 7_16_2013 12_06_44
% Steady-State Experiment - New Cartridge/Extra Outlet TC
% One SS Experiments - Heater on, ~4.1 g/s
% 0.75 scan/second  
for m=1:0
clear
load LoopData
A071613=xlsread('Helium Loop 7_16_2013 12_06_44.csv', 1, 'C30:Y20000');
for i=1:16
    if i<14
        HEMJ(37,i)=mean(A071613(1400:1700,i));
    elseif i>14
        HEMJ(37,i-1)=mean(A071613(1400:1700,i));
    end
end
HEMJ(37,16)=99000;
HEMJ(37,17)=0;
save A071613 A071613
save LoopData HEMJ
end
%% Helium Loop 7_16_2013 13_03_29
% Steady-State Experiment - New Cartridge/Extra Outlet TC
% One SS Experiments - Heater on, ~4.1 g/s
% 0.75 scan/second  
for m=1:0
clear
load LoopData
B071613=xlsread('Helium Loop 7_16_2013 13_03_29.csv', 1, 'C30:Y20000');
for i=1:16
    if i<14
        HEMJ(38,i)=mean(B071613(300:600,i));
    elseif i>14
        HEMJ(38,i-1)=mean(B071613(300:600,i));
    end
end
HEMJ(38,16)=99000;
HEMJ(38,17)=0;
for i=1:16
    if i<14
        HEMJ(39,i)=mean(B071613(3300:3600,i));
    elseif i>14
        HEMJ(39,i-1)=mean(B071613(3300:3600,i));
    end
end
HEMJ(39,16)=99000;
HEMJ(39,17)=0;
save B071613 B071613
save LoopData HEMJ
end
%% Helium Loop 7_16_2013 13_48_54
% Steady-State Experiment - New Cartridge/Extra Outlet TC
% One SS Experiments - Heater on, ~4.1 g/s
% 0.75 scan/second  
for m=1:0
clear
load LoopData
C071613=xlsread('Helium Loop 7_16_2013 13_48_54.csv', 1, 'C30:Y20000');
for i=1:16
    if i<14
        HEMJ(40,i)=mean(C071613(3200:3500,i));
    elseif i>14
        HEMJ(40,i-1)=mean(C071613(3200:3500,i));
    end
end
HEMJ(40,16)=99000;
HEMJ(40,17)=0;
save C071613 C071613
save LoopData HEMJ
end
%% Helium Loop 7_17_2013 13_25_29
% Steady-State Experiment - New Cartridge/Fixed Tcs
% Using Tip # 7 / Oxygen/Fuel Pressure - >8 psig 
% One SS Experiments - Heater on ~110 W, ~6.0 g/s
% 0.75 scan/second  
for m=1:0
clear
load LoopData
A071713=xlsread('Helium Loop 7_17_2013 13_25_29.csv', 1, 'C30:Y20000');
for i=1:16
    if i<14
        HEMJ(41,i)=mean(A071713(3650:3950,i));
    elseif i>14
        HEMJ(41,i-1)=mean(A071713(3650:3950,i));
    end
end
HEMJ(41,16)=99000;
HEMJ(41,17)=0;
save A071713 A071713
save LoopData HEMJ
end
%% Helium Loop 7_17_2013 15_13_09
% Steady-State Experiment - New Cartridge/Fixed Tcs
% Using Tip # 7 / Oxygen/Fuel Pressure - >8 psig 
% One SS Experiments - Heater off, ~3.8 g/s
% 0.75 scan/second  
for m=1:0
clear
load LoopData
B071713=xlsread('Helium Loop 7_17_2013 15_13_09.csv', 1, 'C30:Y20000');
for i=1:16
    if i<14
        HEMJ(42,i)=mean(B071713(20:160,i));
    elseif i>14
        HEMJ(42,i-1)=mean(B071713(20:160,i));
    end
end
HEMJ(42,16)=99000;
HEMJ(42,17)=0;
save B071713 B071713
save LoopData HEMJ
end
%% Helium Loop 7_23_2013 15_30_58
% Steady-State Experiment - New Cartridge/Fixed Tcs
% Using Tip # 7 / Oxygen/Fuel Pressure - >8 psig 
% Two SS Experiments - Heater on, ~5 g/s and ~3.5 g/s
% 0.75 scan/second  
for m=1:0
clear
load LoopData
A072313=xlsread('Helium Loop 7_23_2013 15_30_58.csv', 1, 'C30:Y20000');
for i=1:16
    if i<14
        HEMJ(43,i)=mean(A072313(350:700,i));
    elseif i>14
        HEMJ(43,i-1)=mean(A072313(350:700,i));
    end
end
HEMJ(43,16)=99000;
HEMJ(43,17)=0;
for i=1:16
    if i<14
        HEMJ(44,i)=mean(A072313(3600:3900,i));
    elseif i>14
        HEMJ(44,i-1)=mean(A072313(3600:3900,i));
    end
end
HEMJ(44,16)=99000;
HEMJ(44,17)=0;
save A072313 A072313
save LoopData HEMJ
end
%% Helium Loop 7_26_2013 11_32_38
% Steady-State Experiment - New Cartridge/Fixed Tcs
% Using Tip # 7 / Oxygen/Fuel Pressure - >8 psig 
% One SS Experiments - Heater on, ~4 g/s
% 0.75 scan/second  
for m=1:0
clear
load LoopData
A072613=xlsread('Helium Loop 7_26_2013 11_32_38.csv', 1, 'C30:Y20000');
for i=1:16
    if i<14
        HEMJ(45,i)=mean(A072613(200:500,i));
    elseif i>14
        HEMJ(45,i-1)=mean(A072613(200:500,i));
    end
end
HEMJ(45,16)=99000;
HEMJ(45,17)=0;
save A072613 A072613
save LoopData HEMJ
end
%% Helium Loop 7_29_2013 10_50_35
% Steady-State Experiment - New Cartridge/Fixed Tcs
% Using Tip # 7 / Oxygen/Fuel Pressure - >8 psig 
% One SS Experiments - Heater on, ~6 g/s
% 0.75 scan/second  
for m=1:0
clear
load LoopData
A072913=xlsread('Helium Loop 7_29_2013 10_50_35.csv', 1, 'C30:Y20000');
for i=1:16
    if i<14
        HEMJ(46,i)=mean(A072913(4200:4500,i));
    elseif i>14
        HEMJ(46,i-1)=mean(A072913(4200:4500,i));
    end
end
HEMJ(46,16)=99000;
HEMJ(46,17)=0;
save A072913 A072913
save LoopData HEMJ
end
%% Helium Loop 8_2_2013 10_59_10
% Steady-State Experiment - New Cartridge/Fixed Tcs
% Using Tip # 7 / Oxygen/Fuel Pressure - >8 psig 
% One SS Experiments - Heater on ~312 W, ~4.8 g/s
% 0.75 scan/second  
for m=1:0
clear
load LoopData
A080213=xlsread('Helium Loop 8_2_2013 10_59_10.csv', 1, 'C30:Y20000');
for i=1:16
    if i<14
        HEMJ(47,i)=mean(A080213(4500:4800,i));
    elseif i>14
        HEMJ(47,i-1)=mean(A080213(4500:4800,i));
    end
end
HEMJ(47,16)=99000;
HEMJ(47,17)=0;
save A080213 A080213
save LoopData HEMJ
end
%% Helium Loop 8_6_2013 10_24_56
% Steady-State Experiment - New Cartridge/Fixed Tcs
% Using Tip # 7 / Oxygen/Fuel Pressure - >8 psig 
% One SS Experiments - Heater on ~44 W, ~3.2 g/s
% 0.75 scan/second  
for m=1:0
clear
load LoopData
A080613=xlsread('Helium Loop 8_6_2013 10_24_56.csv', 1, 'C30:Y20000');
for i=1:16
    if i<14
        HEMJ(48,i)=mean(A080613(4400:4700,i));
    elseif i>14
        HEMJ(48,i-1)=mean(A080613(4400:4700,i));
    end
end
HEMJ(48,16)=99000;
HEMJ(48,17)=0;
save A080613 A080613
save LoopData HEMJ
end
%% Importing JDR's Results

clear 
load LoopData
load JDR

HEMJ(49:93,1:17)=JDR;
save LoopData HEMJ

%% Helium Loop 8_7_2013 10_22_49
% Steady-State Experiment - New Cartridge/Fixed Tcs
% Using Tip # 7 / Oxygen/Fuel Pressure - >8 psig 
% One SS Experiments - Heater on ~645 W, ~3.8 g/s
% 0.75 scan/second  
for m=1:0
clear
load LoopData
A080713=xlsread('Helium Loop 8_7_2013 10_22_49.csv', 1, 'C30:Y20000');
for i=1:16
    if i<14
        HEMJ(94,i)=mean(A080713(5400:5700,i));
    elseif i>14
        HEMJ(94,i-1)=mean(A080713(5400:5700,i));
    end
end
HEMJ(94,16)=99000;
HEMJ(94,17)=0;
save A080713 A080713
save LoopData HEMJ
end
%% Helium Loop 8_8_2013 10_22_26
% Steady-State Experiment - New Cartridge/Fixed Tcs
% Using Tip # 7 / Oxygen/Fuel Pressure - >8 psig 
% One SS Experiments - Heater on ~850 W, ~4.8 g/s
% 0.75 scan/second  
for m=1:0
clear
load LoopData
A080813=xlsread('Helium Loop 8_8_2013 10_22_26.csv', 1, 'C30:Y20000');
for i=1:16
    if i<14
        HEMJ(95,i)=mean(A080813(5100:5400,i));
    elseif i>14
        HEMJ(95,i-1)=mean(A080813(5100:5400,i));
    end
end
HEMJ(95,16)=99000;
HEMJ(95,17)=0;
save A080813 A080813
save LoopData HEMJ
end
%% Helium Loop 8_8_2013 11_31_23
% Steady-State Experiment - New Cartridge/Fixed Tcs
% Using Tip # 7 / Oxygen/Fuel Pressure - >8 psig 
% One SS Experiments - Heater on ~1.2 kW, ~5.8 g/s
% 0.75 scan/second  
for m=1:0
clear
load LoopData
B080813=xlsread('Helium Loop 8_8_2013 11_31_23.csv', 1, 'C30:Y20000');
for i=1:16
    if i<14
        HEMJ(96,i)=mean(B080813(2300:2600,i));
    elseif i>14
        HEMJ(96,i-1)=mean(B080813(2300:2600,i));
    end
end
HEMJ(96,16)=99000;
HEMJ(96,17)=0;
save B080813 B080813
save LoopData HEMJ
end
%% Helium Loop 8_9_2013 10_48_34
% Steady-State Experiment - New Cartridge/Fixed Tcs
% Using Tip # 7 / Oxygen/Fuel Pressure - >8 psig 
% One SS Experiments - Heater on ~500 W, ~3 g/s
% 0.75 scan/second  
for m=1:0
clear
load LoopData
A080913=xlsread('Helium Loop 8_9_2013 10_48_34.csv', 1, 'C30:Y20000');
for i=1:16
    if i<14
        HEMJ(97,i)=mean(A080913(2500:2800,i));
    elseif i>14
        HEMJ(97,i-1)=mean(A080913(2500:2800,i));
    end
end
HEMJ(97,16)=99000;
HEMJ(97,17)=0;
save A080913 A080913
save LoopData HEMJ
end
%% Helium Loop 8_9_2013 11_24_23
% Steady-State Experiment - New Cartridge/Fixed Tcs
% Using Tip # 7 / Oxygen/Fuel Pressure - >8 psig 
% One SS Experiments - Heater on ~1.42 kW, ~6.8 g/s
% 0.75 scan/second  
for m=1:0
clear
load LoopData
B080913=xlsread('Helium Loop 8_9_2013 11_24_23.csv', 1, 'C30:Y20000');
for i=1:16
    if i<14
        HEMJ(98,i)=mean(B080913(1400:1700,i));
    elseif i>14
        HEMJ(98,i-1)=mean(B080913(1400:1700,i));
    end
end
HEMJ(98,16)=99000;
HEMJ(98,17)=0;
save B080913 B080913
save LoopData HEMJ
end
%% Helium Loop 8_13_2013 10_11_06
% Steady-State Experiment - New Cartridge/Fixed Tcs
% Using Tip # 7 / Oxygen/Fuel Pressure - >8 psig 
% One SS Experiments - Heater on ~0.97 kW, ~5.0 g/s
% 0.75 scan/second  
for m=1:0
clear
load LoopData
A081313=xlsread('Helium Loop 8_13_2013 10_11_06.csv', 1, 'C30:Y20000');
for i=1:16
    if i<14
        HEMJ(99,i)=mean(A081313(7200:7500,i));
    elseif i>14
        HEMJ(99,i-1)=mean(A081313(7200:7500,i));
    end
end
HEMJ(99,16)=99000;
HEMJ(99,17)=0;
save A081313 A081313
save LoopData HEMJ
end
%% Helium Loop 8_16_2013 12_50_32
% Steady-State Experiment - More Insulation/Graphite Sleeve
% Using Tip # 7 / Oxygen/Fuel Pressure - >8 psig 
% One SS Experiments - Heater on ~1.25 kW, ~6.1 g/s
% 0.75 scan/second  
for m=1:0
clear
load LoopData
A081613=xlsread('Helium Loop 8_16_2013 12_50_32.csv', 1, 'C30:Y20000');
for i=1:16
    if i<14
        HEMJ(100,i)=mean(A081613(2300:2600,i));
    elseif i>14
        HEMJ(100,i-1)=mean(A081613(2300:2600,i));
    end
end
HEMJ(100,16)=99000;
HEMJ(100,17)=0;
save A081613 A081613
save LoopData HEMJ
end
%% Helium Loop 8_26_2013 10_30_39
% Steady-State Experiment - RTDs
% Using Tip # 7 / Oxygen/Fuel Pressure - >8 psig 
% One SS Experiments - Heater on ~910 W, ~5 g/s
% 0.75 scan/second  
for m=1:0
clear
load LoopData
A082613=xlsread('Helium Loop 8_26_2013 10_30_39.csv', 1, 'C30:Y20000');
for i=1:16
    if i<14
        HEMJ(101,i)=mean(A082613(4100:4400,i));
    elseif i>14
        HEMJ(101,i-1)=mean(A082613(4100:4400,i));
    end
end
HEMJ(101,16)=99000;
HEMJ(101,17)=0;
save A082613 A082613
save LoopData HEMJ
end
%% Helium Loop 8_27_2013 10_18_49
% Steady-State Experiment - Laminarization Exp
% Using Tip # 7 / Oxygen/Fuel Pressure - >8 psig 
% One SS Experiments - Heater off, ~0.6x g/s
% 0.75 scan/second  
for m=1:0
clear
load LoopData
A082713=xlsread('Helium Loop 8_27_2013 10_18_49.csv', 1, 'C30:Y20000');
for i=1:16
    if i<14
        HEMJ(102,i)=mean(A082713(9200:9500,i));
    elseif i>14
        HEMJ(102,i-1)=mean(A082713(9200:9500,i));
    end
end
HEMJ(102,16)=99000;
HEMJ(102,17)=0;
save A082713 A082713
save LoopData HEMJ
end
%% Helium Loop 8_29_2013 10_11_34
% Steady-State Experiment - Laminarization Exp
% Using Tip # 5 / Oxygen/Fuel Pressure - >8 psig 
% One SS Experiments - Heater on ~50 W, ~0.6x g/s
% 0.75 scan/second  
for m=1:0
clear
load LoopData
A082913=xlsread('Helium Loop 8_29_2013 10_11_34.csv', 1, 'C30:Y20000');
for i=1:16
    if i<14
        HEMJ(103,i)=mean(A082913(6500:6800,i));
    elseif i>14
        HEMJ(103,i-1)=mean(A082913(6500:6800,i));
    end
end
HEMJ(103,16)=99000;
HEMJ(103,17)=0;
save A082913 A082913
save LoopData HEMJ
end
%% Helium Loop 8_30_2013 10_56_58
% Steady-State Experiment - Laminarization Exp
% Using Tip # 7 / Oxygen/Fuel Pressure - >8 psig 
% One SS Experiments - Heater off, ~0.6x g/s
% 0.75 scan/second  
for m=1:0
clear
load LoopData
A083013=xlsread('Helium Loop 8_30_2013 10_56_58.csv', 1, 'C30:Y20000');
for i=1:16
    if i<14
        HEMJ(104,i)=mean(A083013(5100:5200,i));
    elseif i>14
        HEMJ(104,i-1)=mean(A083013(5100:5200,i));
    end
end
HEMJ(104,16)=99000;
HEMJ(104,17)=0;
save A083013 A083013
save LoopData HEMJ
end
%% Helium Loop 9_17_2013 10_19_24
% Steady-State Experiment - Rebuilt - Brass/MT185
% Using Tip # 7 / Oxygen/Fuel Pressure - >8 psig 
% One SS Experiments - Heater on, ~3.8 g/s
% 0.75 scan/second  
for m=1:0
clear
load LoopData
A091713=xlsread('Helium Loop 9_17_2013 10_19_24.csv', 1, 'C30:Y20000');
for i=1:16
    if i<14
        HEMJ(105,i)=mean(A091713(4250:4550,i));
    elseif i>14
        HEMJ(105,i-1)=mean(A091713(4250:4550,i));
    end
end
HEMJ(105,16)=99000;
HEMJ(105,17)=0;
save A091713 A091713
save LoopData HEMJ
end
%% Helium Loop 9_17_2013 11_39_21
% Steady-State Experiment - Rebuilt - Brass/MT185
% Using Tip # 7 / Oxygen/Fuel Pressure - >8 psig 
% One SS Experiments - Heater on, ~6 g/s
% 0.75 scan/second  
for m=1:0
clear
load LoopData
B091713=xlsread('Helium Loop 9_17_2013 11_39_21.csv', 1, 'C30:Y20000');
for i=1:16
    if i<14
        HEMJ(106,i)=mean(B091713(1650:1950,i));
    elseif i>14
        HEMJ(106,i-1)=mean(B091713(1650:1950,i));
    end
end
HEMJ(106,16)=99000;
HEMJ(106,17)=0;
save B091713 B091713
save LoopData HEMJ
end
%% Helium Loop 9_18_2013 12_25_11
% Steady-State Experiment - Rebuilt - Brass/MT185
% Using Tip # 7 / Oxygen/Fuel Pressure - >8 psig 
% One SS Experiments - Heater on, ~3.8 g/s, Better Tc Profile
% 0.75 scan/second  
for m=1:0
clear
load LoopData
A091813=xlsread('Helium Loop 9_18_2013 12_25_11.csv', 1, 'C30:Y20000');
for i=1:16
    if i<14
        HEMJ(107,i)=mean(A091813(1400:1600,i));
    elseif i>14
        HEMJ(107,i-1)=mean(A091813(1400:1600,i));
    end
end
HEMJ(107,16)=99000;
HEMJ(107,17)=0;
save A091813 A091813
save LoopData HEMJ
end
%% Helium Loop 9_19_2013 10_34_51
% Steady-State Experiment - Rebuilt - Brass/MT185
% Using Tip # 7 / Oxygen/Fuel Pressure - >8 psig 
% One SS Experiments - Heater on, ~6 g/s, Ti=100
% 0.75 scan/second  
for m=1:0
clear
load LoopData
A091913=xlsread('Helium Loop 9_19_2013 10_34_51.csv', 1, 'C30:Y20000');
for i=1:16
    if i<14
        HEMJ(108,i)=mean(A091913(1400:1700,i));
    elseif i>14
        HEMJ(108,i-1)=mean(A091913(1400:1700,i));
    end
end
HEMJ(108,16)=99000;
HEMJ(108,17)=0;
save A091913 A091913
save LoopData HEMJ
end
%% Helium Loop 9_19_2013 10_57_59
% Steady-State Experiment - Rebuilt - Brass/MT185
% Using Tip # 7 / Oxygen/Fuel Pressure - >8 psig 
% One SS Experiments - Heater on, ~5 g/s, Ti=100
% 0.75 scan/second  
for m=1:0
clear
load LoopData
B091913=xlsread('Helium Loop 9_19_2013 10_57_59.csv', 1, 'C30:Y20000');
for i=1:16
    if i<14
        HEMJ(109,i)=mean(B091913(950:1250,i));
    elseif i>14
        HEMJ(109,i-1)=mean(B091913(950:1250,i));
    end
end
HEMJ(109,16)=99000;
HEMJ(109,17)=0;
save B091913 B091913
save LoopData HEMJ
end
%% Helium Loop 9_20_2013 09_49_31
% Steady-State Experiment - Rebuilt - Brass/MT185
% Using Tip # 7 / Oxygen/Fuel Pressure - >8 psig 
% One SS Experiments - Heater on, ~4.5 g/s,  Ti=100
% 0.75 scan/second  
for m=1:0
clear
load LoopData
A092013=xlsread('Helium Loop 9_20_2013 09_49_31.csv', 1, 'C30:Y20000');
for i=1:16
    if i<14
        HEMJ(110,i)=mean(A092013(4700:5000,i));
    elseif i>14
        HEMJ(110,i-1)=mean(A092013(4700:5000,i));
    end
end
HEMJ(110,16)=99000;
HEMJ(110,17)=0;
save A092013 A092013
save LoopData HEMJ
end
%% Helium Loop 9_20_2013 10_56_57
% Steady-State Experiment - Rebuilt - Brass/MT185
% Using Tip # 7 / Oxygen/Fuel Pressure - >8 psig 
% One SS Experiments - Heater on, ~3 g/s, Ti=100
% 0.75 scan/second  
for m=1:0
clear
load LoopData
B092013=xlsread('Helium Loop 9_20_2013 10_56_57.csv', 1, 'C30:Y20000');
for i=1:16
    if i<14
        HEMJ(111,i)=mean(B092013(1950:2250,i));
    elseif i>14
        HEMJ(111,i-1)=mean(B092013(1950:2250,i));
    end
end
HEMJ(111,16)=99000;
HEMJ(111,17)=0;
save B092013 B092013
save LoopData HEMJ
end
%% Helium Loop 9_20_2013 11_27_58
% Steady-State Experiment - Rebuilt - Brass/MT185
% Using Tip # 7 / Oxygen/Fuel Pressure - >8 psig 
% One SS Experiments - Heater on, ~6 g/s, Ti=200
% 0.75 scan/second  
for m=1:0
clear
load LoopData
C092013=xlsread('Helium Loop 9_20_2013 11_27_58.csv', 1, 'C30:Y20000');
for i=1:16
    if i<14
        HEMJ(112,i)=mean(C092013(1900:2200,i));
    elseif i>14
        HEMJ(112,i-1)=mean(C092013(1900:2200,i));
    end
end
HEMJ(112,16)=99000;
HEMJ(112,17)=0;
save C092013 C092013
save LoopData HEMJ
end
%% Helium Loop 9_23_2013 10_05_01
% Steady-State Experiment - Rebuilt - Brass/MT185
% Using Tip # 7 / Oxygen/Fuel Pressure - >8 psig 
% One SS Experiments - Heater on, ~5 g/s, Ti=200
% 0.75 scan/second  
for m=1:0
clear
load LoopData
A092313=xlsread('Helium Loop 9_23_2013 10_05_01.csv', 1, 'C30:Y20000');
for i=1:16
    if i<14
        HEMJ(113,i)=mean(A092313(4650:4950,i));
    elseif i>14
        HEMJ(113,i-1)=mean(A092313(4650:4950,i));
    end
end
HEMJ(113,16)=99000;
HEMJ(113,17)=0;
save A092313 A092313
save LoopData HEMJ
end
%% Helium Loop 9_23_2013 11_13_37
% Steady-State Experiment - Rebuilt - Brass/MT185
% Using Tip # 7 / Oxygen/Fuel Pressure - >8 psig 
% One SS Experiments - Heater on, ~4 g/s, Ti=200
% 0.75 scan/second  
for m=1:0
clear
load LoopData
B092313=xlsread('Helium Loop 9_23_2013 11_13_37.csv', 1, 'C30:Y20000');
for i=1:16
    if i<14
        HEMJ(114,i)=mean(B092313(1250:1550,i));
    elseif i>14
        HEMJ(114,i-1)=mean(B092313(1250:1550,i));
    end
end
HEMJ(114,16)=99000;
HEMJ(114,17)=0;
save B092313 B092313
save LoopData HEMJ
end
%% Helium Loop 9_24_2013 10_11_37
% Steady-State Experiment - Rebuilt - Brass/MT185
% Using Tip # 7 / Oxygen/Fuel Pressure - >8 psig 
% One SS Experiments - Heater on, ~6 g/s, Ti=300
% 0.75 scan/second  
for m=1:0
clear
load LoopData
A092413=xlsread('Helium Loop 9_24_2013 10_11_37.csv', 1, 'C30:Y20000');
for i=1:16
    if i<14
        HEMJ(115,i)=mean(A092413(4100:4400,i));
    elseif i>14
        HEMJ(115,i-1)=mean(A092413(4100:4400,i));
    end
end
HEMJ(115,16)=99000;
HEMJ(115,17)=0;
save A092413 A092413
save LoopData HEMJ
end
%% Helium Loop 9_24_2013 11_11_45
% Steady-State Experiment - Rebuilt - Brass/MT185
% Using Tip # 7 / Oxygen/Fuel Pressure - >8 psig 
% One SS Experiments - Heater on, ~5 g/s, Ti=300
% 0.75 scan/second  
for m=1:0
clear
load LoopData
B092413=xlsread('Helium Loop 9_24_2013 11_11_45.csv', 1, 'C30:Y20000');
for i=1:16
    if i<14
        HEMJ(116,i)=mean(B092413(1820:2010,i));
    elseif i>14
        HEMJ(116,i-1)=mean(B092413(1820:2010,i));
    end
end
HEMJ(116,16)=99000;
HEMJ(116,17)=0;
save B092413 B092413
save LoopData HEMJ
end
%% Helium Loop 9_26_2013 10_19_14
% Steady-State Experiment - Rebuilt - Brass/MT185
% Using Tip # 7 / Oxygen/Fuel Pressure - >8 psig 
% One SS Experiments - Heater on, ~3 g/s, Ti=300
% 0.75 scan/second  
for m=1:0
clear
load LoopData
A092613=xlsread('Helium Loop 9_26_2013 10_19_14.csv', 1, 'C30:Y20000');
for i=1:16
    if i<14
        HEMJ(117,i)=mean(A092613(3150:3450,i));
    elseif i>14
        HEMJ(117,i-1)=mean(A092613(3150:3450,i));
    end
end
HEMJ(117,16)=99000;
HEMJ(117,17)=0;
save A092613 A092613
save LoopData HEMJ
end
%% Helium Loop 9_26_2013 11_07_03
% Steady-State Experiment - Rebuilt - Brass/MT185
% Using Tip # 7 / Oxygen/Fuel Pressure - >8 psig 
% One SS Experiments - Heater on, ~7 g/s, Ti=300
% 0.75 scan/second  
for m=1:0
clear
load LoopData
B092613=xlsread('Helium Loop 9_26_2013 11_07_03.csv', 1, 'C30:Y20000');
for i=1:16
    if i<14
        HEMJ(118,i)=mean(B092613(1350:1650,i));
    elseif i>14
        HEMJ(118,i-1)=mean(B092613(1350:1650,i));
    end
end
HEMJ(118,16)=99000;
HEMJ(118,17)=0;
save B092613 B092613
save LoopData HEMJ
end
%% Helium Loop 9_27_2013 10_27_23
% Steady-State Experiment - Laminarization - Brass/MT185
% Using Tip # 7 / Oxygen/Fuel Pressure - >8 psig 
% One SS Experiments - Heater off, ~1.3 g/s, Ti=125, ~2.4 MW/m^2
% 0.75 scan/second  
for m=1:0
clear
load LoopData
A092713=xlsread('Helium Loop 9_27_2013 10_27_23.csv', 1, 'C30:Y20000');
for i=1:16
    if i<14
        HEMJ(119,i)=mean(A092713(6600:6900,i));
    elseif i>14
        HEMJ(119,i-1)=mean(A092713(6600:6900,i));
    end
end
HEMJ(119,16)=99000;
HEMJ(119,17)=0;
save A092713 A092713
save LoopData HEMJ
end
%% Helium Loop 9_30_2013 10_33_26
% Steady-State Experiment - Laminarization - Brass/MT185
% Using Tip # 7 / Oxygen/Fuel Pressure - >8 psig 
% One SS Experiments - Heater on, ~1.3 g/s, Ti=125, ~0.7 MW/m^2
% 0.75 scan/second  
for m=1:0
clear
load LoopData
A093013=xlsread('Helium Loop 9_30_2013 10_33_26.csv', 1, 'C30:Y20000');
for i=1:16
    if i<14
        HEMJ(120,i)=mean(A093013(5250:5550,i));
    elseif i>14
        HEMJ(120,i-1)=mean(A093013(5250:5550,i));
    end
end
HEMJ(120,16)=99000;
HEMJ(120,17)=0;
save A093013 A093013
save LoopData HEMJ
end
%% Helium Loop 10_21_2013 10_24_22
% Steady-State Experiment - Inlet T Experiments - Brass/MT185
% Using Tip # 7 / Oxygen/Fuel Pressure - >8 psig 
% One SS Experiments - Heater on, ~3.3 g/s, Ti=27, ~2.3 MW/m^2
% 0.75 scan/second  
for m=1:0
clear
load LoopData
A102113=xlsread('Helium Loop 10_21_2013 10_24_22.csv', 1, 'C30:Y20000');
for i=1:16
    if i<14
        HEMJ(121,i)=mean(A102113(4150:4450,i));
    elseif i>14
        HEMJ(121,i-1)=mean(A102113(4150:4450,i));
    end
end
HEMJ(121,16)=99000;
HEMJ(121,17)=0;
save A102113 A102113
save LoopData HEMJ
end
%% Helium Loop 10_22_2013 10_30_11
% Steady-State Experiment - Inlet T Experiments - Brass/MT185
% Using Tip # 7 / Oxygen/Fuel Pressure - >8 psig 
% One SS Experiments - Heater on, ~4.5 g/s, Ti=100, ~2.3 MW/m^2
% 0.75 scan/second  
for m=1:0
clear
load LoopData
A102213=xlsread('Helium Loop 10_22_2013 10_30_11.csv', 1, 'C30:Y20000');
for i=1:16
    if i<14
        HEMJ(122,i)=mean(A102213(5600:5800,i));
    elseif i>14
        HEMJ(122,i-1)=mean(A102213(5600:5800,i));
    end
end
HEMJ(122,16)=99000;
HEMJ(122,17)=0;
save A102213 A102213
save LoopData HEMJ
end
%% Helium Loop 10_23_2013 11_10_25
% Steady-State Experiment - Inlet T Experiments - Brass/MT185
% Using Tip # 7 / Oxygen/Fuel Pressure - >8 psig 
% One SS Experiments - Heater on, ~4.5 g/s, Ti=200, ~2.3 MW/m^2
% 0.75 scan/second  
for m=1:0
clear
load LoopData
A102313=xlsread('Helium Loop 10_23_2013 11_10_25.csv', 1, 'C30:Y20000');
for i=1:16
    if i<14
        HEMJ(123,i)=mean(A102313(1:301,i));
    elseif i>14
        HEMJ(123,i-1)=mean(A102313(1:301,i));
    end
end
HEMJ(123,16)=99000;
HEMJ(123,17)=0;
save A102313 A102313
save LoopData HEMJ
end
%% Helium Loop 10_23_2013 11_46_29
% Steady-State Experiment - Inlet T Experiments - Brass/MT185
% Using Tip # 7 / Oxygen/Fuel Pressure - >8 psig 
% One SS Experiments - Heater on, ~5.2 g/s, Ti=300, ~2.3 MW/m^2
% 0.75 scan/second  
for m=1:0
clear
load LoopData
B102313=xlsread('Helium Loop 10_23_2013 11_46_29.csv', 1, 'C30:Y20000');
for i=1:16
    if i<14
        HEMJ(124,i)=mean(B102313(1:251,i));
    elseif i>14
        HEMJ(124,i-1)=mean(B102313(1:251,i));
    end
end
HEMJ(124,16)=99000;
HEMJ(124,17)=0;
save B102313 B102313
save LoopData HEMJ
end
%% Helium Loop 10_25_2013 10_20_48
% Steady-State Experiment - Inlet T Experiments - Brass/MT185
% Using Tip # 7 / Oxygen/Fuel Pressure - >8 psig 
% One SS Experiments - Heater on, ~6.4 g/s, Ti=300, ~2.3 MW/m^2
% 0.75 scan/second  
for m=1:0
clear
load LoopData
A102513=xlsread('Helium Loop 10_25_2013 10_20_48.csv', 1, 'C30:Y20000');
for i=1:16
    if i<14
        HEMJ(125,i)=mean(A102513(4200:4400,i));
    elseif i>14
        HEMJ(125,i-1)=mean(A102513(4200:4400,i));
    end
end
HEMJ(125,16)=99000;
HEMJ(125,17)=0;
save A102513 A102513
save LoopData HEMJ
end
%% Helium Loop 10_25_2013 11_21_41
% Steady-State Experiment - Inlet T Experiments - Brass/MT185
% Using Tip # 7 / Oxygen/Fuel Pressure - >8 psig 
% One SS Experiments - Heater on, ~5.6 g/s, Ti=200, ~2.3 MW/m^2
% 0.75 scan/second  
for m=1:0
clear
load LoopData
B102513=xlsread('Helium Loop 10_25_2013 11_21_41.csv', 1, 'C30:Y20000');
for i=1:16
    if i<14
        HEMJ(126,i)=mean(B102513(1400:1600,i));
    elseif i>14
        HEMJ(126,i-1)=mean(B102513(1400:1600,i));
    end
end
HEMJ(126,16)=99000;
HEMJ(126,17)=0;
save B102513 B102513
save LoopData HEMJ
end
%% Helium Loop 10_28_2013 10_23_55
% Steady-State Experiment - Inlet T Experiments - Brass/MT185
% Using Tip # 7 / Oxygen/Fuel Pressure - >8 psig 
% One SS Experiments - Heater on, ~4.8 g/s, Ti=100, ~2.3 MW/m^2
% 0.75 scan/second  
for m=1:0
clear
load LoopData
A102813=xlsread('Helium Loop 10_28_2013 10_23_55.csv', 1, 'C30:Y20000');
for i=1:16
    if i<14
        HEMJ(127,i)=mean(A102813(2900:3100,i));
    elseif i>14
        HEMJ(127,i-1)=mean(A102813(2900:3100,i));
    end
end
HEMJ(127,16)=99000;
HEMJ(127,17)=0;
save A102813 A102813
save LoopData HEMJ
end
%% Helium Loop 10_28_2013 11_15_59
% Steady-State Experiment - Inlet T Experiments - Brass/MT185
% Using Tip # 7 / Oxygen/Fuel Pressure - >8 psig 
% One SS Experiments - Heater on, ~4.1 g/s, Ti=27, ~2.3 MW/m^2
% 0.75 scan/second  
for m=1:0
clear
load LoopData
B102813=xlsread('Helium Loop 10_28_2013 11_15_59.csv', 1, 'C30:Y20000');
for i=1:16
    if i<14
        HEMJ(128,i)=mean(B102813(2900:3200,i));
    elseif i>14
        HEMJ(128,i-1)=mean(B102813(2900:3200,i));
    end
end
HEMJ(128,16)=99000;
HEMJ(128,17)=0;
save B102813 B102813
save LoopData HEMJ
end
%% Helium Loop 11_12_2013 10_22_07
% Steady-State Experiment - Inlet T Experiments - Steel/MT185
% Using Tip # 7 / Oxygen/Fuel Pressure - >8 psig 
% One SS Experiments - Heater on, ~4.1 g/s, Ti=27, ~2.8 MW/m^2
% 0.75 scan/second  
for m=1:0
clear
load LoopData
A111213=xlsread('Helium Loop 11_12_2013 10_22_07.csv', 1, 'C30:Y20000');
for i=1:16
    if i<14
        HEMJ(129,i)=mean(A111213(4700:5000,i));
    elseif i>14
        HEMJ(129,i-1)=mean(A111213(4700:5000,i));
    end
end
HEMJ(129,16)=99000;
HEMJ(129,17)=0;
save A111213 A111213
save LoopData HEMJ
end
%% Helium Loop 11_12_2013 11_30_02                                          Case 130
% Steady-State Experiment - Inlet T Experiments - Steel/MT185
% Using Tip # 7 / Oxygen/Fuel Pressure - >8 psig 
% One SS Experiments - Heater on, ~4.7 g/s, Ti=100, ~2.7 MW/m^2
% 0.75 scan/second  
for m=1:0
clear
load LoopData
B111213=xlsread('Helium Loop 11_12_2013 11_30_02.csv', 1, 'C30:Y20000');
for i=1:16
    if i<14
        HEMJ(130,i)=mean(B111213(2300:2500,i));
    elseif i>14
        HEMJ(130,i-1)=mean(B111213(2300:2500,i));
    end
end
HEMJ(130,16)=99000;
HEMJ(130,17)=0;
save B111213 B111213
save LoopData HEMJ
end
%% Helium Loop 11_13_2013 10_46_36
% Steady-State Experiment - Inlet T Experiments - Steel/MT185
% Using Tip # 7 / Oxygen/Fuel Pressure - >8 psig 
% One SS Experiments - Heater on, ~5.6 g/s, Ti=200, ~2.4 MW/m^2
% 0.75 scan/second  
for m=1:0
clear
load LoopData
A111313=xlsread('Helium Loop 11_13_2013 10_46_36.csv', 1, 'C30:Y20000');
for i=1:16
    if i<14
        HEMJ(131,i)=mean(A111313(4800:5100,i));
    elseif i>14
        HEMJ(131,i-1)=mean(A111313(4800:5100,i));
    end
end
HEMJ(131,16)=99000;
HEMJ(131,17)=0;
save A111313 A111313
save LoopData HEMJ
end
%% Helium Loop 11_13_2013 11_55_39
% Steady-State Experiment - Inlet T Experiments - Steel/MT185
% Using Tip # 7 / Oxygen/Fuel Pressure - >8 psig 
% One SS Experiments - Heater on, ~6.4 g/s, Ti=300, ~2.3 MW/m^2
% 0.75 scan/second  
for m=1:0
clear
load LoopData
B111313=xlsread('Helium Loop 11_13_2013 11_55_39.csv', 1, 'C30:Y20000');
for i=1:16
    if i<14
        HEMJ(132,i)=mean(B111313(2700:3000,i));
    elseif i>14
        HEMJ(132,i-1)=mean(B111313(2700:3000,i));
    end
end
HEMJ(132,16)=99000;
HEMJ(132,17)=0;
save B111313 B111313
save LoopData HEMJ
end
%% Helium Loop 11_14_2013 11_21_41
% Steady-State Experiment - Inlet T Experiments - Steel/MT185
% Using Tip # 7 / Oxygen/Fuel Pressure - >8 psig 
% One SS Experiments - Heater on, ~3.1 g/s, Ti=26, ~2.5 MW/m^2
% 0.75 scan/second  
for m=1:0
clear
load LoopData
A111413=xlsread('Helium Loop 11_14_2013 11_21_41.csv', 1, 'C30:Y20000');
for i=1:16
    if i<14
        HEMJ(133,i)=mean(A111413(400:700,i));
    elseif i>14
        HEMJ(133,i-1)=mean(A111413(400:700,i));
    end
end
HEMJ(133,16)=99000;
HEMJ(133,17)=0;
save A111413 A111413
save LoopData HEMJ
end
%% Helium Loop 11_14_2013 11_32_24
% Steady-State Experiment - Inlet T Experiments - Steel/MT185
% Using Tip # 7 / Oxygen/Fuel Pressure - >8 psig 
% One SS Experiments - Heater on, ~3.7 g/s, Ti=100, ~2.3 MW/m^2
% 0.75 scan/second  
for m=1:0
clear
load LoopData
B111413=xlsread('Helium Loop 11_14_2013 11_32_24.csv', 1, 'C30:Y20000');
for i=1:16
    if i<14
        HEMJ(134,i)=mean(B111413(2075:2375,i));
    elseif i>14
        HEMJ(134,i-1)=mean(B111413(2075:2375,i));
    end
end
HEMJ(134,16)=99000;
HEMJ(134,17)=0;
save B111413 B111413
save LoopData HEMJ
end
%% Helium Loop 11_15_2013 10_59_13
% Steady-State Experiment - Inlet T Experiments - Steel/MT185
% Using Tip # 7 / Oxygen/Fuel Pressure - >8 psig 
% One SS Experiments - Heater on, ~4.25 g/s, Ti=200, ~2.5 MW/m^2
% 0.75 scan/second  
for m=1:0
clear
load LoopData
A111513=xlsread('Helium Loop 11_15_2013 10_59_13.csv', 1, 'C30:Y20000');
for i=1:16
    if i<14
        HEMJ(135,i)=mean(A111513(2500:2800,i));
    elseif i>14
        HEMJ(135,i-1)=mean(A111513(2500:2800,i));
    end
end
HEMJ(135,16)=99000;
HEMJ(135,17)=0;
save A111513 A111513
save LoopData HEMJ
end
%% Helium Loop 11_15_2013 11_37_11
% Steady-State Experiment - Inlet T Experiments - Steel/MT185
% Using Tip # 7 / Oxygen/Fuel Pressure - >8 psig 
% One SS Experiments - Heater on, ~4.85 g/s, Ti=300, ~2.3 MW/m^2
% 0.75 scan/second  
for m=1:0
clear
load LoopData
B111513=xlsread('Helium Loop 11_15_2013 11_37_11.csv', 1, 'C30:Y20000');
for i=1:16
    if i<14
        HEMJ(136,i)=mean(B111513(3900:4100,i));
    elseif i>14
        HEMJ(136,i-1)=mean(B111513(3900:4100,i));
    end
end
HEMJ(136,16)=99000;
HEMJ(136,17)=0;
save B111513 B111513
save LoopData HEMJ
end
%% Helium Loop 11_18_2013 10_19_12
% Steady-State Experiment - Inlet T Experiments - Steel/MT185
% Using Tip # 7 / Oxygen/Fuel Pressure - >8 psig 
% One SS Experiments - Heater on, ~5.1 g/s, Ti=26, ~2.7 MW/m^2
% 0.75 scan/second  
for m=1:0
clear
load LoopData
A111813=xlsread('Helium Loop 11_18_2013 10_19_12.csv', 1, 'C30:Y20000');
for i=1:16
    if i<14
        HEMJ(137,i)=mean(A111813(3500:3800,i));
    elseif i>14
        HEMJ(137,i-1)=mean(A111813(3500:3800,i));
    end
end
HEMJ(137,16)=99000;
HEMJ(137,17)=0;
save A111813 A111813
save LoopData HEMJ
end
%% Helium Loop 11_18_2013 11_10_25
% Steady-State Experiment - Inlet T Experiments - Steel/MT185
% Using Tip # 7 / Oxygen/Fuel Pressure - >8 psig 
% One SS Experiments - Heater on, ~5.95 g/s, Ti=100, ~2.6 MW/m^2
% 0.75 scan/second  
for m=1:0
clear
load LoopData
B111813=xlsread('Helium Loop 11_18_2013 11_10_25.csv', 1, 'C30:Y20000');
for i=1:16
    if i<14
        HEMJ(138,i)=mean(B111813(1200:1500,i));
    elseif i>14
        HEMJ(138,i-1)=mean(B111813(1200:1500,i));
    end
end
HEMJ(138,16)=99000;
HEMJ(138,17)=0;
save B111813 B111813
save LoopData HEMJ
end
%% Helium Loop 11_19_2013 10_24_11
% Steady-State Experiment - Inlet T Experiments - Steel/MT185
% Using Tip # 7 / Oxygen/Fuel Pressure - >8 psig 
% One SS Experiments - Heater on, ~4.1 g/s, Ti=27, ~2.6 MW/m^2
% 0.75 scan/second  
for m=1:0
clear
load LoopData
A111913=xlsread('Helium Loop 11_19_2013 10_24_11.csv', 1, 'C30:Y20000');
for i=1:16
    if i<14
        HEMJ(139,i)=mean(A111913(3000:3200,i));
    elseif i>14
        HEMJ(139,i-1)=mean(A111913(3000:3200,i));
    end
end
HEMJ(139,16)=99000;
HEMJ(139,17)=0;
save A111913 A111913
save LoopData HEMJ
end
%% Helium Loop 11_19_2013 11_08_24                                          Case 140
% Steady-State Experiment - Inlet T Experiments - Steel/MT185
% Using Tip # 7 / Oxygen/Fuel Pressure - >8 psig 
% One SS Experiments - Heater on, ~4.9 g/s, Ti=250, ~2.5 MW/m^2
% 0.75 scan/second  
for m=1:0
clear
load LoopData
B111913=xlsread('Helium Loop 11_19_2013 11_08_24.csv', 1, 'C30:Y20000');
for i=1:16
    if i<14
        HEMJ(140,i)=mean(B111913(2700:3000,i));
    elseif i>14
        HEMJ(140,i-1)=mean(B111913(2700:3000,i));
    end
end
HEMJ(140,16)=99000;
HEMJ(140,17)=0;
save B111913 B111913
save LoopData HEMJ
end
%% Helium Loop 11_19_2013 11_49_07
% Steady-State Experiment - Inlet T Experiments - Steel/MT185
% Using Tip # 7 / Oxygen/Fuel Pressure - >8 psig 
% One SS Experiments - Heater on, ~7.5 g/s, Ti=250, ~2.5 MW/m^2
% 0.75 scan/second  
for m=1:0
clear
load LoopData
C111913=xlsread('Helium Loop 11_19_2013 11_49_07.csv', 1, 'C30:Y20000');
for i=1:16
    if i<14
        HEMJ(141,i)=mean(C111913(750:950,i));
    elseif i>14
        HEMJ(141,i-1)=mean(C111913(750:950,i));
    end
end
HEMJ(141,16)=99000;
HEMJ(141,17)=0;
save C111913 C111913
save LoopData HEMJ
end
%% Helium Loop 11_26_2013 16_00_14
% Steady-State Experiment - Induction Heater Experiments - Steel/MT185
% Induction Heater - Tap 10 - ~200 W
% One SS Experiments - Heater off, ~4.1 g/s, Ti=27, ~2 MW/m^2
% 0.75 scan/second  
for m=1:0
clear
load LoopData
A112613=xlsread('Helium Loop 11_26_2013 16_00_14.csv', 1, 'C30:Y20000');
for i=1:16
    if i<14
        HEMJ(142,i)=mean(A112613(1700:2000,i));
    elseif i>14
        HEMJ(142,i-1)=mean(A112613(1700:2000,i));
    end
end
HEMJ(142,16)=99000;
HEMJ(142,17)=0;
save A112613 A112613
save LoopData HEMJ
end
%% Helium Loop 11_27_2013 08_23_12
% Steady-State Experiment - Induction Heater Experiments - Steel/MT185
% Induction Heater - Tap 10 - ~200 W
% One SS Experiments - Heater off, ~4.1 g/s, Ti=27, ~1.6 MW/m^2
% 0.75 scan/second  
for m=1:0
clear
load LoopData
A112713=xlsread('Helium Loop 11_27_2013 08_23_12.csv', 1, 'C30:Y20000');
for i=1:16
    if i<14
        HEMJ(143,i)=mean(A112713(2200:2400,i));
    elseif i>14
        HEMJ(143,i-1)=mean(A112713(2200:2400,i));
    end
end
HEMJ(143,16)=99000;
HEMJ(143,17)=0;
save A112713 A112713
save LoopData HEMJ
end
%% Helium Loop 12_3_2013 10_21_32
% Steady-State Experiment - Inlet T Experiments - Steel/MT185
% Using Tip # 7 / Oxygen/Fuel Pressure - >8 psig 
% One SS Experiments - Heater on, ~2.5 g/s, Ti=26, ~2.5 MW/m^2
% 0.75 scan/second  
for m=1:0
clear
load LoopData
A120313=xlsread('Helium Loop 12_3_2013 10_21_32.csv', 1, 'C30:Y20000');
for i=1:16
    if i<14
        HEMJ(144,i)=mean(A120313(1850:2150,i));
    elseif i>14
        HEMJ(144,i-1)=mean(A120313(1850:2150,i));
    end
end
HEMJ(144,16)=99000;
HEMJ(144,17)=0;
save A120313 A120313
save LoopData HEMJ
end
%% Helium Loop 12_3_2013 10_50_38
% Steady-State Experiment - Inlet T Experiments - Steel/MT185
% Using Tip # 7 / Oxygen/Fuel Pressure - >8 psig 
% One SS Experiments - Heater on, ~2.9 g/s, Ti=100, ~2.5 MW/m^2
% 0.75 scan/second  
for m=1:0
clear
load LoopData
B120313=xlsread('Helium Loop 12_3_2013 10_50_38.csv', 1, 'C30:Y20000');
for i=1:16
    if i<14
        HEMJ(145,i)=mean(B120313(1700:2000,i));
    elseif i>14
        HEMJ(145,i-1)=mean(B120313(1700:2000,i));
    end
end
HEMJ(145,16)=99000;
HEMJ(145,17)=0;
save B120313 B120313
save LoopData HEMJ
end
%% Helium Loop 12_4_2013 10_21_13
% Steady-State Experiment - Inlet T Experiments - Steel/MT185
% Using Tip # 7 / Oxygen/Fuel Pressure - >8 psig 
% One SS Experiments - Heater on, ~3.45 g/s, Ti=200, ~2.3 MW/m^2
% 0.75 scan/second  
for m=1:0
clear
load LoopData
A120413=xlsread('Helium Loop 12_4_2013 10_21_13.csv', 1, 'C30:Y20000');
for i=1:16
    if i<14
        HEMJ(146,i)=mean(A120413(3000:3300,i));
    elseif i>14
        HEMJ(146,i-1)=mean(A120413(3000:3300,i));
    end
end
HEMJ(146,16)=99000;
HEMJ(146,17)=0;
save A120413 A120413
save LoopData HEMJ
end
%% Helium Loop 12_4_2013 11_50_20
% Steady-State Experiment - Inlet T Experiments - Steel/MT185
% Using Tip # 7 / Oxygen/Fuel Pressure - >8 psig 
% One SS Experiments - Heater on, ~3.6 g/s, Ti=300, ~2.2 MW/m^2
% 0.75 scan/second  
for m=1:0
clear
load LoopData
B120413=xlsread('Helium Loop 12_4_2013 11_50_20.csv', 1, 'C30:Y20000');
for i=1:16
    if i<14
        HEMJ(147,i)=mean(B120413(1200:1400,i));
    elseif i>14
        HEMJ(147,i-1)=mean(B120413(1200:1400,i));
    end
end
HEMJ(147,16)=99000;
HEMJ(147,17)=0;
save B120413 B120413
save LoopData HEMJ
end
%% Helium Loop 12_4_2013 12_09_54
% Steady-State Experiment - Inlet T Experiments - Steel/MT185
% Using Tip # 7 / Oxygen/Fuel Pressure - >8 psig 
% One SS Experiments - Heater on, ~6.4 g/s, Ti=300, ~2.2 MW/m^2
% 0.75 scan/second  
for m=1:0
clear
load LoopData
C120413=xlsread('Helium Loop 12_4_2013 12_09_54.csv', 1, 'C30:Y20000');
for i=1:16
    if i<14
        HEMJ(148,i)=mean(C120413(1550:1750,i));
    elseif i>14
        HEMJ(148,i-1)=mean(C120413(1550:1750,i));
    end
end
HEMJ(148,16)=99000;
HEMJ(148,17)=0;
save C120413 C120413
save LoopData HEMJ
end
%% Helium Loop 12_5_2013 10_06_35
% Steady-State Experiment - Inlet T Experiments - Steel/MT185
% Using Tip # 7 / Oxygen/Fuel Pressure - >8 psig 
% One SS Experiments - Heater on, ~4.7 g/s, Ti=25, ~2.5 MW/m^2
% 0.75 scan/second  
for m=1:0
clear
load LoopData
A120513=xlsread('Helium Loop 12_5_2013 10_06_35.csv', 1, 'C30:Y20000');
for i=1:16
    if i<14
        HEMJ(149,i)=mean(A120513(2500:2700,i));
    elseif i>14
        HEMJ(149,i-1)=mean(A120513(2500:2700,i));
    end
end
HEMJ(149,16)=99000;
HEMJ(149,17)=0;
save A120513 A120513
save LoopData HEMJ
end
%% Helium Loop 12_6_2013 11_00_08                                           Case 150
% Steady-State Experiment - Inlet T Experiments - Steel/MT185
% Using Tip # 7 / Oxygen/Fuel Pressure - >8 psig 
% One SS Experiments - Heater on, ~5.5 g/s, Ti=100, ~2.6 MW/m^2
% 0.75 scan/second  
for m=1:0
clear
load LoopData
A120613=xlsread('Helium Loop 12_6_2013 11_00_08.csv', 1, 'C30:Y20000');
for i=1:16
    if i<14
        HEMJ(150,i)=mean(A120613(3300:3600,i));
    elseif i>14
        HEMJ(150,i-1)=mean(A120613(3300:3600,i));
    end
end
HEMJ(150,16)=99000;
HEMJ(150,17)=0;
save A120613 A120613
save LoopData HEMJ
end
%% Helium Loop 12_6_2013 11_49_40
% Steady-State Experiment - Inlet T Experiments - Steel/MT185
% Using Tip # 7 / Oxygen/Fuel Pressure - >8 psig 
% One SS Experiments - Heater on, ~6.45 g/s, Ti=200, ~2.6 MW/m^2
% 0.75 scan/second  
for m=1:0
clear
load LoopData
B120613=xlsread('Helium Loop 12_6_2013 11_49_40.csv', 1, 'C30:Y20000');
for i=1:16
    if i<14
        HEMJ(151,i)=mean(B120613(2300:2600,i));
    elseif i>14
        HEMJ(151,i-1)=mean(B120613(2300:2600,i));
    end
end
HEMJ(151,16)=99000;
HEMJ(151,17)=0;
save B120613 B120613
save LoopData HEMJ
end
%% Helium Loop 12_10_2013 10_56_25
% Steady-State Experiment - Inlet T Experiments - Steel/MT185
% Using Tip # 7 / Oxygen/Fuel Pressure - >8 psig 
% One SS Experiments - Heater on, ~6.05 g/s, Ti=250, ~2.5 MW/m^2
% 0.75 scan/second  
for m=1:0
clear
load LoopData
A121013=xlsread('Helium Loop 12_10_2013 10_56_25.csv', 1, 'C30:Y20000');
for i=1:16
    if i<14
        HEMJ(152,i)=mean(A121013(4350:4650,i));
    elseif i>14
        HEMJ(152,i-1)=mean(A121013(4350:4650,i));
    end
end
HEMJ(152,16)=99000;
HEMJ(152,17)=0;
save A121013 A121013
save LoopData HEMJ
end
%% Helium Loop 12_10_2013 12_00_29
% Steady-State Experiment - Inlet T Experiments - Steel/MT185
% Using Tip # 7 / Oxygen/Fuel Pressure - >8 psig 
% One SS Experiments - Heater on, ~6.95 g/s, Ti=250, ~2.5 MW/m^2
% 0.75 scan/second  
for m=1:0
clear
load LoopData
B121013=xlsread('Helium Loop 12_10_2013 12_00_29.csv', 1, 'C30:Y20000');
for i=1:16
    if i<14
        HEMJ(153,i)=mean(B121013(1350:1650,i));
    elseif i>14
        HEMJ(153,i-1)=mean(B121013(1350:1650,i));
    end
end
HEMJ(153,16)=99000;
HEMJ(153,17)=0;
save B121013 B121013
save LoopData HEMJ
end
%% Helium Loop 12_10_2013 12_23_24
% Steady-State Experiment - Inlet T Experiments - Steel/MT185
% Using Tip # 7 / Oxygen/Fuel Pressure - >8 psig 
% One SS Experiments - Heater on, ~7.9 g/s, Ti=250, ~2.5 MW/m^2
% 0.75 scan/second  
for m=1:0
clear
load LoopData
C121013=xlsread('Helium Loop 12_10_2013 12_23_24.csv', 1, 'C30:Y20000');
for i=1:16
    if i<14
        HEMJ(154,i)=mean(C121013(1300:1600,i));
    elseif i>14
        HEMJ(154,i-1)=mean(C121013(1300:1600,i));
    end
end
HEMJ(154,16)=99000;
HEMJ(154,17)=0;
save C121013 C121013
save LoopData HEMJ
end
%% Helium Loop 12_12_2013 10_43_48
% Steady-State Experiment - Inlet T Experiments - Steel/MT185
% Using Tip # 7 / Oxygen/Fuel Pressure - >8 psig 
% One SS Experiments - Heater on, ~5.65 g/s, Ti=300, ~2.2 MW/m^2
% 0.75 scan/second  
for m=1:0
clear
load LoopData
A121213=xlsread('Helium Loop 12_12_2013 10_43_48.csv', 1, 'C30:Y20000');
for i=1:16
    if i<14
        HEMJ(155,i)=mean(A121213(3300:3600,i));
    elseif i>14
        HEMJ(155,i-1)=mean(A121213(3300:3600,i));
    end
end
HEMJ(155,16)=99000;
HEMJ(155,17)=0;
save A121213 A121213
save LoopData HEMJ
end
%% Helium Loop 12_12_2013 11_42_04
% Steady-State Experiment - Inlet T Experiments - Steel/MT185
% Using Tip # 7 / Oxygen/Fuel Pressure - >8 psig 
% One SS Experiments - Heater on, ~5.0 g/s, Ti=200, ~2.4 MW/m^2
% 0.75 scan/second  
for m=1:0
clear
load LoopData
B121213=xlsread('Helium Loop 12_12_2013 11_42_04.csv', 1, 'C30:Y20000');
for i=1:16
    if i<14
        HEMJ(156,i)=mean(B121213(1850:2050,i));
    elseif i>14
        HEMJ(156,i-1)=mean(B121213(1850:2050,i));
    end
end
HEMJ(156,16)=99000;
HEMJ(156,17)=0;
save B121213 B121213
save LoopData HEMJ
end
%% Helium Loop 12_12_2013 12_11_55
% Steady-State Experiment - Inlet T Experiments - Steel/MT185
% Using Tip # 7 / Oxygen/Fuel Pressure - >8 psig 
% One SS Experiments - Heater on, ~5.55 g/s, Ti=200, ~2.4 MW/m^2
% 0.75 scan/second  
for m=1:0
clear
load LoopData
C121213=xlsread('Helium Loop 12_12_2013 12_11_55.csv', 1, 'C30:Y20000');
for i=1:16
    if i<14
        HEMJ(157,i)=mean(C121213(1600:1900,i));
    elseif i>14
        HEMJ(157,i-1)=mean(C121213(1600:1900,i));
    end
end
HEMJ(157,16)=99000;
HEMJ(157,17)=0;
save C121213 C121213
save LoopData HEMJ
end
%% Helium Loop 1_28_2014 11_11_59
% Steady-State Experiment - Induction Heat Experiments - Steel/MT185
% Induction Heater 
% One SS Experiments - Heater off, ~7 g/s, Ti=27, ~3.5 MW/m^2
% 0.75 scan/second  
for m=1:0
clear
load LoopData
A012814=xlsread('Helium Loop 1_28_2014 11_11_59.csv', 1, 'C31:Y20000');
for i=1:16
    if i<14
        HEMJ(158,i)=mean(A012814(2750:2950,i));
    elseif i>14
        HEMJ(158,i-1)=mean(A012814(2750:2950,i));
    end
end
HEMJ(158,16)=99000;
HEMJ(158,17)=0;
save A012814 A012814
save LoopData HEMJ
end
%% Helium Loop 1_30_2014 11_40_39
% Steady-State Experiment - Induction Heat Experiments - Steel/MT185
% Induction Heater 
% One SS Experiments - Heater off, ~8 g/s, Ti=27, ~4 MW/m^2
% 0.75 scan/second  
for m=1:0
clear
load LoopData
A013014=xlsread('Helium Loop 1_30_2014 11_40_39.csv', 1, 'C31:Y20000');
for i=1:16
    if i<14
        HEMJ(159,i)=mean(A013014(1980:2140,i));
    elseif i>14
        HEMJ(159,i-1)=mean(A013014(1980:2140,i));
    end
end
HEMJ(159,16)=99000;
HEMJ(159,17)=0;
save A013014 A013014
save LoopData HEMJ
end
%% Helium Loop 2_4_2014 11_41_02                                            Case 160
% Steady-State Experiment - Induction Heat Experiments - Steel/MT185
% Induction Heater 
% One SS Experiments - Heater off, ~4 g/s, Ti=27, ~3.2 MW/m^2
% 0.75 scan/second  
for m=1:0
clear
load LoopData
A020414=xlsread('Helium Loop 2_4_2014 11_41_02.csv', 1, 'C31:Y20000');
for i=1:16
    if i<14
        HEMJ(160,i)=mean(A020414(1200:1320,i));
    elseif i>14
        HEMJ(160,i-1)=mean(A020414(1200:1320,i));
    end
end
HEMJ(160,16)=99000;
HEMJ(160,17)=0;
save A020414 A020414
save LoopData HEMJ
end
%% Helium Loop 2_5_2014 15_41_41
% Steady-State Experiment - Induction Heat Experiments - Steel/MT185
% Induction Heater 
% One SS Experiments - Heater off, ~5.6 g/s, Ti=27, ~3.2 MW/m^2
% 0.75 scan/second  
for m=1:0
clear
load LoopData
A020514=xlsread('Helium Loop 2_5_2014 15_41_41.csv', 1, 'C31:Y20000');
for i=1:16
    if i<14
        HEMJ(161,i)=mean(A020514(5650:5850,i));
    elseif i>14
        HEMJ(161,i-1)=mean(A020514(5650:5850,i));
    end
end
HEMJ(161,16)=99000;
HEMJ(161,17)=0;
save A020514 A020514
save LoopData HEMJ
end
%% Helium Loop 2_6_2014 14_28_15
% Steady-State Experiment - Induction Heat Experiments - Steel/MT185
% Induction Heater 
% One SS Experiments - Heater off, ~5.6 g/s, Ti=27, ~2.8 MW/m^2
% 0.75 scan/second  
for m=1:0
clear
load LoopData
A020614=xlsread('Helium Loop 2_6_2014 14_28_15.csv', 1, 'C31:Y20000');
for i=1:16
    if i<14
        HEMJ(162,i)=mean(A020614(1600:1800,i));
    elseif i>14
        HEMJ(162,i-1)=mean(A020614(1600:1800,i));
    end
end
HEMJ(162,16)=99000;
HEMJ(162,17)=0;
save A020614 A020614
save LoopData HEMJ
end
%% Helium Loop 2_6_2014 16_54_35
% Steady-State Experiment - Induction Heat Experiments - Steel/MT185
% Induction Heater 
% One SS Experiments - Heater off, ~5.6 g/s, Ti=27, ~2.9 MW/m^2
% 0.75 scan/second  
for m=1:0
clear
load LoopData
B020614=xlsread('Helium Loop 2_6_2014 16_54_35.csv', 1, 'C31:Y20000');
for i=1:16
    if i<14
        HEMJ(163,i)=mean(B020614(1350:1550,i));
    elseif i>14
        HEMJ(163,i-1)=mean(B020614(1350:1550,i));
    end
end
HEMJ(163,16)=99000;
HEMJ(163,17)=0;
save B020614 B020614
save LoopData HEMJ
end
%% Helium Loop 2_6_2014 17_17_15
% Steady-State Experiment - Induction Heat Experiments - Steel/MT185
% Induction Heater 
% One SS Experiments - Heater off, ~3 g/s, Ti=27, ~2.8 MW/m^2
% 0.75 scan/second  
for m=1:0
clear
load LoopData
C020614=xlsread('Helium Loop 2_6_2014 17_17_15.csv', 1, 'C31:Y20000');
for i=1:16
    if i<14
        HEMJ(164,i)=mean(C020614(250:450,i));
    elseif i>14
        HEMJ(164,i-1)=mean(C020614(250:450,i));
    end
end
HEMJ(164,16)=99000;
HEMJ(164,17)=0;
save C020614 C020614
save LoopData HEMJ
end
%% Helium Loop 2_18_2014 10_39_15
% Steady-State Experiment - Induction Heat Experiments - Steel/MT185
% Induction Heater 
% One SS Experiments - Heater off, ~4.5 g/s, Ti=27, ~3.8 MW/m^2
% 0.75 scan/second  
for m=1:0
clear
load LoopData
A021814=xlsread('Helium Loop 2_18_2014 10_39_15.csv', 1, 'C31:Y20000');
for i=1:16
    if i<14
        HEMJ(165,i)=mean(A021814(3500:3700,i));
    elseif i>14
        HEMJ(165,i-1)=mean(A021814(3500:3700,i));
    end
end
HEMJ(165,16)=99000;
HEMJ(165,17)=0;
save A021814 A021814
save LoopData HEMJ
end
%% Helium Loop 2_18_2014 11_35_30
% Steady-State Experiment - Induction Heat Experiments - Steel/MT185
% Induction Heater 
% One SS Experiments - Heater off, ~3.0 g/s, Ti=27, ~3.5 MW/m^2
% 0.75 scan/second  
for m=1:0
clear
load LoopData
B021814=xlsread('Helium Loop 2_18_2014 11_35_30.csv', 1, 'C31:Y20000'); 
for i=1:16
    if i<14
        HEMJ(166,i)=mean(B021814(325:525,i));
    elseif i>14
        HEMJ(166,i-1)=mean(B021814(325:525,i));
    end
end
HEMJ(166,16)=99000;
HEMJ(166,17)=0;
save B021814 B021814
save LoopData HEMJ
end
%% Helium Loop 2_20_2014 10_51_55
% Steady-State Experiment - Induction Heat Experiments - Steel/MT185
% Induction Heater 
% One SS Experiments - Heater off, ~3.8 g/s, Ti=27, ~4.3 MW/m^2
% 0.75 scan/second  
for m=1:0
clear
load LoopData
A022014=xlsread('Helium Loop 2_20_2014 10_51_55.csv', 1, 'C31:Y20000');
for i=1:16
    if i<14
        HEMJ(167,i)=mean(A022014(2050:2250,i));
    elseif i>14
        HEMJ(167,i-1)=mean(A022014(2050:2250,i));
    end
end
HEMJ(167,16)=99000;
HEMJ(167,17)=0;
save A022014 A022014
save LoopData HEMJ
end
%% Helium Loop 2_20_2014 11_23_23
% Steady-State Experiment - Induction Heat Experiments - Steel/MT185
% Induction Heater 
% One SS Experiments - Heater off, ~3 g/s, Ti=27, ~4.2 MW/m^2
% 0.75 scan/second  
for m=1:0
clear
load LoopData
B022014=xlsread('Helium Loop 2_20_2014 11_23_23.csv', 1, 'C31:Y20000');
for i=1:16
    if i<14
        HEMJ(168,i)=mean(B022014(400:700,i));
    elseif i>14
        HEMJ(168,i-1)=mean(B022014(400:700,i));
    end
end
HEMJ(168,16)=99000;
HEMJ(168,17)=0;
save B022014 B022014
save LoopData HEMJ
end
%% Helium Loop 2_21_2014 14_06_29                                           Case 170
% Steady-State Experiment - Induction Heat Experiments - Steel/MT185
% Induction Heater 
% One SS Experiments - Heater off, ~3.8 g/s, Ti=27, ~4.5 & 5.0 MW/m^2
% 0.75 scan/second  
for m=1:0
clear
load LoopData
A022114=xlsread('Helium Loop 2_21_2014 14_06_29.csv', 1, 'C31:Y20000');
for i=1:16
    if i<14
        HEMJ(169,i)=mean(A022114(4100:4200,i));
    elseif i>14
        HEMJ(169,i-1)=mean(A022114(4100:4200,i));
    end
end
HEMJ(169,16)=99000;
HEMJ(169,17)=0;
for i=1:16
    if i<14
        HEMJ(170,i)=mean(A022114(4520:4650,i));
    elseif i>14
        HEMJ(170,i-1)=mean(A022114(4520:4650,i));
    end
end
HEMJ(170,16)=99000;
HEMJ(170,17)=0;
save A022114 A022114
save LoopData HEMJ
end
%% Helium Loop 2_28_2014 11_33_30                                           
% Steady-State Experiment - Induction Heat Experiments - Steel/MT185
% Induction Heater 
% One SS Experiments - Heater on, ~6 g/s, Ti=100, ~4.5 & 5.0 MW/m^2
% 0.75 scan/second  
for m=1:0
clear
load LoopData
A022814=xlsread('Helium Loop 2_28_2014 11_33_30.csv', 1, 'C31:Y20000');
for i=1:16
    if i<14
        HEMJ(171,i)=mean(A022814(2500:2700,i));
    elseif i>14
        HEMJ(171,i-1)=mean(A022814(2500:2700,i));
    end
end
HEMJ(171,16)=99000;
HEMJ(171,17)=0;
save A022814 A022814
save LoopData HEMJ
end
%% Helium Loop 2_28_2014 12_22_06
% Steady-State Experiment - Induction Heat Experiments - Steel/MT185
% Induction Heater 
% One SS Experiments - Heater on, ~3 g/s, Ti=100, ~3.8 MW/m^2
% 0.75 scan/second  
for m=1:0
clear
load LoopData
B022814=xlsread('Helium Loop 2_28_2014 12_22_06.csv', 1, 'C31:Y20000');
for i=1:16
    if i<14
        HEMJ(172,i)=mean(B022814(1200:1400,i));
    elseif i>14
        HEMJ(172,i-1)=mean(B022814(1200:1400,i));
    end
end
HEMJ(172,16)=99000;
HEMJ(172,17)=0;
save B022814 B022814
save LoopData HEMJ
end
%% Helium Loop 3_7_2014 14_14_50
% Steady-State Experiment - Induction Heat Experiments - Steel/MT185
% Induction Heater 
% One SS Experiments - Heater on, ~4.6 & 6.7 g/s, Ti=100, ~3.9 MW/m^2
% 0.75 scan/second  
for m=1:0
clear
load LoopData
A030714=xlsread('Helium Loop 3_7_2014 14_14_50.csv', 1, 'C31:Y20000');
for i=1:16
    if i<14
        HEMJ(173,i)=mean(A030714(4250:4450,i));
    elseif i>14
        HEMJ(173,i-1)=mean(A030714(4250:4450,i));
    end
end
HEMJ(173,16)=99000;
HEMJ(173,17)=0;
for i=1:16
    if i<14
        HEMJ(174,i)=mean(A030714(5550:5750,i));
    elseif i>14
        HEMJ(174,i-1)=mean(A030714(5550:5750,i));
    end
end
HEMJ(174,16)=99000;
HEMJ(174,17)=0;
save A030714 A030714
save LoopData HEMJ
end
%% Helium Loop 3_12_2014 12_21_52
% Steady-State Experiment - Induction Heat Experiments - Steel/MT185
% Induction Heater 
% One SS Experiments - Heater on, ~7.9 g/s, Ti=200, ~3.4 MW/m^2
% 0.75 scan/second  
for m=1:0
clear
load LoopData
A031214=xlsread('Helium Loop 3_12_2014 12_21_52.csv', 1, 'C31:Y20000');
for i=1:16
    if i<14
        HEMJ(175,i)=mean(A031214(5950:6150,i));
    elseif i>14
        HEMJ(175,i-1)=mean(A031214(5950:6150,i));
    end
end
HEMJ(175,16)=99000;
HEMJ(175,17)=0;
save A031214 A031214
save LoopData HEMJ
end
%% Helium Loop 3_12_2014 13_49_21
% Steady-State Experiment - Induction Heat Experiments - Steel/MT185
% Induction Heater 
% One SS Experiments - Heater on, ~6.3 g/s, Ti=200, ~3.7 MW/m^2
% 0.75 scan/second 
for m=1:0
clear
load LoopData
B031214=xlsread('Helium Loop 3_12_2014 13_49_21.csv', 1, 'C31:Y20000');
for i=1:16
    if i<14
        HEMJ(176,i)=mean(B031214(1000:1200,i));
    elseif i>14
        HEMJ(176,i-1)=mean(B031214(1000:1200,i));
    end
end
HEMJ(176,16)=99000;
HEMJ(176,17)=0;
save B031214 B031214
save LoopData HEMJ
end
%% Helium Loop 3_13_2014 10_40_28
% Steady-State Experiment - Induction Heat Experiments - Steel/MT185
% Induction Heater 
% One SS Experiments - Heater on, ~4 g/s, Ti=200, ~4.3 MW/m^2
% 0.75 scan/second 
for m=1:0
clear
load LoopData
A031314=xlsread('Helium Loop 3_13_2014 10_40_28.csv', 1, 'C31:Y20000');
for i=1:16
    if i<14
        HEMJ(177,i)=mean(A031314(3040:3240,i));
    elseif i>14
        HEMJ(177,i-1)=mean(A031314(3040:3240,i));
    end
end
HEMJ(177,16)=99000;
HEMJ(177,17)=0;
save A031314 A031314
save LoopData HEMJ
end
%% Helium Loop 3_13_2014 11_26_56
% Steady-State Experiment - Induction Heat Experiments - Steel/MT185
% Induction Heater 
% One SS Experiments - Heater on, ~5 g/s, Ti=200, ~4.9 MW/m^2
% 0.75 scan/second 
for m=1:0
clear
load LoopData
B031314=xlsread('Helium Loop 3_13_2014 11_26_56.csv', 1, 'C31:Y20000');
for i=1:16
    if i<14
        HEMJ(178,i)=mean(B031314(1100:1300,i));
    elseif i>14
        HEMJ(178,i-1)=mean(B031314(1100:1300,i));
    end
end
HEMJ(178,16)=99000;
HEMJ(178,17)=0;
save B031314 B031314
save LoopData HEMJ
end
%% Helium Loop 3_14_2014 12_14_02
% Steady-State Experiment - Induction Heat Experiments - Steel/MT185
% Induction Heater 
% One SS Experiments - Heater on, ~8.3 g/s, Ti=250, ~3.4 MW/m^2
% 0.75 scan/second 
for m=1:0
clear
load LoopData
A031414=xlsread('Helium Loop 3_14_2014 12_14_02.csv', 1, 'C31:Y20000');
for i=1:16
    if i<14
        HEMJ(179,i)=mean(A031414(1800:1950,i));
    elseif i>14
        HEMJ(179,i-1)=mean(A031414(1800:1950,i));
    end
end
HEMJ(179,16)=99000;
HEMJ(179,17)=0;
save A031414 A031414
save LoopData HEMJ
end
%% Helium Loop 3_14_2014 12_42_15                                           Case 180
% Steady-State Experiment - Induction Heat Experiments - Steel/MT185
% Induction Heater 
% One SS Experiments - Heater on, ~6.8 g/s, Ti=250, ~4.5 MW/m^2
% 0.75 scan/second 
for m=1:0
clear
load LoopData
B031414=xlsread('Helium Loop 3_14_2014 12_42_15.csv', 1, 'C31:Y20000');
for i=1:16
    if i<14
        HEMJ(180,i)=mean(B031414(2040:2240,i));
    elseif i>14
        HEMJ(180,i-1)=mean(B031414(2040:2240,i));
    end
end
HEMJ(180,16)=99000;
HEMJ(180,17)=0;
save B031414 B031414
save LoopData HEMJ
end
%% Helium Loop 3_18_2014 11_32_57
% Steady-State Experiment - Induction Heat Experiments - Steel/MT185
% Induction Heater 
% One SS Experiments - Heater on, ~5.25 g/s, Ti=250, ~4.0 MW/m^2
% 0.75 scan/second 
for m=1:0
clear
load LoopData
A031814=xlsread('Helium Loop 3_18_2014 11_32_57.csv', 1, 'C31:Y20000');
for i=1:16
    if i<14
        HEMJ(181,i)=mean(A031814(3950:4050,i));
    elseif i>14
        HEMJ(181,i-1)=mean(A031814(3950:4050,i));
    end
end
HEMJ(181,16)=99000;
HEMJ(181,17)=0;
save A031814 A031814
save LoopData HEMJ
end
%% Helium Loop 3_28_2014 11_43_28
% Steady-State Experiment - Induction Heat Experiments - Steel/WL10
% Induction Heater 
% One SS Experiments - Heater off, ~6.7 g/s, Ti=27, ~5.3 MW/m^2
% 0.75 scan/second 
for m=1:0
clear
load LoopData
A032814=xlsread('Helium Loop 3_28_2014 11_43_28.csv', 1, 'C33:Y20000');
for i=1:18
    HEMJ(182,i)=mean(A032814(2000:2200,i));
end
HEMJ(182,19)=99000;
HEMJ(182,20)=0;
save A032814 A032814
save LoopData HEMJ
end
%% Helium Loop 3_28_2014 12_16_48
% Steady-State Experiment - Induction Heat Experiments - Steel/WL10
% Induction Heater 
% One SS Experiments - Heater off, ~5 g/s, Ti=27, ~5.4 MW/m^2
% 0.75 scan/second 
for m=1:0
clear
load LoopData
B032814=xlsread('Helium Loop 3_28_2014 12_16_48.csv', 1, 'C33:Y20000');
for i=1:18
    HEMJ(183,i)=mean(B032814(250:450,i));
end
HEMJ(183,19)=99000;
HEMJ(183,20)=0;
save B032814 B032814
save LoopData HEMJ
end
%% Helium Loop 3_28_2014 12_24_42
% Steady-State Experiment - Induction Heat Experiments - Steel/WL10
% Induction Heater 
% One SS Experiments - Heater off, ~4 g/s, Ti=27, ~5.4 MW/m^2
% 0.75 scan/second 
for m=1:0
clear
load LoopData
C032814=xlsread('Helium Loop 3_28_2014 12_24_42.csv', 1, 'C33:Y20000');
for i=1:18
    HEMJ(184,i)=mean(C032814(500:650,i));
end
HEMJ(184,19)=99000;
HEMJ(184,20)=0;
save C032814 C032814
save LoopData HEMJ
end
%% Helium Loop 4_3_2014 10_50_03
% Steady-State Experiment - Induction Heat Experiments - Steel/WL10
% Induction Heater 
% One SS Experiments - Heater on, ~4.5 g/s, Ti=100, ~5 MW/m^2
% 0.75 scan/second 
for m=1:0
clear
load LoopData
A040314=xlsread('Helium Loop 4_3_2014 10_50_03.csv', 1, 'C33:Y20000');
for i=1:18
    HEMJ(185,i)=mean(A040314(2600:2800,i));
end
HEMJ(185,19)=99000;
HEMJ(185,20)=0;
save A040314 A040314
save LoopData HEMJ
end
%% Helium Loop 4_3_2014 11_31_38
% Steady-State Experiment - Induction Heat Experiments - Steel/WL10
% Induction Heater 
% One SS Experiments - Heater on, ~5.5 g/s, Ti=100, ~5 MW/m^2
% 0.75 scan/second 
for m=1:0
clear
load LoopData
B040314=xlsread('Helium Loop 4_3_2014 11_31_38.csv', 1, 'C33:Y20000');
for i=1:18
    HEMJ(186,i)=mean(B040314(820:1020,i));
end
HEMJ(186,19)=99000;
HEMJ(186,20)=0;
save B040314 B040314
save LoopData HEMJ
end
%% Helium Loop 3_28_2014 12_24_42
% Steady-State Experiment - Induction Heat Experiments - Steel/WL10
% Induction Heater 
% One SS Experiments - Heater on, ~6.5 g/s, Ti=100, ~4.9 MW/m^2
% 0.75 scan/second 
for m=1:0
clear
load LoopData
C040314=xlsread('Helium Loop 4_3_2014 11_47_07.csv', 1, 'C33:Y20000');
for i=1:18
    HEMJ(187,i)=mean(C040314(550:750,i));
end
HEMJ(187,19)=99000;
HEMJ(187,20)=0;
save C040314 C040314
save LoopData HEMJ
end
%% Helium Loop 4_4_2014 11_00_04
% Steady-State Experiment - Induction Heat Experiments - Steel/WL10
% Induction Heater 
% One SS Experiments - Heater on, ~4.85 g/s, Ti=200, ~4.9 MW/m^2
% 0.75 scan/second 
for m=1:0
clear
load LoopData
A040414=xlsread('Helium Loop 4_4_2014 11_00_04.csv', 1, 'C33:Y20000');
for i=1:18
    HEMJ(188,i)=mean(A040414(3000:3200,i));
end
HEMJ(188,19)=99000;
HEMJ(188,20)=0;
save A040414 A040414
save LoopData HEMJ
end
%% Helium Loop 4_4_2014 11_47_22
% Steady-State Experiment - Induction Heat Experiments - Steel/WL10
% Induction Heater 
% One SS Experiments - Heater on, ~5.9 g/s, Ti=200, ~4.8 MW/m^2
% 0.75 scan/second 
for m=1:0
clear
load LoopData
B040414=xlsread('Helium Loop 4_4_2014 11_47_22.csv', 1, 'C33:Y20000');
for i=1:18
    HEMJ(189,i)=mean(B040414(1050:1150,i));
end
HEMJ(189,19)=99000;
HEMJ(189,20)=0;
save B040414 B040414
save LoopData HEMJ
end
%% Helium Loop 4_4_2014 12_05_27                                            Case 190
% Steady-State Experiment - Induction Heat Experiments - Steel/WL10
% Induction Heater 
% One SS Experiments - Heater on, ~6.9 g/s, Ti=200, ~4.7 MW/m^2
% 0.75 scan/second 
for m=1:0
clear
load LoopData
C040414=xlsread('Helium Loop 4_4_2014 12_05_27.csv', 1, 'C33:Y20000');
for i=1:18
    HEMJ(190,i)=mean(C040414(400:600,i));
end
HEMJ(190,19)=99000;
HEMJ(190,20)=0;
save C040414 C040414
save LoopData HEMJ
end
%% Helium Loop 4_7_2014 15_48_18
% Steady-State Experiment - Induction Heat Experiments - Steel/WL10
% Induction Heater 
% One SS Experiments - Heater off, ~? g/s, Ti=27, ~? MW/m^2
% 0.75 scan/second
for m=1:0
clear
load LoopData
A040714=xlsread('Helium Loop 4_7_2014 15_48_18.csv', 1, 'C33:Y20000');
for i=1:18
    HEMJ(191,i)=mean(A040714(2250:2450,i));
end
HEMJ(191,19)=99000;
HEMJ(191,20)=0;
save A040714 A040714
save LoopData HEMJ
end
%% Helium Loop 4_7_2014 16_25_24
% Steady-State Experiment - Induction Heat Experiments - Steel/WL10
% Induction Heater 
% One SS Experiments - Heater off, ~? g/s, Ti=27, ~? MW/m^2
% 0.75 scan/second 
for m=1:0
clear
load LoopData
B040714=xlsread('Helium Loop 4_7_2014 16_25_24.csv', 1, 'C33:Y20000');
for i=1:18
    HEMJ(192,i)=mean(B040714(160:360,i));
end
HEMJ(192,19)=99000;
HEMJ(192,20)=0;
save B040714 B040714
save LoopData HEMJ
end
%% Helium Loop 4_7_2014 16_31_56
% Steady-State Experiment - Induction Heat Experiments - Steel/WL10
% Induction Heater 
% One SS Experiments - Heater off, ~? g/s, Ti=27, ~? MW/m^2
% 0.75 scan/second 
for m=1:0
clear
load LoopData
C040714=xlsread('Helium Loop 4_7_2014 16_31_56.csv', 1, 'C33:Y20000');
for i=1:18
    HEMJ(193,i)=mean(C040714(350:550,i));
end
HEMJ(193,19)=99000;
HEMJ(193,20)=0;
save C040714 C040714
save LoopData HEMJ
end
%% Helium Loop 4_11_2014 15_46_22
% Steady-State Experiment - Induction Heat Experiments - Steel/WL10
% Induction Heater 
% One SS Experiments - Heater on, ~? g/s, Ti=250, ~? MW/m^2
% 0.75 scan/second 
for m=1:0
clear
load LoopData
A041114=xlsread('Helium Loop 4_11_2014 15_46_22.csv', 1, 'C33:Y20000');
for i=1:18
    HEMJ(194,i)=mean(A041114(4300:4500,i));
end
HEMJ(194,19)=99000;
HEMJ(194,20)=0;
save A041114 A041114
save LoopData HEMJ
end
%% Helium Loop 4_11_2014 16_52_30
% Steady-State Experiment - Induction Heat Experiments - Steel/WL10
% Induction Heater 
% One SS Experiments - Heater on, ~? g/s, Ti=250, ~? MW/m^2
% 0.75 scan/second 
for m=1:0
clear
load LoopData
B041114=xlsread('Helium Loop 4_11_2014 16_52_30.csv', 1, 'C33:Y20000');
for i=1:18
    HEMJ(195,i)=mean(B041114(1900:2000,i));
end
HEMJ(195,19)=99000;
HEMJ(195,20)=0;
save B041114 B041114
save LoopData HEMJ
end
%% Helium Loop 4_25_2014 12_33_24
% Steady-State Experiment - Induction Heat Experiments - Steel/WL10
% Induction Heater w/ Tungsten Workpiece 
% One SS Experiments - Heater off, ~7 g/s, Ti=27, ~6.3 MW/m^2
% 0.75 scan/second 
for m=1:0
clear
load LoopData
A042514=xlsread('Helium Loop 4_25_2014 12_33_24.csv', 1, 'C33:Y20000');
for i=1:18
    HEMJ(196,i)=mean(A042514(3150:3350,i));
end
HEMJ(196,19)=99000;
HEMJ(196,20)=0;
save A042514 A042514
save LoopData HEMJ
end
%% Helium Loop 4_25_2014 13_23_37
% Steady-State Experiment - Induction Heat Experiments - Steel/WL10
% Induction Heater w/ Tungsten Workpiece
% One SS Experiments - Heater off, ~5.5 g/s, Ti=27, ~6.4 MW/m^2
% 0.75 scan/second 
for m=1:0
clear
load LoopData
B042514=xlsread('Helium Loop 4_25_2014 13_23_37.csv', 1, 'C33:Y20000');
for i=1:18
    HEMJ(197,i)=mean(B042514(400:600,i));
end
HEMJ(197,19)=99000;
HEMJ(197,20)=0;
save B042514 B042514
save LoopData HEMJ
end
%% Helium Loop 4_25_2014 13_33_13
% Steady-State Experiment - Induction Heat Experiments - Steel/WL10
% Induction Heater w/ Tungsten Workpiece
% One SS Experiments - Heater off, ~4.5 g/s, Ti=27, ~6.3 MW/m^2
% 0.75 scan/second 
for m=1:0
clear
load LoopData
C042514=xlsread('Helium Loop 4_25_2014 13_33_13.csv', 1, 'C33:Y20000');
for i=1:18
    HEMJ(198,i)=mean(C042514(350:550,i));
end
HEMJ(198,19)=99000;
HEMJ(198,20)=0;
save C042514 C042514
save LoopData HEMJ
end
%% Helium Loop 5_2_2014 11_52_47
% Time Constant Experiment - Induction Heat Experiments - Steel/WL10
% Induction Heater w/ Tungsten Workpiece
% One SS Experiments - Heater off, ~4 g/s, Ti=27, ~0.6 MW/m^2
% 0.75 scan/second 
for m=1:0
clear
load LoopData
A050214=xlsread('Helium Loop 5_2_2014 11_52_47.csv', 1, 'C33:Y20000');
for i=1:18
    HEMJ(199,i)=mean(A050214(350:550,i));
end
HEMJ(199,19)=99000;
HEMJ(199,20)=0;
save A050214 A050214
save LoopData HEMJ
end
%% Induction Heater Distribution
% Steady-State Experiment - Induction Heat Experiments - Steel/WL10
% Induction Heater w/ Tungsten Workpiece
% One SS Experiments - Heater off, ~6 g/s, Ti=27,
% 0.75 scan/second 
for m=1:0
clear
load LoopData
A050914=xlsread('Helium Loop 5_9_2014 15_10_17.csv', 1, 'C33:Y20000');
IHD(1,2)=mean(A050914(2080:2180,23));
A051614=xlsread('Helium Loop 5_16_2014 16_02_09.csv', 1, 'C33:Y20000');
IHD(1,3)=mean(A051614(1300:1500,23));
IHD(1,1)=mean(A051614(3100:3200,23));
IHD(1,4)=mean(A051614(4440:4540,23));
save A050914 A050914
save A051614 A051614
end
%% Helium Loop 6_19_2014 16_32_18                                           Case 200
% Steady-State Experiment - Induction Heat Experiments - Steel/WL10
% Induction Heater w/ Tungsten Workpiece - 1.5 in ID Coil/3 turns  - ~10 mm height
% One SS Experiments - Heater off, ~6 g/s, Ti=27, ~6.5 MW/m^2
% 0.75 scan/second 
for m=1:0
clear
load LoopData
A061914=xlsread('Helium Loop 6_19_2014 16_32_18.csv', 1, 'C33:Y20000');
for i=1:18
    HEMJ(200,i)=mean(A061914(3750:3950,i));
end
HEMJ(200,19)=99000;
HEMJ(200,20)=0;
save A061914 A061914
save LoopData HEMJ
end
%% Helium Loop 6_20_2014 14_18_16
% Steady-State Experiment - Induction Heat Experiments - Steel/WL10
% Induction Heater w/ Tungsten Workpiece - 1.5 in ID Coil/3 turns - ~15 mm height
% One SS Experiments - Heater off, ~6 g/s, Ti=27, ~6 MW/m^2
% 0.75 scan/second 
for m=1:0
clear
load LoopData
A062014=xlsread('Helium Loop 6_20_2014 14_18_16.csv', 1, 'C33:Y20000');
for i=1:18
    HEMJ(201,i)=mean(A062014(2400:2600,i));
end
HEMJ(201,19)=99000;
HEMJ(201,20)=0;
save A062014 A062014
save LoopData HEMJ
end
%% Helium Loop 6_24_2014 12_58_00
% Steady-State Experiment - Induction Heat Experiments - Steel/WL10
% Induction Heater w/ Tungsten Workpiece - 1.5 in ID Coil/3 turns - ~15 mm height
% One SS Experiments - Heater off, ~4 g/s, Ti=30, ~6 MW/m^2
% 0.75 scan/second 
for m=1:0
clear
load LoopData
A062414=xlsread('Helium Loop 6_24_2014 12_58_00.csv', 1, 'C33:Y20000');
for i=1:18
    HEMJ(202,i)=mean(A062414(2900:3100,i));
end
HEMJ(202,19)=99000;
HEMJ(202,20)=0;
save A062414 A062414
save LoopData HEMJ
end
%% Helium Loop 6_24_2014 13_43_32
% Steady-State Experiment - Induction Heat Experiments - Steel/WL10
% Induction Heater w/ Tungsten Workpiece - 1.5 in ID Coil/3 turns - ~15 mm height
% One SS Experiments - Heater off, ~5 g/s, Ti=30, ~6 MW/m^2
% 0.75 scan/second 
for m=1:0
clear
load LoopData
B062414=xlsread('Helium Loop 6_24_2014 13_43_32.csv', 1, 'C33:Y20000');
for i=1:18
    HEMJ(203,i)=mean(B062414(350:500,i));
end
HEMJ(203,19)=99000;
HEMJ(203,20)=0;
save B062414 B062414
save LoopData HEMJ
end
%% Helium Loop 6_24_2014 13_51_35
% Steady-State Experiment - Induction Heat Experiments - Steel/WL10
% Induction Heater w/ Tungsten Workpiece - 1.5 in ID Coil/3 turns - ~15 mm height
% One SS Experiments - Heater off, ~7 g/s, Ti=30, ~6 MW/m^2
% 0.75 scan/second 
for m=1:0
clear
load LoopData
C062414=xlsread('Helium Loop 6_24_2014 13_51_35.csv', 1, 'C33:Y20000');
for i=1:18
    HEMJ(204,i)=mean(C062414(100:300,i));
end
HEMJ(204,19)=99000;
HEMJ(204,20)=0;
save C062414 C062414
save LoopData HEMJ
end
%% Helium Loop 6_24_2014 13_57_44
% Steady-State Experiment - Induction Heat Experiments - Steel/WL10
% Induction Heater w/ Tungsten Workpiece - 1.5 in ID Coil/3 turns - ~15 mm height
% One SS Experiments - Heater off, ~8 g/s, Ti=30, ~6 MW/m^2
% 0.75 scan/second 
for m=1:0
clear
load LoopData
D062414=xlsread('Helium Loop 6_24_2014 13_57_44.csv', 1, 'C33:Y20000');
for i=1:18
    HEMJ(205,i)=mean(D062414(200:400,i));
end
HEMJ(205,19)=99000;
HEMJ(205,20)=0;
save D062414 D062414
save LoopData HEMJ
end
%% Helium Loop 6_25_2014 12_15_46
% Steady-State Experiment - Induction Heat Experiments - Steel/WL10
% Induction Heater w/ Tungsten Workpiece - 1.5 in ID Coil/3 turns - ~15 mm height
% One SS Experiments - Heater on, ~6 g/s, Ti=100, ~6 MW/m^2
% 0.75 scan/second 
for m=1:0
clear
load LoopData
A062514=xlsread('Helium Loop 6_25_2014 12_15_46.csv', 1, 'C33:Y20000');
for i=1:18
    HEMJ(206,i)=mean(A062514(2800:3000,i));
end
HEMJ(206,19)=99000;
HEMJ(206,20)=0;
save A062514 A062514
save LoopData HEMJ
end
%% Helium Loop 6_25_2014 13_00_12
% Steady-State Experiment - Induction Heat Experiments - Steel/WL10
% Induction Heater w/ Tungsten Workpiece - 1.5 in ID Coil/3 turns - ~15 mm height
% One SS Experiments - Heater on, ~5 g/s, Ti=100, ~6 MW/m^2
% 0.75 scan/second 
for m=1:0
clear
load LoopData
B062514=xlsread('Helium Loop 6_25_2014 13_00_12.csv', 1, 'C33:Y20000');
for i=1:18
    HEMJ(207,i)=mean(B062514(540:740,i));
end
HEMJ(207,19)=99000;
HEMJ(207,20)=0;
save B062514 B062514
save LoopData HEMJ
end
%% Helium Loop 6_25_2014 13_11_34
% Steady-State Experiment - Induction Heat Experiments - Steel/WL10
% Induction Heater w/ Tungsten Workpiece - 1.5 in ID Coil/3 turns - ~15 mm height
% One SS Experiments - Heater on, ~4 g/s, Ti=100, ~6 MW/m^2
% 0.75 scan/second 
for m=1:0
clear
load LoopData
C062514=xlsread('Helium Loop 6_25_2014 13_11_34.csv', 1, 'C33:Y20000');
for i=1:18
    HEMJ(208,i)=mean(C062514(600:800,i));
end
HEMJ(208,19)=99000;
HEMJ(208,20)=0;
save C062514 C062514
save LoopData HEMJ
end
%% Helium Loop 6_25_2014 13_24_07
% Steady-State Experiment - Induction Heat Experiments - Steel/WL10
% Induction Heater w/ Tungsten Workpiece - 1.5 in ID Coil/3 turns - ~15 mm height
% One SS Experiments - Heater on, ~7 g/s, Ti=100, ~6 MW/m^2
% 0.75 scan/second 
for m=1:0
clear
load LoopData
D062514=xlsread('Helium Loop 6_25_2014 13_24_07.csv', 1, 'C33:Y20000');
for i=1:18
    HEMJ(209,i)=mean(D062514(650:850,i));
end
HEMJ(209,19)=99000;
HEMJ(209,20)=0;
save D062514 D062514
save LoopData HEMJ
end
%% Helium Loop 6_26_2014 12_52_51                                           Case 210
% Steady-State Experiment - Induction Heat Experiments - Steel/WL10
% Induction Heater w/ Tungsten Workpiece - 1.5 in ID Coil/3 turns - ~15 mm height
% One SS Experiments - Heater on, ~6 g/s, Ti=200, ~6 MW/m^2
% 0.75 scan/second 
for m=1:0
clear
load LoopData
A062614=xlsread('Helium Loop 6_26_2014 12_52_51.csv', 1, 'C33:Y20000');
for i=1:18
    HEMJ(210,i)=mean(A062614(2100:2300,i));
end
HEMJ(210,19)=99000;
HEMJ(210,20)=0;
save A062614 A062614
save LoopData HEMJ
end
%% Helium Loop 6_26_2014 13_27_36
% Steady-State Experiment - Induction Heat Experiments - Steel/WL10
% Induction Heater w/ Tungsten Workpiece - 1.5 in ID Coil/3 turns - ~15 mm height
% One SS Experiments - Heater on, ~7 g/s, Ti=200, ~6 MW/m^2
% 0.75 scan/second 
for m=1:0
clear
load LoopData
B062614=xlsread('Helium Loop 6_26_2014 13_27_36.csv', 1, 'C33:Y20000');
for i=1:18
    HEMJ(211,i)=mean(B062614(700:900,i));
end
HEMJ(211,19)=99000;
HEMJ(211,20)=0;
save B062614 B062614
save LoopData HEMJ
end
%% Helium Loop 6_26_2014 13_41_32
% Steady-State Experiment - Induction Heat Experiments - Steel/WL10
% Induction Heater w/ Tungsten Workpiece - 1.5 in ID Coil/3 turns - ~15 mm height
% One SS Experiments - Heater on, ~5 g/s, Ti=200, ~6 MW/m^2
% 0.75 scan/second 
for m=1:0
clear
load LoopData
C062614=xlsread('Helium Loop 6_26_2014 13_41_32.csv', 1, 'C33:Y20000');
for i=1:18
    HEMJ(212,i)=mean(C062614(450:650,i));
end
HEMJ(212,19)=99000;
HEMJ(212,20)=0;
save C062614 C062614
save LoopData HEMJ
end
%% Helium Loop 6_26_2014 13_51_43
% Steady-State Experiment - Induction Heat Experiments - Steel/WL10
% Induction Heater w/ Tungsten Workpiece - 1.5 in ID Coil/3 turns - ~15 mm height
% One SS Experiments - Heater on, ~4 g/s, Ti=200, ~6 MW/m^2
% 0.75 scan/second 
for m=1:0
clear
load LoopData
D062614=xlsread('Helium Loop 6_26_2014 13_51_43.csv', 1, 'C33:Y20000');
for i=1:18
    HEMJ(213,i)=mean(D062614(800:1000,i));
end
HEMJ(213,19)=99000;
HEMJ(213,20)=0;
save D062614 D062614
save LoopData HEMJ
end
%% Helium Loop 6_27_2014 13_54_09
% Steady-State Experiment - Induction Heat Experiments - Steel/WL10
% Induction Heater w/ Tungsten Workpiece - 1.5 in ID Coil/3 turns - ~15 mm height
% One SS Experiments - Heater on, ~6 g/s, Ti=250, ~5 MW/m^2
% 0.75 scan/second 
for m=1:0
clear
load LoopData
A062714=xlsread('Helium Loop 6_27_2014 13_54_09.csv', 1, 'C33:Y20000');
for i=1:18
    HEMJ(214,i)=mean(A062714(2600:2800,i));
end
HEMJ(214,19)=99000;
HEMJ(214,20)=0;
save A062714 A062714
save LoopData HEMJ
end
%% Helium Loop 6_27_2014 14_35_59
% Steady-State Experiment - Induction Heat Experiments - Steel/WL10
% Induction Heater w/ Tungsten Workpiece - 1.5 in ID Coil/3 turns - ~15 mm height
% One SS Experiments - Heater on, ~7 g/s, Ti=250, ~5 MW/m^2
% 0.75 scan/second 
for m=1:0
clear
load LoopData
B062714=xlsread('Helium Loop 6_27_2014 14_35_59.csv', 1, 'C33:Y20000');
for i=1:18
    HEMJ(215,i)=mean(B062714(750:950,i));
end
HEMJ(215,19)=99000;
HEMJ(215,20)=0;
save B062714 B062714
save LoopData HEMJ
end
%% Helium Loop 6_27_2014 14_50_54
% Steady-State Experiment - Induction Heat Experiments - Steel/WL10
% Induction Heater w/ Tungsten Workpiece - 1.5 in ID Coil/3 turns - ~15 mm height
% One SS Experiments - Heater on, ~5 g/s, Ti=250, ~5 MW/m^2
% 0.75 scan/second 
for m=1:0
clear
load LoopData
C062714=xlsread('Helium Loop 6_27_2014 14_50_54.csv', 1, 'C33:Y20000');
for i=1:18
    HEMJ(216,i)=mean(C062714(1100:1300,i));
end
HEMJ(216,19)=99000;
HEMJ(216,20)=0;
save C062714 C062714
save LoopData HEMJ
end
%% Helium Loop 6_27_2014 15_10_39
% Steady-State Experiment - Induction Heat Experiments - Steel/WL10
% Induction Heater w/ Tungsten Workpiece - 1.5 in ID Coil/3 turns - ~15 mm height
% One SS Experiments - Heater on, ~4 g/s, Ti=250, ~5 MW/m^2
% 0.75 scan/second 
for m=1:0
clear
load LoopData
D062714=xlsread('Helium Loop 6_27_2014 15_10_39.csv', 1, 'C33:Y20000');
for i=1:18
    HEMJ(217,i)=mean(D062714(400:600,i));
end
HEMJ(217,19)=99000;
HEMJ(217,20)=0;
save D062714 D062714
save LoopData HEMJ
end
%% Helium Loop 6_30_2014 14_52_17
% Steady-State Experiment - Induction Heat Experiments - Steel/WL10
% Induction Heater w/ Tungsten Workpiece - 1.5 in ID Coil/3 turns - ~15 mm height
% One SS Experiments - Heater off, ~5.5 g/s, Ti=27, ~5.5 MW/m^2
% 0.75 scan/second 
for m=1:0
clear
load LoopData
A063014=xlsread('Helium Loop 6_30_2014 14_52_17.csv', 1, 'C33:Y20000');
for i=1:18
    HEMJ(218,i)=mean(A063014(3450:3650,i));
end
HEMJ(218,19)=99000;
HEMJ(218,20)=0;
save A063014 A063014
save LoopData HEMJ
end
%% Helium Loop 6_30_2014 15_47_09
% Steady-State Experiment - Induction Heat Experiments - Steel/WL10
% Induction Heater w/ Tungsten Workpiece - 1.5 in ID Coil/3 turns - ~15 mm height
% One SS Experiments - Heater off, ~3 g/s, Ti=27, ~5.5 MW/m^2
% 0.75 scan/second 
for m=1:0
clear
load LoopData
B063014=xlsread('Helium Loop 6_30_2014 15_47_09.csv', 1, 'C33:Y20000');
for i=1:18
    HEMJ(219,i)=mean(B063014(750:950,i));
end
HEMJ(219,19)=99000;
HEMJ(219,20)=0;
save B063014 B063014
save LoopData HEMJ
end
%% Helium Loop 6_30_2014 16_01_30                                           Case 220
% Steady-State Experiment - Induction Heat Experiments - Steel/WL10
% Induction Heater w/ Tungsten Workpiece - 1.5 in ID Coil/3 turns - ~15 mm height
% One SS Experiments - Heater on, ~3 g/s, Ti=100, ~5.5 MW/m^2
% 0.75 scan/second 
for m=1:0
clear
load LoopData
C063014=xlsread('Helium Loop 6_30_2014 16_01_30.csv', 1, 'C33:Y20000');
for i=1:18
    HEMJ(220,i)=mean(C063014(1900:2100,i));
end
HEMJ(220,19)=99000;
HEMJ(220,20)=0;
save C063014 C063014
save LoopData HEMJ
end
%% Helium Loop 6_30_2014 16_33_13
% Steady-State Experiment - Induction Heat Experiments - Steel/WL10
% Induction Heater w/ Tungsten Workpiece - 1.5 in ID Coil/3 turns - ~15 mm height
% One SS Experiments - Heater on, ~6.5 g/s, Ti=100, ~5.5 MW/m^2
% 0.75 scan/second 
for m=1:0
clear
load LoopData
D063014=xlsread('Helium Loop 6_30_2014 16_33_13.csv', 1, 'C33:Y20000');
for i=1:18
    HEMJ(221,i)=mean(D063014(1200:1400,i));
end
HEMJ(221,19)=99000;
HEMJ(221,20)=0;
save D063014 D063014
save LoopData HEMJ
end
%% Helium Loop 7_16_2014 14_07_27
% Steady-State Experiment - Induction Heat Experiments - Steel/WL10
% Induction Heater w/ Tungsten Workpiece - 1.5 in ID Coil/3 turns - ~15 mm height
% One SS Experiments - Heater on, ~7 g/s, Ti=300, ~4.5 MW/m^2
% 0.75 scan/second 
for m=1:0
clear
load LoopData
A071614=xlsread('Helium Loop 7_16_2014 14_07_27.csv', 1, 'C33:Y20000');
for i=1:18
    HEMJ(222,i)=mean(A071614(3900:4100,i));
end
HEMJ(222,19)=99000;
HEMJ(222,20)=0;
save A071614 A071614
save LoopData HEMJ
end
%% Helium Loop 7_16_2014 15_07_29
% Steady-State Experiment - Induction Heat Experiments - Steel/WL10
% Induction Heater w/ Tungsten Workpiece - 1.5 in ID Coil/3 turns - ~15 mm height
% One SS Experiments - Heater on, ~6 g/s, Ti=300, ~4.5 MW/m^2
% 0.75 scan/second 
for m=1:0
clear
load LoopData
B071614=xlsread('Helium Loop 7_16_2014 15_07_29.csv', 1, 'C33:Y20000');
for i=1:18
    HEMJ(223,i)=mean(B071614(1050:1200,i));
end
HEMJ(223,19)=99000;
HEMJ(223,20)=0;
save B071614 B071614
save LoopData HEMJ
end
%% Helium Loop 7_16_2014 15_33_05
% Steady-State Experiment - Induction Heat Experiments - Steel/WL10
% Induction Heater w/ Tungsten Workpiece - 1.5 in ID Coil/3 turns - ~15 mm height
% One SS Experiments - Heater on, ~5 g/s, Ti=300, ~4.5 MW/m^2
% 0.75 scan/second 
for m=1:0
clear
load LoopData
C071614=xlsread('Helium Loop 7_16_2014 15_33_05.csv', 1, 'C33:Y20000');
for i=1:18
    HEMJ(224,i)=mean(C071614(200:350,i));
end
HEMJ(224,19)=99000;
HEMJ(224,20)=0;
save C071614 C071614
save LoopData HEMJ
end
%% Helium Loop 7_18_2014 13_01_09                                          
% Steady-State Experiment - Induction Heat Experiments - Steel/WL10
% Induction Heater w/ Tungsten Workpiece - 1.5 in ID Coil/3 turns - ~15 mm height
% One SS Experiments - Heater off, ~3.5 g/s, Ti=27, ~5.5 MW/m^2
% 0.75 scan/second 
for m=1:0
clear
load LoopData
A071814=xlsread('Helium Loop 7_18_2014 13_01_09.csv', 1, 'C33:Y20000');
for i=1:18
    HEMJ(225,i)=mean(A071814(3400:3600,i));
end
HEMJ(225,19)=99000;
HEMJ(225,20)=0;
save A071814 A071814
save LoopData HEMJ
end
%% HHelium Loop 7_18_2014 13_54_12
% Steady-State Experiment - Induction Heat Experiments - Steel/WL10
% Induction Heater w/ Tungsten Workpiece - 1.5 in ID Coil/3 turns - ~15 mm height
% One SS Experiments - Heater on, ~8 g/s, Ti=250, ~5.5 MW/m^2
% 0.75 scan/second 
for m=1:0
clear
load LoopData
B071814=xlsread('Helium Loop 7_18_2014 13_54_12.csv', 1, 'C33:Y20000');
for i=1:18
    HEMJ(226,i)=mean(B071814(2000:2200,i));
end
HEMJ(226,19)=99000;
HEMJ(226,20)=0;
save B071814 B071814
save LoopData HEMJ
end
%% Helium Loop 7_18_2014 14_27_24
% Steady-State Experiment - Induction Heat Experiments - Steel/WL10
% Induction Heater w/ Tungsten Workpiece - 1.5 in ID Coil/3 turns - ~15 mm height
% One SS Experiments - Heater on, ~8 g/s, Ti=200, ~5.5 MW/m^2
% 0.75 scan/second 
for m=1:0
clear
load LoopData
C071814=xlsread('Helium Loop 7_18_2014 14_27_24.csv', 1, 'C33:Y20000');
for i=1:18
    HEMJ(227,i)=mean(C071814(1700:1900,i));
end
HEMJ(227,19)=99000;
HEMJ(227,20)=0;
save C071814 C071814
save LoopData HEMJ
end
%% Helium Loop 7_24_2014 14_36_57
% Steady-State Experiment - Induction Heat Experiments - Steel/MT185 Integrated
% Induction Heater w/ Tungsten Workpiece - 1.5 in ID Coil/3 turns - ~15 mm height
% One SS Experiments - Heater off, ~8 g/s, Ti=27, ~5.5 MW/m^2, 0.9mm Gap
% 0.75 scan/second 
for m=1:0
clear
load LoopData
A072414=xlsread('Helium Loop 7_24_2014 14_36_57.csv', 1, 'C33:Y20000');
for i=1:18
    HEMJ(228,i)=mean(A072414(3350:3550,i));
end
HEMJ(228,19)=99000;
HEMJ(228,20)=0;
save A072414 A072414
save LoopData HEMJ
end
%% Helium Loop 7_24_2014 15_28_48
% Steady-State Experiment - Induction Heat Experiments - Steel/MT185 Integrated
% Induction Heater w/ Tungsten Workpiece - 1.5 in ID Coil/3 turns - ~15 mm height
% One SS Experiments - Heater off, ~7 g/s, Ti=27, ~5.5 MW/m^2, 0.9mm Gap
% 0.75 scan/second 
for m=1:0
clear
load LoopData
B072414=xlsread('Helium Loop 7_24_2014 15_28_48.csv', 1, 'C33:Y20000');
for i=1:18
    HEMJ(229,i)=mean(B072414(250:450,i));
end
HEMJ(229,19)=99000;
HEMJ(229,20)=0;
save B072414 B072414
save LoopData HEMJ
end
%% Helium Loop 7_24_2014 15_36_10                                           Case 230
% Steady-State Experiment - Induction Heat Experiments - Steel/MT185 Integrated
% Induction Heater w/ Tungsten Workpiece - 1.5 in ID Coil/3 turns - ~15 mm height
% One SS Experiments - Heater off, ~6 g/s, Ti=27, ~5.5 MW/m^2, 0.9mm Gap
% 0.75 scan/second 
for m=1:0
clear
load LoopData
C072414=xlsread('Helium Loop 7_24_2014 15_36_10.csv', 1, 'C33:Y20000');
for i=1:18
    HEMJ(230,i)=mean(C072414(300:450,i));
end
HEMJ(230,19)=99000;
HEMJ(230,20)=0;
save C072414 C072414
save LoopData HEMJ
end
%% Helium Loop 7_24_2014 15_43_36
% Steady-State Experiment - Induction Heat Experiments - Steel/MT185 Integrated
% Induction Heater w/ Tungsten Workpiece - 1.5 in ID Coil/3 turns - ~15 mm height
% One SS Experiments - Heater off, ~5 g/s, Ti=27, ~5.5 MW/m^2, 0.9mm Gap
% 0.75 scan/second 
for m=1:0
clear
load LoopData
D072414=xlsread('Helium Loop 7_24_2014 15_43_36.csv', 1, 'C33:Y20000');
for i=1:18
    HEMJ(231,i)=mean(D072414(220:420,i));
end
HEMJ(231,19)=99000;
HEMJ(231,20)=0;
save D072414 D072414
save LoopData HEMJ
end
%% Helium Loop 7_24_2014 15_50_40
% Steady-State Experiment - Induction Heat Experiments - Steel/MT185 Integrated
% Induction Heater w/ Tungsten Workpiece - 1.5 in ID Coil/3 turns - ~15 mm height
% One SS Experiments - Heater off, ~4 g/s, Ti=27, ~5 MW/m^2, 0.9mm Gap
% 0.75 scan/second 
for m=1:0
clear
load LoopData
E072414=xlsread('Helium Loop 7_24_2014 15_50_40.csv', 1, 'C33:Y20000');
for i=1:18
    HEMJ(232,i)=mean(E072414(800:1000,i));
end
HEMJ(232,19)=99000;
HEMJ(232,20)=0;
save E072414 E072414
save LoopData HEMJ
end
%% Helium Loop 7_24_2014 16_05_39
% Steady-State Experiment - Induction Heat Experiments - Steel/MT185 Integrated
% Induction Heater - 1.5 in ID Coil/3 turns - ~15 mm height
% One SS Experiments - Heater off, ~3 g/s, Ti=27, ~5 MW/m^2, 0.9mm Gap
% 0.75 scan/second 
for m=1:0
clear
load LoopData
F072414=xlsread('Helium Loop 7_24_2014 16_05_39.csv', 1, 'C33:Y20000');
for i=1:18
    HEMJ(233,i)=mean(F072414(390:590,i));
end
HEMJ(233,19)=99000;
HEMJ(233,20)=0;
save F072414 F072414
save LoopData HEMJ
end
%% Helium Loop 7_31_2014 14_05_48
% Steady-State Experiment - Induction Heat Experiments - Steel/MT185 Integrated
% Induction Heater - 1.5 in ID Coil/3 turns - ~15 mm height
% One SS Experiments - Heater off, ~8 g/s, Ti=27, ~5.4 MW/m^2, 0.5mm Gap
% 0.75 scan/second 
for m=1:0
clear
load LoopData
A073114=xlsread('Helium Loop 7_31_2014 14_05_48.csv', 1, 'C33:Y20000');
for i=1:18
    HEMJ(234,i)=mean(A073114(4093:4293,i));
end
HEMJ(234,19)=99000;
HEMJ(234,20)=0;
save A073114 A073114
save LoopData HEMJ
end
%% Helium Loop 7_31_2014 15_08_24
% Steady-State Experiment - Induction Heat Experiments - Steel/MT185 Integrated
% Induction Heater - 1.5 in ID Coil/3 turns - ~15 mm height
% One SS Experiments - Heater off, ~7 g/s, Ti=27, ~5.4 MW/m^2, 0.5mm Gap
% 0.75 scan/second 
for m=1:0
clear
load LoopData
B073114=xlsread('Helium Loop 7_31_2014 15_08_24.csv', 1, 'C33:Y20000');
for i=1:18
    HEMJ(235,i)=mean(B073114(469:669,i));
end
HEMJ(235,19)=99000;
HEMJ(235,20)=0;
save B073114 B073114
save LoopData HEMJ
end
%% Helium Loop 7_31_2014 15_18_37
% Steady-State Experiment - Induction Heat Experiments - Steel/MT185 Integrated
% Induction Heater - 1.5 in ID Coil/3 turns - ~15 mm height
% One SS Experiments - Heater off, ~5 g/s, Ti=27, ~5.4 MW/m^2, 0.5mm Gap
% 0.75 scan/second 
for m=1:0
clear
load LoopData
C073114=xlsread('Helium Loop 7_31_2014 15_18_37.csv', 1, 'C33:Y20000');
for i=1:18
    HEMJ(236,i)=mean(C073114(811:1011,i));
end
HEMJ(236,19)=99000;
HEMJ(236,20)=0;
save C073114 C073114
save LoopData HEMJ
end
%% Helium Loop 7_31_2014 15_38_34
% Steady-State Experiment - Induction Heat Experiments - Steel/MT185 Integrated
% Induction Heater - 1.5 in ID Coil/3 turns - ~15 mm height
% One SS Experiments - Heater off, ~3 g/s, Ti=27, ~4.9 MW/m^2, 0.5mm Gap
% 0.75 scan/second 
for m=1:0
clear
load LoopData
D073114=xlsread('Helium Loop 7_31_2014 15_38_34.csv', 1, 'C33:Y20000');
for i=1:18
    HEMJ(237,i)=mean(D073114(740:1076,i));
end
HEMJ(237,19)=99000;
HEMJ(237,20)=0;
save D073114 D073114
save LoopData HEMJ
end
%% Helium Loop 8_7_2014 12_25_56
% Steady-State Experiment - Pressure Drop Experiments - Steel/MT185 Integrated
% Cold Experiment (No Heating)
% One SS Experiment - Heater off, ~8 g/s, Ti=27, 0 MW/m^2, 0.5mm Gap 
% 0.75 scan/second 
for m=1:0
clear
load LoopData
A080714=xlsread('Helium Loop 8_7_2014 12_25_56.csv', 1, 'C33:Y20000');
for i=1:18
    HEMJ(238,i)=mean(A080714(1050:3000,i));
end
HEMJ(238,19)=99000;
HEMJ(238,20)=0;
save A080714 A080714
save LoopData HEMJ
end
%% Helium Loop 8_7_2014 12_25_56
% Steady-State Experiment - Pressure Drop Experiments - Steel/MT185 Integrated
% Cold Experiment (No Heating)
% One SS Experiment - Heater off, ~7 g/s, Ti=27, 0 MW/m^2, 0.5mm Gap
% 0.75 scan/second 
for m=1:0
clear
load LoopData
B080714=xlsread('Helium Loop 8_7_2014 12_25_56.csv', 1, 'C33:Y20000');
for i=1:18
    HEMJ(239,i)=mean(B080714(2319:2556,i));
end
HEMJ(239,19)=99000;
HEMJ(239,20)=0;
save B080714 B080714
save LoopData HEMJ
end
%% Helium Loop 8_7_2014 12_25_56                                            Case 240
% Steady-State Experiment - Pressure Drop Experiments - Steel/MT185 Integrated
% Cold Experiment (No Heating)
% One SS Experiment - Heater off, ~6 g/s, Ti=27, 0 MW/m^2, 0.5mm Gap
% 0.75 scan/second 
for m=1:0
clear
load LoopData
C080714=xlsread('Helium Loop 8_7_2014 12_25_56.csv', 1, 'C33:Y20000');
for i=1:18
    HEMJ(240,i)=mean(C080714(2626:2954,i));
end
HEMJ(240,19)=99000;
HEMJ(240,20)=0;
save C080714 C080714
save LoopData HEMJ
end
%% Helium Loop 8_7_2014 12_25_56
% Steady-State Experiment - Pressure Drop Experiments - Steel/MT185 Integrated
% Cold Experiment (No Heating)
% One SS Experiment - Heater off, ~5 g/s, Ti=27, 0 MW/m^2, 0.5mm Gap
% 0.75 scan/second 
for m=1:0
clear
load LoopData
D080714=xlsread('Helium Loop 8_7_2014 12_25_56.csv', 1, 'C33:Y20000');
for i=1:18
    HEMJ(241,i)=mean(D080714(3043:3312,i));
end
HEMJ(241,19)=99000;
HEMJ(241,20)=0;
save D080714 D080714
save LoopData HEMJ
end
%% Helium Loop 8_7_2014 12_25_56
% Steady-State Experiment - Pressure Drop Experiments - Steel/MT185 Integrated
% Cold Experiment (No Heating)
% One SS Experiment - Heater off, ~4 g/s, Ti=27, 0 MW/m^2, 0.5mm Gap
% 0.75 scan/second 
for m=1:0
clear
load LoopData
E080714=xlsread('Helium Loop 8_7_2014 12_25_56.csv', 1, 'C33:Y20000');
for i=1:18
    HEMJ(242,i)=mean(E080714(3406:3897,i));
end
HEMJ(242,19)=99000;
HEMJ(242,20)=0;
save E080714 E080714
save LoopData HEMJ
end
%% Helium Loop 8_7_2014 12_25_56
% Steady-State Experiment - Pressure Drop Experiments - Steel/MT185 Integrated
% Cold Experiment (No Heating)
% One SS Experiment - Heater off, ~3 g/s, Ti=27, 0 MW/m^2, 0.5mm Gap
% 0.75 scan/second 
for m=1:0
clear
load LoopData
F080714=xlsread('Helium Loop 8_7_2014 12_25_56.csv', 1, 'C33:Y20000');
for i=1:18
    HEMJ(243,i)=mean(F080714(3948:4192,i));
end
HEMJ(243,19)=99000;
HEMJ(243,20)=0;
save F080714 F080714
save LoopData HEMJ
end
%% Helium Loop 8_12_2014 16_47_20
% Steady-State Experiment - Pressure Drop Experiments - Steel/MT185 Integrated
% Cold Experiment (No Heating)
% One SS Experiment - Heater off, ~7 g/s, Ti=27, 0.9mm Gap, Debris present
% 0.75 scan/second 
for m=1:0
clear
load LoopData
A081214=xlsread('Helium Loop 8_12_2014 16_47_20.csv', 1, 'C33:Y20000');
for i=1:18
    HEMJ(244,i)=mean(A081214(2518:3089,i));
end
HEMJ(244,19)=99000;
HEMJ(244,20)=0;
save A081214 A081214
save LoopData HEMJ
end
%% Helium Loop 8_12_2014 16_47_20
% Steady-State Experiment - Pressure Drop Experiments - Steel/MT185 Integrated
% Cold Experiment (No Heating)
% One SS Experiment - Heater off, ~6 g/s, Ti=27, 0.9mm Gap, Debris present
% 0.75 scan/second 
for m=1:0
clear
load LoopData
B081214=xlsread('Helium Loop 8_12_2014 16_47_20.csv', 1, 'C33:Y20000');
for i=1:18
    HEMJ(245,i)=mean(B081214(3205:3469,i));
end
HEMJ(245,19)=99000;
HEMJ(245,20)=0;
save B081214 B081214
save LoopData HEMJ
end
%% Helium Loop 8_12_2014 16_47_20
% Steady-State Experiment - Pressure Drop Experiments - Steel/MT185 Integrated
% Cold Experiment (No Heating)
% One SS Experiment - Heater off, ~5 g/s, Ti=27, 0.9mm Gap, Debris present
% 0.75 scan/second 
for m=1:0
clear
load LoopData
C081214=xlsread('Helium Loop 8_12_2014 16_47_20.csv', 1, 'C33:Y20000');
for i=1:18
    HEMJ(246,i)=mean(C081214(3715:3926,i));
end
HEMJ(246,19)=99000;
HEMJ(246,20)=0;
save C081214 C081214
save LoopData HEMJ
end
%% Helium Loop 8_12_2014 16_47_20
% Steady-State Experiment - Pressure Drop Experiments - Steel/MT185 Integrated
% Cold Experiment (No Heating)
% One SS Experiment - Heater off, ~4 g/s, Ti=27, 0.9mm Gap, Debris present
% 0.75 scan/second 
for m=1:0
clear
load LoopData
D081214=xlsread('Helium Loop 8_12_2014 16_47_20.csv', 1, 'C33:Y20000');
for i=1:18
    HEMJ(247,i)=mean(D081214(4121:4351,i));
end
HEMJ(247,19)=99000;
HEMJ(247,20)=0;
save D081214 D081214
save LoopData HEMJ
end
%% Helium Loop 8_12_2014 16_47_20
% Steady-State Experiment - Pressure Drop Experiments - Steel/MT185 Integrated
% Cold Experiment (No Heating)
% One SS Experiment - Heater off, ~3 g/s, Ti=27, 0.9mm Gap, Debris present
% 0.75 scan/second 
for m=1:0
clear
load LoopData
E081214=xlsread('Helium Loop 8_12_2014 16_47_20.csv', 1, 'C33:Y20000');
for i=1:18
    HEMJ(248,i)=mean(E081214(4426:4684,i));
end
HEMJ(248,19)=99000;
HEMJ(248,20)=0;
save E081214 E081214
save LoopData HEMJ
end
%% Helium Loop 8_14_2014 11_15_10
% Steady-State Experiment - Pressure Drop Experiments - Steel/MT185 Integrated
% Cold Experiment (No Heating)
% One SS Experiment - Heater off, ~6.6 g/s, Ti=27, 0.9mm, No debris
% 0.75 scan/second 
for m=1:0
clear
load LoopData
A081414=xlsread('Helium Loop 8_14_2014 11_15_10.csv', 1, 'C33:Y20000');
for i=1:18
    HEMJ(249,i)=mean(A081414(2300:2500,i));
end
HEMJ(249,19)=99000;
HEMJ(249,20)=0;
save A081414 A081414
save LoopData HEMJ
end
%% Helium Loop 8_14_2014 11_15_10                                           Case 250
% Steady-State Experiment - Pressure Drop Experiments - Steel/MT185 Integrated
% Cold Experiment (No Heating)
% One SS Experiment - Heater off, ~6 g/s, Ti=27, 0.9mm, No debris
% 0.75 scan/second 
for m=1:0
clear
load LoopData
B081414=xlsread('Helium Loop 8_14_2014 11_15_10.csv', 1, 'C33:Y20000');
for i=1:18
    HEMJ(250,i)=mean(B081414(2950:3150,i));
end
HEMJ(250,19)=99000;
HEMJ(250,20)=0;
save B081414 B081414
save LoopData HEMJ
end
%% Helium Loop 8_14_2014 11_15_10
% Steady-State Experiment - Pressure Drop Experiments - Steel/MT185 Integrated
% Cold Experiment (No Heating)
% One SS Experiment - Heater off, ~5 g/s, Ti=27, 0.9mm, No debris
% 0.75 scan/second 
for m=1:0
clear
load LoopData
C081414=xlsread('Helium Loop 8_14_2014 11_15_10.csv', 1, 'C33:Y20000');
for i=1:18
    HEMJ(251,i)=mean(C081414(3400:3600,i));
end
HEMJ(251,19)=99000;
HEMJ(251,20)=0;
save C081414 C081414
save LoopData HEMJ
end
%% Helium Loop 8_14_2014 11_15_10
% Steady-State Experiment - Pressure Drop Experiments - Steel/MT185 Integrated
% Cold Experiment (No Heating)
% One SS Experiment - Heater off, ~4 g/s, Ti=27, 0.9mm, No debris
% 0.75 scan/second 
for m=1:0
clear
load LoopData
D081414=xlsread('Helium Loop 8_14_2014 11_15_10.csv', 1, 'C33:Y20000');
for i=1:18
    HEMJ(252,i)=mean(D081414(3750:3950,i));
end
HEMJ(252,19)=99000;
HEMJ(252,20)=0;
save D081414 D081414
save LoopData HEMJ
end
%% Helium Loop 8_14_2014 11_15_10
% Steady-State Experiment - Pressure Drop Experiments - Steel/MT185 Integrated
% Cold Experiment (No Heating)
% One SS Experiment - Heater off, ~3 g/s, Ti=27, 0.9mm, No debris
% 0.75 scan/second 
for m=1:0
clear
load LoopData
E081414=xlsread('Helium Loop 8_14_2014 11_15_10.csv', 1, 'C33:Y20000');
for i=1:18
    HEMJ(253,i)=mean(E081414(4150:4350,i));
end
HEMJ(253,19)=99000;
HEMJ(253,20)=0;
save E081414 E081414
save LoopData HEMJ
end
%% Helium Loop 8_14_2014 11_15_10
% Steady-State Experiment - Pressure Drop Experiments - Steel/MT185 Integrated
% Cold Experiment (No Heating)
% One SS Experiment - Heater off, ~8 g/s, Ti=27, 0.9mm, No debris
% 0.75 scan/second 
for m=1:0
clear
load LoopData
F081414=xlsread('Helium Loop 8_14_2014 11_15_10.csv', 1, 'C33:Y20000');
for i=1:18
    HEMJ(254,i)=mean(F081414(5050:5250,i));
end
HEMJ(254,19)=99000;
HEMJ(254,20)=0;
save F081414 F081414
save LoopData HEMJ
end
%% Helium Loop 8_14_2014 17_14_48
% Steady-State Experiment - Pressure Drop Experiments - Steel/MT185 Integrated
% Cold Experiment (No Heating)
% One SS Experiment - Heater off, ~8 g/s, Ti=27, 0.9mm, Old Jet Cartridge
% 0.75 scan/second 
for m=1:0
clear
load LoopData
G081414=xlsread('Helium Loop 8_14_2014 17_14_48.csv', 1, 'C33:Y20000');
for i=1:18
    HEMJ(255,i)=mean(G081414(1008:1577,i));
end
HEMJ(255,19)=99000;
HEMJ(255,20)=0;
save G081414 G081414
save LoopData HEMJ
end
%% Helium Loop 8_14_2014 17_14_48
% Steady-State Experiment - Pressure Drop Experiments - Steel/MT185 Integrated
% Cold Experiment (No Heating)
% One SS Experiment - Heater off, ~7 g/s, Ti=27, 0.9mm, Old Jet Cartridge
% 0.75 scan/second 
for m=1:0
clear
load LoopData
H081414=xlsread('Helium Loop 8_14_2014 17_14_48.csv', 1, 'C33:Y20000');
for i=1:18
    HEMJ(256,i)=mean(H081414(1644:1992,i));
end
HEMJ(256,19)=99000;
HEMJ(256,20)=0;
save H081414 H081414
save LoopData HEMJ
end
%% Helium Loop 8_14_2014 17_14_48
% Steady-State Experiment - Pressure Drop Experiments - Steel/MT185 Integrated
% Cold Experiment (No Heating)
% One SS Experiment - Heater off, ~6 g/s, Ti=27, 0.9mm, Old Jet Cartridge
% 0.75 scan/second 
for m=1:0
clear
load LoopData
I081414=xlsread('Helium Loop 8_14_2014 17_14_48.csv', 1, 'C33:Y20000');
for i=1:18
    HEMJ(257,i)=mean(I081414(2296:2571,i));
end
HEMJ(257,19)=99000;
HEMJ(257,20)=0;
save I081414 I081414
save LoopData HEMJ
end
%% Helium Loop 8_14_2014 17_14_48
% Steady-State Experiment - Pressure Drop Experiments - Steel/MT185 Integrated
% Cold Experiment (No Heating)
% One SS Experiment - Heater off, ~5 g/s, Ti=27, 0.9mm, Old Jet Cartridge
% 0.75 scan/second 
for m=1:0
clear
load LoopData
J081414=xlsread('Helium Loop 8_14_2014 17_14_48.csv', 1, 'C33:Y20000');
for i=1:18
    HEMJ(258,i)=mean(J081414(2616:2964,i));
end
HEMJ(258,19)=99000;
HEMJ(258,20)=0;
save J081414 J081414
save LoopData HEMJ
end
%% Helium Loop 8_14_2014 17_14_48
% Steady-State Experiment - Pressure Drop Experiments - Steel/MT185 Integrated
% Cold Experiment (No Heating)
% One SS Experiment - Heater off, ~4 g/s, Ti=27, 0.9mm, Old Jet Cartridge
% 0.75 scan/second 
for m=1:0
clear
load LoopData
K081414=xlsread('Helium Loop 8_14_2014 17_14_48.csv', 1, 'C33:Y20000');
for i=1:18
    HEMJ(259,i)=mean(K081414(3044:3371,i));
end
HEMJ(259,19)=99000;
HEMJ(259,20)=0;
save K081414 K081414
save LoopData HEMJ
end
%% Helium Loop 8_14_2014 17_14_48                                           Case 260
% Steady-State Experiment - Pressure Drop Experiments - Steel/MT185 Integrated
% Cold Experiment (No Heating)
% One SS Experiment - Heater off, ~3 g/s, Ti=27, 0.9mm, Old Jet Cartridge
% 0.75 scan/second 
for m=1:0
clear
load LoopData
L081414=xlsread('Helium Loop 8_14_2014 17_14_48.csv', 1, 'C33:Y20000');
for i=1:18
    HEMJ(260,i)=mean(L081414(3444:3722,i));
end
HEMJ(260,19)=99000;
HEMJ(260,20)=0;
save L081414 L081414
save LoopData HEMJ
end
%% Helium Loop 8_15_2014 17_17_16
% Steady-State Experiment - Pressure Drop Experiments - Steel/MT185 Integrated
% Cold Experiment (No Heating), Cleaned debris
% One SS Experiment - Heater off, ~8,6,4,3 g/s, Ti=27, 0.9mm, Old Jet Cartridge
% 0.75 scan/second 
for m=1:0
clear
load LoopData
D081514=xlsread('Helium Loop 8_15_2014 17_17_16.csv', 1, 'C33:Y20000');
for i=1:18
    HEMJ(264,i)=mean(D081514(1800:2000,i));
end
HEMJ(264,19)=99000;
HEMJ(264,20)=0;
for i=1:18
    HEMJ(265,i)=mean(D081514(2100:2200,i));
end
HEMJ(265,19)=99000;
HEMJ(265,20)=0;
for i=1:18
    HEMJ(266,i)=mean(D081514(2450:2650,i));
end
HEMJ(266,19)=99000;
HEMJ(266,20)=0;
for i=1:18
    HEMJ(267,i)=mean(D081514(2750:2950,i));
end
HEMJ(267,19)=99000;
HEMJ(267,20)=0;
save D081514 D081514
save LoopData HEMJ
end
%% Helium Loop 8_19_2014 12_08_54                                           Case 270
% Steady-State Experiment - Pressure Drop Experiments - Steel/MT185 Integrated
% Cold Experiment (No Heating), Cleaned debris
% One SS Experiment - Heater off, ~8,7,6,5,4,3,2 g/s, Ti=27, 0.5mm, New Jet Cartridge
% 0.75 scan/second 
for m=1:0
clear
load LoopData
A081914=xlsread('Helium Loop 8_19_2014 12_08_54.csv', 1, 'C33:Y20000');
for i=1:18                                  % 8 g/s
    HEMJ(268,i)=mean(A081914(1635:1835,i));
end
HEMJ(268,19)=99000;
HEMJ(268,20)=0;
for i=1:18                                  % 7 g/s
    HEMJ(269,i)=mean(A081914(2331:2531,i));
end
HEMJ(269,19)=99000;
HEMJ(269,20)=0;
for i=1:18                                  % 6 g/s
    HEMJ(270,i)=mean(A081914(2894:3094,i));
end
HEMJ(270,19)=99000;
HEMJ(270,20)=0;
for i=1:18                                  % 5 g/s
    HEMJ(271,i)=mean(A081914(3234:3434,i));
end
HEMJ(271,19)=99000;
HEMJ(271,20)=0;
for i=1:18                                  % 4 g/s
    HEMJ(272,i)=mean(A081914(3580:3780,i));
end
HEMJ(272,19)=99000;
HEMJ(272,20)=0;
for i=1:18                                  % 3 g/s
    HEMJ(273,i)=mean(A081914(3931:4131,i));
end
HEMJ(273,19)=99000;
HEMJ(273,20)=0;
save A081914 A081914
save LoopData HEMJ
end
%% Helium Loop 8_20_2014 17_57_56
% Steady-State Experiment - Steel/MT185 Integrated - 0.5mm RT Repeats
% Induction Heater - 1.5 in ID Coil/3 turns - ~15 mm height - Tap 30
% One SS Experiment - Heater off, ~6.3 g/s, Ti=27, ~5 MW/m^2, 0.5mm, New Jet Cartridge
% 0.75 scan/second 
for m=1:0
clear
load LoopData
A082014=xlsread('Helium Loop 8_20_2014 17_57_56.csv', 1, 'C33:Y20000');
for i=1:18
    HEMJ(274,i)=mean(A082014(2900:3800,i));
end
HEMJ(274,19)=99000;
HEMJ(274,20)=0;
save A082014 A082014
save LoopData HEMJ
end
%% Helium Loop 8_20_2014 18_54_07                                           Case 275
% Steady-State Experiment - Steel/MT185 Integrated - 0.5mm RT Repeats
% Induction Heater - 1.5 in ID Coil/3 turns - ~15 mm height - Tap 30
% One SS Experiment - Heater off, ~4.9 g/s, Ti=27, ~5 MW/m^2, 0.5mm, New Jet Cartridge
% 0.75 scan/second 
for m=1:0
clear
load LoopData
B082014=xlsread('Helium Loop 8_20_2014 18_54_07.csv', 1, 'C33:Y20000');
for i=1:18
    HEMJ(275,i)=mean(B082014(298:498,i));
end
HEMJ(275,19)=99000;
HEMJ(275,20)=0;
save B082014 B082014
save LoopData HEMJ
end
%% Helium Loop 8_20_2014 19_02_00
% Steady-State Experiment - Steel/MT185 Integrated - 0.5mm RT Repeats
% Induction Heater - 1.5 in ID Coil/3 turns - ~15 mm height - Tap 30
% One SS Experiment - Heater off, ~4.1 g/s, Ti=27, ~5 MW/m^2, 0.5mm, New Jet Cartridge
% 0.75 scan/second 
for m=1:0
clear
load LoopData
C082014=xlsread('Helium Loop 8_20_2014 19_02_00.csv', 1, 'C33:Y20000');
for i=1:18
    HEMJ(276,i)=mean(C082014(193:393,i));
end
HEMJ(276,19)=99000;
HEMJ(276,20)=0;
save C082014 C082014
save LoopData HEMJ
end
%% Helium Loop 8_20_2014 19_08_19
% Steady-State Experiment - Steel/MT185 Integrated - 0.5mm RT Repeats
% Induction Heater - 1.5 in ID Coil/3 turns - ~15 mm height - Tap 30
% One SS Experiment - Heater off, ~3.3 g/s, Ti=27, ~5 MW/m^2, 0.5mm, New Jet Cartridge
% 0.75 scan/second 
for m=1:0
clear
load LoopData
D082014=xlsread('Helium Loop 8_20_2014 19_08_19.csv', 1, 'C33:Y20000');
for i=1:18
    HEMJ(277,i)=mean(D082014(949:1149,i));
end
HEMJ(277,19)=99000;
HEMJ(277,20)=0;
save D082014 D082014
save LoopData HEMJ
end
%% Helium Loop 8_21_2014 15_49_25
% Steady-State Experiment - Steel/MT185 Integrated - 0.5mm RT Repeats
% Induction Heater - 1.5 in ID Coil/3 turns - ~15 mm height - Tap 36
% One SS Experiment - Heater off, ~6.3 g/s, Ti=27, ~5 MW/m^2, 0.5mm, New Jet Cartridge
% 0.75 scan/second 
for m=1:0
clear
load LoopData
A082114=xlsread('Helium Loop 8_21_2014 15_49_25.csv', 1, 'C33:Y20000');
for i=1:18
    HEMJ(278,i)=mean(A082114(3175:3375,i));
end
HEMJ(278,19)=99000;
HEMJ(278,20)=0;
save A082114 A082114
save LoopData HEMJ
end
%% Helium Loop 8_21_2014 16_39_01
% Steady-State Experiment - Steel/MT185 Integrated - 0.5mm RT Repeats
% Induction Heater - 1.5 in ID Coil/3 turns - ~15 mm height - Tap 36
% One SS Experiment - Heater off, ~5.4 g/s, Ti=27, ~5 MW/m^2, 0.5mm, New Jet Cartridge
% 0.75 scan/second 
for m=1:0
clear
load LoopData
B082114=xlsread('Helium Loop 8_21_2014 16_39_01.csv', 1, 'C33:Y20000');
for i=1:18
    HEMJ(279,i)=mean(B082114(468:668,i));
end
HEMJ(279,19)=99000;
HEMJ(279,20)=0;
save B082114 B082114
save LoopData HEMJ
end
%% Helium Loop 8_21_2014 16_49_23                                           Case 280
% Steady-State Experiment - Steel/MT185 Integrated - 0.5mm RT Repeats
% Induction Heater - 1.5 in ID Coil/3 turns - ~15 mm height - Tap 36
% One SS Experiment - Heater off, ~5.0 g/s, Ti=27, ~5 MW/m^2, 0.5mm, New Jet Cartridge
% 0.75 scan/second 
for m=1:0
clear
load LoopData
C082114=xlsread('Helium Loop 8_21_2014 16_49_23.csv', 1, 'C33:Y20000');
for i=1:18
    HEMJ(280,i)=mean(C082114(225:425,i));
end
HEMJ(280,19)=99000;
HEMJ(280,20)=0;
save C082114 C082114
save LoopData HEMJ
end
%% Helium Loop 8_21_2014 16_56_13
% Steady-State Experiment - Steel/MT185 Integrated - 0.5mm RT Repeats
% Induction Heater - 1.5 in ID Coil/3 turns - ~15 mm height - Tap 36
% One SS Experiment - Heater off, ~4.0 g/s, Ti=27, ~5 MW/m^2, 0.5mm, New Jet Cartridge
% 0.75 scan/second 
for m=1:0
clear
load LoopData
D082114=xlsread('Helium Loop 8_21_2014 16_56_13.csv', 1, 'C33:Y20000');
for i=1:18
    HEMJ(281,i)=mean(D082114(426:626,i));
end
HEMJ(281,19)=99000;
HEMJ(281,20)=0;
save D082114 D082114
save LoopData HEMJ
end
%% Helium Loop 8_21_2014 17_06_00
% Steady-State Experiment - Steel/MT185 Integrated - 0.5mm RT Repeats
% Induction Heater - 1.5 in ID Coil/3 turns - ~15 mm height - Tap 36
% One SS Experiment - Heater off, ~3.0 g/s, Ti=27, ~5 MW/m^2, 0.5mm, New Jet Cartridge
% 0.75 scan/second 
for m=1:0
clear
load LoopData
E082114=xlsread('Helium Loop 8_21_2014 17_06_00.csv', 1, 'C33:Y20000');
for i=1:18
    HEMJ(282,i)=mean(E082114(285:485,i));
end
HEMJ(282,19)=99000;
HEMJ(282,20)=0;
save E082114 E082114
save LoopData HEMJ
end
%% Helium Loop 8_27_2014 14_57_20
% Steady-State Experiment - Steel/MT185 Integrated - Low q" repeats w/ IH
% Induction Heater - 1.5 in ID Coil/3 turns - ~15 mm height, Tap 22
% One SS Experiment - Heater off, ~4.15 g/s, Ti=27, ~2.7 MW/m^2, 0.5mm
% 0.75 scan/second 
for m=1:0
clear
load LoopData
A082714=xlsread('Helium Loop 8_27_2014 14_57_20.csv', 1, 'C33:Y20000');
file = A082714;
for i=1:18
    HEMJ(283,i)=mean(A082714(2135:2335,i));
end
HEMJ(283,19)=99000;
HEMJ(283,20)=0;
save A082714 A082714
save LoopData HEMJ
end
%% Helium Loop 8_27_2014 15_31_38
% Steady-State Experiment - Steel/MT185 Integrated - Low q" repeats w/ IH
% Induction Heater - 1.5 in ID Coil/3 turns - ~15 mm height, Tap 22
% One SS Experiment - Heater off, ~2.5 g/s, Ti=27, ~2.5 MW/m^2, 0.5mm
% 0.75 scan/second 
for m=1:0
clear
load LoopData
B082714=xlsread('Helium Loop 8_27_2014 15_31_38.csv', 1, 'C33:Y20000');
file = B082714;
for i=1:18
    HEMJ(284,i)=mean(B082714(793:993,i));
end
HEMJ(284,19)=99000;
HEMJ(284,20)=0;
save B082714 B082714
save LoopData HEMJ
end
%% Helium Loop 8_27_2014 15_46_39
% Steady-State Experiment - Steel/MT185 Integrated - Low q" repeats w/ IH
% Induction Heater - 1.5 in ID Coil/3 turns - ~15 mm height, Tap 16
% One SS Experiment - Heater off, ~2.5 g/s, Ti=27, ~2 MW/m^2, 0.5mm
% 0.75 scan/second 
for m=1:0
clear
load LoopData
C082714=xlsread('Helium Loop 8_27_2014 15_46_39.csv', 1, 'C33:Y20000');
file = C082714;
for i=1:18
    HEMJ(285,i)=mean(C082714(1825:2025,i));
end
HEMJ(285,19)=99000;
HEMJ(285,20)=0;
save C082714 C082714
save LoopData HEMJ
end
%% Helium Loop 8_27_2014 16_16_31
% Steady-State Experiment - Steel/MT185 Integrated - Low q" repeats w/ IH
% Induction Heater - 1.5 in ID Coil/3 turns - ~15 mm height, Tap 16
% One SS Experiment - Heater off, ~4.2 g/s, Ti=27, ~2 MW/m^2, 0.5mm
% 0.75 scan/second 
for m=1:0
clear
load LoopData
D082714=xlsread('Helium Loop 8_27_2014 16_16_31.csv', 1, 'C33:Y20000');
file = D082714;
for i=1:18
    HEMJ(286,i)=mean(D082714(495:695,i));
end
HEMJ(286,19)=99000;
HEMJ(286,20)=0;
save D082714 D082714
save LoopData HEMJ
end
%% Helium Loop 8_27_2014 16_27_11
% Steady-State Experiment - Steel/MT185 Integrated - Low q" repeats w/ IH
% Induction Heater - 1.5 in ID Coil/3 turns - ~15 mm height, Tap 30
% One SS Experiment - Heater off, ~4.2 g/s, Ti=27, ~2 MW/m^2, 0.5mm
% 0.75 scan/second 
for m=1:0
clear
load LoopData
E082714=xlsread('Helium Loop 8_27_2014 16_27_11.csv', 1, 'C33:Y20000');
file = E082714;
for i=1:18
    HEMJ(287,i)=mean(E082714(1127:1327,i));
end
HEMJ(287,19)=99000;
HEMJ(287,20)=0;
save E082714 E082714
save LoopData HEMJ
end
%% Helium Loop 8_27_2014 16_47_02
% Steady-State Experiment - Steel/MT185 Integrated - Low q" repeats w/ IH
% Induction Heater - 1.5 in ID Coil/3 turns - ~15 mm height, Tap 30
% One SS Experiment - Heater off, ~4.2 g/s, Ti=27, ~4 MW/m^2, 0.5mm
% 0.75 scan/second 
for m=1:0
clear
load LoopData
F082714=xlsread('Helium Loop 8_27_2014 16_47_02.csv', 1, 'C33:Y20000');
file = F082714;
for i=1:18
    HEMJ(288,i)=mean(F082714(211:411,i));
end
HEMJ(288,19)=99000;
HEMJ(288,20)=0;
save F082714 F082714
save LoopData HEMJ
end
%% Helium Loop 9_4_2014 17_07_43
% Steady-State Experiment - Steel/MT185 Integrated - Temp profile analysis
% Induction Heater - 1.5 in ID Coil/3 turns - ~15 mm height, Tap 22
% One SS Experiment - Heater off, ~7 g/s, Ti=27, ~4 MW/m^2, 0.5mm
% 0.75 scan/second 
for m=1:0
clear
load LoopData
A090414=xlsread('Helium Loop 9_4_2014 17_07_43.csv', 1, 'C33:Y20000');
file = A090414;
for i=1:18
    HEMJ(289,i)=mean(A090414(1953:2153,i));
end
HEMJ(289,19)=99000;
HEMJ(289,20)=0;
save A090414 A090414
save LoopData HEMJ
end
%% Helium Loop 9_4_2014 17_39_30
% Steady-State Experiment - Steel/MT185 Integrated - Temp profile analysis
% Induction Heater - 1.5 in ID Coil/3 turns - ~15 mm height, Tap 22
% One SS Experiment - Heater off, ~6.1 g/s, Ti=27, ~4 MW/m^2, 0.5mm
% 0.75 scan/second 
for m=1:0
clear
load LoopData
B090414=xlsread('Helium Loop 9_4_2014 17_39_30.csv', 1, 'C33:Y20000');
file = B090414; 
for i=1:18
    HEMJ(290,i)=mean(B090414(1158:1358,i));
end
HEMJ(290,19)=99000;
HEMJ(290,20)=0;
save B090414 B090414
save LoopData HEMJ
end
%% Helium Loop 9_4_2014 17_59_43
% Steady-State Experiment - Steel/MT185 Integrated - Temp profile analysis
% Induction Heater - 1.5 in ID Coil/3 turns - ~15 mm height, Tap 22
% One SS Experiment - Heater off, ~4.8 g/s, Ti=27, ~4 MW/m^2, 0.5mm
% 0.75 scan/second 
for m=1:0
clear
load LoopData
C090414=xlsread('Helium Loop 9_4_2014 17_59_43.csv', 1, 'C33:Y20000');
file = C090414;
for i=1:18
    HEMJ(291,i)=mean(C090414(602:802,i));
end
HEMJ(291,19)=99000;
HEMJ(291,20)=0;
save C090414 C090414
save LoopData HEMJ
end
%% Helium Loop 9_4_2014 18_11_57
% Steady-State Experiment - Steel/MT185 Integrated - Temp profile analysis
% Induction Heater - 1.5 in ID Coil/3 turns - ~15 mm height, Tap 22
% One SS Experiment - Heater off, ~4.0 g/s, Ti=27, ~4 MW/m^2, 0.5mm
% 0.75 scan/second 
for m=1:0
clear
load LoopData
D090414=xlsread('Helium Loop 9_4_2014 18_11_57.csv', 1, 'C33:Y20000');
file = D090414;
for i=1:18
    HEMJ(292,i)=mean(D090414(190:390,i));
end
HEMJ(292,19)=99000;
HEMJ(292,20)=0;
save D090414 D090414
save LoopData HEMJ
end
%% Helium Loop 9_4_2014 18_18_16
% Steady-State Experiment - Steel/MT185 Integrated - Temp profile analysis
% Induction Heater - 1.5 in ID Coil/3 turns - ~15 mm height, Tap 22
% One SS Experiment - Heater off, ~3.1 g/s, Ti=27, ~4 MW/m^2, 0.5mm
% 0.75 scan/second 
for m=1:0
clear
load LoopData
E090414=xlsread('Helium Loop 9_4_2014 18_18_16.csv', 1, 'C33:Y20000');
file = E090414;
for i=1:18
    HEMJ(293,i)=mean(E090414(266:466,i));
end
HEMJ(293,19)=99000;
HEMJ(293,20)=0;
save E090414 E090414
save LoopData HEMJ
end
%% Helium Loop 9_5_2014 15_17_06
% Steady-State Experiment - Steel/MT185 Integrated - Temp profile analysis
% Induction Heater - 1.5 in ID Coil/3 turns - ~15 mm height, Tap 22
% One SS Experiment - Heater on, ~6.8 g/s, Ti=100, ~3.8 MW/m^2, 0.5mm
% 0.75 scan/second 
for m=1:0
clear
load LoopData
A090514=xlsread('Helium Loop 9_5_2014 15_17_06.csv', 1, 'C33:Y20000');
file = A090514;
for i=1:18
    HEMJ(294,i)=mean(A090514(1650:1850,i));
end
HEMJ(294,19)=99000;
HEMJ(294,20)=0;
save A090514 A090514
save LoopData HEMJ
end
%% Helium Loop 9_5_2014 15_44_25
% Steady-State Experiment - Steel/MT185 Integrated - Temp profile analysis
% Induction Heater - 1.5 in ID Coil/3 turns - ~15 mm height, Tap 22
% One SS Experiment - Heater on, ~6 g/s, Ti=100, ~3.7 MW/m^2, 0.5mm
% 0.75 scan/second 
for m=1:0
clear
load LoopData
B090514=xlsread('Helium Loop 9_5_2014 15_44_25.csv', 1, 'C33:Y20000');
file = B090514;
for i=1:18
    HEMJ(295,i)=mean(B090514(700:900,i));
end
HEMJ(295,19)=99000;
HEMJ(295,20)=0;
save B090514 B090514
save LoopData HEMJ
end
%% Helium Loop 9_5_2014 15_58_27
% Steady-State Experiment - Steel/MT185 Integrated - Temp profile analysis
% Induction Heater - 1.5 in ID Coil/3 turns - ~15 mm height, Tap 22
% One SS Experiment - Heater on, ~5.2 g/s, Ti=100, ~3.75 MW/m^2, 0.5mm
% 0.75 scan/second 
for m=1:0
clear
load LoopData
C090514=xlsread('Helium Loop 9_5_2014 15_58_27.csv', 1, 'C33:Y20000');
file = C090514;
for i=1:18
    HEMJ(296,i)=mean(C090514(750:950,i));
end
HEMJ(296,19)=99000;
HEMJ(296,20)=0;
save C090514 C090514
save LoopData HEMJ
end
%% Helium Loop 9_5_2014 16_13_07
% Steady-State Experiment - Steel/MT185 Integrated - Temp profile analysis
% Induction Heater - 1.5 in ID Coil/3 turns - ~15 mm height, Tap 22
% One SS Experiment - Heater on, ~4.1 g/s, Ti=100, ~3.7 MW/m^2, 0.5mm
% 0.75 scan/second 
for m=1:0
clear
load LoopData
D090514=xlsread('Helium Loop 9_5_2014 16_13_07.csv', 1, 'C33:Y20000');
file = D090514;
for i=1:18
    HEMJ(297,i)=mean(D090514(680:880,i));
end
HEMJ(297,19)=99000;
HEMJ(297,20)=0;
save D090514 D090514
save LoopData HEMJ
end
%% Helium Loop 9_5_2014 16_26_37
% Steady-State Experiment - Steel/MT185 Integrated - Temp profile analysis
% Induction Heater - 1.5 in ID Coil/3 turns - ~15 mm height, Tap 22
% One SS Experiment - Heater on, ~3.05 g/s, Ti=100, ~3.7 MW/m^2, 0.5mm
% 0.75 scan/second 
for m=1:0
clear
load LoopData
E090514=xlsread('Helium Loop 9_5_2014 16_26_37.csv', 1, 'C33:Y20000');
file = E090514;
for i=1:18
    HEMJ(298,i)=mean(E090514(850:1050,i));
end
HEMJ(298,19)=99000;
HEMJ(298,20)=0;
save E090514 E090514
save LoopData HEMJ
end
%% Helium Loop 9_8_2014 14_53_34
% Steady-State Experiment - Induction Heat Experiments - Steel/MT185 Integrated
% Heating Experiment - Tap 22
% One SS Experiment - , ~8.0 g/s, Ti=200, 3.4 MW/m^2 0.5mm
% 0.75 scan/second 
for m=1:0
clear
load LoopData
A090814=xlsread('Helium Loop 9_8_2014 14_53_34.csv', 1, 'C33:Y20000');
file = A090814;
for i=1:18
    HEMJ(299,i)=mean(A090814(1800:2000,i));
end
HEMJ(299,19)=99000;
HEMJ(299,20)=0;
save A090814 A090814
save LoopData HEMJ
end
%% Helium Loop 9_8_2014 15_35_31                                            Case 300
% Steady-State Experiment - Induction Heat Experiments - Steel/MT185 Integrated
% Heating Experiment - Tap 22
% One SS Experiment - , ~7.0 g/s, Ti=200, 3.4 MW/m^2 0.5mm
% 0.75 scan/second 
for m=1:0
clear
load LoopData
B090814=xlsread('Helium Loop 9_8_2014 15_35_31.csv', 1, 'C33:Y20000');
file = B090814;
for i=1:18
    HEMJ(300,i)=mean(B090814(800:1000,i));
end
HEMJ(300,19)=99000;
HEMJ(300,20)=0;
save B090814 B090814
save LoopData HEMJ
end
%% Helium Loop 9_8_2014 15_52_07
% Steady-State Experiment - Induction Heat Experiments - Steel/MT185 Integrated
% Heating Experiment - Tap 22
% One SS Experiment - , ~6.0 g/s, Ti=200, 3.4 MW/m^2 0.5mm
% 0.75 scan/second 
for m=1:0
clear
load LoopData
C090814=xlsread('Helium Loop 9_8_2014 15_52_07.csv', 1, 'C33:Y20000');
file = C090814;
for i=1:18
    HEMJ(301,i)=mean(C090814(400:600,i));
end
HEMJ(301,19)=99000;
HEMJ(301,20)=0;
save C090814 C090814
save LoopData HEMJ
end
%% Helium Loop 9_8_2014 16_02_58
% Steady-State Experiment - Induction Heat Experiments - Steel/MT185 Integrated
% Heating Experiment - Tap 22
% One SS Experiment - , ~5.0 g/s, Ti=200, 3.4 MW/m^2 0.5mm
% 0.75 scan/second 
for m=1:0
clear
load LoopData
D090814=xlsread('Helium Loop 9_8_2014 16_02_58.csv', 1, 'C33:Y20000');
file = D090814;
for i=1:18
    HEMJ(302,i)=mean(D090814(800:1000,i));
end
HEMJ(302,19)=99000;
HEMJ(302,20)=0;
save D090814 D090814
save LoopData HEMJ
end
%% Helium Loop 9_8_2014 16_21_00
% Steady-State Experiment - Induction Heat Experiments - Steel/MT185 Integrated
% Heating Experiment - Tap 22
% One SS Experiment - , ~4.0 g/s, Ti=200, 3.4 MW/m^2 0.5mm
% 0.75 scan/second 
for m=1:0
clear
load LoopData
E090814=xlsread('Helium Loop 9_8_2014 16_21_00.csv', 1, 'C33:Y20000');
file = E090814;
for i=1:18
    HEMJ(303,i)=mean(E090814(800:1000,i));
end
HEMJ(303,19)=99000;
HEMJ(303,20)=0;
save E090814 E090814
save LoopData HEMJ
end
%% Helium Loop 9_8_2014 16_41_00
% Steady-State Experiment - Induction Heat Experiments - Steel/MT185 Integrated
% Heating Experiment - Tap 22
% One SS Experiment - , ~3.0 g/s, Ti=200, 3.4 MW/m^2 0.5mm
% 0.75 scan/second 
for m=1:0
clear
load LoopData
F090814=xlsread('Helium Loop 9_8_2014 16_41_00.csv', 1, 'C33:Y20000');
file = F090814;
for i=1:18
    HEMJ(304,i)=mean(F090814(500:700,i));
end
HEMJ(304,19)=99000;
HEMJ(304,20)=0;
save F090814 F090814
save LoopData HEMJ
end
%% Helium Loop 9_9_2014 14_15_53
% Steady-State Experiment - Induction Heat Experiments - Steel/MT185 Integrated
% Heating Experiment 
% One SS Experiment - , ~7.9 g/s, Ti=250, 3.0 MW/m^2 0.5mm
% 0.75 scan/second 
for m=1:0
clear
load LoopData
A090914=xlsread('Helium Loop 9_9_2014 14_15_53.csv', 1, 'C33:Y20000');
file = A090914;
for i=1:18
    HEMJ(305,i)=mean(A090914(1700:1900,i));
end
HEMJ(305,19)=99000;
HEMJ(305,20)=0;
save A090914 A090914
save LoopData HEMJ
end
%% Helium Loop 9_9_2014 14_51_15
% Steady-State Experiment - Induction Heat Experiments - Steel/MT185 Integrated
% Heating Experiment 
% One SS Experiment - , ~7.0 g/s, Ti=250, 3.0 MW/m^2 0.5mm
% 0.75 scan/second 
for m=1:0
clear
load LoopData
B090914=xlsread('Helium Loop 9_9_2014 14_51_15.csv', 1, 'C33:Y20000');
file = B090914;
for i=1:18
    HEMJ(306,i)=mean(B090914(800:1200,i));
end
HEMJ(306,19)=99000;
HEMJ(306,20)=0;
save B090914 B090914
save LoopData HEMJ
end
%% Helium Loop 9_9_2014 15_10_15
% Steady-State Experiment - Induction Heat Experiments - Steel/MT185 Integrated
% Heating Experiment 
% One SS Experiment - , ~6.0 g/s, Ti=250, 3.0 MW/m^2 0.5mm
% 0.75 scan/second 
for m=1:0
clear
load LoopData
C090914=xlsread('Helium Loop 9_9_2014 15_10_15.csv', 1, 'C33:Y20000');
file = C090914;
for i=1:18
    HEMJ(307,i)=mean(C090914(400:700,i));
end
HEMJ(307,19)=99000;
HEMJ(307,20)=0;
save C090914 C090914
save LoopData HEMJ
end
%% Helium Loop 9_9_2014 15_21_33
% Steady-State Experiment - Induction Heat Experiments - Steel/MT185 Integrated
% Heating Experiment 
% One SS Experiment - , ~5.0 g/s, Ti=250, 3.0 MW/m^2 0.5mm
% 0.75 scan/second 
for m=1:0
clear
load LoopData
D090914=xlsread('Helium Loop 9_9_2014 15_21_33.csv', 1, 'C33:Y20000');
file = D090914;
for i=1:18
    HEMJ(308,i)=mean(D090914(650:850,i));
end
HEMJ(308,19)=99000;
HEMJ(308,20)=0;
save D090914 D090914
save LoopData HEMJ
end
%% Helium Loop 9_9_2014 15_38_54
% Steady-State Experiment - Induction Heat Experiments - Steel/MT185 Integrated
% Heating Experiment 
% One SS Experiment - , ~4.0 g/s, Ti=250, 3.0 MW/m^2 0.5mm
% 0.75 scan/second 
for m=1:0
clear
load LoopData
E090914=xlsread('Helium Loop 9_9_2014 15_38_54.csv', 1, 'C33:Y20000');
file = E090914;
for i=1:18
    HEMJ(309,i)=mean(E090914(450:650,i));
end
HEMJ(309,19)=99000;
HEMJ(309,20)=0;
save E090914 E090914
save LoopData HEMJ
end
%% Helium Loop 9_9_2014 15_50_10                                            Case 310
% Steady-State Experiment - Induction Heat Experiments - Steel/MT185 Integrated
% Heating Experiment  
% One SS Experiment - , ~3.0 g/s, Ti=250, 3.0 MW/m^2 0.5mm
% 0.75 scan/second 
for m=1:0
clear
load LoopData
F090914=xlsread('Helium Loop 9_9_2014 15_50_10.csv', 1, 'C33:Y20000');
file = F090914;
for i=1:18
    HEMJ(310,i)=mean(F090914(600:800,i));
end
HEMJ(310,19)=99000;
HEMJ(310,20)=0;
save F090914 F090914
save LoopData HEMJ
end
%% Helium Loop 9_11_2014 14_39_49
% Steady-State Experiment - Induction Heat Experiments - Steel/MT185 Integrated
% Heating Experiment 
% One SS Experiment - , ~2.9 g/s, Ti=300, 3.0 MW/m^2 0.5mm
% 0.75 scan/second 
for m=1:0
clear
load LoopData
A091114=xlsread('Helium Loop 9_11_2014 14_39_49.csv', 1, 'C33:Y20000');
file = A091114;
for i=1:18
    HEMJ(311,i)=mean(A091114(100:300,i));
end
HEMJ(311,19)=99000;
HEMJ(311,20)=0;
save A091114 A091114
save LoopData HEMJ
end
%% Helium Loop 9_11_2014 14_45_00
% Steady-State Experiment - Induction Heat Experiments - Steel/MT185 Integrated
% Heating Experiment 
% One SS Experiment - , ~4 g/s, Ti=300, 3.0 MW/m^2 0.5mm
% 0.75 scan/second 
for m=1:0
clear
load LoopData
B091114=xlsread('Helium Loop 9_11_2014 14_45_00.csv', 1, 'C33:Y20000');
file = B091114;
for i=1:18
    HEMJ(312,i)=mean(B091114(550:750,i));
end
HEMJ(312,19)=99000;
HEMJ(312,20)=0;
save B091114 B091114
save LoopData HEMJ
end
%% Helium Loop 9_11_2014 14_57_01
% Steady-State Experiment - Induction Heat Experiments - Steel/MT185 Integrated
% Heating Experiment 
% One SS Experiment - , ~5 g/s, Ti=300, 3.0 MW/m^2 0.5mm
% 0.75 scan/second 
for m=1:0
clear
load LoopData
C091114=xlsread('Helium Loop 9_11_2014 14_57_01.csv', 1, 'C33:Y20000');
file = C091114;
for i=1:18
    HEMJ(313,i)=mean(C091114(650:850,i));
end
HEMJ(313,19)=99000;
HEMJ(313,20)=0;
save C091114 C091114
save LoopData HEMJ
end
%% Helium Loop 9_11_2014 15_10_24
% Steady-State Experiment - Induction Heat Experiments - Steel/MT185 Integrated
% Heating Experiment 
% One SS Experiment - , ~6 g/s, Ti=300, 3.0 MW/m^2 0.5mm
% 0.75 scan/second 
for m=1:0
clear
load LoopData
D091114=xlsread('Helium Loop 9_11_2014 15_10_24.csv', 1, 'C33:Y20000');
file = D091114;
for i=1:18
    HEMJ(314,i)=mean(D091114(1600:1800,i));
end
HEMJ(314,19)=99000;
HEMJ(314,20)=0;
save D091114 D091114
save LoopData HEMJ
end
%% Helium Loop 9_11_2014 15_37_14
% Steady-State Experiment - Induction Heat Experiments - Steel/MT185 Integrated
% Heating Experiment 
% One SS Experiment - , ~6.8 g/s, Ti=300, 3.0 MW/m^2 0.5mm
% 0.75 scan/second 
for m=1:0
clear
load LoopData
E091114=xlsread('Helium Loop 9_11_2014 15_37_14.csv', 1, 'C33:Y20000');
file = E091114;
for i=1:18
    HEMJ(315,i)=mean(E091114(600:800,i));
end
HEMJ(315,19)=99000;
HEMJ(315,20)=0;
save E091114 E091114
save LoopData HEMJ
end

%% Helium Loop 9_12_2014 16_24_58
% Steady-State Experiment - Induction Heat Experiments - Steel/MT185 Integrated
% Heating Experiment 
% One SS Experiment - , ~7 g/s, Ti=27, 2.7 MW/m^2 0.25mm
% 0.75 scan/second 
for m=1:0
clear
load LoopData
A091214=xlsread('Helium Loop 9_12_2014 16_24_58.csv', 1, 'C33:Y20000');
file = A091214;
for i=1:18
    HEMJ(316,i)=mean(A091214(3340:3540,i));
end
HEMJ(316,19)=99000;
HEMJ(316,20)=0;
save A091214 A091214
save LoopData HEMJ
end

%% Helium Loop 9_12_2014 17_16_44
% Steady-State Experiment - Induction Heat Experiments - Steel/MT185 Integrated
% Heating Experiment 
% One SS Experiment - , ~6 g/s, Ti=27, 2.7 MW/m^2 0.25mm
% 0.75 scan/second 
for m=1:0
clear
load LoopData
B091214=xlsread('Helium Loop 9_12_2014 17_16_44.csv', 1, 'C33:Y20000');
file = B091214;
for i=1:18
    HEMJ(317,i)=mean(B091214(525:725,i));
end
HEMJ(317,19)=99000;
HEMJ(317,20)=0;
save B091214 B091214
save LoopData HEMJ
end

%% Helium Loop 9_12_2014 17_27_54
% Steady-State Experiment - Induction Heat Experiments - Steel/MT185 Integrated
% Heating Experiment 
% One SS Experiment - , ~5 g/s, Ti=27, 2.7 MW/m^2 0.25mm
% 0.75 scan/second 
for m=1:0
clear
load LoopData
C091214=xlsread('Helium Loop 9_12_2014 17_27_54.csv', 1, 'C33:Y20000');
file = C091214;
for i=1:18
    HEMJ(318,i)=mean(C091214(410:610,i));
end
HEMJ(318,19)=99000;
HEMJ(318,20)=0;
save C091214 C091214
save LoopData HEMJ
end

%% Helium Loop 9_12_2014 17_37_31
% Steady-State Experiment - Induction Heat Experiments - Steel/MT185 Integrated
% Heating Experiment 
% One SS Experiment - , ~4 g/s, Ti=27, 2.7 MW/m^2 0.25mm
% 0.75 scan/second 
for m=1:0
clear
load LoopData
D091214=xlsread('Helium Loop 9_12_2014 17_37_31.csv', 1, 'C33:Y20000');
file = D091214;
for i=1:18
    HEMJ(319,i)=mean(D091214(300:500,i));
end
HEMJ(319,19)=99000;
HEMJ(319,20)=0;
save D091214 D091214
save LoopData HEMJ
end

%% Helium Loop 9_12_2014 17_45_32                                           Case 320
% Steady-State Experiment - Induction Heat Experiments - Steel/MT185 Integrated
% Heating Experiment 
% One SS Experiment - , ~3 g/s, Ti=27, 2.7 MW/m^2 0.25mm
% 0.75 scan/second 
for m=1:0
clear
load LoopData
E091214=xlsread('Helium Loop 9_12_2014 17_45_32.csv', 1, 'C33:Y20000');
file = E091214;
for i=1:18
    HEMJ(320,i)=mean(E091214(550:750,i));
end
HEMJ(320,19)=99000;
HEMJ(320,20)=0;
save E091214 E091214
save LoopData HEMJ
end
%% Helium Loop 9_14_2014 10_44_52
% Steady-State Experiment - Induction Heat Experiments - Steel/MT185 Integrated
% Heating Experiment 
% One SS Experiment - , ~3.1 g/s, Ti=200, 2.5 MW/m^2 0.25mm
% 0.75 scan/second 
for m=1:0
clear
load LoopData
A091414=xlsread('Helium Loop 9_14_2014 10_44_52.csv', 1, 'C33:Y20000');
file = A091414;
for i=1:18
    HEMJ(321,i)=mean(A091414(2900:3100,i));
end
HEMJ(321,19)=99000;
HEMJ(321,20)=0;
save A091414 A091414
save LoopData HEMJ
end
%% Helium Loop 9_14_2014 11_30_49
% Steady-State Experiment - Induction Heat Experiments - Steel/MT185 Integrated
% Heating Experiment 
% One SS Experiment - , ~4.0 g/s, Ti=200, 2.5 MW/m^2 0.25mm
% 0.75 scan/second 
for m=1:0
clear
load LoopData
B091414=xlsread('Helium Loop 9_14_2014 11_30_49.csv', 1, 'C33:Y20000');
file = B091414;
for i=1:18
    HEMJ(322,i)=mean(B091414(850:1050,i));
end
HEMJ(322,19)=99000;
HEMJ(322,20)=0;
save B091414 B091414
save LoopData HEMJ
end
%% Helium Loop 9_14_2014 11_46_49
% Steady-State Experiment - Induction Heat Experiments - Steel/MT185 Integrated
% Heating Experiment 
% One SS Experiment - , ~5.0 g/s, Ti=200, 2.5 MW/m^2 0.25mm
% 0.75 scan/second 
for m=1:0
clear
load LoopData
C091414=xlsread('Helium Loop 9_14_2014 11_46_49.csv', 1, 'C33:Y20000');
file = C091414;
for i=1:18
    HEMJ(323,i)=mean(C091414(1700:1900,i));
end
HEMJ(323,19)=99000;
HEMJ(323,20)=0;
save C091414 C091414
save LoopData HEMJ
end
%% Helium Loop 9_14_2014 12_15_11
% Steady-State Experiment - Induction Heat Experiments - Steel/MT185 Integrated
% Heating Experiment 
% One SS Experiment - , ~5.35 g/s, Ti=200, 2.5 MW/m^2 0.25mm
% 0.75 scan/second 
for m=1:0
clear
load LoopData
D091414=xlsread('Helium Loop 9_14_2014 12_15_11.csv', 1, 'C33:Y20000');
file = D091414;
for i=1:18
    HEMJ(324,i)=mean(D091414(1650:1850,i));
end
HEMJ(324,19)=99000;
HEMJ(324,20)=0;
save D091414 D091414
save LoopData HEMJ
end
%% Helium Loop 9_14_2014 18_33_39                                          
% Steady-State Experiment - Induction Heat Experiments - Steel/MT185 Integrated
% Heating Experiment 
% One SS Experiment - , ~3 g/s, Ti=100, 2.5 MW/m^2 0.25mm
% 0.75 scan/second 
for m=1:0
clear
load LoopData
E091414=xlsread('Helium Loop 9_14_2014 18_33_39.csv', 1, 'C33:Y20000');
file = E091414;
for i=1:18
    HEMJ(325,i)=mean(E091414(550:750,i));
end
HEMJ(325,19)=99000;
HEMJ(325,20)=0;
save E091414 E091414
save LoopData HEMJ
end
%% Helium Loop 9_14_2014 18_45_24
% Steady-State Experiment - Induction Heat Experiments - Steel/MT185 Integrated
% Heating Experiment 
% One SS Experiment - , ~4 g/s, Ti=100, 2.5 MW/m^2 0.25mm
% 0.75 scan/second 
for m=1:0
clear
load LoopData
F091414=xlsread('Helium Loop 9_14_2014 18_45_24.csv', 1, 'C33:Y20000');
file = F091414;
for i=1:18
    HEMJ(326,i)=mean(F091414(650:850,i));
end
HEMJ(326,19)=99000;
HEMJ(326,20)=0;
save F091414 F091414
save LoopData HEMJ
end
%% Helium Loop 9_14_2014 18_58_48
% Steady-State Experiment - Induction Heat Experiments - Steel/MT185 Integrated
% Heating Experiment 
% One SS Experiment - , ~5 g/s, Ti=100, 2.5 MW/m^2 0.25mm
% 0.75 scan/second 
for m=1:0
clear
load LoopData
G091414=xlsread('Helium Loop 9_14_2014 18_58_48.csv', 1, 'C33:Y20000');
file = G091414;
for i=1:18
    HEMJ(327,i)=mean(G091414(450:650,i));
end
HEMJ(327,19)=99000;
HEMJ(327,20)=0;
save G091414 G091414
save LoopData HEMJ
end
%% Helium Loop 9_14_2014 19_09_12
% Steady-State Experiment - Induction Heat Experiments - Steel/MT185 Integrated
% Heating Experiment 
% One SS Experiment - , ~6 g/s, Ti=100, 2.5 MW/m^2 0.25mm
% 0.75 scan/second 
for m=1:0
clear
load LoopData
H091414=xlsread('Helium Loop 9_14_2014 19_09_12.csv', 1, 'C33:Y20000');
file = H091414;
for i=1:18
    HEMJ(328,i)=mean(H091414(700:900,i));
end
HEMJ(328,19)=99000;
HEMJ(328,20)=0;
save H091414 H091414
save LoopData HEMJ
end
%% Helium Loop 9_15_2014 10_32_07
% Steady-State Experiment - Induction Heat Experiments - Steel/MT185 Integrated
% Heating Experiment 
% One SS Experiment - , ~3 g/s, Ti=300, 2.5 MW/m^2 0.25mm
% 0.75 scan/second 
for m=1:0
clear
load LoopData
A091514=xlsread('Helium Loop 9_15_2014 10_32_07.csv', 1, 'C33:Y20000');
file = A091514;
for i=1:18
    HEMJ(329,i)=mean(A091514(3300:3500,i));
end
HEMJ(329,19)=99000;
HEMJ(329,20)=0;
save A091514 A091514
save LoopData HEMJ
end
%% Helium Loop 9_15_2014 11_23_56                                           Case 330
% Steady-State Experiment - Induction Heat Experiments - Steel/MT185 Integrated
% Heating Experiment 
% One SS Experiment - , ~4 g/s, Ti=300, 2.5 MW/m^2 0.25mm
% 0.75 scan/second 
for m=1:0
clear
load LoopData
B091514=xlsread('Helium Loop 9_15_2014 11_23_56.csv', 1, 'C33:Y20000');
file = B091514;
for i=1:18
    HEMJ(330,i)=mean(B091514(950:1150,i));
end
HEMJ(330,19)=99000;
HEMJ(330,20)=0;
save B091514 B091514
save LoopData HEMJ
end
%% Helium Loop 9_15_2014 11_41_06
% Steady-State Experiment - Induction Heat Experiments - Steel/MT185 Integrated
% Heating Experiment 
% One SS Experiment - , ~4.7 g/s, Ti=300, 2.5 MW/m^2 0.25mm
% 0.75 scan/second 
for m=1:0
clear
load LoopData
C091514=xlsread('Helium Loop 9_15_2014 11_41_06.csv', 1, 'C33:Y20000');
file = C091514;
for i=1:18
    HEMJ(331,i)=mean(C091514(850:1050,i));
end
HEMJ(331,19)=99000;
HEMJ(331,20)=0;
save C091514 C091514
save LoopData HEMJ
end
%% Helium Loop 9_15_2014 11_56_55
% Steady-State Experiment - Induction Heat Experiments - Steel/MT185 Integrated
% Heating Experiment 
% One SS Experiment - , ~5.1 g/s, Ti=250, 2.5 MW/m^2 0.25mm
% 0.75 scan/second 
for m=1:0
clear
load LoopData
D091514=xlsread('Helium Loop 9_15_2014 11_56_55.csv', 1, 'C33:Y20000');
file = D091514;
for i=1:18
    HEMJ(332,i)=mean(D091514(1340:1540,i));
end
HEMJ(332,19)=99000;
HEMJ(332,20)=0;
save D091514 D091514
save LoopData HEMJ
end
%% Helium Loop 9_15_2014 12_19_47
% Steady-State Experiment - Induction Heat Experiments - Steel/MT185 Integrated
% Heating Experiment 
% One SS Experiment - , ~4 g/s, Ti=250, 2.5 MW/m^2 0.25mm
% 0.75 scan/second 
for m=1:0
clear
load LoopData
E091514=xlsread('Helium Loop 9_15_2014 12_19_47.csv', 1, 'C33:Y20000');
file = E091514;
for i=1:18
    HEMJ(333,i)=mean(E091514(1300:1500,i));
end
HEMJ(333,19)=99000;
HEMJ(333,20)=0;
save E091514 E091514
save LoopData HEMJ
end
%% Helium Loop 9_15_2014 12_42_11
% Steady-State Experiment - Induction Heat Experiments - Steel/MT185 Integrated
% Heating Experiment 
% One SS Experiment - , ~2.9 g/s, Ti=250, 2.5 MW/m^2 0.25mm
% 0.75 scan/second 
for m=1:0
clear
load LoopData
F091514=xlsread('Helium Loop 9_15_2014 12_42_11.csv', 1, 'C33:Y20000');
file = F091514;
for i=1:18
    HEMJ(334,i)=mean(F091514(1180:1380,i));
end
HEMJ(334,19)=99000;
HEMJ(334,20)=0;
save F091514 F091514
save LoopData HEMJ
end
%% Helium Loop 9_19_2014 16_41_56
% Steady-State Experiment - Induction Heat Experiments - Steel/MT185 Integrated
% Heating Experiment - Copper shield
% One SS Experiment - , ~6.1 g/s, Ti=27, 1.4 MW/m^2 0.25mm
% 0.75 scan/second 
for m=1:0
clear
load LoopData
A091914=xlsread('Helium Loop 9_19_2014 16_41_56.csv', 1, 'C33:Y20000');
file = A091914;
for i=1:18
    HEMJ(335,i)=mean(A091914(2750:2950,i));
end
HEMJ(335,19)=99000;
HEMJ(335,20)=0;
save A091914 A091914
save LoopData HEMJ
end
%% Helium Loop 9_19_2014 17_25_51
% Steady-State Experiment - Induction Heat Experiments - Steel/MT185 Integrated
% Heating Experiment - Copper shield
% One SS Experiment - , ~2.9 g/s, Ti=27, 1.4 MW/m^2 0.25mm
% 0.75 scan/second 
for m=1:0
clear
load LoopData
B091914=xlsread('Helium Loop 9_19_2014 17_25_51.csv', 1, 'C33:Y20000');
file = B091914;
for i=1:18
    HEMJ(336,i)=mean(B091914(420:620,i));
end
HEMJ(336,19)=99000;
HEMJ(336,20)=0;
save B091914 B091914
save LoopData HEMJ
end
%% Helium Loop 9_23_2014 12_39_21
% Steady-State Experiment - Induction Heat Experiments - Steel/MT185 Integrated
% Heating Experiment - No copper shield - Repeat
% One SS Experiment - , ~6.1 g/s, Ti=27, 2.4 MW/m^2 0.25mm
% 0.75 scan/second 
for m=1:0
clear
load LoopData
A100314=xlsread('Helium Loop 9_23_2014 12_39_21.csv', 1, 'C33:Y20000');
file = A100314;
for i=1:18
    HEMJ(337,i)=mean(A100314(3650:3850,i));
end
HEMJ(337,19)=99000;
HEMJ(337,20)=0;
save A092314 A100314
save LoopData HEMJ
end
%% Helium Loop 9_23_2014 13_35_43
% Steady-State Experiment - Induction Heat Experiments - Steel/MT185 Integrated
% Heating Experiment - No copper shield - Repeat
% One SS Experiment - , ~2.9 g/s, Ti=27, 2.4 MW/m^2 0.25mm
% 0.75 scan/second 
for m=1:0
clear
load LoopData
C100314=xlsread('Helium Loop 9_23_2014 13_35_43.csv', 1, 'C33:Y20000');
file = C100314;
for i=1:18
    HEMJ(338,i)=mean(C100314(300:500,i));
end
HEMJ(338,19)=99000;
HEMJ(338,20)=0;
save B092314 C100314
save LoopData HEMJ
end
%% Helium Loop 10_3_2014 12_08_53
% Steady-State Experiment - Induction Heat Experiments - Steel/WL10
% Heating Experiment - High heat flux repeat
% One SS Experiment - , ~2.9 g/s, Ti=27, 6.2 MW/m^2 0.9mm
% 0.75 scan/second 
for m=1:0
clear
load LoopData
A100314=xlsread('Helium Loop 10_3_2014 12_08_53.csv', 1, 'C33:Y20000');
file = A100314;
for i=1:18
    HEMJ(339,i)=mean(A100314(3750:3950,i));
end
HEMJ(339,19)=99000;
HEMJ(339,20)=0;
save A100314 A100314
save LoopData HEMJ
end
%% Helium Loop 10_3_2014 13_07_15                                           Case 340
% Steady-State Experiment - Induction Heat Experiments - Steel/WL10
% Heating Experiment - High heat flux repeat
% One SS Experiment - , ~4 g/s, Ti=27, 6.4 MW/m^2 0.9mm
% 0.75 scan/second 
for m=1:0
clear
load LoopData
B100314=xlsread('Helium Loop 10_3_2014 13_07_15.csv', 1, 'C33:Y20000');
file = B100314;
for i=1:18
    HEMJ(340,i)=mean(B100314(850:1050,i));
end
HEMJ(340,19)=99000;
HEMJ(340,20)=0;
save B100314 B100314
save LoopData HEMJ
end
%% Helium Loop 10_3_2014 13_24_11
% Steady-State Experiment - Induction Heat Experiments - Steel/WL10
% Heating Experiment - High heat flux repeat
% One SS Experiment - , ~5 g/s, Ti=27, 6.6 MW/m^2 0.9mm
% 0.75 scan/second 
for m=1:0
clear
load LoopData
C100314=xlsread('Helium Loop 10_3_2014 13_24_11.csv', 1, 'C33:Y20000');
file = C100314;
for i=1:18
    HEMJ(341,i)=mean(C100314(250:450,i));
end
HEMJ(341,19)=99000;
HEMJ(341,20)=0;
save C100314 C100314
save LoopData HEMJ
end
%% Helium Loop 10_3_2014 13_31_57
% Steady-State Experiment - Induction Heat Experiments - Steel/WL10
% Heating Experiment - High heat flux repeat
% One SS Experiment - , ~5.9 g/s, Ti=27, 6.7 MW/m^2 0.9mm
% 0.75 scan/second 
for m=1:0
clear
load LoopData
D100314=xlsread('Helium Loop 10_3_2014 13_31_57.csv', 1, 'C33:Y20000');
file = D100314;
for i=1:18
    HEMJ(342,i)=mean(D100314(750:950,i));
end
HEMJ(342,19)=99000;
HEMJ(342,20)=0;
save D100314 D100314
save LoopData HEMJ 
end
%% Helium Loop 10_7_2014 15_35_08
% Steady-State Experiment - Induction Heat Experiments - Steel/WL10
% Heating Experiment - High heat flux repeat
% One SS Experiment - , ~2.9 g/s, Ti=200, 4.0 MW/m^2 0.9mm
% 0.75 scan/second 
for m=1:0
clear
load LoopData
A100714=xlsread('Helium Loop 10_7_2014 15_35_08.csv', 1, 'C33:Y20000');
file = A100714;
for i=1:18
    HEMJ(343,i)=mean(A100714(3225:3425,i));
end
HEMJ(343,19)=99000;
HEMJ(343,20)=0;
save A100714 A100714
save LoopData HEMJ
end
%% Helium Loop 10_7_2014 16_25_59
% Steady-State Experiment - Induction Heat Experiments - Steel/WL10
% Heating Experiment - High heat flux repeat
% One SS Experiment - , ~4 g/s, Ti=200, 4.4 MW/m^2 0.9mm
% 0.75 scan/second 
for m=1:0
clear
load LoopData
B100714=xlsread('Helium Loop 10_7_2014 16_25_59.csv', 1, 'C33:Y20000');
file = B100714;
for i=1:18
    HEMJ(344,i)=mean(B100714(1700:1900,i));
end
HEMJ(344,19)=99000;
HEMJ(344,20)=0;
save B100714 B100714
save LoopData HEMJ
end
%% Helium Loop 10_7_2014 16_54_21
% Steady-State Experiment - Induction Heat Experiments - Steel/WL10
% Heating Experiment - High heat flux repeat
% One SS Experiment - , ~5 g/s, Ti=200, 4.5 MW/m^2 0.9mm
% 0.75 scan/second 
for m=1:0
clear
load LoopData
C100714=xlsread('Helium Loop 10_7_2014 16_54_21.csv', 1, 'C33:Y20000');
file = C100714;
for i=1:18
    HEMJ(345,i)=mean(C100714(525:725,i));
end
HEMJ(345,19)=99000;
HEMJ(345,20)=0;
save C100714 C100714
save LoopData HEMJ
end
%% Helium Loop 10_7_2014 17_05_31
% Steady-State Experiment - Induction Heat Experiments - Steel/WL10
% Heating Experiment - High heat flux repeat
% One SS Experiment - , ~6 g/s, Ti=200, 4.6 MW/m^2 0.9mm
% 0.75 scan/second 
for m=1:0
clear
load LoopData
D100714=xlsread('Helium Loop 10_7_2014 17_05_31.csv', 1, 'C33:Y20000');
file = D100714;
for i=1:18
    HEMJ(346,i)=mean(D100714(750:950,i));
end
HEMJ(346,19)=99000;
HEMJ(346,20)=0;
save D100714 D100714
save LoopData HEMJ
end
%% Helium Loop 10_14_2014 13_34_11
% Steady-State Experiment - Torch Experiments - Steel/WL10
% Heating Experiment - Different heat source experiment
% One SS Experiment - , ~3 g/s, Ti=27, 1.5 MW/m^2 0.9mm
% 0.75 scan/second 
for m=1:0
clear
load LoopData
A101414=xlsread('Helium Loop 10_14_2014 13_34_11.csv', 1, 'C33:Y20000');
file = A101414;
for i=1:18
    HEMJ(347,i)=mean(A101414(3350:3550,i));
end
HEMJ(347,19)=99000;
HEMJ(347,20)=0;
save A101414 A101414
save LoopData HEMJ
end
%% Helium Loop 10_14_2014 14_26_47
% Steady-State Experiment - Torch Experiments - Steel/WL10
% Heating Experiment - Different heat source experiment
% One SS Experiment - , ~3.9 g/s, Ti=27, 1.6 MW/m^2 0.9mm
% 0.75 scan/second 
for m=1:0
clear
load LoopData
B101414=xlsread('Helium Loop 10_14_2014 14_26_47.csv', 1, 'C33:Y20000');
file = B101414;
for i=1:18
    HEMJ(348,i)=mean(B101414(500:700,i));
end
HEMJ(348,19)=99000;
HEMJ(348,20)=0;
save B101414 B101414
save LoopData HEMJ
end
%% Helium Loop 10_14_2014 14_37_40
% Steady-State Experiment - Torch Experiments - Steel/WL10
% Heating Experiment - Different heat source experiment
% One SS Experiment - , ~4.9 g/s, Ti=27, 1.6 MW/m^2 0.9mm
% 0.75 scan/second 
for m=1:0
clear
load LoopData
C101414=xlsread('Helium Loop 10_14_2014 14_37_40.csv', 1, 'C33:Y20000');
file = C101414;
for i=1:18
    HEMJ(349,i)=mean(C101414(140:340,i));
end
HEMJ(349,19)=99000;
HEMJ(349,20)=0;
save C101414 C101414
save LoopData HEMJ
end
%% Helium Loop 10_14_2014 14_43_22                                          Case 350
% Steady-State Experiment - Torch Experiments - Steel/WL10
% Heating Experiment - Different heat source experiment
% One SS Experiment - , ~5.8 g/s, Ti=27, 1.6 MW/m^2 0.9mm
% 0.75 scan/second 
for m=1:0
clear
load LoopData
D101414=xlsread('Helium Loop 10_14_2014 14_43_22.csv', 1, 'C33:Y20000');
file = D101414;
for i=1:18
    HEMJ(350,i)=mean(D101414(190:340,i));
end
HEMJ(350,19)=99000;
HEMJ(350,20)=0;
save D101414 D101414
save LoopData HEMJ
end
%% Helium Loop 10_14_2014 14_49_05
% Steady-State Experiment - Torch Experiments - Steel/WL10
% Heating Experiment - Different heat source experiment
% One SS Experiment - , ~7 g/s, Ti=27, 1.6 MW/m^2 0.9mm
% 0.75 scan/second 
for m=1:0
clear
load LoopData
E101414=xlsread('Helium Loop 10_14_2014 14_49_05.csv', 1, 'C33:Y20000');
file = E101414;
for i=1:18
    HEMJ(351,i)=mean(E101414(170:370,i));
end
HEMJ(351,19)=99000;
HEMJ(351,20)=0;
save E101414 E101414
save LoopData HEMJ
end
%% Helium Loop 1_20_2015 10_47_56 1
% Steady-State Experiment - WL10 Repeats
% One SS Experiment - 8 g/s, Ti=27, 5.2 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:0
clear
load LoopData
A012015=xlsread('Helium Loop 1_20_2015 10_47_56 1.csv', 1, 'C33:Y20000');
file = A012015;
for i=1:18
    Data(352,i)=mean(A012015(4644:4918,i));
end
Ptest = Data(352,18); tempData = Data(352,14:17);
HEMJ(352,1:18) = [Data(352,1:13) Ptest tempData];
HEMJ(352,19)=99000;
HEMJ(352,20)=0;
save A012015 A012015
save LoopData HEMJ
end
%% Helium Loop 1_20_2015 12_00_18 1
% Steady-State Experiment - WL10 Repeats
% One SS Experiment - 7 g/s, Ti=27, 5.3 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:0
clear
load LoopData
B012015=xlsread('Helium Loop 1_20_2015 12_00_18 1.csv', 1, 'C33:Y20000');
file = B012015;
for i=1:18
    Data(353,i)=mean(B012015(615:817,i));
end
Ptest = Data(353,18); tempData = Data(353,14:17);
HEMJ(353,1:18) = [Data(353,1:13) Ptest tempData];
HEMJ(353,19)=99000;
HEMJ(353,20)=0;
save B012015 B012015
save LoopData HEMJ
end
%% Helium Loop 1_20_2015 12_13_12 1
% Steady-State Experiment - WL10 Repeats
% One SS Experiment - 5.8 g/s, Ti=27, 5.3 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:0
clear
load LoopData
C012015=xlsread('Helium Loop 1_20_2015 12_13_12 1.csv', 1, 'C33:Y20000');
file = C012015;
for i=1:18
    Data(354,i)=mean(C012015(600:800,i));
end
Ptest = Data(354,18); tempData = Data(354,14:17);
HEMJ(354,1:18) = [Data(354,1:13) Ptest tempData];
HEMJ(354,19)=99000;
HEMJ(354,20)=0;
save C012015 C012015
save LoopData HEMJ
end
%% Helium Loop 1_20_2015 12_49_03 1
% Steady-State Experiment - WL10 Repeats
% One SS Experiment - 3.5 g/s, Ti=27, 5.3 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:0
clear
load LoopData
E012015=xlsread('Helium Loop 1_20_2015 12_49_03 1.csv', 1, 'C33:Y20000');
file = E012015;
for i=1:18
    Data(355,i)=mean(E012015(1000:1199,i));
end
Ptest = Data(355,18); tempData = Data(355,14:17);
HEMJ(355,1:18) = [Data(355,1:13) Ptest tempData];
HEMJ(355,19)=99000;
HEMJ(355,20)=0;
save E012015 E012015
save LoopData HEMJ
end
%% Helium Loop 1_20_2015 13_07_03 1
% Steady-State Experiment - WL10 Repeats
% One SS Experiment - 3.0 g/s, Ti=27, 5.3 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:0
clear; load LoopData; 
x = 356;    % Case number
F012015=xlsread('Helium Loop 1_20_2015 13_07_03 1.csv', 1, 'C33:Y20000');
file = F012015;
for i=1:18
    Data(x,i)=mean(file(500:700,i));
end
Ptest = Data(x,18); tempData = Data(x,14:17);
HEMJ(x,1:18) = [Data(x,1:13) Ptest tempData];
HEMJ(x,19)=99000;
HEMJ(x,20)=0;
save F012015 F012015
save LoopData HEMJ
end
%% Helium Loop 1_22_2015 10_13_53
% Steady-State Experiment - WL10 Repeats
% One SS Experiment - 6.5 g/s, Ti=27, 5 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:0
clear; load LoopData; 
x = 357;    % Case number
A012215=xlsread('Helium Loop 1_22_2015 10_13_53.csv', 1, 'C33:Y20000');
file = A012215;
for i=1:18
    Data(x,i)=mean(file(2419:2619,i));
end
Ptest = Data(x,18); tempData = Data(x,14:17);
HEMJ(x,1:18) = [Data(x,1:13) Ptest tempData];
HEMJ(x,19)=99000;
HEMJ(x,20)=0;
save A012215 A012215
save LoopData HEMJ
end
%% Helium Loop 1_22_2015 11_03_29
% Steady-State Experiment - WL10 Repeats
% One SS Experiment - 4.2 g/s, Ti=27, 5 MW/m^2, 0.9mm
% 0.75 scan/second      % B012215 omitted because of strange TC108 reading
for m=1:0
clear; load LoopData; 
x = 358;    % Case number
C012215=xlsread('Helium Loop 1_22_2015 11_03_29.csv', 1, 'C33:Y20000');
file = C012215;
for i=1:18
    Data(x,i)=mean(file(2340:2540,i));
end
Ptest = Data(x,18); tempData = Data(x,14:17);
HEMJ(x,1:18) = [Data(x,1:13) Ptest tempData];
HEMJ(x,19)=99000;
HEMJ(x,20)=0;
save C012215 C012215
save LoopData HEMJ
end
%% Helium Loop 1_22_2015 11_41_07
% Steady-State Experiment - WL10 Repeats
% One SS Experiment - 3.7 g/s, Ti=27, 5 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:0
clear; load LoopData; 
x = 359;    % Case number
D012215=xlsread('Helium Loop 1_22_2015 11_41_07.csv', 1, 'C33:Y20000');
file = D012215;
for i=1:18
    Data(x,i)=mean(file(500:700,i));
end
Ptest = Data(x,18); tempData = Data(x,14:17);
HEMJ(x,1:18) = [Data(x,1:13) Ptest tempData];
HEMJ(x,19)=99000;
HEMJ(x,20)=0;
save D012215 D012215
save LoopData HEMJ
end
%% Helium Loop 1_22_2015 11_51_56                                           Case 360
% Steady-State Experiment - WL10 Repeats
% One SS Experiment - 3.3 g/s, Ti=27, 5 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:0
clear; load LoopData; 
x = 360;    % Case number
E012215=xlsread('Helium Loop 1_22_2015 11_51_56.csv', 1, 'C33:Y20000');
file = E012215;
for i=1:18
    Data(x,i)=mean(file(542:742,i));
end
Ptest = Data(x,18); tempData = Data(x,14:17);
HEMJ(x,1:18) = [Data(x,1:13) Ptest tempData];
HEMJ(x,19)=99000;
HEMJ(x,20)=0;
save E012215 E012215
save LoopData HEMJ
end
%% Helium Loop 4_3_2015 12_42_31
% Steady-State Experiment - WL10 Repeats
% One SS Experiment - 8.0 g/s, Ti=100, 3.5 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:0
clear; load LoopData; 
x = 361;    % Case number
A040315=xlsread('Helium Loop 4_3_2015 12_42_31.csv', 1, 'C33:Y20000');
file = A040315;
for i=1:18
    Data(x,i)=mean(file(2286:2486,i));
end
Ptest = Data(x,18); tempData = Data(x,14:17);
HEMJ(x,1:18) = [Data(x,1:13) Ptest tempData];
HEMJ(x,19)=99000;
HEMJ(x,20)=0;
save A040315 A040315
save LoopData HEMJ
end
%% Helium Loop 4_3_2015 13_19_13
% Steady-State Experiment - WL10 Repeats
% One SS Experiment - 7.0 g/s, Ti=100, 3.5 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:0
clear; load LoopData; 
x = 362;    % Case number
B040315=xlsread('Helium Loop 4_3_2015 13_19_13.csv', 1, 'C33:Y20000');
file = B040315;
for i=1:18
    Data(x,i)=mean(file(258:458,i));
end
Ptest = Data(x,18); tempData = Data(x,14:17);
HEMJ(x,1:18) = [Data(x,1:13) Ptest tempData];
HEMJ(x,19)=99000;
HEMJ(x,20)=0;
save B040315 B040315
save LoopData HEMJ
end
%% Helium Loop 4_3_2015 13_26_24
% Steady-State Experiment - WL10 Repeats
% One SS Experiment - 6.0 g/s, Ti=100, 3.5 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:0
clear; load LoopData; 
x = 363;    % Case number
C040315=xlsread('Helium Loop 4_3_2015 13_26_24.csv', 1, 'C33:Y20000');
file = C040315;
for i=1:18
    Data(x,i)=mean(file(1433:1633,i));
end
Ptest = Data(x,18); tempData = Data(x,14:17);
HEMJ(x,1:18) = [Data(x,1:13) Ptest tempData];
HEMJ(x,19)=99000;
HEMJ(x,20)=0;
save C040315 C040315
save LoopData HEMJ
end
%% Helium Loop 4_3_2015 13_50_41
% Steady-State Experiment - WL10 Repeats
% One SS Experiment - 5.0 g/s, Ti=100, 3.5 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:0
clear; load LoopData; 
x = 364;    % Case number
D040315=xlsread('Helium Loop 4_3_2015 13_50_41.csv', 1, 'C33:Y20000');
file = D040315;
for i=1:18
    Data(x,i)=mean(file(497:697,i));
end
Ptest = Data(x,18); tempData = Data(x,14:17);
HEMJ(x,1:18) = [Data(x,1:13) Ptest tempData];
HEMJ(x,19)=99000;
HEMJ(x,20)=0;
save D040315 D040315
save LoopData HEMJ
end
%% Helium Loop 4_3_2015 14_01_22
% Steady-State Experiment - WL10 Repeats
% One SS Experiment - 4.0 g/s, Ti=100, 3.5 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:0
clear; load LoopData; 
x = 365;    % Case number
E040315=xlsread('Helium Loop 4_3_2015 14_01_22.csv', 1, 'C33:Y20000');
file = E040315;
for i=1:18
    Data(x,i)=mean(file(874:1074,i));
end
Ptest = Data(x,18); tempData = Data(x,14:17);
HEMJ(x,1:18) = [Data(x,1:13) Ptest tempData];
HEMJ(x,19)=99000;
HEMJ(x,20)=0;
save E040315 E040315
save LoopData HEMJ
end
%% Helium Loop 4_3_2015 14_17_30
% Steady-State Experiment - WL10 Repeats
% One SS Experiment - 3.0 g/s, Ti=100, 3.5 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:0
clear; load LoopData; 
x = 366;    % Case number
F040315=xlsread('Helium Loop 4_3_2015 14_17_30.csv', 1, 'C33:Y20000');
file = F040315;
for i=1:18
    Data(x,i)=mean(file(1640:1820,i));
end
Ptest = Data(x,18); tempData = Data(x,14:17);
HEMJ(x,1:18) = [Data(x,1:13) Ptest tempData];
HEMJ(x,19)=99000;
HEMJ(x,20)=0;
save F040315 F040315
save LoopData HEMJ
end
%% Helium Loop 4_3_2015 14_17_30
% Steady-State Experiment - WL10 Repeats
% One SS Experiment - 3.0 g/s, Ti=30, 3.5 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:0
clear; load LoopData; 
x = 367;    % Case number
G040315=xlsread('Helium Loop 4_3_2015 14_17_30.csv', 1, 'C33:Y20000');
file = G040315;
for i=1:18
    Data(x,i)=mean(file(2834:4034,i));
end
Ptest = Data(x,18); tempData = Data(x,14:17);
HEMJ(x,1:18) = [Data(x,1:13) Ptest tempData];
HEMJ(x,19)=99000;
HEMJ(x,20)=0;
save G040315 G040315
save LoopData HEMJ
end
%% Helium Loop 4_3_2015 15_17_03
% Steady-State Experiment - WL10 Repeats
% One SS Experiment - 4.0 g/s, Ti=30, 3.5 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:0
clear; load LoopData; 
x = 368;    % Case number
H040315=xlsread('Helium Loop 4_3_2015 15_17_03.csv', 1, 'C33:Y20000');
file = H040315;
for i=1:18
    Data(x,i)=mean(file(816:1016,i));
end
Ptest = Data(x,18); tempData = Data(x,14:17);
HEMJ(x,1:18) = [Data(x,1:13) Ptest tempData];
HEMJ(x,19)=99000;
HEMJ(x,20)=0;
save H040315 H040315
save LoopData HEMJ
end
%% Helium Loop 4_3_2015 15_32_20
% Steady-State Experiment - WL10 Repeats
% One SS Experiment - 5.0 g/s, Ti=30, 3.5 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:0
clear; load LoopData; 
x = 369;    % Case number
I040315=xlsread('Helium Loop 4_3_2015 15_32_20.csv', 1, 'C33:Y20000');
file = I040315;
for i=1:18
    Data(x,i)=mean(file(440:640,i));
end
Ptest = Data(x,18); tempData = Data(x,14:17);
HEMJ(x,1:18) = [Data(x,1:13) Ptest tempData];
HEMJ(x,19)=99000;
HEMJ(x,20)=0;
save I040315 I040315
save LoopData HEMJ
end
%% Helium Loop 4_3_2015 15_42_20                                            Case 370
% Steady-State Experiment - WL10 Repeats
% One SS Experiment - 6.0 g/s, Ti=30, 3.5 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:0
clear; load LoopData; 
x = 370;    % Case number
J040315=xlsread('Helium Loop 4_3_2015 15_42_20.csv', 1, 'C33:Y20000');
file = J040315;
for i=1:18
    Data(x,i)=mean(file(391:591,i));
end
Ptest = Data(x,18); tempData = Data(x,14:17);
HEMJ(x,1:18) = [Data(x,1:13) Ptest tempData];
HEMJ(x,19)=99000;
HEMJ(x,20)=0;
save J040315 J040315
save LoopData HEMJ
end
%% Helium Loop 4_3_2015 15_51_29
% Steady-State Experiment - WL10 Repeats
% One SS Experiment - 7.0 g/s, Ti=30, 3.5 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:0
clear; load LoopData; 
x = 371;    % Case number
K040315=xlsread('Helium Loop 4_3_2015 15_51_29.csv', 1, 'C33:Y20000');
file = K040315;
for i=1:18
    Data(x,i)=mean(file(390:590,i));
end
Ptest = Data(x,18); tempData = Data(x,14:17);
HEMJ(x,1:18) = [Data(x,1:13) Ptest tempData];
HEMJ(x,19)=99000;
HEMJ(x,20)=0;
save K040315 K040315
save LoopData HEMJ
end
%% Helium Loop 4_3_2015 16_00_40
% Steady-State Experiment - WL10 Repeats
% One SS Experiment - 8.0 g/s, Ti=30, 3.5 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:0
clear; load LoopData; 
x = 372;    % Case number
L040315=xlsread('Helium Loop 4_3_2015 16_00_40.csv', 1, 'C33:Y20000');
file = L040315;
for i=1:18
    Data(x,i)=mean(file(316:516,i));
end
Ptest = Data(x,18); tempData = Data(x,14:17);
HEMJ(x,1:18) = [Data(x,1:13) Ptest tempData];
HEMJ(x,19)=99000;
HEMJ(x,20)=0;
save L040315 L040315
save LoopData HEMJ
end
%% Helium Loop 4_6_2015 09_52_18
% Steady-State Experiment - WL10 Repeats
% One SS Experiment - 3.0 g/s, Ti=200, 3.5 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:0
clear; load LoopData; 
x = 373;    % Case number
A040615=xlsread('Helium Loop 4_6_2015 09_52_18.csv', 1, 'C33:Y20000');
file = A040615;
for i=1:18
    Data(x,i)=mean(file(3593:3793,i));
end
Ptest = Data(x,18); tempData = Data(x,14:17);
HEMJ(x,1:18) = [Data(x,1:13) Ptest tempData];
HEMJ(x,19)=99000;
HEMJ(x,20)=0;
save A040615 A040615
save LoopData HEMJ
end
%% Helium Loop 4_6_2015 10_47_54
% Steady-State Experiment - WL10 Repeats
% One SS Experiment - 4.0 g/s, Ti=200, 3.5 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:0
clear; load LoopData; 
x = 374;    % Case number
B040615=xlsread('Helium Loop 4_6_2015 10_47_54.csv', 1, 'C33:Y20000');
file = B040615;
for i=1:18
    Data(x,i)=mean(file(994:1194,i));
end
Ptest = Data(x,18); tempData = Data(x,14:17);
HEMJ(x,1:18) = [Data(x,1:13) Ptest tempData];
HEMJ(x,19)=99000;
HEMJ(x,20)=0;
save B040615 B040615
save LoopData HEMJ
end
%% Helium Loop 4_6_2015 11_19_46                                           
% Steady-State Experiment - WL10 Repeats
% One SS Experiment - 5.0 g/s, Ti=200, 3.5 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:0
clear; load LoopData; 
x = 375;    % Case number
C040615=xlsread('Helium Loop 4_6_2015 11_19_46.csv', 1, 'C33:Y20000');
file = C040615;
for i=1:18
    Data(x,i)=mean(file(396:596,i));
end
Ptest = Data(x,18); tempData = Data(x,14:17);
HEMJ(x,1:18) = [Data(x,1:13) Ptest tempData];
HEMJ(x,19)=99000;
HEMJ(x,20)=0;
save C040615 C040615
save LoopData HEMJ
end
%% Helium Loop 4_6_2015 11_28_59
% Steady-State Experiment - WL10 Repeats
% One SS Experiment - 6.0 g/s, Ti=200, 3.5 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:0
clear; load LoopData; 
x = 376;    % Case number
D040615=xlsread('Helium Loop 4_6_2015 11_28_59.csv', 1, 'C33:Y20000');
file = D040615;
for i=1:18
    Data(x,i)=mean(file(518:718,i));
end
Ptest = Data(x,18); tempData = Data(x,14:17);
HEMJ(x,1:18) = [Data(x,1:13) Ptest tempData];
HEMJ(x,19)=99000;
HEMJ(x,20)=0;
save D040615 D040615
save LoopData HEMJ
end
%% Helium Loop 4_6_2015 11_40_00
% Steady-State Experiment - WL10 Repeats
% One SS Experiment - 7.0 g/s, Ti=200, 3.5 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:0
clear; load LoopData; 
x = 377;    % Case number
E040615=xlsread('Helium Loop 4_6_2015 11_40_00.csv', 1, 'C33:Y20000');
file = E040615;
for i=1:18
    Data(x,i)=mean(file(1344:1544,i));
end
Ptest = Data(x,18); tempData = Data(x,14:17);
HEMJ(x,1:18) = [Data(x,1:13) Ptest tempData];
HEMJ(x,19)=99000;
HEMJ(x,20)=0;
save E040615 E040615
save LoopData HEMJ
end
%% Helium Loop 4_6_2015 12_02_59
% Steady-State Experiment - WL10 Repeats
% One SS Experiment - 8.0 g/s, Ti=200, 3.5 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:0
clear; load LoopData; 
x = 378;    % Case number
F040615=xlsread('Helium Loop 4_6_2015 12_02_59.csv', 1, 'C33:Y20000');
file = F040615;
for i=1:18
    Data(x,i)=mean(file(1348:1548,i));
end
Ptest = Data(x,18); tempData = Data(x,14:17);
HEMJ(x,1:18) = [Data(x,1:13) Ptest tempData];
HEMJ(x,19)=99000;
HEMJ(x,20)=0;
save F040615 F040615
save LoopData HEMJ
end
%% Helium Loop 4_7_2015 10_35_41
% Steady-State Experiment - WL10 Repeats
% One SS Experiment - 3.0 g/s, Ti=300, 2.8 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:0
clear; load LoopData; 
x = 379;    % Case number
A040715=xlsread('Helium Loop 4_7_2015 10_35_41.csv', 1, 'C33:Y20000');
file = A040715;
for i=1:18
    Data(x,i)=mean(file(748:948,i));
end
Ptest = Data(x,18); tempData = Data(x,14:17);
HEMJ(x,1:18) = [Data(x,1:13) Ptest tempData];
HEMJ(x,19)=99000;
HEMJ(x,20)=0;
save A040715 A040715
save LoopData HEMJ
end
%% Helium Loop 4_7_2015 10_50_03                                            Case 380
% Steady-State Experiment - WL10 Repeats
% One SS Experiment - 4.0 g/s, Ti=300, 2.8 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:0
clear; load LoopData; 
x = 380;    % Case number
B040715=xlsread('Helium Loop 4_7_2015 10_50_03.csv', 1, 'C33:Y20000');
file = B040715;
for i=1:18
    Data(x,i)=mean(file(974:1174,i));
end
Ptest = Data(x,18); tempData = Data(x,14:17);
HEMJ(x,1:18) = [Data(x,1:13) Ptest tempData];
HEMJ(x,19)=99000;
HEMJ(x,20)=0;
save B040715 B040715
save LoopData HEMJ
end
%% Helium Loop 4_7_2015 11_07_40
% Steady-State Experiment - WL10 Repeats
% One SS Experiment - 5.0 g/s, Ti=300, 2.8 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:0
clear; load LoopData; 
x = 381;    % Case number
C040715=xlsread('Helium Loop 4_7_2015 11_07_40.csv', 1, 'C33:Y20000');
file = C040715;
for i=1:18
    Data(x,i)=mean(file(1684:1884,i));
end
Ptest = Data(x,18); tempData = Data(x,14:17);
HEMJ(x,1:18) = [Data(x,1:13) Ptest tempData];
HEMJ(x,19)=99000;
HEMJ(x,20)=0;
save C040715 C040715
save LoopData HEMJ
end
%% Helium Loop 4_7_2015 11_35_35
% Steady-State Experiment - WL10 Repeats
% One SS Experiment - 6.0 g/s, Ti=300, 2.8 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:0
clear; load LoopData; 
x = 382;    % Case number
D040715=xlsread('Helium Loop 4_7_2015 11_35_35.csv', 1, 'C33:Y20000');
file = D040715;
for i=1:18
    Data(x,i)=mean(file(449:649,i));
end
Ptest = Data(x,18); tempData = Data(x,14:17);
HEMJ(x,1:18) = [Data(x,1:13) Ptest tempData];
HEMJ(x,19)=99000;
HEMJ(x,20)=0;
save D040715 D040715
save LoopData HEMJ
end
%% Helium Loop 4_7_2015 11_45_35
% Steady-State Experiment - WL10 Repeats
% One SS Experiment - 6.8 g/s, Ti=300, 2.8 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:0
clear; load LoopData; 
x = 383;    % Case number
E040715=xlsread('Helium Loop 4_7_2015 11_45_35.csv', 1, 'C33:Y20000');
file = E040715;
for i=1:18
    Data(x,i)=mean(file(1176:1376,i));
end
Ptest = Data(x,18); tempData = Data(x,14:17);
HEMJ(x,1:18) = [Data(x,1:13) Ptest tempData];
HEMJ(x,19)=99000;
HEMJ(x,20)=0;
save E040715 E040715
save LoopData HEMJ
end
%% Helium Loop 4_10_2015 10_47_41
% Steady-State Experiment - WL10
% One SS Experiment - 8.0 g/s, Ti=100, 5.2 MW/m^2, 1.5mm
% 0.75 scan/second 
for m=1:0
clear; load LoopData; 
x = 384;    % Case number
A041015=xlsread('Helium Loop 4_10_2015 10_47_41.csv', 1, 'C33:Y20000');
file = A041015;
for i=1:18
    Data(x,i)=mean(file(752:952,i));
end
Ptest = Data(x,18); tempData = Data(x,14:17);
HEMJ(x,1:18) = [Data(x,1:13) Ptest tempData];
HEMJ(x,19)=99000;
HEMJ(x,20)=0;
save A041015 A041015
save LoopData HEMJ
end
%% Helium Loop 4_10_2015 11_02_00
% Steady-State Experiment - WL10
% One SS Experiment - 7.0 g/s, Ti=100, 5.2 MW/m^2, 1.5mm
% 0.75 scan/second 
for m=1:0
clear; load LoopData; 
x = 385;    % Case number
B041015=xlsread('Helium Loop 4_10_2015 11_02_00.csv', 1, 'C33:Y20000');
file = B041015;
for i=1:18
    Data(x,i)=mean(file(959:1159,i));
end
Ptest = Data(x,18); tempData = Data(x,14:17);
HEMJ(x,1:18) = [Data(x,1:13) Ptest tempData];
HEMJ(x,19)=99000;
HEMJ(x,20)=0;
save B041015 B041015
save LoopData HEMJ
end
%% Helium Loop 4_10_2015 11_19_22
% Steady-State Experiment - WL10
% One SS Experiment - 6.0 g/s, Ti=100, 5.2 MW/m^2, 1.5mm
% 0.75 scan/second 
for m=1:0
clear; load LoopData; 
x = 386;    % Case number
C041015=xlsread('Helium Loop 4_10_2015 11_19_22.csv', 1, 'C33:Y20000');
file = C041015;
for i=1:18
    Data(x,i)=mean(file(754:954,i));
end
Ptest = Data(x,18); tempData = Data(x,14:17);
HEMJ(x,1:18) = [Data(x,1:13) Ptest tempData];
HEMJ(x,19)=99000;
HEMJ(x,20)=0;
save C041015 C041015
save LoopData HEMJ
end
%% Helium Loop 4_10_2015 11_33_44
% Steady-State Experiment - WL10
% One SS Experiment - 5.0 g/s, Ti=100, 5.2 MW/m^2, 1.5mm
% 0.75 scan/second 
for m=1:0
clear; load LoopData; 
x = 387;    % Case number
D041015=xlsread('Helium Loop 4_10_2015 11_33_44.csv', 1, 'C33:Y20000');
file = D041015;
for i=1:18
    Data(x,i)=mean(file(737:937,i));
end
Ptest = Data(x,18); tempData = Data(x,14:17);
HEMJ(x,1:18) = [Data(x,1:13) Ptest tempData];
HEMJ(x,19)=99000;
HEMJ(x,20)=0;
save D041015 D041015
save LoopData HEMJ
end
%% Helium Loop 4_13_2015 10_22_06
% Steady-State Experiment - WL10
% One SS Experiment - 3.5 g/s, Ti=27, 4.75 MW/m^2, 1.5mm
% 0.75 scan/second 
for m=1:0
clear; load LoopData; 
x = 388;    % Case number
A041315=xlsread('Helium Loop 4_13_2015 10_22_06.csv', 1, 'C33:Y20000');
file = A041315;
for i=1:18
    Data(x,i)=mean(file(1573:1773,i));
end
Ptest = Data(x,18); tempData = Data(x,14:17);
HEMJ(x,1:18) = [Data(x,1:13) Ptest tempData];
HEMJ(x,19)=99000;
HEMJ(x,20)=0;
save A041315 A041315
save LoopData HEMJ
end
%% Helium Loop 4_13_2015 10_48_25
% Steady-State Experiment - WL10
% One SS Experiment - 4.0 g/s, Ti=27, 4.75 MW/m^2, 1.5mm
% 0.75 scan/second 
for m=1:0
clear; load LoopData; 
x = 389;    % Case number
B041315=xlsread('Helium Loop 4_13_2015 10_48_25.csv', 1, 'C33:Y20000');
file = B041315;
for i=1:18
    Data(x,i)=mean(file(400:560,i));
end
Ptest = Data(x,18); tempData = Data(x,14:17);
HEMJ(x,1:18) = [Data(x,1:13) Ptest tempData];
HEMJ(x,19)=99000;
HEMJ(x,20)=0;
save B041315 B041315
save LoopData HEMJ
end
%% Helium Loop 4_13_2015 10_58_14                                           Case 390
% Steady-State Experiment - WL10
% One SS Experiment - 4.5 g/s, Ti=27, 4.75 MW/m^2, 1.5mm
% 0.75 scan/second 
for m=1:0
clear; load LoopData; 
x = 390;    % Case number
C041315=xlsread('Helium Loop 4_13_2015 10_58_14.csv', 1, 'C33:Y20000');
file = C041315;
for i=1:18
    Data(x,i)=mean(file(175:625,i));
end
Ptest = Data(x,18); tempData = Data(x,14:17);
HEMJ(x,1:18) = [Data(x,1:13) Ptest tempData];
HEMJ(x,19)=99000;
HEMJ(x,20)=0;
save C041315 C041315
save LoopData HEMJ
end
%% Helium Loop 4_13_2015 11_07_51
% Steady-State Experiment - WL10
% One SS Experiment - 5.0 g/s, Ti=27, 4.75 MW/m^2, 1.5mm
% 0.75 scan/second 
for m=1:0
clear; load LoopData; 
x = 391;    % Case number
D041315=xlsread('Helium Loop 4_13_2015 11_07_51.csv', 1, 'C33:Y20000');
file = D041315;
for i=1:18
    Data(x,i)=mean(file(872:1072,i));
end
Ptest = Data(x,18); tempData = Data(x,14:17);
HEMJ(x,1:18) = [Data(x,1:13) Ptest tempData];
HEMJ(x,19)=99000;
HEMJ(x,20)=0;
save D041315 D041315
save LoopData HEMJ
end
%% Helium Loop 4_13_2015 11_23_58
% Steady-State Experiment - WL10
% One SS Experiment - 6.0 g/s, Ti=27, 4.75 MW/m^2, 1.5mm
% 0.75 scan/second 
for m=1:0
clear; load LoopData; 
x = 392;    % Case number
E041315=xlsread('Helium Loop 4_13_2015 11_23_58.csv', 1, 'C33:Y20000');
file = E041315;
for i=1:18
    Data(x,i)=mean(file(375:575,i));
end
Ptest = Data(x,18); tempData = Data(x,14:17);
HEMJ(x,1:18) = [Data(x,1:13) Ptest tempData];
HEMJ(x,19)=99000;
HEMJ(x,20)=0;
save E041315 E041315
save LoopData HEMJ
end
%% Helium Loop 4_13_2015 11_32_52
% Steady-State Experiment - WL10
% One SS Experiment - 7.0 g/s, Ti=27, 4.75 MW/m^2, 1.5mm
% 0.75 scan/second 
for m=1:0
clear; load LoopData; 
x = 393;    % Case number
F041315=xlsread('Helium Loop 4_13_2015 11_32_52.csv', 1, 'C33:Y20000');
file = F041315;
for i=1:18
    Data(x,i)=mean(file(377:577,i));
end
Ptest = Data(x,18); tempData = Data(x,14:17);
HEMJ(x,1:18) = [Data(x,1:13) Ptest tempData];
HEMJ(x,19)=99000;
HEMJ(x,20)=0;
save F041315 F041315
save LoopData HEMJ
end
%% Helium Loop 4_13_2015 11_41_48
% Steady-State Experiment - WL10
% One SS Experiment - 8.0 g/s, Ti=27, 4.75 MW/m^2, 1.5mm
% 0.75 scan/second 
for m=1:0
clear; load LoopData; 
x = 394;    % Case number
G041315=xlsread('Helium Loop 4_13_2015 11_41_48.csv', 1, 'C33:Y20000');
file = G041315;
for i=1:18
    Data(x,i)=mean(file(171:371,i));
end
Ptest = Data(x,18); tempData = Data(x,14:17);
HEMJ(x,1:18) = [Data(x,1:13) Ptest tempData];
HEMJ(x,19)=99000;
HEMJ(x,20)=0;
save G041315 G041315
save LoopData HEMJ
end
%% Helium Loop 5_11_2015 16_08_52
% Steady-State Experiment - WL10
% One SS Experiment - 3.0 g/s, Ti=200, 5.2 MW/m^2, 1.5mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 395;    % Case number
A051115=xlsread('Helium Loop 5_11_2015 16_08_52.csv', 1, 'C33:Y20000');
file = A051115;
for i=1:18
    Data(x,i)=mean(file(656:856,i));
end
Ptest = Data(x,18); tempData = Data(x,14:17);
HEMJ(x,1:18) = [Data(x,1:13) Ptest tempData];
HEMJ(x,19)=99000;
HEMJ(x,20)=0;
save A051115 A051115
save LoopData HEMJ
end
%% Helium Loop 5_11_2015 16_21_51
% Steady-State Experiment - WL10
% One SS Experiment - 4.0 g/s, Ti=200, 5.2 MW/m^2, 1.5mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 396;    % Case number
B051115=xlsread('Helium Loop 5_11_2015 16_21_51.csv', 1, 'C33:Y20000');
file = B051115;
for i=1:18
    Data(x,i)=mean(file(933:1133,i));
end
Ptest = Data(x,18); tempData = Data(x,14:17);
HEMJ(x,1:18) = [Data(x,1:13) Ptest tempData];
HEMJ(x,19)=99000;
HEMJ(x,20)=0;
save B051115 B051115
save LoopData HEMJ
end
%% Helium Loop 5_11_2015 16_38_52
% Steady-State Experiment - WL10
% One SS Experiment - 5.0 g/s, Ti=200, 5.2 MW/m^2, 1.5mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 397;    % Case number
C051115=xlsread('Helium Loop 5_11_2015 16_38_52.csv', 1, 'C33:Y20000');
file = C051115;
for i=1:18
    Data(x,i)=mean(file(1503:1703,i));
end
Ptest = Data(x,18); tempData = Data(x,14:17);
HEMJ(x,1:18) = [Data(x,1:13) Ptest tempData];
HEMJ(x,19)=99000;
HEMJ(x,20)=0;
save C051115 C051115
save LoopData HEMJ
end
%% Helium Loop 5_11_2015 17_04_06
% Steady-State Experiment - WL10
% One SS Experiment - 6.0 g/s, Ti=200, 5.2 MW/m^2, 1.5mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 398;    % Case number
D051115=xlsread('Helium Loop 5_11_2015 17_04_06.csv', 1, 'C33:Y20000');
file = D051115;
for i=1:18
    Data(x,i)=mean(file(1059:1259,i));
end
Ptest = Data(x,18); tempData = Data(x,14:17);
HEMJ(x,1:18) = [Data(x,1:13) Ptest tempData];
HEMJ(x,19)=99000;
HEMJ(x,20)=0;
save D051115 D051115
save LoopData HEMJ
end
%% Helium Loop 5_11_2015 17_22_59
% Steady-State Experiment - WL10
% One SS Experiment - 7.0 g/s, Ti=200, 5.2 MW/m^2, 1.5mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 399;    % Case number
E051115=xlsread('Helium Loop 5_11_2015 17_22_59.csv', 1, 'C33:Y20000');
file = E051115;
for i=1:18
    Data(x,i)=mean(file(396:596,i));
end
Ptest = Data(x,18); tempData = Data(x,14:17);
HEMJ(x,1:18) = [Data(x,1:13) Ptest tempData];
HEMJ(x,19)=99000;
HEMJ(x,20)=0;
save E051115 E051115
save LoopData HEMJ
end
%% Helium Loop 5_11_2015 17_32_09                                           Case 400
% Steady-State Experiment - WL10
% One SS Experiment - 8.0 g/s, Ti=200, 5.2 MW/m^2, 1.5mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 400;    % Case number
F051115=xlsread('Helium Loop 5_11_2015 17_32_09.csv', 1, 'C33:Y20000');
file = F051115;
for i=1:18
    Data(x,i)=mean(file(1109:1309,i));
end
Ptest = Data(x,18); tempData = Data(x,14:17);
HEMJ(x,1:18) = [Data(x,1:13) Ptest tempData];
HEMJ(x,19)=99000;
HEMJ(x,20)=0;
save F051115 F051115
save LoopData HEMJ
end
%% Helium Loop 6_10_2015 12_29_15                                        
% Steady-State Experiment - WL10 - Repeats for Compressor Diagnosis
% One SS Experiment - 8.0 g/s, Ti=200, 4.0 MW/m^2, 1.5mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 401;    % Case number
A061015=xlsread('Helium Loop 6_10_2015 12_29_15.csv', 1, 'C33:Y20000');
file = A061015;
for i=1:18
    Data(x,i)=mean(file(130:295,i));
end
Ptest = Data(x,18); tempData = Data(x,14:17);
HEMJ(x,1:18) = [Data(x,1:13) Ptest tempData];
HEMJ(x,19)=99000;
HEMJ(x,20)=0;
save A061015 A061015
save LoopData HEMJ
end
%% Helium Loop 6_10_2015 12_34_07                                          
% Steady-State Experiment - WL10 - Repeats for Compressor Diagnosis
% One SS Experiment - 7.0 g/s, Ti=200, 4.0 MW/m^2, 1.5mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 402;    % Case number
B061015=xlsread('Helium Loop 6_10_2015 12_34_07.csv', 1, 'C33:Y20000');
file = B061015;
for i=1:18
    Data(x,i)=mean(file(1533:1733,i));
end
Ptest = Data(x,18); tempData = Data(x,14:17);
HEMJ(x,1:18) = [Data(x,1:13) Ptest tempData];
HEMJ(x,19)=99000;
HEMJ(x,20)=0;
save B061015 B061015
save LoopData HEMJ
end
%% Helium Loop 6_10_2015 12_59_45                                          
% Steady-State Experiment - WL10 - Repeats for Compressor Diagnosis
% One SS Experiment - 6.0 g/s, Ti=200, 4.0 MW/m^2, 1.5mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 403;    % Case number
C061015=xlsread('Helium Loop 6_10_2015 12_59_45.csv', 1, 'C33:Y20000');
file = C061015;
for i=1:18
    Data(x,i)=mean(file(456:583,i));
end
Ptest = Data(x,18); tempData = Data(x,14:17);
HEMJ(x,1:18) = [Data(x,1:13) Ptest tempData];
HEMJ(x,19)=99000;
HEMJ(x,20)=0;
save C061015 C061015
save LoopData HEMJ
end
%% Helium Loop 6_10_2015 13_08_46                                          
% Steady-State Experiment - WL10 - Repeats for Compressor Diagnosis
% One SS Experiment - 5.0 g/s, Ti=200, 3.7 MW/m^2, 1.5mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 404;    % Case number
D061015=xlsread('Helium Loop 6_10_2015 13_08_46.csv', 1, 'C33:Y20000');
file = D061015;
for i=1:18
    Data(x,i)=mean(file(477:677,i));
end
Ptest = Data(x,18); tempData = Data(x,14:17);
HEMJ(x,1:18) = [Data(x,1:13) Ptest tempData];
HEMJ(x,19)=99000;
HEMJ(x,20)=0;
save D061015 D061015
save LoopData HEMJ
end
%% Helium Loop 6_10_2015 13_19_09                                          
% Steady-State Experiment - WL10 - Repeats for Compressor Diagnosis
% One SS Experiment - 4.0 g/s, Ti=200, 3.5 MW/m^2, 1.5mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 405;    % Case number
E061015=xlsread('Helium Loop 6_10_2015 13_19_09.csv', 1, 'C33:Y20000');
file = E061015;
for i=1:18
    Data(x,i)=mean(file(825:1025,i));
end
Ptest = Data(x,18); tempData = Data(x,14:17);
HEMJ(x,1:18) = [Data(x,1:13) Ptest tempData];
HEMJ(x,19)=99000;
HEMJ(x,20)=0;
save E061015 E061015
save LoopData HEMJ
end
%% Helium Loop 6_10_2015 13_39_24                                          
% Steady-State Experiment - WL10 - Repeats for Compressor Diagnosis
% One SS Experiment - 3.5 g/s, Ti=200, 3.5 MW/m^2, 1.5mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 406;    % Case number
F061015=xlsread('Helium Loop 6_10_2015 13_39_24.csv', 1, 'C33:Y20000');
file = F061015;
for i=1:18
    Data(x,i)=mean(file(514:674,i));
end
Ptest = Data(x,18); tempData = Data(x,14:17);
HEMJ(x,1:18) = [Data(x,1:13) Ptest tempData];
HEMJ(x,19)=99000;
HEMJ(x,20)=0;
save F061015 F061015
save LoopData HEMJ
end
%% Helium Loop 6_12_2015 14_38_31                                          
% Steady-State Experiment - WL10
% One SS Experiment - 5.0 g/s, Ti=300, 2.2 MW/m^2, 1.5mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 407;    % Case number
A061215=xlsread('Helium Loop 6_12_2015 14_38_31.csv', 1, 'C33:Y20000');
file = A061215;
for i=1:18
    Data(x,i)=mean(file(287:487,i));
end
Ptest = Data(x,18); tempData = Data(x,14:17);
HEMJ(x,1:18) = [Data(x,1:13) Ptest tempData];
HEMJ(x,19)=99000;
HEMJ(x,20)=0;
save A061215 A061215
save LoopData HEMJ
end
%% Helium Loop 6_12_2015 14_46_26                                          
% Steady-State Experiment - WL10
% One SS Experiment - 4.0 g/s, Ti=300, 2.3 MW/m^2, 1.5mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 408;    % Case number
B061215=xlsread('Helium Loop 6_12_2015 14_46_26.csv', 1, 'C33:Y20000');
file = B061215;
for i=1:18
    Data(x,i)=mean(file(550:750,i));
end
Ptest = Data(x,18); tempData = Data(x,14:17);
HEMJ(x,1:18) = [Data(x,1:13) Ptest tempData];
HEMJ(x,19)=99000;
HEMJ(x,20)=0;
save B061215 B061215
save LoopData HEMJ
end
%% Helium Loop 6_12_2015 14_58_06                                          
% Steady-State Experiment - WL10
% One SS Experiment - 3.3 g/s, Ti=300, 3.0 MW/m^2, 1.5mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 409;    % Case number
C061215=xlsread('Helium Loop 6_12_2015 14_58_06.csv', 1, 'C33:Y20000');
file = C061215;
for i=1:18
    Data(x,i)=mean(file(2100:2220,i));
end
Ptest = Data(x,18); tempData = Data(x,14:17);
HEMJ(x,1:18) = [Data(x,1:13) Ptest tempData];
HEMJ(x,19)=99000;
HEMJ(x,20)=0;
save C061215 C061215
save LoopData HEMJ
end
%% Helium Loop 6_12_2015 15_31_01                                          % Case 410
% Steady-State Experiment - WL10
% One SS Experiment - 6.2 g/s, Ti=300, 2.5 MW/m^2, 1.5mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 410;    % Case number
D061215=xlsread('Helium Loop 6_12_2015 15_31_01.csv', 1, 'C33:Y20000');
file = D061215;
for i=1:18
    Data(x,i)=mean(file(1360:1560,i));
end
Ptest = Data(x,18); tempData = Data(x,14:17);
HEMJ(x,1:18) = [Data(x,1:13) Ptest tempData];
HEMJ(x,19)=99000;
HEMJ(x,20)=0;
save D061215 D061215
save LoopData HEMJ
end
%% Helium Loop 6_12_2015 15_54_24 - 411                                           
% Steady-State Experiment - WL10
% One SS Experiment - 6.6 g/s, Ti=300, 2.4 MW/m^2, 1.5mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 411;    % Case number
E061215=xlsread('Helium Loop 6_12_2015 15_54_24.csv', 1, 'C33:Y20000');
file = E061215;
for i=1:18
    Data(x,i)=mean(file(469:669,i));
end
Ptest = Data(x,18); tempData = Data(x,14:17);
HEMJ(x,1:18) = [Data(x,1:13) Ptest tempData];
HEMJ(x,19)=99000;
HEMJ(x,20)=0;
save E061215 E061215
save LoopData HEMJ
end
%% Helium Loop 11_9_2015 16_28_12 - 412                                           
% Steady-State Experiment - WL10 New (2015)
% One SS Experiment - 8.0 g/s, Ti=27, 3 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 412;    % Case number
A110915=xlsread('Helium Loop 11_9_2015 16_28_12.csv', 1, 'C30:V20000');
file = A110915;
for i=1:18
    Data(1,i)=mean(file(2850:3080,i));
end
Ptest = Data(1,15); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,14)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save A110915 A110915
save LoopData HEMJ
end
%% Helium Loop 11_9_2015 17_08_01 - 413                                           
% Steady-State Experiment - WL10 New (2015)
% One SS Experiment - 7.2 g/s, Ti=27, 1.8 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 413;    % Case number
B110915=xlsread('Helium Loop 11_9_2015 17_08_01.csv', 1, 'C30:V20000');
file = B110915;
for i=1:18
    Data(1,i)=mean(file(2127:2293,i));
end
Ptest = Data(1,15); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,14)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save B110915 B110915
save LoopData HEMJ
end
%% Helium Loop 11_9_2015 17_37_23 - 414                                           
% Steady-State Experiment - WL10 New (2015)
% One SS Experiment - 5.0 g/s, Ti=27, 1.8 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 414;    % Case number
C110915=xlsread('Helium Loop 11_9_2015 17_37_23.csv', 1, 'C30:V20000');
file = C110915;
for i=1:18
    Data(1,i)=mean(file(681:881,i));
end
Ptest = Data(1,15); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,14)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save C110915 C110915
save LoopData HEMJ
end
%% Helium Loop 11_9_2015 17_49_00 - 415                                           
% Steady-State Experiment - WL10 New (2015)
% One SS Experiment - 3.1 g/s, Ti=27, 1.5 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 415;    % Case number
D110915=xlsread('Helium Loop 11_9_2015 17_49_00.csv', 1, 'C30:V20000');
file = D110915;
for i=1:18
    Data(1,i)=mean(file(400:585,i));
end
Ptest = Data(1,15); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,14)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save D110915 D110915
save LoopData HEMJ
end
%% Helium Loop 11_10_2015 09_36_13 - 416                                           
% Steady-State Experiment - WL10 New (2015)
% One SS Experiment - 3.0 g/s, Ti=100, 2.2 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 416;    % Case number
A111015=xlsread('Helium Loop 11_10_2015 09_36_13.csv', 1, 'C30:V20000');
file = A111015;
for i=1:18
    Data(1,i)=mean(file(618:818,i));
end
Ptest = Data(1,15); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,14)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save A111015 A111015
save LoopData HEMJ
end
%% Helium Loop 11_10_2015 09_47_03 - 417                                           
% Steady-State Experiment - WL10 New (2015)
% One SS Experiment - 4.0 g/s, Ti=100, 2.2 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 417;    % Case number
B111015=xlsread('Helium Loop 11_10_2015 09_47_03.csv', 1, 'C30:V20000');
file = B111015;
for i=1:18
    Data(1,i)=mean(file(1211:1411,i));
end
Ptest = Data(1,15); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,14)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save B111015 B111015
save LoopData HEMJ
end
%% Helium Loop 11_10_2015 10_05_24 - 418                                           
% Steady-State Experiment - WL10 New (2015)
% One SS Experiment - 5.0 g/s, Ti=100, 2.2 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 418;    % Case number
C111015=xlsread('Helium Loop 11_10_2015 10_05_24.csv', 1, 'C30:V20000');
file = C111015;
for i=1:18
    Data(1,i)=mean(file(540:740,i));
end
Ptest = Data(1,15); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,14)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save C111015 C111015
save LoopData HEMJ
end
%% Helium Loop 11_10_2015 10_15_17 - 419                                           
% Steady-State Experiment - WL10 New (2015)
% One SS Experiment - 6.0 g/s, Ti=100, 2.2 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 419;    % Case number
D111015=xlsread('Helium Loop 11_10_2015 10_15_17.csv', 1, 'C30:V20000');
file = D111015;
for i=1:18
    Data(1,i)=mean(file(555:755,i));
end
Ptest = Data(1,15); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,14)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save D111015 D111015
save LoopData HEMJ
end
%% Helium Loop 11_10_2015 10_25_20 -                                       % Case 420                                           
% Steady-State Experiment - WL10 New (2015)
% One SS Experiment - 7.0 g/s, Ti=100, 2.2 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 420;    % Case number
E111015=xlsread('Helium Loop 11_10_2015 10_25_20.csv', 1, 'C30:V20000');
file = E111015;
for i=1:18
    Data(1,i)=mean(file(373:573,i));
end
Ptest = Data(1,15); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,14)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save E111015 E111015
save LoopData HEMJ
end
%% Helium Loop 11_10_2015 10_33_08 - 421                                           
% Steady-State Experiment - WL10 New (2015)
% One SS Experiment - 8.0 g/s, Ti=100, 2.2 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 421;    % Case number
F111015=xlsread('Helium Loop 11_10_2015 10_33_08.csv', 1, 'C30:V20000');
file = F111015;
for i=1:18
    Data(1,i)=mean(file(453:653,i));
end
Ptest = Data(1,15); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,14)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save F111015 F111015
save LoopData HEMJ
end
%% Helium Loop 12_9_2015 16_19_52 - 422                                           
% Steady-State Experiment - WL10 New (2015)
% One SS Experiment - 3.0 g/s, Ti=200, 5.7 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 422;    % Case number
A120915=xlsread('Helium Loop 12_9_2015 16_19_52.csv', 1, 'C30:W20000');
file = A120915;
for i=1:18
    Data(1,i)=mean(file(700:900,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save A120915 A120915
save LoopData HEMJ
end
%% Helium Loop 12_9_2015 16_33_54 - 423                                           
% Steady-State Experiment - WL10 New (2015)
% One SS Experiment - 4.0 g/s, Ti=200, 5.7 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 423;    % Case number
B120915=xlsread('Helium Loop 12_9_2015 16_33_54.csv', 1, 'C30:W20000');
file = B120915;
for i=1:18
    Data(1,i)=mean(file(1426:1626,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save B120915 B120915
save LoopData HEMJ
end
%% Helium Loop 12_9_2015 16_55_24 - 424                                           
% Steady-State Experiment - WL10 New (2015)
% One SS Experiment - 5.0 g/s, Ti=200, 5.7 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 424;    % Case number
C120915=xlsread('Helium Loop 12_9_2015 16_55_24.csv', 1, 'C30:W20000');
file = C120915;
for i=1:18
    Data(1,i)=mean(file(1223:1523,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save C120915 C120915
save LoopData HEMJ
end
%% Helium Loop 12_9_2015 17_17_12 - 425                                           
% Steady-State Experiment - WL10 New (2015)
% One SS Experiment - 6.0 g/s, Ti=200, 5.7 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 425;    % Case number
D120915=xlsread('Helium Loop 12_9_2015 17_17_12.csv', 1, 'C30:W20000');
file = D120915;
for i=1:18
    Data(1,i)=mean(file(806:926,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save D120915 D120915
save LoopData HEMJ
end
%% Helium Loop 12_9_2015 17_31_19 - 426                                           
% Steady-State Experiment - WL10 New (2015)
% One SS Experiment - 6.7 g/s, Ti=200, 5.7 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 426;    % Case number
E120915=xlsread('Helium Loop 12_9_2015 17_31_19.csv', 1, 'C30:W20000');
file = E120915;
for i=1:18
    Data(1,i)=mean(file(1742:1942,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save E120915 E120915
save LoopData HEMJ
end
%% Helium Loop 12_9_2015 17_58_05 - 427                                           
% Steady-State Experiment - WL10 New (2015)
% One SS Experiment - 8.0 g/s, Ti=200, 5.0 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 427;    % Case number
F120915=xlsread('Helium Loop 12_9_2015 17_58_05.csv', 1, 'C30:W20000');
file = F120915;
for i=1:18
    Data(1,i)=mean(file(933:1133,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save F120915 F120915
save LoopData HEMJ
end
%% Helium Loop 12_10_2015 10_47_30 - 428                                           
% Steady-State Experiment - WL10 New (2015)
% One SS Experiment - 5.0 g/s, Ti=300, 4.9 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 428;    % Case number
A121015=xlsread('Helium Loop 12_10_2015 10_47_30.csv', 1, 'C30:W20000');
file = A121015;
for i=1:18
    Data(1,i)=mean(file(2324:2524,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save A121015 A121015
save LoopData HEMJ
end
%% Helium Loop 12_10_2015 11_20_34 - 429                                           
% Steady-State Experiment - WL10 New (2015)
% One SS Experiment - 4.0 g/s, Ti=300, 5.0 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 429;    % Case number
B121015=xlsread('Helium Loop 12_10_2015 11_20_34.csv', 1, 'C30:W20000');
file = B121015;
for i=1:18
    Data(1,i)=mean(file(825:1025,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save B121015 B121015
save LoopData HEMJ
end
%% Helium Loop 12_10_2015 11_34_18 -                                       % Case 430                                           
% Steady-State Experiment - WL10 New (2015)
% One SS Experiment - 3.0 g/s, Ti=300, 5.0 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 430;    % Case number
C121015=xlsread('Helium Loop 12_10_2015 11_34_18.csv', 1, 'C30:W20000');
file = C121015;
for i=1:18
    Data(1,i)=mean(file(1159:1359,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save C121015 C121015
save LoopData HEMJ
end
%% Helium Loop 12_10_2015 11_52_20 - 431                                           
% Steady-State Experiment - WL10 New (2015)
% One SS Experiment - 6.0 g/s, Ti=300, 5.0 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 431;    % Case number
D121015=xlsread('Helium Loop 12_10_2015 11_52_20.csv', 1, 'C30:W20000');
file = D121015;
for i=1:18
    Data(1,i)=mean(file(1060:1260,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save D121015 D121015
save LoopData HEMJ
end
%% Helium Loop 12_10_2015 12_09_12 - 432                                           
% Steady-State Experiment - WL10 New (2015)
% One SS Experiment - 7.0 g/s, Ti=300, 5.0 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 432;    % Case number
E121015=xlsread('Helium Loop 12_10_2015 12_09_12.csv', 1, 'C30:W20000');
file = E121015;
for i=1:18
    Data(1,i)=mean(file(775:975,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save E121015 E121015
save LoopData HEMJ
end
%% Helium Loop 12_10_2015 12_22_18 - 433                                           
% Steady-State Experiment - WL10 New (2015)
% One SS Experiment - 8.0 g/s, Ti=300, 5.0 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 433;    % Case number
F121015=xlsread('Helium Loop 12_10_2015 12_22_18.csv', 1, 'C30:W20000');
file = F121015;
for i=1:18
    Data(1,i)=mean(file(1686:1886,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save F121015 F121015
save LoopData HEMJ
end
%% Helium Loop 12_11_2015 09_53_03 - 434                                           
% Steady-State Experiment - WL10 New (2015)
% One SS Experiment - 4.5 g/s, Ti=100, 4.7 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 434;    % Case number
A121115=xlsread('Helium Loop 12_11_2015 09_53_03.csv', 1, 'C30:W20000');
file = A121115;
for i=1:18
    Data(1,i)=mean(file(375:575,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save A121115 A121115
save LoopData HEMJ
end
%% Helium Loop 12_11_2015 10_01_30 - 435                                           
% Steady-State Experiment - WL10 New (2015)
% One SS Experiment - 5.3 g/s, Ti=100, 4.7 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 435;    % Case number
B121115=xlsread('Helium Loop 12_11_2015 10_01_30.csv', 1, 'C30:W20000');
file = B121115;
for i=1:18
    Data(1,i)=mean(file(1957:2157,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save B121115 B121115
save LoopData HEMJ
end
%% Helium Loop 12_11_2015 10_29_54 - 436                                     
% Steady-State Experiment - WL10 New (2015)
% One SS Experiment - 6.2 g/s, Ti=100, 4.7 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 436;    % Case number
C121115=xlsread('Helium Loop 12_11_2015 10_29_54.csv', 1, 'C30:W20000');
file = C121115;
for i=1:18
    Data(1,i)=mean(file([1130:1180,1187:1223,1232:1283,1292:1367],i));   
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save C121115 C121115
save LoopData HEMJ
end
%% Helium Loop 12_11_2015 10_49_30 - 437                                           
% Steady-State Experiment - WL10 New (2015)
% One SS Experiment - 7.5 g/s, Ti=100, 4.7 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 437;    % Case number
D121115=xlsread('Helium Loop 12_11_2015 10_49_30.csv', 1, 'C30:W20000');
file = D121115;
for i=1:18
    Data(1,i)=mean(file(625:825,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save D121115 D121115
save LoopData HEMJ
end
%% Helium Loop 12_11_2015 11_01_02 - 438                                           
% Steady-State Experiment - WL10 New (2015)
% One SS Experiment - 8.1 g/s, Ti=100, 4.7 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 438;    % Case number
E121115=xlsread('Helium Loop 12_11_2015 11_01_02.csv', 1, 'C30:W20000');
file = E121115;
for i=1:18
    Data(1,i)=mean(file(1700:1900,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save E121115 E121115
save LoopData HEMJ
end
%% Helium Loop 12_11_2015 11_26_10 - 439                                           
% Steady-State Experiment - WL10 New (2015)
% One SS Experiment - 3.5 g/s, Ti=100, 4.5 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 439;    % Case number
F121115=xlsread('Helium Loop 12_11_2015 11_26_10.csv', 1, 'C30:W20000');
file = F121115;
for i=1:18
    Data(1,i)=mean(file(2780:2829,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save F121115 F121115
save LoopData HEMJ
end
%% Helium Loop 12_11_2015 12_18_01 -                                       % Case 440                                           
% Steady-State Experiment - WL10 New (2015)
% One SS Experiment - 4.5 g/s, Ti=28, 4.5 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 440;    % Case number
G121115=xlsread('Helium Loop 12_11_2015 12_18_01.csv', 1, 'C30:W20000');
file = G121115;
for i=1:18
    Data(1,i)=mean(file(959:1159,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save G121115 G121115
save LoopData HEMJ
end
%% Helium Loop 12_11_2015 12_33_28 - 441                                       
% Steady-State Experiment - WL10 New (2015)
% One SS Experiment - 5.5 g/s, Ti=28, 4.5 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 441;    % Case number
H121115=xlsread('Helium Loop 12_11_2015 12_33_28.csv', 1, 'C30:W20000');
file = H121115;
for i=1:18
    Data(1,i)=mean(file(375:575,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save H121115 H121115
save LoopData HEMJ
end
%% Helium Loop 12_11_2015 12_45_58 - 442                                       
% Steady-State Experiment - WL10 New (2015)
% One SS Experiment - 6.5 g/s, Ti=28, 4.5 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 442;    % Case number
I121115=xlsread('Helium Loop 12_11_2015 12_45_58.csv', 1, 'C30:W20000');
file = I121115;
for i=1:18
    Data(1,i)=mean(file(804:1004,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save I121115 I121115
save LoopData HEMJ
end
%% Helium Loop 12_11_2015 12_59_27 - 443                                       
% Steady-State Experiment - WL10 New (2015)
% One SS Experiment - 7.5 g/s, Ti=28, 4.5 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 443;    % Case number
J121115=xlsread('Helium Loop 12_11_2015 12_59_27.csv', 1, 'C30:W20000');
file = J121115;
for i=1:18
    Data(1,i)=mean(file(337:537,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save J121115 J121115
save LoopData HEMJ
end
%% Helium Loop 12_11_2015 13_06_56 - 444                                       
% Steady-State Experiment - WL10 New (2015)
% One SS Experiment - 8.5 g/s, Ti=28, 4.5 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 444;    % Case number
K121115=xlsread('Helium Loop 12_11_2015 13_06_56.csv', 1, 'C30:W20000');
file = K121115;
for i=1:18
    Data(1,i)=mean(file(234:434,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save K121115 K121115
save LoopData HEMJ
end
%% Helium Loop 12_16_2015 10_52_00 - 445                                       
% Steady-State Experiment - WL10 New (2015)
% One SS Experiment - 5.0 g/s, Ti=400, 3.0 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 445;    % Case number
A121615=xlsread('Helium Loop 12_16_2015 10_52_00.csv', 1, 'C30:W20000');
file = A121615;
for i=1:18
    Data(1,i)=mean(file(1385:1585,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save A121615 A121615
save LoopData HEMJ
end
%% Helium Loop 12_16_2015 11_12_57 - 446                                       
% Steady-State Experiment - WL10 New (2015)
% One SS Experiment - 4.1 g/s, Ti=400, 3.0 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 446;    % Case number
B121615=xlsread('Helium Loop 12_16_2015 11_12_57.csv', 1, 'C30:W20000');
file = B121615;
for i=1:18
    Data(1,i)=mean(file(1782:1982,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save B121615 B121615
save LoopData HEMJ
end
%% Helium Loop 12_16_2015 11_39_01 - 447                                       
% Steady-State Experiment - WL10 New (2015)
% One SS Experiment - 3.2 g/s, Ti=400, 3.0 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 447;    % Case number
C121615=xlsread('Helium Loop 12_16_2015 11_39_01.csv', 1, 'C30:W20000');
file = C121615;
for i=1:18
    Data(1,i)=mean(file(2454:2654,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save C121615 C121615
save LoopData HEMJ
end
%% Helium Loop 12_16_2015 12_13_41 - 448                                       
% Steady-State Experiment - WL10 New (2015)
% One SS Experiment - 6.0 g/s, Ti=400, 3.0 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 448;    % Case number
D121615=xlsread('Helium Loop 12_16_2015 12_13_41.csv', 1, 'C30:W20000');
file = D121615;
for i=1:18
    Data(1,i)=mean(file(1857:2057,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save D121615 D121615
save LoopData HEMJ
end
%% Helium Loop 12_16_2015 12_40_45 - 449                                       
% Steady-State Experiment - WL10 New (2015)
% One SS Experiment - 7.0 g/s, Ti=400, 3.0 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 449;    % Case number
E121615=xlsread('Helium Loop 12_16_2015 12_40_45.csv', 1, 'C30:W20000');
file = E121615;
for i=1:18
    Data(1,i)=mean(file(2800:3040,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save E121615 E121615
save LoopData HEMJ
end
%% Helium Loop 12_16_2015 13_20_25 -                                       % Case 450                                       
% Steady-State Experiment - WL10 New (2015)
% One SS Experiment - 8.1 g/s, Ti=400, 3.0 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 450;    % Case number
F121615=xlsread('Helium Loop 12_16_2015 13_20_25.csv', 1, 'C30:W20000');
file = F121615;
for i=1:18
    Data(1,i)=mean(file(1664:1790,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save F121615 F121615
save LoopData HEMJ
end
%% Helium Loop 12_17_2015 11_09_04 - 451
% Steady-State Experiment - WL10 New (2015)
% One SS Experiment - 5.0 g/s, Ti=27, 3.0 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 451;    % Case number
A121715=xlsread('Helium Loop 12_17_2015 11_09_04.csv', 1, 'C30:W20000');
file = A121715;
for i=1:18
    Data(1,i)=mean(file(6025:6225,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save A121715 A121715
save LoopData HEMJ
end
%% Helium Loop 12_17_2015 12_29_45 - 452
% Steady-State Experiment - WL10 New (2015)
% One SS Experiment - 4.0 g/s, Ti=27, 3.0 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 452;    % Case number
B121715=xlsread('Helium Loop 12_17_2015 12_29_45.csv', 1, 'C30:W20000');
file = B121715;
for i=1:18
    Data(1,i)=mean(file(355:555,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save B121715 B121715
save LoopData HEMJ
end
%% Helium Loop 12_17_2015 12_37_27 - 453
% Steady-State Experiment - WL10 New (2015)
% One SS Experiment - 6.5 g/s, Ti=27, 3.0 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 453;    % Case number
C121715=xlsread('Helium Loop 12_17_2015 12_37_27.csv', 1, 'C30:W20000');
file = C121715;
for i=1:18
    Data(1,i)=mean(file(2107:2307,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save C121715 C121715
save LoopData HEMJ
end
%% Helium Loop 12_17_2015 13_07_40 - 454
% Steady-State Experiment - WL10 New (2015)
% One SS Experiment - 7.5 g/s, Ti=27, 3.0 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 454;    % Case number
D121715=xlsread('Helium Loop 12_17_2015 13_07_40.csv', 1, 'C30:W20000');
file = D121715;
for i=1:18
    Data(1,i)=mean(file(246:446,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save D121715 D121715
save LoopData HEMJ
end
%% Helium Loop 12_17_2015 13_13_57 - 455
% Steady-State Experiment - WL10 New (2015)
% One SS Experiment - 8.0 g/s, Ti=27, 3.0 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 455;    % Case number
E121715=xlsread('Helium Loop 12_17_2015 13_13_57.csv', 1, 'C30:W20000');
file = E121715;
for i=1:18
    Data(1,i)=mean(file(329:529,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save E121715 E121715
save LoopData HEMJ
end
%% Helium Loop 1_9_2016 10_23_25 - 456
% Steady-State Experiment - WL10 New (2015)
% One SS Experiment - 2.9 g/s, Ti=400, 4.0 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 456;    % Case number
A010916=xlsread('Helium Loop 1_9_2016 10_23_25-3g-s-Extra.csv', 1, 'C30:W20000');
file = A010916;
for i=1:18
    Data(1,i)=mean(file(2195:2395,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save A010916 A010916
save LoopData HEMJ
end
%% Helium Loop 1_9_2016 10_54_46 - 457
% Steady-State Experiment - WL10 New (2015)
% One SS Experiment - 2.9 g/s, Ti=400, 4.0 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 457;    % Case number
B010916=xlsread('Helium Loop 1_9_2016 10_54_46.csv', 1, 'C30:W20000');
file = B010916;
for i=1:18
    Data(1,i)=mean(file(117:317,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save B010916 B010916
save LoopData HEMJ
end
%% Helium Loop 1_9_2016 10_59_26 - 458
% Steady-State Experiment - WL10 New (2015)
% One SS Experiment - 4.0 g/s, Ti=400, 4.0 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 458;    % Case number
C010916=xlsread('Helium Loop 1_9_2016 10_59_26.csv', 1, 'C30:W20000');
file = C010916;
for i=1:18
    Data(1,i)=mean(file(2009:2209,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save C010916 C010916
save LoopData HEMJ
end
%% Helium Loop 1_9_2016 11_28_26 - 459
% Steady-State Experiment - WL10 New (2015)
% One SS Experiment - 5.0 g/s, Ti=400, 4.0 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 459;    % Case number
D010916=xlsread('Helium Loop 1_9_2016 11_28_26.csv', 1, 'C30:W20000');
file = D010916;
for i=1:18
    Data(1,i)=mean(file(3238:3438,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save D010916 D010916
save LoopData HEMJ
end
%% Helium Loop 1_9_2016 12_13_15 -                                         % Case 460
% Steady-State Experiment - WL10 New (2015)
% One SS Experiment - 6.0 g/s, Ti=400, 4.0 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 460;    % Case number
E010916=xlsread('Helium Loop 1_9_2016 12_13_15.csv', 1, 'C30:W20000');
file = E010916;
for i=1:18
    Data(1,i)=mean(file(2104:2304,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save E010916 E010916
save LoopData HEMJ
end
%% Helium Loop 1_9_2016 13_22_03 - Case 461
% Steady-State Experiment - WL10 New (2015)
% One SS Experiment - 6.9 g/s, Ti=400, 4.0 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 461;    % Case number
F010916=xlsread('Helium Loop 1_9_2016 13_22_03.csv', 1, 'C30:W20000');
file = F010916;
for i=1:18
    Data(1,i)=mean(file(429:629,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save F010916 F010916
save LoopData HEMJ
end
%% Helium Loop 1_9_2016 13_30_44 - Case 462
% Steady-State Experiment - WL10 New (2015)
% One SS Experiment - 8.0 g/s, Ti=400, 4.0 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 462;    % Case number
G010916=xlsread('Helium Loop 1_9_2016 13_30_44.csv', 1, 'C30:W20000');
file = G010916;
for i=1:18
    Data(1,i)=mean(file(2000:2303,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save G010916 G010916
save LoopData HEMJ
end
%% Helium Loop 1_23_2016 13_12_56 - Case 463
% Steady-State Experiment - WL10 New (2015)
% One SS Experiment - 5.4 g/s, Ti=400, 4.0 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 463;    % Case number
A012316=xlsread('Helium Loop 1_23_2016 13_12_56.csv', 1, 'C30:W20000');
file = A012316;
for i=1:18
    Data(1,i)=mean(file(2230:2430,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save A012316 A012316
save LoopData HEMJ
end
%% Helium Loop 1_23_2016 13_47_56 - Case 464
% Steady-State Experiment - WL10 New (2015)
% One SS Experiment - 5.0 g/s, Ti=300, 4.0 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 464;    % Case number
B012316=xlsread('Helium Loop 1_23_2016 13_47_56.csv', 1, 'C30:W20000');
file = B012316;
for i=1:18
    Data(1,i)=mean(file(2859:3059,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save B012316 B012316
save LoopData HEMJ
end
%% Helium Loop 1_23_2016 14_27_51 - Case 465
% Steady-State Experiment - WL10 New (2015)
% One SS Experiment - 5.0 g/s, Ti=300, 4.0 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 465;    % Case number
C012316=xlsread('Helium Loop 1_23_2016 14_27_51.csv', 1, 'C30:W20000');
file = C012316;
for i=1:18
    Data(1,i)=mean(file(3858:4058,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save C012316 C012316
save LoopData HEMJ
end
%% Helium Loop 1_23_2016 15_51_15 - Case 466
% Steady-State Experiment - WL10 New (2015)
% One SS Experiment - 5.0 g/s, Ti=300, 4.0 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 466;    % Case number
D012316=xlsread('Helium Loop 1_23_2016 15_51_15.csv', 1, 'C30:W20000');
file = D012316;
for i=1:18
    Data(1,i)=mean(file(131:331,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save D012316 D012316
save LoopData HEMJ
end
%% Helium Loop 1_23_2016 16_25_11 - Case 467
% Steady-State Experiment - WL10 New (2015)
% One SS Experiment - 5.0 g/s, Ti=300, 4.0 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 467;    % Case number
E012316=xlsread('Helium Loop 1_23_2016 16_25_11.csv', 1, 'C30:W20000');
file = E012316;
for i=1:18
    Data(1,i)=mean(file(115:315,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save E012316 E012316
save LoopData HEMJ
end
%% Helium Loop 1_26_2016 13_02_29 - Case 468
% Steady-State Experiment - WL10 New (2015)
% One SS Experiment - 4.2 g/s, Ti=200, 1.9 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 468;    % Case number
A012616=xlsread('Helium Loop 1_26_2016 13_02_29.csv', 1, 'C30:W20000');
file = A012616;
for i=1:18
    Data(1,i)=mean(file(230:430,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save A012616 A012616
save LoopData HEMJ
end
%% Helium Loop 1_26_2016 13_08_43 - Case 469
% Steady-State Experiment - WL10 New (2015)
% One SS Experiment - 3.6 g/s, Ti=100, 2.2 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 469;    % Case number
B012616=xlsread('Helium Loop 1_26_2016 13_08_43.csv', 1, 'C30:W20000');
file = B012616;
for i=1:18
    Data(1,i)=mean(file(2600:2720,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save B012616 B012616
save LoopData HEMJ
end
%% Helium Loop 1_26_2016 13_44_17 -                                        % Case 470
% Steady-State Experiment - WL10 New (2015)
% One SS Experiment - 3.1 g/s, Ti=27, 2.2 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 470;    % Case number
C012616=xlsread('Helium Loop 1_26_2016 13_44_17.csv', 1, 'C30:W20000');
file = C012616;
for i=1:18
    Data(1,i)=mean(file(2300:2500,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save C012616 C012616
save LoopData HEMJ
end
%% Helium Loop 1_29_2016 13_27_40 - Case 471
% Steady-State Experiment - WL10 New (2015)
% One SS Experiment - 5.4 g/s, Ti=400, 1.2 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 471;    % Case number
D012916=xlsread('Helium Loop 1_29_2016 13_27_40.csv', 1, 'C30:W20000');
file = D012916;
for i=1:18
    Data(1,i)=mean(file(1300:1500,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save D012916 D012916
save LoopData HEMJ
end
%% Helium Loop 1_29_2016 14_19_14 - Case 472
% Steady-State Experiment - WL10 New (2015)
% One SS Experiment - 5.0 g/s, Ti=300, 1.4 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 472;    % Case number
E012916=xlsread('Helium Loop 1_29_2016 14_19_14.csv', 1, 'C30:W20000');
file = E012916;
for i=1:18
    Data(1,i)=mean(file(540:740,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save E012916 E012916
save LoopData HEMJ
end

%% Helium Loop 6_2_2016 11_18_33 - Case 473
% Steady-State Experiment - WL10 New (2015-2016)
% One SS Experiment - 3.1 g/s, Ti=400, 3.7 MW/m^2, 1.28mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 473;    % Case number
A060216=xlsread('Helium Loop 6_2_2016 11_18_33.csv', 1, 'C30:W20000');
file = A060216;
for i=1:18
    Data(1,i)=mean(file(750:950,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save A060216 A060216
save LoopData HEMJ
end
%% Helium Loop 6_2_2016 11_32_15 - Case 474
% Steady-State Experiment - WL10 New (2015-2016)
% One SS Experiment - 4.0 g/s, Ti=400, 3.8 MW/m^2, 1.28mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 474;    % Case number
B060216=xlsread('Helium Loop 6_2_2016 11_32_15.csv', 1, 'C30:W20000');
file = B060216;
for i=1:18
    Data(1,i)=mean(file(1800:2000,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save B060216 B060216
save LoopData HEMJ
end
%% Helium Loop 6_2_2016 11_59_35 - Case 475
% Steady-State Experiment - WL10 New (2015-2016)
% One SS Experiment - 5.0 g/s, Ti=400, 3.8 MW/m^2, 1.28mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 475;    % Case number
C060216=xlsread('Helium Loop 6_2_2016 11_59_35.csv', 1, 'C30:W20000');
file = C060216;
for i=1:18
    Data(1,i)=mean(file(820:1020,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save C060216 C060216
save LoopData HEMJ
end
%% Helium Loop 6_2_2016 12_13_24 - Case 476
% Steady-State Experiment - WL10 New (2015-2016)
% One SS Experiment - 6.0 g/s, Ti=400, 3.8 MW/m^2, 1.28mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 476;    % Case number
D060216=xlsread('Helium Loop 6_2_2016 12_13_24.csv', 1, 'C30:W20000');
file = D060216;
for i=1:18
    Data(1,i)=mean(file(1300:1500,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save D060216 D060216
save LoopData HEMJ
end
%% Helium Loop 6_2_2016 12_33_21 - Case 477
% Steady-State Experiment - WL10 New (2015-2016)
% One SS Experiment - 7.0 g/s, Ti=400, 3.8 MW/m^2, 0.5mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 477;    % Case number
E060216=xlsread('Helium Loop 6_2_2016 12_33_21.csv', 1, 'C30:W20000');
file = E060216;
for i=1:18
    Data(1,i)=mean(file(980:1180,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save E060216 E060216
save LoopData HEMJ
end
%% Helium Loop 6_2_2016 12_49_08 - Case 478
% Steady-State Experiment - WL10 New (2015-2016)
% One SS Experiment - 8.0 g/s, Ti=400, 3.65 MW/m^2, 1.28mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 478;    % Case number
F060216=xlsread('Helium Loop 6_2_2016 12_49_08.csv', 1, 'C30:W20000');
file = F060216;
for i=1:18
    Data(1,i)=mean(file(2950:3150,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save F060216 F060216
save LoopData HEMJ
end
%% Helium Loop 6_2_2016 13_30_49 - Case 479
% Steady-State Experiment - WL10 New (2015-2016)
% One SS Experiment - 8.0 g/s, Ti=300, 4.0 MW/m^2, 1.28mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 479;    % Case number
G060216=xlsread('Helium Loop 6_2_2016 13_30_49.csv', 1, 'C30:W20000');
file = G060216;
for i=1:18
    Data(1,i)=mean(file(1888:2088,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save G060216 G060216
save LoopData HEMJ
end
%% Helium Loop 6_2_2016 13_58_14 -                                         % Case 480
% Steady-State Experiment - WL10 New (2015-2016)
% One SS Experiment - 7.0 g/s, Ti=300, 4.0 MW/m^2, 1.28mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 480;    % Case number
H060216=xlsread('Helium Loop 6_2_2016 13_58_14.csv', 1, 'C30:W20000');
file = H060216;
for i=1:18
    Data(1,i)=mean(file(1350:1550,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save H060216 H060216
save LoopData HEMJ
end
%% Helium Loop 6_2_2016 14_19_22 - Case 481
% Steady-State Experiment - WL10 New (2015-2016)
% One SS Experiment - 6.1 g/s, Ti=300, 4.0 MW/m^2, 1.28mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 481;    % Case number
I060216=xlsread('Helium Loop 6_2_2016 14_19_22.csv', 1, 'C30:W20000');
file = I060216;
for i=1:18
    Data(1,i)=mean(file(1511:1711,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save I060216 I060216
save LoopData HEMJ
end
%% Helium Loop 6_2_2016 14_41_57 - Case 482
% Steady-State Experiment - WL10 New (2015-2016)
% One SS Experiment - 5.0 g/s, Ti=300, 4.0 MW/m^2, 1.28mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 482;    % Case number
J060216=xlsread('Helium Loop 6_2_2016 14_41_57.csv', 1, 'C30:W20000');
file = J060216;
for i=1:18
    Data(1,i)=mean(file(1375:1575,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save J060216 J060216
save LoopData HEMJ
end
%% Helium Loop 6_2_2016 15_03_34 - Case 483
% Steady-State Experiment - WL10 New (2015-2016)
% One SS Experiment - 4.0 g/s, Ti=300, 4.0 MW/m^2, 1.28mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 483;    % Case number
K060216=xlsread('Helium Loop 6_2_2016 15_03_34.csv', 1, 'C30:W20000');
file = K060216;
for i=1:18
    Data(1,i)=mean(file(800:1000,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save K060216 K060216
save LoopData HEMJ
end
%% Helium Loop 6_2_2016 15_17_39 - Case 484
% Steady-State Experiment - WL10 New (2015-2016)
% One SS Experiment - 3.0 g/s, Ti=300, 4.0 MW/m^2, 1.28mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 484;    % Case number
L060216=xlsread('Helium Loop 6_2_2016 15_17_39.csv', 1, 'C30:W20000');
file = L060216;
for i=1:18
    Data(1,i)=mean(file(800:1000,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save L060216 L060216
save LoopData HEMJ
end
%% Helium Loop 6_4_2016 10_47_15 - Case 485
% Steady-State Experiment - WL10 New (2015-2016)
% One SS Experiment - 3.0 g/s, Ti=400, 3.0 MW/m^2, 0.5mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 485;    % Case number
A060416=xlsread('Helium Loop 6_4_2016 10_47_15.csv', 1, 'C30:W20000');
file = A060416;
for i=1:18
    Data(1,i)=mean(file(1000:1260,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save A060416 A060416
save LoopData HEMJ
end
%% Helium Loop 6_4_2016 11_04_09 - Case 486
% Steady-State Experiment - WL10 New (2015-2016)
% One SS Experiment - 4.0 g/s, Ti=400, 3.0 MW/m^2, 0.5mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 486;    % Case number
B060416=xlsread('Helium Loop 6_4_2016 11_04_09.csv', 1, 'C30:W20000');
file = B060416;
for i=1:18
    Data(1,i)=mean(file(680:885,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save B060416 B060416
save LoopData HEMJ
end
%% Helium Loop 6_4_2016 11_20_56 - Case 487
% Steady-State Experiment - WL10 New (2015-2016)
% One SS Experiment - 5.0 g/s, Ti=400, 2.7 MW/m^2, 0.5mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 487;    % Case number
C060416=xlsread('Helium Loop 6_4_2016 11_20_56.csv', 1, 'C30:W20000');
file = C060416;
for i=1:18
    Data(1,i)=mean(file(1100:1300,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save C060416 C060416
save LoopData HEMJ
end
%% Helium Loop 6_4_2016 11_38_26 - Case 488
% Steady-State Experiment - WL10 New (2015-2016)
% One SS Experiment - 6.0 g/s, Ti=400, 2.6 MW/m^2, 0.5mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 488;    % Case number
D060416=xlsread('Helium Loop 6_4_2016 11_38_26.csv', 1, 'C30:W20000');
file = D060416;
for i=1:18
    Data(1,i)=mean(file(1275:1475,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save D060416 D060416
save LoopData HEMJ
end
%% Helium Loop 6_4_2016 11_59_03 - Case 489
% Steady-State Experiment - WL10 New (2015-2016)
% One SS Experiment - 7.0 g/s, Ti=400, 2.5 MW/m^2, 0.5mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 489;    % Case number
E060416=xlsread('Helium Loop 6_4_2016 11_59_03.csv', 1, 'C30:W20000');
file = E060416;
for i=1:18
    Data(1,i)=mean(file(960:1160,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save E060416 E060416
save LoopData HEMJ
end
%% Helium Loop 6_4_2016 12_14_35 -                                         % Case 490
% Steady-State Experiment - WL10 New (2015-2016)
% One SS Experiment - 8.0 g/s, Ti=400, 2.4 MW/m^2, 0.5mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 490;    % Case number
F060416=xlsread('Helium Loop 6_4_2016 12_14_35.csv', 1, 'C30:W20000');
file = F060416;
for i=1:18
    Data(1,i)=mean(file(2125:2325,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save F060416 F060416
save LoopData HEMJ
end
%% Helium Loop 6_4_2016 13_27_22 - Case 491
% Steady-State Experiment - WL10 New (2015-2016)
% One SS Experiment - 8.0 g/s, Ti=300, 2.7 MW/m^2, 0.5mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 491;    % Case number
G060416=xlsread('Helium Loop 6_4_2016 13_27_22.csv', 1, 'C30:W20000');
file = G060416;
for i=1:18
    Data(1,i)=mean(file(30:230,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save G060416 G060416
save LoopData HEMJ
end
%% Helium Loop 6_4_2016 13_32_13 - Case 492
% Steady-State Experiment - WL10 New (2015-2016)
% One SS Experiment - 7.0 g/s, Ti=300, 2.7 MW/m^2, 0.5mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 492;    % Case number
H060416=xlsread('Helium Loop 6_4_2016 13_32_13.csv', 1, 'C30:W20000');
file = H060416;
for i=1:18
    Data(1,i)=mean(file(600:800,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save H060416 H060416
save LoopData HEMJ
end
%% Helium Loop 6_4_2016 13_43_55 - Case 493
% Steady-State Experiment - WL10 New (2015-2016)
% One SS Experiment - 6.0 g/s, Ti=300, 2.8 MW/m^2, 0.5mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 493;    % Case number
I060416=xlsread('Helium Loop 6_4_2016 13_43_55.csv', 1, 'C30:W20000');
file = I060416;
for i=1:18
    Data(1,i)=mean(file(2030:2200,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save I060416 I060416
save LoopData HEMJ
end
%% Helium Loop 6_4_2016 14_14_07 - Case 494
% Steady-State Experiment - WL10 New (2015-2016)
% One SS Experiment - 5.0 g/s, Ti=300, 2.8 MW/m^2, 0.5mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 494;    % Case number
J060416=xlsread('Helium Loop 6_4_2016 14_14_07.csv', 1, 'C30:W20000');
file = J060416;
for i=1:18
    Data(1,i)=mean(file(1048:1248,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save J060416 J060416
save LoopData HEMJ
end
%% Helium Loop 6_4_2016 14_30_42 - Case 495
% Steady-State Experiment - WL10 New (2015-2016)
% One SS Experiment - 4.0 g/s, Ti=300, 2.8 MW/m^2, 0.5mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 495;    % Case number
K060416=xlsread('Helium Loop 6_4_2016 14_30_42.csv', 1, 'C30:W20000');
file = K060416;
for i=1:18
    Data(1,i)=mean(file(2000:2200,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save K060416 K060416
save LoopData HEMJ
end
%% Helium Loop 6_4_2016 15_00_18 - Case 496
% Steady-State Experiment - WL10 New (2015-2016)
% One SS Experiment - 3.0 g/s, Ti=300, 2.8 MW/m^2, 0.5mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 496;    % Case number
L060416=xlsread('Helium Loop 6_4_2016 15_00_18.csv', 1, 'C30:W20000');
file = L060416;
for i=1:18
    Data(1,i)=mean(file(1300:1743,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save L060416 L060416
save LoopData HEMJ
end
%% Helium Loop 6_17_2016 11_29_18 - Case 497
% Steady-State Experiment - WL10 New (2015-2016)
% One SS Experiment - 3.0 g/s, Ti=400, 3.3 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 497;    % Case number
A061716=xlsread('Helium Loop 6_17_2016 11_29_18.csv', 1, 'C30:W20000');
file = A061716;
for i=1:18
    Data(1,i)=mean(file(558:685,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save A061716 A061716
save LoopData HEMJ
end
%% Helium Loop 6_17_2016 11_40_13 - Case 498
% Steady-State Experiment - WL10 New (2015-2016)
% One SS Experiment - 4.0 g/s, Ti=400, 4.54 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 498;    % Case number
B061716=xlsread('Helium Loop 6_17_2016 11_40_13.csv', 1, 'C30:W20000');
file = B061716;
for i=1:18
    Data(1,i)=mean(file(2050:2250,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save B061716 B061716
save LoopData HEMJ
end
%% Helium Loop 6_17_2016 12_27_50 - Case 499
% Steady-State Experiment - WL10 New (2015-2016)
% One SS Experiment - 5.0 g/s, Ti=400, 4.3 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 499;    % Case number
C061716=xlsread('Helium Loop 6_17_2016 12_27_50.csv', 1, 'C30:W20000');
file = C061716;
for i=1:18
    Data(1,i)=mean(file(1470:1640,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save C061716 C061716
save LoopData HEMJ
end
%% Helium Loop 6_17_2016 12_50_56 -                                        % Case 500
% Steady-State Experiment - WL10 New (2015-2016)
% One SS Experiment - 6.0 g/s, Ti=400, 4.2 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 500;    % Case number
D061716=xlsread('Helium Loop 6_17_2016 12_50_56.csv', 1, 'C30:W20000');
file = D061716;
for i=1:18
    Data(1,i)=mean(file(2320:2520,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save D061716 D061716
save LoopData HEMJ
end
%% Helium Loop 6_17_2016 13_25_07 - Case 501
% Steady-State Experiment - WL10 New (2015-2016)
% One SS Experiment - 7.0 g/s, Ti=400, 4.2 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 501;    % Case number
E061716=xlsread('Helium Loop 6_17_2016 13_25_07.csv', 1, 'C30:W20000');
file = E061716;
for i=1:18
    Data(1,i)=mean(file(1505:1705,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save E061716 E061716
save LoopData HEMJ
end
%% Helium Loop 6_17_2016 13_49_21 - Case 502
% Steady-State Experiment - WL10 New (2015-2016)
% One SS Experiment - 8.0 g/s, Ti=400, 4.0 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 502;    % Case number
F061716=xlsread('Helium Loop 6_17_2016 13_49_21.csv', 1, 'C30:W20000');
file = F061716;
for i=1:18
    Data(1,i)=mean(file(2303:2503,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save F061716 F061716
save LoopData HEMJ
end
%% Helium Loop 6_17_2016 14_53_31 - Case 503
% Steady-State Experiment - WL10 New (2015-2016)
% One SS Experiment - 8.0 g/s, Ti=300, 4.2 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 503;    % Case number
G061716=xlsread('Helium Loop 6_17_2016 14_53_31.csv', 1, 'C30:W20000');
file = G061716;
for i=1:18
    Data(1,i)=mean(file(232:432,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save G061716 G061716
save LoopData HEMJ
end
%% Helium Loop 6_17_2016 15_28_32 - Case 504
% Steady-State Experiment - WL10 New (2015-2016)
% One SS Experiment - 7.0 g/s, Ti=300, 4.2 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 504;    % Case number
H061716=xlsread('Helium Loop 6_17_2016 15_28_32.csv', 1, 'C30:W20000');
file = H061716;
for i=1:18
    Data(1,i)=mean(file(950:1150,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save H061716 H061716
save LoopData HEMJ
end
%% Helium Loop 6_17_2016 15_44_20 - Case 505
% Steady-State Experiment - WL10 New (2015-2016)
% One SS Experiment - 6.0 g/s, Ti=300, 4.2 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 505;    % Case number
I061716=xlsread('Helium Loop 6_17_2016 15_44_20.csv', 1, 'C30:W20000');
file = I061716;
for i=1:18
    Data(1,i)=mean(file(1874:2074,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save I061716 I061716
save LoopData HEMJ
end
%% Helium Loop 6_17_2016 16_11_33 - Case 506
% Steady-State Experiment - WL10 New (2015-2016)
% One SS Experiment - 4.9 g/s, Ti=300, 4.2 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 506;    % Case number
J061716=xlsread('Helium Loop 6_17_2016 16_11_33.csv', 1, 'C30:W20000');
file = J061716;
for i=1:18
    Data(1,i)=mean(file(972:1172,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save J061716 J061716
save LoopData HEMJ
end
%% Helium Loop 6_17_2016 16_27_15 - Case 507
% Steady-State Experiment - WL10 New (2015-2016)
% One SS Experiment - 4.0 g/s, Ti=300, 4.2 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 507;    % Case number
K061716=xlsread('Helium Loop 6_17_2016 16_27_15.csv', 1, 'C30:W20000');
file = K061716;
for i=1:18
    Data(1,i)=mean(file(1295:1485,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save K061716 K061716
save LoopData HEMJ
end
%% Helium Loop 6_17_2016 16_46_53 - Case 508
% Steady-State Experiment - WL10 New (2015-2016)
% One SS Experiment - 4.0 g/s, Ti=300, 4.2 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 508;    % Case number
L061716=xlsread('Helium Loop 6_17_2016 16_46_53.csv', 1, 'C30:W20000');
file = L061716;
for i=1:18
    Data(1,i)=mean(file(1540:2565,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save L061716 L061716
save LoopData HEMJ
end
%% Helium Loop 7_7_2016 09_42_54 - Case 509
% Steady-State Experiment - WL10 New (2015-2016)
% One SS Experiment - 3.0 g/s, Ti=300, 4.2 MW/m^2, 0.5mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 509;    % Case number
A070716=xlsread('Helium Loop 7_7_2016 09_42_54.csv', 1, 'C30:W20000');
file = A070716;
for i=1:18
    Data(1,i)=mean(file(1420:1600,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save A070716 A070716
save LoopData HEMJ
end
%% Helium Loop 7_7_2016 10_04_29 -                                         % Case 510
% Steady-State Experiment - WL10 New (2015-2016)
% One SS Experiment - 4.0 g/s, Ti=300, 4.35 MW/m^2, 0.5mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 510;    % Case number
B070716=xlsread('Helium Loop 7_7_2016 10_04_29.csv', 1, 'C30:W20000');
file = B070716;
for i=1:18
    Data(1,i)=mean(file(1460:1650,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save B070716 B070716
save LoopData HEMJ
end
%% Helium Loop 7_7_2016 10_27_30 - Case 511
% Steady-State Experiment - WL10 New (2015-2016)
% One SS Experiment - 5.0 g/s, Ti=300, 4.2 MW/m^2, 0.5mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 511;    % Case number
C070716=xlsread('Helium Loop 7_7_2016 10_27_30.csv', 1, 'C30:W20000');
file = C070716;
for i=1:18
    Data(1,i)=mean(file(1990:2170,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save C070716 C070716
save LoopData HEMJ
end
%% Helium Loop 7_7_2016 11_26_41 - Case 512
% Steady-State Experiment - WL10 New (2015-2016)
% One SS Experiment - 7.0 g/s, Ti=300, 3.9 MW/m^2, 0.5mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 512;    % Case number
D070716=xlsread('Helium Loop 7_7_2016 11_26_41.csv', 1, 'C30:W20000');
file = D070716;
for i=1:18
    Data(1,i)=mean(file(1100:1300,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save D070716 D070716
save LoopData HEMJ
end
%% Helium Loop 7_7_2016 11_44_04 - Case 513
% Steady-State Experiment - WL10 New (2015-2016)
% One SS Experiment - 8.0 g/s, Ti=300, 3.9 MW/m^2, 0.5mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 513;    % Case number
E070716=xlsread('Helium Loop 7_7_2016 11_44_04.csv', 1, 'C30:W20000');
file = E070716;
for i=1:18
    Data(1,i)=mean(file(1220:1400,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save E070716 E070716
save LoopData HEMJ
end
%% Helium Loop 7_7_2016 12_35_00 - Case 514
% Steady-State Experiment - WL10 New (2015-2016)
% One SS Experiment - 8.0 g/s, Ti=400, 2.8 MW/m^2, 0.5mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 514;    % Case number
F070716=xlsread('Helium Loop 7_7_2016 12_35_00.csv', 1, 'C30:W20000');
file = F070716;
for i=1:18
    Data(1,i)=mean(file(1620:1800,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save F070716 F070716
save LoopData HEMJ
end
%% Helium Loop 7_7_2016 13_01_28 - Case 515
% Steady-State Experiment - WL10 New (2015-2016)
% One SS Experiment - 7.0 g/s, Ti=400, 1.95 MW/m^2, 0.5mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 515;    % Case number
G070716=xlsread('Helium Loop 7_7_2016 13_01_28.csv', 1, 'C30:W20000');
file = G070716;
for i=1:18
    Data(1,i)=mean(file(3400:3600,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save G070716 G070716
save LoopData HEMJ
end
%% Helium Loop 7_7_2016 13_49_03 - Case 516
% Steady-State Experiment - WL10 New (2015-2016)
% One SS Experiment - 6.0 g/s, Ti=400, 2.0 MW/m^2, 0.5mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 516;    % Case number
H070716=xlsread('Helium Loop 7_7_2016 13_49_03.csv', 1, 'C30:W20000');
file = H070716;
for i=1:18
    Data(1,i)=mean(file(1450:1630,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save H070716 H070716
save LoopData HEMJ
end
%% Helium Loop 7_7_2016 14_12_06 - Case 517
% Steady-State Experiment - WL10 New (2015-2016)
% One SS Experiment - 5.0 g/s, Ti=400, 2.0 MW/m^2, 0.5mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 517;    % Case number
I070716=xlsread('Helium Loop 7_7_2016 14_12_06.csv', 1, 'C30:W20000');
file = I070716;
for i=1:18
    Data(1,i)=mean(file(1880:2080,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save I070716 I070716
save LoopData HEMJ
end
%% Helium Loop 7_7_2016 14_39_24 - Case 518
% Steady-State Experiment - WL10 New (2015-2016)
% One SS Experiment - 4.0 g/s, Ti=400, 2.0 MW/m^2, 0.5mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 518;    % Case number
J070716=xlsread('Helium Loop 7_7_2016 14_39_24.csv', 1, 'C30:W20000');
file = J070716;
for i=1:18
    Data(1,i)=mean(file(1530:1730,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save J070716 J070716
save LoopData HEMJ
end
%% Helium Loop 7_7_2016 15_43_00 - Case 519
% Steady-State Experiment - WL10 New (2015-2016)
% One SS Experiment - 3.0 g/s, Ti=400, 2.0 MW/m^2, 0.5mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 519;    % Case number
K070716=xlsread('Helium Loop 7_7_2016 15_43_00.csv', 1, 'C30:W20000');
file = K070716;
for i=1:18
    Data(1,i)=mean(file(836:1036,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save K070716 K070716
save LoopData HEMJ
end
%% Helium Loop 7_10_2016 13_24_16 -                                        % Case 520
% Steady-State Experiment - WL10 New (2015-2016)
% One SS Experiment - 3.0 g/s, Ti=300, 4.9 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 520;    % Case number
A071016=xlsread('Helium Loop 7_10_2016 13_24_16.csv', 1, 'C30:W20000');
file = A071016;
for i=1:18
    Data(1,i)=mean(file(1970:2170,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save A071016 A071016
save LoopData HEMJ
end
%% Helium Loop 7_10_2016 13_55_25 - Case 521
% Steady-State Experiment - WL10 New (2015-2016)
% One SS Experiment - 4.0 g/s, Ti=300, 5.0 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 521;    % Case number
B071016=xlsread('Helium Loop 7_10_2016 13_55_25.csv', 1, 'C30:W20000');
file = B071016;
for i=1:18
    Data(1,i)=mean(file(2720:2920,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save B071016 B071016
save LoopData HEMJ
end
%% Helium Loop 7_10_2016 14_38_40 - Case 522
% Steady-State Experiment - WL10 New (2015-2016)
% One SS Experiment - 5.0 g/s, Ti=300, 5.0 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 522;    % Case number
C071016=xlsread('Helium Loop 7_10_2016 14_38_40.csv', 1, 'C30:W20000');
file = C071016;
for i=1:18
    Data(1,i)=mean(file(1650:1850,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save C071016 C071016
save LoopData HEMJ
end
%% Helium Loop 7_10_2016 15_03_00 - Case 523
% Steady-State Experiment - WL10 New (2015-2016)
% One SS Experiment - 6.0 g/s, Ti=300, 5.0 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 523;    % Case number
D071016=xlsread('Helium Loop 7_10_2016 15_03_00.csv', 1, 'C30:W20000');
file = D071016;
for i=1:18
    Data(1,i)=mean(file(1010:1190,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save D071016 D071016
save LoopData HEMJ
end
%% Helium Loop 7_10_2016 15_19_28 - Case 524
% Steady-State Experiment - WL10 New (2015-2016)
% One SS Experiment - 7.0 g/s, Ti=300, 5.0 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 524;    % Case number
E071016=xlsread('Helium Loop 7_10_2016 15_19_28.csv', 1, 'C30:W20000');
file = E071016;
for i=1:18
    Data(1,i)=mean(file(1170:1370,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save E071016 E071016
save LoopData HEMJ
end
%% Helium Loop 7_10_2016 15_37_43 - Case 525
% Steady-State Experiment - WL10 New (2015-2016)
% One SS Experiment - 8.0 g/s, Ti=300, 5.0 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 525;    % Case number
F071016=xlsread('Helium Loop 7_10_2016 15_37_43.csv', 1, 'C30:W20000');
file = F071016;
for i=1:18
    Data(1,i)=mean(file(3000:3200,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save F071016 F071016
save LoopData HEMJ
end
%% Helium Loop 7_10_2016 16_59_18 - Case 526
% Steady-State Experiment - WL10 New (2015-2016)
% One SS Experiment - 8.0 g/s, Ti=400, 3.3 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 526;    % Case number
G071016=xlsread('Helium Loop 7_10_2016 16_59_18.csv', 1, 'C30:W20000');
file = G071016;
for i=1:18
    Data(1,i)=mean(file(824:1024,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save G071016 G071016
save LoopData HEMJ
end
%% Helium Loop 7_10_2016 17_52_09 - Case 527
% Steady-State Experiment - WL10 New (2015-2016)
% One SS Experiment - 6.0 g/s, Ti=400, 3.1 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 527;    % Case number
H071016=xlsread('Helium Loop 7_10_2016 17_52_09.csv', 1, 'C30:W20000');
file = H071016;
for i=1:18
    Data(1,i)=mean(file(581:781,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save H071016 H071016
save LoopData HEMJ
end
%% Helium Loop 7_10_2016 18_02_45 - Case 528
% Steady-State Experiment - WL10 New (2015-2016)
% One SS Experiment - 5.0 g/s, Ti=400, 3.1 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 528;    % Case number
I071016=xlsread('Helium Loop 7_10_2016 18_02_45.csv', 1, 'C30:W20000');
file = I071016;
for i=1:18
    Data(1,i)=mean(file(2700:2900,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save I071016 I071016
save LoopData HEMJ
end
%% Helium Loop 7_10_2016 18_41_44 - Case 529
% Steady-State Experiment - WL10 New (2015-2016)
% One SS Experiment - 4.0 g/s, Ti=400, 3.1 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 529;    % Case number
J071016=xlsread('Helium Loop 7_10_2016 18_41_44.csv', 1, 'C30:W20000');
file = J071016;
for i=1:18
    Data(1,i)=mean(file(931:1131,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save J071016 J071016
save LoopData HEMJ
end
%% Helium Loop 7_10_2016 19_35_47 -                                        % Case 530
% Steady-State Experiment - WL10 New (2015-2016)
% One SS Experiment - 3.0 g/s, Ti=400, 3.1 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 530;    % Case number
K071016=xlsread('Helium Loop 7_10_2016 19_35_47.csv', 1, 'C30:W20000');
file = K071016;
for i=1:18
    Data(1,i)=mean(file(600:800,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save K071016 K071016
save LoopData HEMJ
end
%% Helium Loop 7_16_2016 12_56_30 - Case 531
% Steady-State Experiment - WL10 New (2015-2016)
% One SS Experiment - 3.0 g/s, Ti=400, 3.0 MW/m^2, 1.5mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 531;    % Case number
A071616=xlsread('Helium Loop 7_16_2016 12_56_30.csv', 1, 'C30:W20000');
file = A071616;
for i=1:18
    Data(1,i)=mean(file(1400:1600,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save A071616 A071616
save LoopData HEMJ
end
%% Helium Loop 7_16_2016 13_17_49 - Case 532
% Steady-State Experiment - WL10 New (2015-2016)
% One SS Experiment - 4.0 g/s, Ti=400, 2.2 MW/m^2, 1.5mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 532;    % Case number
B071616=xlsread('Helium Loop 7_16_2016 13_17_49.csv', 1, 'C30:W20000');
file = B071616;
for i=1:18
    Data(1,i)=mean(file(2350:2550,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save B071616 B071616
save LoopData HEMJ
end
%% Helium Loop 7_16_2016 14_49_23 - Case 533
% Steady-State Experiment - WL10 New (2015-2016)
% One SS Experiment - 5.4 g/s, Ti=400, 2.7 MW/m^2, 1.5mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 533;    % Case number
C071616=xlsread('Helium Loop 7_16_2016 14_49_23.csv', 1, 'C30:W20000');
file = C071616;
for i=1:18
    Data(1,i)=mean(file(1720:1920,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save C071616 C071616
save LoopData HEMJ
end
%% Helium Loop 7_16_2016 15_14_42 - Case 534
% Steady-State Experiment - WL10 New (2015-2016)
% One SS Experiment - 6.0 g/s, Ti=400, 2.4 MW/m^2, 1.5mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 534;    % Case number
D071616=xlsread('Helium Loop 7_16_2016 15_14_42.csv', 1, 'C30:W20000');
file = D071616;
for i=1:18
    Data(1,i)=mean(file(1055:1255,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save D071616 D071616
save LoopData HEMJ
end
%% Helium Loop 7_16_2016 15_31_28 - Case 535
% Steady-State Experiment - WL10 New (2015-2016)
% One SS Experiment - 7.0 g/s, Ti=400, 2.1 MW/m^2, 1.5mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 535;    % Case number
E071616=xlsread('Helium Loop 7_16_2016 15_31_28.csv', 1, 'C30:W20000');
file = E071616;
for i=1:18
    Data(1,i)=mean(file(944:1144,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save E071616 E071616
save LoopData HEMJ
end
%% Helium Loop 7_16_2016 15_46_43 - Case 536
% Steady-State Experiment - WL10 New (2015-2016)
% One SS Experiment - 8.0 g/s, Ti=400, 1.8 MW/m^2, 1.5mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 536;    % Case number
F071616=xlsread('Helium Loop 7_16_2016 15_46_43.csv', 1, 'C30:W20000');
file = F071616;
for i=1:18
    Data(1,i)=mean(file(1390:1590,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save F071616 F071616
save LoopData HEMJ
end
%% Helium Loop 8_9_2016 09_42_59 - Case 537
% Steady-State Experiment - MT-185
% One SS Experiment - 3.1 g/s, Ti=400, 3.4 MW/m^2, 0.25mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 537;    % Case number
A080916=xlsread('Helium Loop 8_9_2016 09_42_59.csv', 1, 'C30:W20000');
file = A080916;
for i=1:18
    Data(1,i)=mean(file(4600:4780,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save A080916 A080916
save LoopData HEMJ
end
%% Helium Loop 8_9_2016 10_45_36 - Case 538
% Steady-State Experiment - MT-185
% One SS Experiment - 4.1 g/s, Ti=400, 3.2 MW/m^2, 0.25mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 538;    % Case number
B080916=xlsread('Helium Loop 8_9_2016 10_45_36.csv', 1, 'C30:W20000');
file = B080916;
for i=1:18
    Data(1,i)=mean(file(1394:1594,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save B080916 B080916
save LoopData HEMJ
end
%% Helium Loop 8_9_2016 11_06_37 - Case 539
% Steady-State Experiment - MT-185
% One SS Experiment - 5.05 g/s, Ti=400, 2.8 MW/m^2, 0.25mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 539;    % Case number
C080916=xlsread('Helium Loop 8_9_2016 11_06_37.csv', 1, 'C30:W20000');
file = C080916;
for i=1:18
    Data(1,i)=mean(file(1160:1330,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save C080916 C080916
save LoopData HEMJ
end
%% Helium Loop 8_9_2016 11_24_14 -                                         % Case 540
% Steady-State Experiment - MT-185
% One SS Experiment - 6.1 g/s, Ti=400, 2.6 MW/m^2, 0.25mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 540;    % Case number
D080916=xlsread('Helium Loop 8_9_2016 11_24_14.csv', 1, 'C30:W20000');
file = D080916;
for i=1:18
    Data(1,i)=mean(file([1250:1280,1300:1450],i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save D080916 D080916
save LoopData HEMJ
end
%% Helium Loop 8_9_2016 11_51_19 - Case 541
% Steady-State Experiment - MT-185
% One SS Experiment - 7.1 g/s, Ti=400, 2.3 MW/m^2, 0.25mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 541;    % Case number
E080916=xlsread('Helium Loop 8_9_2016 11_51_19.csv', 1, 'C30:W20000');
file = E080916;
for i=1:18
    Data(1,i)=mean(file(931:1131,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save E080916 E080916
save LoopData HEMJ
end
%% Helium Loop 8_9_2016 12_06_25 - Case 542
% Steady-State Experiment - MT-185
% One SS Experiment - 8.0 g/s, Ti=400, 2.0 MW/m^2, 0.25mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 542;    % Case number
F080916=xlsread('Helium Loop 8_9_2016 12_06_25.csv', 1, 'C30:W20000');
file = F080916;
for i=1:18
    Data(1,i)=mean(file([1987:2090,2100:end],i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save F080916 F080916
save LoopData HEMJ
end
%% Helium Loop 8_9_2016 12_34_15 - Case 543
% Steady-State Experiment - MT-185
% One SS Experiment - 7.8 g/s, Ti=350, 2.8 MW/m^2, 0.25mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 543;    % Case number
G080916=xlsread('Helium Loop 8_9_2016 12_34_15.csv', 1, 'C30:W20000');
file = G080916;
for i=1:18
    Data(1,i)=mean(file(2485:2685,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save G080916 G080916
save LoopData HEMJ
end
%% Helium Loop 8_9_2016 13_10_01 - Case 544
% Steady-State Experiment - MT-185
% One SS Experiment - 7.1 g/s, Ti=350, 3.0 MW/m^2, 0.25mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 544;    % Case number
H080916=xlsread('Helium Loop 8_9_2016 13_10_01.csv', 1, 'C30:W20000');
file = H080916;
for i=1:18
    Data(1,i)=mean(file(1238:1438,i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save H080916 H080916
save LoopData HEMJ
end
%% Helium Loop 8_9_2016 13_29_02 - Case 545
% Steady-State Experiment - MT-185
% One SS Experiment - 6.1 g/s, Ti=350, 3.4 MW/m^2, 0.25mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 545;    % Case number
I080916=xlsread('Helium Loop 8_9_2016 13_29_02.csv', 1, 'C30:W20000');
file = I080916;
for i=1:18
    Data(1,i)=mean(file([510:660,695:730],i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save I080916 I080916
save LoopData HEMJ
end
%% Helium Loop 8_9_2016 13_39_06 - Case 546
% Steady-State Experiment - MT-185
% One SS Experiment - 5.1 g/s, Ti=350, 3.55 MW/m^2, 0.25mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 546;    % Case number
J080916=xlsread('Helium Loop 8_9_2016 13_39_06.csv', 1, 'C30:W20000');
file = J080916;
for i=1:18
    Data(1,i)=mean(file([900:1030,1050:1100],i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save J080916 J080916
save LoopData HEMJ
end
%% Helium Loop 8_9_2016 13_54_01 - Case 547
% Steady-State Experiment - MT-185
% One SS Experiment - 4.1 g/s, Ti=350, 3.8 MW/m^2, 0.25mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 547;    % Case number
K080916=xlsread('Helium Loop 8_9_2016 13_54_01.csv', 1, 'C30:W20000');
file = K080916;
for i=1:18
    Data(1,i)=mean(file([1400:1525,1550:1580],i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save K080916 K080916
save LoopData HEMJ
end
%% Helium Loop 8_11_2016 10_39_52 - Case 548
% Steady-State Experiment - MT-185
% One SS Experiment - 3.5 g/s, Ti=30, 4.8 MW/m^2, 0.25mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 548;    % Case number
A081116=xlsread('Helium Loop 8_11_2016 10_39_52.csv', 1, 'C30:W20000');
file = A081116;
for i=1:18
    Data(1,i)=mean(file([1325:1425,1570:1650],i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save A081116 A081116
save LoopData HEMJ
end
%% Helium Loop 8_11_2016 11_01_50 - Case 549
% Steady-State Experiment - MT-185
% One SS Experiment - 4.5 g/s, Ti=30, 4.7 MW/m^2, 0.25mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 549;    % Case number
B081116=xlsread('Helium Loop 8_11_2016 11_01_50.csv', 1, 'C30:W20000');
file = B081116;
for i=1:18
    Data(1,i)=mean(file([730:930],i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save B081116 B081116
save LoopData HEMJ
end
%% Helium Loop 8_11_2016 11_14_28 -                                        % Case 550
% Steady-State Experiment - MT-185
% One SS Experiment - 5.5 g/s, Ti=30, 4.7 MW/m^2, 0.25mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 550;    % Case number
C081116=xlsread('Helium Loop 8_11_2016 11_14_28.csv', 1, 'C30:W20000');
file = C081116;
for i=1:18
    Data(1,i)=mean(file([1280:1460],i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save C081116 C081116
save LoopData HEMJ
end
%% Helium Loop 8_11_2016 11_34_23 - Case 551
% Steady-State Experiment - MT-185
% One SS Experiment - 6.75 g/s, Ti=30, 4.5 MW/m^2, 0.25mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 551;    % Case number
D081116=xlsread('Helium Loop 8_11_2016 11_34_23.csv', 1, 'C30:W20000');
file = D081116;
for i=1:18
    Data(1,i)=mean(file([3715:3812],i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save D081116 D081116
save LoopData HEMJ
end
%% Helium Loop 8_11_2016 12_23_54 - Case 552
% Steady-State Experiment - MT-185
% One SS Experiment - 7.75 g/s, Ti=30, 3.9 MW/m^2, 0.25mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 552;    % Case number
E081116=xlsread('Helium Loop 8_11_2016 12_23_54.csv', 1, 'C30:W20000');
file = E081116;
for i=1:18
    Data(1,i)=mean(file([400:470,570:615],i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save E081116 E081116
save LoopData HEMJ
end
%% Helium Loop 11_16_2016 11_11_29 - Case 553
% Steady-State Experiment - MT-185
% One SS Experiment - 3.0 g/s, Ti=400, 1.95 MW/m^2, 0.25mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 553;    % Case number
A111616=xlsread('Helium Loop 11_16_2016 11_11_29.csv', 1, 'C30:W20000');
file = A111616;
for i=1:18
    Data(1,i)=mean(file([1300:1500],i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save A111616 A111616
save LoopData HEMJ
end
%% Helium Loop 11_16_2016 11_31_24 - Case 554
% Steady-State Experiment - MT-185
% One SS Experiment - 4.0 g/s, Ti=400, 1.8 MW/m^2, 0.25mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 554;    % Case number
B111616=xlsread('Helium Loop 11_16_2016 11_31_24.csv', 1, 'C30:W20000');
file = B111616;
for i=1:18
    Data(1,i)=mean(file([2960:3160],i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save B111616 B111616
save LoopData HEMJ
end
%% Helium Loop 11_16_2016 12_12_42 - Case 555
% Steady-State Experiment - MT-185
% One SS Experiment - 5.0 g/s, Ti=400, 1.6 MW/m^2, 0.25mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 555;    % Case number
C111616=xlsread('Helium Loop 11_16_2016 12_12_42.csv', 1, 'C30:W20000');
file = C111616;
for i=1:18
    Data(1,i)=mean(file([1960:2160],i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save C111616 C111616
save LoopData HEMJ
end
%% Helium Loop 11_16_2016 12_41_07 - Case 556
% Steady-State Experiment - MT-185
% One SS Experiment - 6.0 g/s, Ti=400, 1.4 MW/m^2, 0.25mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 556;    % Case number
D111616=xlsread('Helium Loop 11_16_2016 12_41_07.csv', 1, 'C30:W20000');
file = D111616;
for i=1:18
    Data(1,i)=mean(file([1878:2078],i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save D111616 D111616
save LoopData HEMJ
end
%% Helium Loop 11_16_2016 13_08_23 - Case 557
% Steady-State Experiment - MT-185
% One SS Experiment - 7.0 g/s, Ti=400, 1.1 MW/m^2, 0.25mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 557;    % Case number
E111616=xlsread('Helium Loop 11_16_2016 13_08_23.csv', 1, 'C30:W20000');
file = E111616;
for i=1:18
    Data(1,i)=mean(file([2360:2560],i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save E111616 E111616
save LoopData HEMJ
end
%% Helium Loop 11_16_2016 13_41_50 - Case 558
% Steady-State Experiment - MT-185
% One SS Experiment - 8.0 g/s, Ti=400, 0.8 MW/m^2, 0.25mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 558;    % Case number
F111616=xlsread('Helium Loop 11_16_2016 13_41_50.csv', 1, 'C30:W20000');
file = F111616;
for i=1:18
    Data(1,i)=mean(file([3300:3500],i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save F111616 F111616
save LoopData HEMJ
end
%% Helium Loop 11_18_2016 09_47_53 - Case 559
% Steady-State Experiment - MT-185
% One SS Experiment - 3.0 g/s, Ti=27, 2.2 MW/m^2, 0.25mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 559;    % Case number
A111816=xlsread('Helium Loop 11_18_2016 09_47_53.csv', 1, 'C30:W20000');
file = A111816;
for i=1:18
    Data(1,i)=mean(file([954:1154],i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save A111816 A111816
save LoopData HEMJ
end
%% Helium Loop 11_18_2016 10_04_44 -                                       % Case 560
% Steady-State Experiment - MT-185
% One SS Experiment - 4.0 g/s, Ti=27, 2.1 MW/m^2, 0.25mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 560;    % Case number
B111816=xlsread('Helium Loop 11_18_2016 10_04_44.csv', 1, 'C30:W20000');
file = B111816;
for i=1:18
    Data(1,i)=mean(file([982:1162],i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save B111816 B111816
save LoopData HEMJ
end
%% Helium Loop 11_18_2016 10_20_25 - Case 561
% Steady-State Experiment - MT-185
% One SS Experiment - 5.0 g/s, Ti=27, 2.2 MW/m^2, 0.25mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 561;    % Case number
C111816=xlsread('Helium Loop 11_18_2016 10_20_25.csv', 1, 'C30:W20000');
file = C111816;
for i=1:18
    Data(1,i)=mean(file([827:1007],i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save C111816 C111816
save LoopData HEMJ
end
%% Helium Loop 11_18_2016 10_34_02 - Case 562
% Steady-State Experiment - MT-185
% One SS Experiment - 6.0 g/s, Ti=27, 2.0 MW/m^2, 0.25mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 562;    % Case number
D111816=xlsread('Helium Loop 11_18_2016 10_34_02.csv', 1, 'C30:W20000');
file = D111816;
for i=1:18
    Data(1,i)=mean(file([447:647],i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save D111816 D111816
save LoopData HEMJ
end
%% Helium Loop 11_18_2016 10_43_05 - Case 563
% Steady-State Experiment - MT-185
% One SS Experiment - 7.0 g/s, Ti=27, 2.0 MW/m^2, 0.25mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 563;    % Case number
E111816=xlsread('Helium Loop 11_18_2016 10_43_05.csv', 1, 'C30:W20000');
file = E111816;
for i=1:18
    Data(1,i)=mean(file([809:1009],i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save E111816 E111816
save LoopData HEMJ
end
%% Helium Loop 11_18_2016 10_43_05 - Case 564
% Steady-State Experiment - MT-185
% One SS Experiment - 8.0 g/s, Ti=27, 2.0 MW/m^2, 0.25mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 564;    % Case number
F111816=xlsread('Helium Loop 11_18_2016 10_56_46.csv', 1, 'C30:W20000');
file = F111816;
for i=1:18
    Data(1,i)=mean(file([343:543],i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save F111816 F111816
save LoopData HEMJ
end
%% Helium Loop 11_30_2016 10_37_22 - Case 565
% Steady-State Experiment - MT-185
% One SS Experiment - 3.2 g/s, Ti=400, 1.5 MW/m^2, 0.90mm (low Ptest)
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 565;    % Case number
A113016=xlsread('Helium Loop 11_30_2016 10_37_22.csv', 1, 'C30:W20000');
file = A113016;
for i=1:18
    Data(1,i)=mean(file([5044:5244],i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save A113016 A113016
save LoopData HEMJ
end
%% Helium Loop 11_30_2016 11_45_16 - Case 566
% Steady-State Experiment - MT-185
% One SS Experiment - 3.2 g/s, Ti=400, 1.3 MW/m^2, 0.90mm (normal Ptest)
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 566;    % Case number
B113016=xlsread('Helium Loop 11_30_2016 11_45_16.csv', 1, 'C30:W20000');
file = B113016;
for i=1:18
    Data(1,i)=mean(file([1591:1791],i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save B113016 B113016
save LoopData HEMJ
end
%% Helium Loop 11_30_2016 12_08_51 - Case 567
% Steady-State Experiment - MT-185
% One SS Experiment - 4.2 g/s, Ti=400, 1.1 MW/m^2, 0.90mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 567;    % Case number
C113016=xlsread('Helium Loop 11_30_2016 12_08_51.csv', 1, 'C30:W20000');
file = C113016;
for i=1:18
    Data(1,i)=mean(file([3677:3877],i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save C113016 C113016
save LoopData HEMJ
end
%% Helium Loop 11_30_2016 12_59_15 - Case 568
% Steady-State Experiment - MT-185
% One SS Experiment - 5.2 g/s, Ti=400, 0.9 MW/m^2, 0.90mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 568;    % Case number
D113016=xlsread('Helium Loop 11_30_2016 12_59_15.csv', 1, 'C30:W20000');
file = D113016;
for i=1:18
    Data(1,i)=mean(file([1318:1518],i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save D113016 D113016
save LoopData HEMJ
end
%% Helium Loop 11_30_2016 13_19_23 - Case 569
% Steady-State Experiment - MT-185
% One SS Experiment - 6.2 g/s, Ti=400, 0.7 MW/m^2, 0.90mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 569;    % Case number
E113016=xlsread('Helium Loop 11_30_2016 13_19_23.csv', 1, 'C30:W20000');
file = E113016;
for i=1:18
    Data(1,i)=mean(file([2665:2865],i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save E113016 E113016
save LoopData HEMJ
end
%% Helium Loop 11_30_2016 14_03_45 -                                       % Case 570
% Steady-State Experiment - MT-185
% One SS Experiment - 7.2 g/s, Ti=400, 0.5 MW/m^2, 0.90mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 570;    % Case number
F113016=xlsread('Helium Loop 11_30_2016 14_03_45.csv', 1, 'C30:W20000');
file = F113016;
for i=1:18
    Data(1,i)=mean(file([850:1100],i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save F113016 F113016
save LoopData HEMJ
end
%% Helium Loop 11_30_2016 14_20_11 - Case 571
% Steady-State Experiment - MT-185
% One SS Experiment - 8.2 g/s, Ti=400, 0.3 MW/m^2, 0.90mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 571;    % Case number
G113016=xlsread('Helium Loop 11_30_2016 14_20_11.csv', 1, 'C30:W20000');
file = G113016;
for i=1:18
    Data(1,i)=mean(file([1800:2000],i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save G113016 G113016
save LoopData HEMJ
end
%% Helium Loop 12_2_2016 11_37_29 - Case 572
% Steady-State Experiment - MT-185
% One SS Experiment - 3.2 g/s, Ti=300, 1.5 MW/m^2, 0.90mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 572;    % Case number
A120216=xlsread('Helium Loop 12_2_2016 11_37_29.csv', 1, 'C30:W20000');
file = A120216;
for i=1:18
    Data(1,i)=mean(file([3562:3762],i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save A120216 A120216
save LoopData HEMJ
end
%% Helium Loop 12_2_2016 12_26_23 - Case 573
% Steady-State Experiment - MT-185
% One SS Experiment - 4.3 g/s, Ti=300, 1.5 MW/m^2, 0.90mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 573;    % Case number
B120216=xlsread('Helium Loop 12_2_2016 12_26_23.csv', 1, 'C30:W20000');
file = B120216;
for i=1:18
    Data(1,i)=mean(file([2620:2820],i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save B120216 B120216
save LoopData HEMJ
end
%% Helium Loop 12_2_2016 13_07_59 - Case 574
% Steady-State Experiment - MT-185
% One SS Experiment - 5.2 g/s, Ti=300, 1.5 MW/m^2, 0.90mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 574;    % Case number
C120216=xlsread('Helium Loop 12_2_2016 13_07_59.csv', 1, 'C30:W20000');
file = C120216;
for i=1:18
    Data(1,i)=mean(file([2340:2520],i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save C120216 C120216
save LoopData HEMJ
end
%% Helium Loop 12_2_2016 13_41_01 - Case 575
% Steady-State Experiment - MT-185
% One SS Experiment - 6.2 g/s, Ti=300, 1.4 MW/m^2, 0.90mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 575;    % Case number
D120216=xlsread('Helium Loop 12_2_2016 13_41_01.csv', 1, 'C30:W20000');
file = D120216;
for i=1:18
    Data(1,i)=mean(file([1300:1500],i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save D120216 D120216
save LoopData HEMJ
end
%% Helium Loop 12_2_2016 14_02_08 - Case 576
% Steady-State Experiment - MT-185
% One SS Experiment - 7.2 g/s, Ti=300, 1.3 MW/m^2, 0.90mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 576;    % Case number
E120216=xlsread('Helium Loop 12_2_2016 14_02_08.csv', 1, 'C30:W20000');
file = E120216;
for i=1:18
    Data(1,i)=mean(file([1800:2000],i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save E120216 E120216
save LoopData HEMJ
end
%% Helium Loop 12_2_2016 14_28_52 - Case 577
% Steady-State Experiment - MT-185
% One SS Experiment - 8.2 g/s, Ti=300, 1.25 MW/m^2, 0.90mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 577;    % Case number
F120216=xlsread('Helium Loop 12_2_2016 14_28_52.csv', 1, 'C30:W20000');
file = F120216;
for i=1:18
    Data(1,i)=mean(file([938:1138],i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save F120216 F120216
save LoopData HEMJ
end
%% Helium Loop 12_8_2016 12_24_52 - Case 578
% Steady-State Experiment - WL10
% One SS Experiment - 3.0 g/s, Ti=400, 1.15 MW/m^2, 0.90mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 578;    % Case number
A120816=xlsread('Helium Loop 12_8_2016 12_24_52.csv', 1, 'C30:W20000');
file = A120816;
for i=1:18
    Data(1,i)=mean(file([790:990],i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save A120816 A120816
save LoopData HEMJ
end
%% Helium Loop 12_8_2016 12_38_19 - Case 579
% Steady-State Experiment - WL10
% One SS Experiment - 4.0 g/s, Ti=400, 0.8 MW/m^2, 0.90mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 579;    % Case number
B120816=xlsread('Helium Loop 12_8_2016 12_38_19.csv', 1, 'C30:W20000');
file = B120816;
for i=1:18
    Data(1,i)=mean(file([800:1100],i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save B120816 B120816
save LoopData HEMJ
end
%% Helium Loop 12_8_2016 12_53_45 -                                        % Case 580
% Steady-State Experiment - WL10
% One SS Experiment - 5.0 g/s, Ti=400, 0.6 MW/m^2, 0.90mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 580;    % Case number
C120816=xlsread('Helium Loop 12_8_2016 12_53_45.csv', 1, 'C30:W20000');
file = C120816;
for i=1:18
    Data(1,i)=mean(file([800:1000],i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save C120816 C120816
save LoopData HEMJ
end
%% Helium Loop 12_8_2016 13_07_16 - Case 581
% Steady-State Experiment - WL10
% One SS Experiment - 6.0 g/s, Ti=400, 0.5 MW/m^2, 0.90mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 581;    % Case number
D120816=xlsread('Helium Loop 12_8_2016 13_07_16.csv', 1, 'C30:W20000');
file = D120816;
for i=1:18
    Data(1,i)=mean(file([1500:1700],i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save D120816 D120816
save LoopData HEMJ
end
%% Helium Loop 12_8_2016 13_29_43 - Case 582
% Steady-State Experiment - WL10
% One SS Experiment - 7.0 g/s, Ti=400, 0.3 MW/m^2, 0.90mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 582;    % Case number
E120816=xlsread('Helium Loop 12_8_2016 13_29_43.csv', 1, 'C30:W20000');
file = E120816;
for i=1:18
    Data(1,i)=mean(file([850:1050],i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save E120816 E120816
save LoopData HEMJ
end
%% Helium Loop 12_8_2016 13_44_03 - Case 583
% Steady-State Experiment - WL10
% One SS Experiment - 8.0 g/s, Ti=400, 0.15 MW/m^2, 0.90mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 583;    % Case number
F120816=xlsread('Helium Loop 12_8_2016 13_44_03.csv', 1, 'C30:W20000');
file = F120816;
for i=1:18
    Data(1,i)=mean(file([2100:2340],i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save F120816 F120816
save LoopData HEMJ
end
%% Helium Loop 12_8_2016 14_15_08 - Case 584
% Steady-State Experiment - WL10
% One SS Experiment - 8.0 g/s, Ti=300, 1.1 MW/m^2, 0.90mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 584;    % Case number
G120816=xlsread('Helium Loop 12_8_2016 14_15_08.csv', 1, 'C30:W20000');
file = G120816;
for i=1:18
    Data(1,i)=mean(file([2400:2600],i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save G120816 G120816
save LoopData HEMJ
end
%% Helium Loop 12_8_2016 14_49_19 - Case 585
% Steady-State Experiment - WL10
% One SS Experiment - 7.0 g/s, Ti=300, 1.1 MW/m^2, 0.90mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 585;    % Case number
H120816=xlsread('Helium Loop 12_8_2016 14_49_19.csv', 1, 'C30:W20000');
file = H120816;
for i=1:18
    Data(1,i)=mean(file([1279:1479],i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save H120816 H120816
save LoopData HEMJ
end
%% Helium Loop 12_8_2016 15_08_53 - Case 586
% Steady-State Experiment - WL10
% One SS Experiment - 6.0 g/s, Ti=300, 1.2 MW/m^2, 0.90mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 586;    % Case number
I120816=xlsread('Helium Loop 12_8_2016 15_08_53.csv', 1, 'C30:W20000');
file = I120816;
for i=1:18
    Data(1,i)=mean(file([1690:1890],i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save I120816 I120816
save LoopData HEMJ
end
%% Helium Loop 12_8_2016 15_33_47 - Case 587
% Steady-State Experiment - WL10
% One SS Experiment - 5.0 g/s, Ti=300, 1.3 MW/m^2, 0.90mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 587;    % Case number
J120816=xlsread('Helium Loop 12_8_2016 15_33_47.csv', 1, 'C30:W20000');
file = J120816;
for i=1:18
    Data(1,i)=mean(file([721:921],i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save J120816 J120816
save LoopData HEMJ
end
%% Helium Loop 12_8_2016 15_46_13 - Case 588
% Steady-State Experiment - WL10
% One SS Experiment - 4.0 g/s, Ti=300, 1.4 MW/m^2, 0.90mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 588;    % Case number
K120816=xlsread('Helium Loop 12_8_2016 15_46_13.csv', 1, 'C30:W20000');
file = K120816;
for i=1:18
    Data(1,i)=mean(file([680:880],i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save K120816 K120816
save LoopData HEMJ
end
%% Helium Loop 12_8_2016 15_58_45 - Case 589
% Steady-State Experiment - WL10
% One SS Experiment - 3.0 g/s, Ti=300, 1.4 MW/m^2, 0.90mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 589;    % Case number
L120816=xlsread('Helium Loop 12_8_2016 15_58_45.csv', 1, 'C30:W20000');
file = L120816;
for i=1:18
    Data(1,i)=mean(file([1522:1722],i));
end
Ptest = Data(1,16); tempData = Data(1,12:13);
HEMJ(x,1) = Data(1,1); HEMJ(x,2:3) = 0;
HEMJ(x,4:18) = [Data(1,2:11) Ptest tempData 0 Data(1,15)];
HEMJ(x,19)=99000; HEMJ(x,20)=0;
save L120816 L120816
save LoopData HEMJ
end
%% Helium Loop 5_28_2017 16_52_05 -                                        % Case 590 - Experiments with Vacuum Chamber
% Steady-State Experiment - WL10
% One SS Experiment - 3.1 g/s, Ti=30, 1.3 MW/m^2, 0.90mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 590;    % Case number
A052817=xlsread('Helium Loop 5_28_2017 16_52_05.csv', 1, 'C50:X20000');
file = A052817;
for i=1:22
    Data(1,i)=mean(file([2300:2480],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
% HEMJ(x,:) = [Data(1,1) 0 0 Data(1,5) Data(1,4) Data(1,2) Data(1,3) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save A052817 A052817
save LoopData HEMJ
end
%% Helium Loop 5_28_2017 17_30_00 - Case 591
% Steady-State Experiment - WL10
% One SS Experiment - 4.1 g/s, Ti=30, 1.3 MW/m^2, 0.90mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 591;    % Case number
B052817=xlsread('Helium Loop 5_28_2017 17_30_00.csv', 1, 'C50:X20000');
file = B052817;
for i=1:22
    Data(1,i)=mean(file([840:1020],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
% HEMJ(x,:) = [Data(1,1) 0 0 Data(1,5) Data(1,4) Data(1,2) Data(1,3) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save B052817 B052817
save LoopData HEMJ
end
%% Helium Loop 5_28_2017 17_45_30 - Case 592
% Steady-State Experiment - WL10
% One SS Experiment - 5.1 g/s, Ti=30, 1.3 MW/m^2, 0.90mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 592;    % Case number
C052817=xlsread('Helium Loop 5_28_2017 17_45_30.csv', 1, 'C50:X20000');
file = C052817;
for i=1:22
    Data(1,i)=mean(file([460:660],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
% HEMJ(x,:) = [Data(1,1) 0 0 Data(1,5) Data(1,4) Data(1,2) Data(1,3) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save C052817 C052817
save LoopData HEMJ
end
%% Helium Loop 5_28_2017 17_55_44 - Case 593
% Steady-State Experiment - WL10
% One SS Experiment - 6.3 g/s, Ti=30, 1.3 MW/m^2, 0.90mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 593;    % Case number
D052817=xlsread('Helium Loop 5_28_2017 17_55_44.csv', 1, 'C50:X20000');
file = D052817;
for i=1:22
    Data(1,i)=mean(file([600:770],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
% HEMJ(x,:) = [Data(1,1) 0 0 Data(1,5) Data(1,4) Data(1,2) Data(1,3) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save D052817 D052817
save LoopData HEMJ
end
%% Helium Loop 5_28_2017 18_12_42 - Case 594
% Steady-State Experiment - WL10
% One SS Experiment - 7.1 g/s, Ti=30, 1.3 MW/m^2, 0.90mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 594;    % Case number
E052817=xlsread('Helium Loop 5_28_2017 18_12_42.csv', 1, 'C50:X20000');
file = E052817;
for i=1:22
    Data(1,i)=mean(file([380:560],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
% HEMJ(x,:) = [Data(1,1) 0 0 Data(1,5) Data(1,4) Data(1,2) Data(1,3) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save E052817 E052817
save LoopData HEMJ
end
%% Helium Loop 5_31_2017 13_50_17 - Case 595
% Steady-State Experiment - WL10
% One SS Experiment - 3.1 g/s, Ti=30, 0.8 MW/m^2, 0.90mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 595;    % Case number
A053117=xlsread('Helium Loop 5_31_2017 13_50_17.csv', 1, 'C50:X20000');
file = A053117;
for i=1:22
    Data(1,i)=mean(file([2310:2420],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
% HEMJ(x,:) = [Data(1,1) 0 0 Data(1,5) Data(1,4) Data(1,2) Data(1,3) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save A053117 A053117
save LoopData HEMJ
end
%% Helium Loop 5_31_2017 14_26_02 - Case 596
% Steady-State Experiment - WL10
% One SS Experiment - 4.0 g/s, Ti=30, 0.8 MW/m^2, 0.90mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 596;    % Case number
B053117=xlsread('Helium Loop 5_31_2017 14_26_02.csv', 1, 'C50:X20000');
file = B053117;
for i=1:22
    Data(1,i)=mean(file([770:903],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
% HEMJ(x,:) = [Data(1,1) 0 0 Data(1,5) Data(1,4) Data(1,2) Data(1,3) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save B053117 B053117
save LoopData HEMJ
end
%% Helium Loop 5_31_2017 14_39_58 - Case 597
% Steady-State Experiment - WL10
% One SS Experiment - 5.0 g/s, Ti=30, 0.8 MW/m^2, 0.90mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 597;    % Case number
C053117=xlsread('Helium Loop 5_31_2017 14_39_58.csv', 1, 'C50:X20000');
file = C053117;
for i=1:22
    Data(1,i)=mean(file([528:728],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
% HEMJ(x,:) = [Data(1,1) 0 0 Data(1,5) Data(1,4) Data(1,2) Data(1,3) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save C053117 C053117
save LoopData HEMJ
end
%% Helium Loop 5_31_2017 14_51_07 - Case 598
% Steady-State Experiment - WL10
% One SS Experiment - 6.1 g/s, Ti=30, 0.8 MW/m^2, 0.90mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 598;    % Case number
D053117=xlsread('Helium Loop 5_31_2017 14_51_07.csv', 1, 'C50:X20000');
file = D053117;
for i=1:22
    Data(1,i)=mean(file([490:673],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
% HEMJ(x,:) = [Data(1,1) 0 0 Data(1,5) Data(1,4) Data(1,2) Data(1,3) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save D053117 D053117
save LoopData HEMJ
end
%% Helium Loop 5_31_2017 15_01_28 - Case 599
% Steady-State Experiment - WL10
% One SS Experiment - 7.0 g/s, Ti=30, 0.8 MW/m^2, 0.90mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 599;    % Case number
E053117=xlsread('Helium Loop 5_31_2017 15_01_28.csv', 1, 'C50:X20000');
file = E053117;
for i=1:22
    Data(1,i)=mean(file([555:755],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
% HEMJ(x,:) = [Data(1,1) 0 0 Data(1,5) Data(1,4) Data(1,2) Data(1,3) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save E053117 E053117
save LoopData HEMJ
end
%% Helium Loop 6_2_2017 15_24_20 -                                         % Case 600
% Steady-State Experiment - WL10
% One SS Experiment - 3.0 g/s, Ti=30, 1.45 MW/m^2, 0.90mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 600;    % Case number
A060217=xlsread('Helium Loop 6_2_2017 15_24_20.csv', 1, 'C50:X20000');
file = A060217;
for i=1:22
    Data(1,i)=mean(file([782:982],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save A060217 A060217
save LoopData HEMJ
end
%% Helium Loop 6_2_2017 15_49_54 - Case 601
% Steady-State Experiment - WL10
% One SS Experiment - 3.9 g/s, Ti=30, 1.4 MW/m^2, 0.90mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 601;    % Case number
B060217=xlsread('Helium Loop 6_2_2017 15_49_54.csv', 1, 'C50:X20000');
file = B060217;
for i=1:22
    Data(1,i)=mean(file(:,i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save B060217 B060217
save LoopData HEMJ
end
%% Helium Loop 6_2_2017 15_57_03 - Case 602
% Steady-State Experiment - WL10
% One SS Experiment - 5.4 g/s, Ti=30, 1.35 MW/m^2, 0.90mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 602;    % Case number
C060217=xlsread('Helium Loop 6_2_2017 15_57_03.csv', 1, 'C50:X20000');
file = C060217;
for i=1:22
    Data(1,i)=mean(file([1860:2060],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save C060217 C060217
save LoopData HEMJ
end
%% Helium Loop 6_2_2017 16_27_29 - Case 603
% Steady-State Experiment - WL10
% One SS Experiment - 6.2 g/s, Ti=30, 1.3 MW/m^2, 0.90mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 603;    % Case number
D060217=xlsread('Helium Loop 6_2_2017 16_27_29.csv', 1, 'C50:X20000');
file = D060217;
for i=1:22
    Data(1,i)=mean(file([2050:2250],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save D060217 D060217
save LoopData HEMJ
end
%% Helium Loop 6_2_2017 17_00_45 - Case 604
% Steady-State Experiment - WL10
% One SS Experiment - 7.0 g/s, Ti=30, 1.3 MW/m^2, 0.90mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 604;    % Case number
E060217=xlsread('Helium Loop 6_2_2017 17_00_45.csv', 1, 'C50:X20000');
file = E060217;
for i=1:22
    Data(1,i)=mean(file([669:869],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save E060217 E060217
save LoopData HEMJ
end
%% Helium Loop 6_2_2017 17_13_57 - Case 605
% Steady-State Experiment - WL10
% One SS Experiment - 7.5 g/s, Ti=30, 1.3 MW/m^2, 0.90mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 605;    % Case number
F060217=xlsread('Helium Loop 6_2_2017 17_13_57.csv', 1, 'C50:X20000');
file = F060217;
for i=1:22
    Data(1,i)=mean(file([200:400],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save F060217 F060217
save LoopData HEMJ
end
%% Helium Loop 6_6_2017 16_20_15 - Case 606
% Steady-State Experiment - WL10
% One SS Experiment - 3.2 g/s, Ti=200, 1.45 MW/m^2, 0.90mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 606;    % Case number
A060617=xlsread('Helium Loop 6_6_2017 16_20_15.csv', 1, 'C50:X20000');
file = A060617;
for i=1:22
    Data(1,i)=mean(file([1171:1371],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save A060617 A060617
save LoopData HEMJ
end
%% Helium Loop 6_6_2017 16_40_43 - Case 607
% Steady-State Experiment - WL10
% One SS Experiment - 4.0 g/s, Ti=200, 1.45 MW/m^2, 0.90mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 607;    % Case number
B060617=xlsread('Helium Loop 6_6_2017 16_40_43.csv', 1, 'C50:X20000');
file = B060617;
for i=1:22
    Data(1,i)=mean(file([2436:2636],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save B060617 B060617
save LoopData HEMJ
end
%% Helium Loop 6_6_2017 17_19_31 - Case 608
% Steady-State Experiment - WL10
% One SS Experiment - 5.0 g/s, Ti=200, 1.45 MW/m^2, 0.90mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 608;    % Case number
C060617=xlsread('Helium Loop 6_6_2017 17_19_31.csv', 1, 'C50:X20000');
file = C060617;
for i=1:22
    Data(1,i)=mean(file([2046:2246],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save C060617 C060617
save LoopData HEMJ
end
%% Helium Loop 6_6_2017 17_52_39 - Case 609
% Steady-State Experiment - WL10
% One SS Experiment - 6.0 g/s, Ti=200, 1.45 MW/m^2, 0.90mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 609;    % Case number
D060617=xlsread('Helium Loop 6_6_2017 17_52_39.csv', 1, 'C50:X20000');
file = D060617;
for i=1:22
    Data(1,i)=mean(file([1189:1389],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save D060617 D060617
save LoopData HEMJ
end
%% Helium Loop 6_6_2017 18_16_02 -                                         % Case 610
% Steady-State Experiment - WL10
% One SS Experiment - 7.0 g/s, Ti=200, 1.45 MW/m^2, 0.90mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 610;    % Case number
E060617=xlsread('Helium Loop 6_6_2017 18_16_02.csv', 1, 'C50:X20000');
file = E060617;
for i=1:22
    Data(1,i)=mean(file([837:1037],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save E060617 E060617
save LoopData HEMJ
end
%% Helium Loop 6_6_2017 18_31_40 - Case 611
% Steady-State Experiment - WL10
% One SS Experiment - 8.0 g/s, Ti=200, 1.45 MW/m^2, 0.90mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 611;    % Case number
F060617=xlsread('Helium Loop 6_6_2017 18_31_40.csv', 1, 'C50:X20000');
file = F060617;
for i=1:22
    Data(1,i)=mean(file([841:1041],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save F060617 F060617
save LoopData HEMJ
end
%% Helium Loop 6_7_2017 12_41_37 - Case 612
% Steady-State Experiment - WL10
% One SS Experiment - 3.15 g/s, Ti=300, 2.1 MW/m^2, 0.90mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 612;    % Case number
A060717=xlsread('Helium Loop 6_7_2017 12_41_37.csv', 1, 'C50:X20000');
file = A060717;
for i=1:22
    Data(1,i)=mean(file([17:210],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save A060717 A060717
save LoopData HEMJ
end
%% Helium Loop 6_7_2017 12_46_14 - Case 613
% Steady-State Experiment - WL10
% One SS Experiment - 4.0 g/s, Ti=300, 2.1 MW/m^2, 0.90mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 613;    % Case number
B060717=xlsread('Helium Loop 6_7_2017 12_46_14.csv', 1, 'C50:X20000');
file = B060717;
for i=1:22
    Data(1,i)=mean(file([1800:2000],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save B060717 B060717
save LoopData HEMJ
end
%% Helium Loop 6_7_2017 13_17_04 - Case 614
% Steady-State Experiment - WL10
% One SS Experiment - 4.9 g/s, Ti=300, 2.1 MW/m^2, 0.90mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 614;    % Case number
C060717=xlsread('Helium Loop 6_7_2017 13_17_04.csv', 1, 'C50:X20000');
file = C060717;
for i=1:22
    Data(1,i)=mean(file([2650:2850],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save C060717 C060717
save LoopData HEMJ
end
%% Helium Loop 6_7_2017 14_00_14 - Case 615
% Steady-State Experiment - WL10
% One SS Experiment - 5.9 g/s, Ti=300, 2.1 MW/m^2, 0.90mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 615;    % Case number
D060717=xlsread('Helium Loop 6_7_2017 14_00_14.csv', 1, 'C50:X20000');
file = D060717;
for i=1:22
    Data(1,i)=mean(file([1250:1450],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save D060717 D060717
save LoopData HEMJ
end
%% Helium Loop 6_7_2017 14_26_46 - Case 616
% Steady-State Experiment - WL10
% One SS Experiment - 6.9 g/s, Ti=300, 2.1 MW/m^2, 0.90mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 616;    % Case number
E060717=xlsread('Helium Loop 6_7_2017 14_26_46.csv', 1, 'C50:X20000');
file = E060717;
for i=1:22
    Data(1,i)=mean(file([2800:2980],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save E060717 E060717
save LoopData HEMJ
end
%% Helium Loop 6_7_2017 15_12_37 - Case 617
% Steady-State Experiment - WL10
% One SS Experiment - 8.0 g/s, Ti=300, 2.1 MW/m^2, 0.90mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 617;    % Case number
F060717=xlsread('Helium Loop 6_7_2017 15_12_37.csv', 1, 'C50:X20000');
file = F060717;
for i=1:22
    Data(1,i)=mean(file([2559:2759],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save F060717 F060717
save LoopData HEMJ
end
%% Helium Loop 6_8_2017 12_15_00 - Case 618
% Steady-State Experiment - WL10
% One SS Experiment - 3.2 g/s, Ti=400, 1.8 MW/m^2, 0.90mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 618;    % Case number
A060817=xlsread('Helium Loop 6_8_2017 12_15_00.csv', 1, 'C50:X20000');
file = A060817;
for i=1:22
    Data(1,i)=mean(file([3592:3792],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save A060817 A060817
save LoopData HEMJ
end
%% Helium Loop 6_8_2017 13_10_31 - Case 619
% Steady-State Experiment - WL10
% One SS Experiment - 4.0 g/s, Ti=400, 1.7 MW/m^2, 0.90mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 619;    % Case number
B060817=xlsread('Helium Loop 6_8_2017 13_10_31.csv', 1, 'C50:X20000');
file = B060817;
for i=1:22
    Data(1,i)=mean(file([3000:3200],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save B060817 B060817
save LoopData HEMJ
end
%% Helium Loop 6_8_2017 13_57_36 -                                         % Case 620
% Steady-State Experiment - WL10
% One SS Experiment - 5.0 g/s, Ti=400, 1.6 MW/m^2, 0.90mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 620;    % Case number
C060817=xlsread('Helium Loop 6_8_2017 13_57_36.csv', 1, 'C50:X20000');
file = C060817;
for i=1:22
    Data(1,i)=mean(file([1556:1756],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save C060817 C060817
save LoopData HEMJ
end
%% Helium Loop 6_8_2017 14_23_40 - Case 621
% Steady-State Experiment - WL10
% One SS Experiment - 6.0 g/s, Ti=400, 1.5 MW/m^2, 0.90mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 621;    % Case number
D060817=xlsread('Helium Loop 6_8_2017 14_23_40.csv', 1, 'C50:X20000');
file = D060817;
for i=1:22
    Data(1,i)=mean(file([1600:1800],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save D060817 D060817
save LoopData HEMJ
end
%% Helium Loop 6_8_2017 14_50_25 - Case 622
% Steady-State Experiment - WL10
% One SS Experiment - 7.0 g/s, Ti=400, 1.5 MW/m^2, 0.90mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 622;    % Case number
E060817=xlsread('Helium Loop 6_8_2017 14_50_25.csv', 1, 'C50:X20000');
file = E060817;
for i=1:22
    Data(1,i)=mean(file([2340:2540],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save E060817 E060817
save LoopData HEMJ
end
%% Helium Loop 6_8_2017 15_27_51 - Case 623
% Steady-State Experiment - WL10
% One SS Experiment - 8.0 g/s, Ti=400, 1.5 MW/m^2, 0.90mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 623;    % Case number
F060817=xlsread('Helium Loop 6_8_2017 15_27_51.csv', 1, 'C50:X20000');
file = F060817;
for i=1:22
    Data(1,i)=mean(file([800:1000],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save F060817 F060817
save LoopData HEMJ
end
%% Helium Loop 6_9_2017 12_38_02 - Case 624
% Steady-State Experiment - WL10
% One SS Experiment - 3.0 g/s, Ti=100, 1.4 MW/m^2, 0.90mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 624;    % Case number
A060917=xlsread('Helium Loop 6_9_2017 12_38_02.csv', 1, 'C50:X20000');
file = A060917;
for i=1:22
    Data(1,i)=mean(file([800:1000],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save A060917 A060917
save LoopData HEMJ
end
%% Helium Loop 6_9_2017 12_53_08 - Case 625
% Steady-State Experiment - WL10
% One SS Experiment - 4.0 g/s, Ti=100, 1.4 MW/m^2, 0.90mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 625;    % Case number
B060917=xlsread('Helium Loop 6_9_2017 12_53_08.csv', 1, 'C50:X20000');
file = B060917;
for i=1:22
    Data(1,i)=mean(file([1039:1239],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save B060917 B060917
save LoopData HEMJ
end
%% Helium Loop 6_9_2017 13_11_42 - Case 626
% Steady-State Experiment - WL10
% One SS Experiment - 5.0 g/s, Ti=100, 1.4 MW/m^2, 0.90mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 626;    % Case number
C060917=xlsread('Helium Loop 6_9_2017 13_11_42.csv', 1, 'C50:X20000');
file = C060917;
for i=1:22
    Data(1,i)=mean(file([1659:1859],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save C060917 C060917
save LoopData HEMJ
end
%% Helium Loop 6_9_2017 13_39_13 - Case 627
% Steady-State Experiment - WL10
% One SS Experiment - 6.0 g/s, Ti=100, 1.4 MW/m^2, 0.90mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 627;    % Case number
D060917=xlsread('Helium Loop 6_9_2017 13_39_13.csv', 1, 'C50:X20000');
file = D060917;
for i=1:22
    Data(1,i)=mean(file([1413:1613],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save D060917 D060917
save LoopData HEMJ
end
%% Helium Loop 6_9_2017 14_03_09 - Case 628
% Steady-State Experiment - WL10
% One SS Experiment - 7.0 g/s, Ti=100, 1.4 MW/m^2, 0.90mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 628;    % Case number
E060917=xlsread('Helium Loop 6_9_2017 14_03_09.csv', 1, 'C50:X20000');
file = E060917;
for i=1:22
    Data(1,i)=mean(file([1249:1449],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save E060917 E060917
save LoopData HEMJ
end
%% Helium Loop 6_9_2017 14_24_45 - Case 629
% Steady-State Experiment - WL10
% One SS Experiment - 8.0 g/s, Ti=100, 1.4 MW/m^2, 0.90mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 629;    % Case number
F060917=xlsread('Helium Loop 6_9_2017 14_24_45.csv', 1, 'C50:X20000');
file = F060917;
for i=1:22
    Data(1,i)=mean(file([786:986],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save F060917 F060917
save LoopData HEMJ
end
%% Helium Loop 6_10_2017 12_36_03 -                                        % Case 629
% Steady-State Experiment - WL10
% One SS Experiment - 3.1 g/s, Ti=350, 1.5 MW/m^2, 0.90mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 630;    % Case number
A061017=xlsread('Helium Loop 6_10_2017 12_36_03.csv', 1, 'C50:X20000');
file = A061017;
for i=1:22
    Data(1,i)=mean(file([925:1125],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save A061017 A061017
save LoopData HEMJ
end
%% Helium Loop 6_10_2017 12_52_57 - Case 631
% Steady-State Experiment - WL10
% One SS Experiment - 4.0 g/s, Ti=350, 1.5 MW/m^2, 0.90mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 631;    % Case number
B061017=xlsread('Helium Loop 6_10_2017 12_52_57.csv', 1, 'C50:X20000');
file = B061017;
for i=1:22
    Data(1,i)=mean(file([752:952],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save B061017 B061017
save LoopData HEMJ
end
%% Helium Loop 6_10_2017 13_07_20 - Case 632
% Steady-State Experiment - WL10
% One SS Experiment - 5.0 g/s, Ti=350, 1.5 MW/m^2, 0.90mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 632;    % Case number
C061017=xlsread('Helium Loop 6_10_2017 13_07_20.csv', 1, 'C50:X20000');
file = C061017;
for i=1:22
    Data(1,i)=mean(file([2275:2450],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save C061017 C061017
save LoopData HEMJ
end
%% Helium Loop 6_10_2017 14_14_09 - Case 633
% Steady-State Experiment - WL10
% One SS Experiment - 6.0 g/s, Ti=350, 1.5 MW/m^2, 0.90mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 633;    % Case number
D061017=xlsread('Helium Loop 6_10_2017 14_14_09.csv', 1, 'C50:X20000');
file = D061017;
for i=1:22
    Data(1,i)=mean(file([936:1136],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save D061017 D061017
save LoopData HEMJ
end
%% Helium Loop 6_10_2017 14_31_10 - Case 634
% Steady-State Experiment - WL10
% One SS Experiment - 7.0 g/s, Ti=350, 1.5 MW/m^2, 0.90mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 634;    % Case number
E061017=xlsread('Helium Loop 6_10_2017 14_31_10.csv', 1, 'C50:X20000');
file = E061017;
for i=1:22
    Data(1,i)=mean(file([770:970],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save E061017 E061017
save LoopData HEMJ
end
%% Helium Loop 6_10_2017 14_46_33 - Case 635
% Steady-State Experiment - WL10
% One SS Experiment - 8.0 g/s, Ti=350, 1.5 MW/m^2, 0.90mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 635;    % Case number
F061017=xlsread('Helium Loop 6_10_2017 14_46_33.csv', 1, 'C50:X20000');
file = F061017;
for i=1:22
    Data(1,i)=mean(file([1600:1800],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save F061017 F061017
save LoopData HEMJ
end
%% Helium Loop 6_12_2017 11_57_56 - Case 636
% Steady-State Experiment - WL10
% One SS Experiment - 8.0 g/s, Ti=425, 1.45 MW/m^2, 0.90mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 636;    % Case number
A061217=xlsread('Helium Loop 6_12_2017 11_57_56.csv', 1, 'C50:X20000');
file = A061217;
for i=1:22
    Data(1,i)=mean(file([3342:3522],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save A061217 A061217
save LoopData HEMJ
end
%% Helium Loop 6_12_2017 12_49_32 - Case 637
% Steady-State Experiment - WL10
% One SS Experiment - 7.0 g/s, Ti=425, 1.35 MW/m^2, 0.90mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 637;    % Case number
B061217=xlsread('Helium Loop 6_12_2017 12_49_32.csv', 1, 'C50:X20000');
file = B061217;
for i=1:22
    Data(1,i)=mean(file([2127:2327],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save B061217 B061217
save LoopData HEMJ
end
%% Helium Loop 6_12_2017 13_24_32 - Case 638
% Steady-State Experiment - WL10
% One SS Experiment - 6.0 g/s, Ti=425, 1.3 MW/m^2, 0.90mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 638;    % Case number
C061217=xlsread('Helium Loop 6_12_2017 13_24_32.csv', 1, 'C50:X20000');
file = C061217;
for i=1:22
    Data(1,i)=mean(file([2056:2256],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save C061217 C061217
save LoopData HEMJ
end
%% Helium Loop 6_12_2017 13_57_48 - Case 639
% Steady-State Experiment - WL10
% One SS Experiment - 5.0 g/s, Ti=425, 1.25 MW/m^2, 0.90mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 639;    % Case number
D061217=xlsread('Helium Loop 6_12_2017 13_57_48.csv', 1, 'C50:X20000');
file = D061217;
for i=1:22
    Data(1,i)=mean(file([1934:2134],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save D061217 D061217
save LoopData HEMJ
end
%% Helium Loop 6_12_2017 14_29_18 -                                        % Case 640
% Steady-State Experiment - WL10
% One SS Experiment - 4.0 g/s, Ti=425, 1.2 MW/m^2, 0.90mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 640;    % Case number
E061217=xlsread('Helium Loop 6_12_2017 14_29_18.csv', 1, 'C50:X20000');
file = E061217;
for i=1:22
    Data(1,i)=mean(file([2518:2698],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save E061217 E061217
save LoopData HEMJ
end
%% Helium Loop 6_12_2017 15_08_57 - Case 641
% Steady-State Experiment - WL10
% One SS Experiment - 3.0 g/s, Ti=425, 1.15 MW/m^2, 0.90mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 641;    % Case number
F061217=xlsread('Helium Loop 6_12_2017 15_08_57.csv', 1, 'C50:X20000');
file = F061217;
for i=1:22
    Data(1,i)=mean(file([2208:2408],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save F061217 F061217
save LoopData HEMJ
end
%% Helium Loop 6_13_2017 11_56_29 - Case 642
% Steady-State Experiment - WL10
% One SS Experiment - 3.1 g/s, Ti=375, 1.7 MW/m^2, 0.90mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 642;    % Case number
A061317=xlsread('Helium Loop 6_13_2017 11_56_29.csv', 1, 'C50:X20000');
file = A061317;
for i=1:22
    Data(1,i)=mean(file([110:310],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save A061317 A061317
save LoopData HEMJ
end
%% Helium Loop 6_13_2017 12_35_42 - Case 643
% Steady-State Experiment - WL10
% One SS Experiment - 4.0 g/s, Ti=375, 1.7 MW/m^2, 0.90mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 643;    % Case number
B061317=xlsread('Helium Loop 6_13_2017 12_35_42.csv', 1, 'C50:X20000');
file = B061317;
for i=1:22
    Data(1,i)=mean(file([255:410,440:467],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save B061317 B061317
save LoopData HEMJ
end
%% Helium Loop 6_13_2017 12_54_47 - Case 644
% Steady-State Experiment - WL10
% One SS Experiment - 5.0 g/s, Ti=375, 1.7 MW/m^2, 0.90mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 644;    % Case number
C061317=xlsread('Helium Loop 6_13_2017 12_54_47.csv', 1, 'C50:X20000');
file = C061317;
for i=1:22
    Data(1,i)=mean(file([970:1149],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save C061317 C061317
save LoopData HEMJ
end
%% Helium Loop 6_13_2017 13_46_22 - Case 645
% Steady-State Experiment - WL10
% One SS Experiment - 6.0 g/s, Ti=375, 1.7 MW/m^2, 0.90mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 645;    % Case number
D061317=xlsread('Helium Loop 6_13_2017 13_46_22.csv', 1, 'C50:X20000');
file = D061317;
for i=1:22
    Data(1,i)=mean(file([140:320],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save D061317 D061317
save LoopData HEMJ
end
%% Helium Loop 6_13_2017 14_38_21 - Case 646
% Steady-State Experiment - WL10
% One SS Experiment - 7.0 g/s, Ti=375, 1.7 MW/m^2, 0.90mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 646;    % Case number
E061317=xlsread('Helium Loop 6_13_2017 14_38_21.csv', 1, 'C50:X20000');
file = E061317;
for i=1:22
    Data(1,i)=mean(file([21:133,155:204],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save E061317 E061317
save LoopData HEMJ
end
%% Helium Loop 6_13_2017 15_25_19 - Case 647
% Steady-State Experiment - WL10
% One SS Experiment - 8.0 g/s, Ti=375, 1.7 MW/m^2, 0.90mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 647;    % Case number
F061317=xlsread('Helium Loop 6_13_2017 15_25_19.csv', 1, 'C50:X20000');
file = F061317;
for i=1:22
    Data(1,i)=mean(file([1750:2128],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save F061317 F061317
save LoopData HEMJ
end
%% Helium Loop 6_20_2017 13_18_25 - Case 648
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 3.0 g/s, Ti=100, 2.3 MW/m^2, 1.25mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 648;    % Case number
A062017=xlsread('Helium Loop 6_20_2017 13_18_25.csv', 1, 'C50:X20000');
file = A062017;
for i=1:22
    Data(1,i)=mean(file([1600:1760],i));
%     Data(1,i)=mean(file([1480:1580],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save A062017 A062017
save LoopData HEMJ
end
%% Helium Loop 6_20_2017 13_44_51 - Case 649
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 4.0 g/s, Ti=100, 2.45 MW/m^2, 1.25mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 649;    % Case number
B062017=xlsread('Helium Loop 6_20_2017 13_44_51.csv', 1, 'C50:X20000');
file = B062017;
for i=1:22
    Data(1,i)=mean(file([3070:3270],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save B062017 B062017
save LoopData HEMJ
end
%% Helium Loop 6_20_2017 14_34_47 -                                        % Case 650
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 5.0 g/s, Ti=100, 2.6 MW/m^2, 1.25mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 650;    % Case number
C062017=xlsread('Helium Loop 6_20_2017 14_34_47.csv', 1, 'C50:X20000');
file = C062017;
for i=1:22
    Data(1,i)=mean(file([1099:1299],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save C062017 C062017
save LoopData HEMJ
end
%% Helium Loop 6_20_2017 14_54_12 - Case 651
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 6.0 g/s, Ti=100, 2.6 MW/m^2, 1.25mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 651;    % Case number
D062017=xlsread('Helium Loop 6_20_2017 14_54_12.csv', 1, 'C50:X20000');
file = D062017;
for i=1:22
    Data(1,i)=mean(file([900:1100],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save D062017 D062017
save LoopData HEMJ
end
%% Helium Loop 6_20_2017 15_24_15 - Case 652
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 7.0 g/s, Ti=100, 2.7 MW/m^2, 1.25mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 652;    % Case number
E062017=xlsread('Helium Loop 6_20_2017 15_24_15.csv', 1, 'C50:X20000');
file = E062017;
for i=1:22
    Data(1,i)=mean(file([460:660],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save E062017 E062017
save LoopData HEMJ
end
%% Helium Loop 6_20_2017 15_34_23 - Case 653
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 8.1 g/s, Ti=100, 2.7 MW/m^2, 1.25mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 653;    % Case number
F062017=xlsread('Helium Loop 6_20_2017 15_34_23.csv', 1, 'C50:X20000');
file = F062017;
for i=1:22
    Data(1,i)=mean(file([860:907,913:956,963:987,1000:1041,1105:1129],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save F062017 F062017
save LoopData HEMJ
end
%% Helium Loop 6_20_2017 15_57_46 - Case 654
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 8.2 g/s, Ti=30, 2.8 MW/m^2, 1.25mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 654;    % Case number
G062017=xlsread('Helium Loop 6_20_2017 15_57_46.csv', 1, 'C50:X20000');
file = G062017;
for i=1:22
    Data(1,i)=mean(file([1897:2097],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save G062017 G062017
save LoopData HEMJ
end
%% Helium Loop 6_20_2017 16_28_44 - Case 655
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 7.0 g/s, Ti=30, 2.8 MW/m^2, 1.25mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 655;    % Case number
H062017=xlsread('Helium Loop 6_20_2017 16_28_44.csv', 1, 'C50:X20000');
file = H062017;
for i=1:22
    Data(1,i)=mean(file([214:414],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save H062017 H062017
save LoopData HEMJ
end
%% Helium Loop 6_20_2017 16_35_17 - Case 656
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 6.0 g/s, Ti=30, 2.8 MW/m^2, 1.25mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 656;    % Case number
I062017=xlsread('Helium Loop 6_20_2017 16_35_17.csv', 1, 'C50:X20000');
file = I062017;
for i=1:22
    Data(1,i)=mean(file([346:546],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save I062017 I062017
save LoopData HEMJ
end
%% Helium Loop 6_20_2017 16_43_53 - Case 657
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 5.0 g/s, Ti=30, 2.8 MW/m^2, 1.25mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 657;    % Case number
J062017=xlsread('Helium Loop 6_20_2017 16_43_53.csv', 1, 'C50:X20000');
file = J062017;
for i=1:22
    Data(1,i)=mean(file([800:1060],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save J062017 J062017
save LoopData HEMJ
end
%% Helium Loop 6_20_2017 16_59_50 - Case 658
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 4.0 g/s, Ti=30, 2.8 MW/m^2, 1.25mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 658;    % Case number
K062017=xlsread('Helium Loop 6_20_2017 16_59_50.csv', 1, 'C50:X20000');
file = K062017;
for i=1:22
    Data(1,i)=mean(file([525:725],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save K062017 K062017
save LoopData HEMJ
end
%% Helium Loop 6_20_2017 17_11_28 - Case 659
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 3.1 g/s, Ti=30, 2.8 MW/m^2, 1.25mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 659;    % Case number
L062017=xlsread('Helium Loop 6_20_2017 17_11_28.csv', 1, 'C50:X20000');
file = L062017;
for i=1:22
    Data(1,i)=mean(file([540:740],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save L062017 L062017
save LoopData HEMJ
end
%% Helium Loop 6_21_2017 10_34_30 -                                        % Case 660
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 3.1 g/s, Ti=200, 1.7 MW/m^2, 1.25mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 660;    % Case number
A062117=xlsread('Helium Loop 6_21_2017 10_34_30.csv', 1, 'C50:X20000');
file = A062117;
for i=1:22
    Data(1,i)=mean(file([2024:2224],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save A062117 A062117
save LoopData HEMJ
end
%% Helium Loop 6_21_2017 11_50_39 - Case 661
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 4.0 g/s, Ti=200, 1.7 MW/m^2, 1.25mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 661;    % Case number
B062117=xlsread('Helium Loop 6_21_2017 11_50_39.csv', 1, 'C50:X20000');
file = B062117;
for i=1:22
    Data(1,i)=mean(file([170:370],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save B062117 B062117
save LoopData HEMJ
end
%% Helium Loop 6_21_2017 11_56_36 - Case 662
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 5.0 g/s, Ti=200, 1.7 MW/m^2, 1.25mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 662;    % Case number
C062117=xlsread('Helium Loop 6_21_2017 11_56_36.csv', 1, 'C50:X20000');
file = C062117;
for i=1:22
    Data(1,i)=mean(file([1600:1800],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save C062117 C062117
save LoopData HEMJ
end
%% Helium Loop 6_21_2017 12_23_18 - Case 663
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 6.0 g/s, Ti=200, 1.7 MW/m^2, 1.25mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 663;    % Case number
D062117=xlsread('Helium Loop 6_21_2017 12_23_18.csv', 1, 'C50:X20000');
file = D062117;
for i=1:22
    Data(1,i)=mean(file([2071:2271],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save D062117 D062117
save LoopData HEMJ
end
%% Helium Loop 6_21_2017 12_56_45 - Case 664
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 7.0 g/s, Ti=200, 1.7 MW/m^2, 1.25mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 664;    % Case number
E062117=xlsread('Helium Loop 6_21_2017 12_56_45.csv', 1, 'C50:X20000');
file = E062117;
for i=1:22
    Data(1,i)=mean(file([1753:1953],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save E062117 E062117
save LoopData HEMJ
end
%% Helium Loop 6_21_2017 13_25_38 - Case 665
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 8.0 g/s, Ti=200, 1.7 MW/m^2, 1.25mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 665;    % Case number
F062117=xlsread('Helium Loop 6_21_2017 13_25_38.csv', 1, 'C50:X20000');
file = F062117;
for i=1:22
    Data(1,i)=mean(file([1638:1838],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save F062117 F062117
save LoopData HEMJ
end
%% Helium Loop 6_21_2017 14_36_37 - Case 666
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 8.0 g/s, Ti=200, 1.7 MW/m^2, 1.25mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 666;    % Case number
A08262019=xlsread('Helium Loop 6_21_2017 14_36_37.csv', 1, 'C50:X20000');
file = A08262019;
for i=1:22
    Data(1,i)=mean(file([500:700],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save G062117 A08262019
save LoopData HEMJ
end
%% Helium Loop 6_21_2017 14_47_24 - Case 667
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 7.0 g/s, Ti=300, 1.7 MW/m^2, 1.25mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 667;    % Case number
H062117=xlsread('Helium Loop 6_21_2017 14_47_24.csv', 1, 'C50:X20000');
file = H062117;
for i=1:22
    Data(1,i)=mean(file([1360:1560],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save H062117 H062117
save LoopData HEMJ
end
%% Helium Loop 6_21_2017 15_10_40 - Case 668
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 6.0 g/s, Ti=300, 1.7 MW/m^2, 1.25mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 668;    % Case number
I062117=xlsread('Helium Loop 6_21_2017 15_10_40.csv', 1, 'C50:X20000');
file = I062117;
for i=1:22
    Data(1,i)=mean(file([4060:4260],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save I062117 I062117
save LoopData HEMJ
end
%% Helium Loop 6_21_2017 16_13_01 - Case 669
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 5.0 g/s, Ti=300, 1.7 MW/m^2, 1.25mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 669;    % Case number
J062117=xlsread('Helium Loop 6_21_2017 16_13_01.csv', 1, 'C50:X20000');
file = J062117;
for i=1:22
    Data(1,i)=mean(file([1105:1305],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save J062117 J062117
save LoopData HEMJ
end
%% Helium Loop 6_21_2017 16_33_15 -                                        % Case 670
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 4.0 g/s, Ti=300, 1.7 MW/m^2, 1.25mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 670;    % Case number
K062117=xlsread('Helium Loop 6_21_2017 16_33_15.csv', 1, 'C50:X20000');
file = K062117;
for i=1:22
    Data(1,i)=mean(file([2057:2257],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save K062117 K062117
save LoopData HEMJ
end
%% Helium Loop 6_21_2017 17_06_32 - Case 671
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 3.35 g/s, Ti=300, 1.7 MW/m^2, 1.25mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 671;    % Case number
L062117=xlsread('Helium Loop 6_21_2017 17_06_32.csv', 1, 'C50:X20000');
file = L062117;
for i=1:22
    Data(1,i)=mean(file([2525:2725],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save L062117 L062117
save LoopData HEMJ
end
%% Helium Loop 6_22_2017 13_05_29 - Case 672
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 3.15 g/s, Ti=400, 1.7 MW/m^2, 1.25mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 672;    % Case number
A062217=xlsread('Helium Loop 6_22_2017 13_05_29.csv', 1, 'C50:X20000');
file = A062217;
for i=1:22
    Data(1,i)=mean(file([350:550],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save A062217 A062217
save LoopData HEMJ
end
%% Helium Loop 6_22_2017 13_14_57 - Case 673
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 4.0 g/s, Ti=400, 1.7 MW/m^2, 1.25mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 673;    % Case number
B062217=xlsread('Helium Loop 6_22_2017 13_14_57.csv', 1, 'C50:X20000');
file = B062217;
for i=1:22
    Data(1,i)=mean(file([1230:1430],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save B062217 B062217
save LoopData HEMJ
end
%% Helium Loop 6_22_2017 13_36_29 - Case 674
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 4.7 g/s, Ti=400, 1.7 MW/m^2, 1.25mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 674;    % Case number
C062217=xlsread('Helium Loop 6_22_2017 13_36_29.csv', 1, 'C50:X20000');
file = C062217;
for i=1:22
    Data(1,i)=mean(file([2600:2780],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save C062217 C062217
save LoopData HEMJ
end
%% Helium Loop 6_22_2017 14_17_19 - Case 675
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 6.0 g/s, Ti=400, 1.7 MW/m^2, 1.25mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 675;    % Case number
D062217=xlsread('Helium Loop 6_22_2017 14_17_19.csv', 1, 'C50:X20000');
file = D062217;
for i=1:22
    Data(1,i)=mean(file([930:1130],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save D062217 D062217
save LoopData HEMJ
end
%% Helium Loop 6_22_2017 15_34_34 - Case 676
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 7.0 g/s, Ti=400, 1.7 MW/m^2, 1.25mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 676;    % Case number
E062217=xlsread('Helium Loop 6_22_2017 15_34_34.csv', 1, 'C50:X20000');
file = E062217;
for i=1:22
    Data(1,i)=mean(file([1272:1472],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save E062217 E062217
save LoopData HEMJ
end
%% Helium Loop 6_23_2017 14_30_15 - Case 677
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 2.9 g/s, Ti=100, 2.1 MW/m^2, 1.25mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 677;    % Case number
A062317=xlsread('Helium Loop 6_23_2017 14_30_15.csv', 1, 'C50:X20000');
file = A062317;
for i=1:22
    Data(1,i)=mean(file([1600:1800],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save A062317 A062317
save LoopData HEMJ
end
%% Helium Loop 6_25_2017 12_29_44 - Case 678
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 7.5 g/s, Ti=425, 1.4 MW/m^2, 1.25mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 678;    % Case number
A062517=xlsread('Helium Loop 6_25_2017 12_29_44.csv', 1, 'C50:X20000');
file = A062517;
for i=1:22
    Data(1,i)=mean(file([2450:2600],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save A062517 A062517
save LoopData HEMJ
end
%% Helium Loop 6_25_2017 13_09_08 - Case 679
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 7.0 g/s, Ti=425, 1.4 MW/m^2, 1.25mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 679;    % Case number
B062517=xlsread('Helium Loop 6_25_2017 13_09_08.csv', 1, 'C50:X20000');
file = B062517;
for i=1:22
    Data(1,i)=mean(file([786:952],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save B062517 B062517
save LoopData HEMJ
end
%% Helium Loop 6_25_2017 13_23_31 -                                        % Case 680
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 6.0 g/s, Ti=425, 1.4 MW/m^2, 1.25mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 680;    % Case number
C062517=xlsread('Helium Loop 6_25_2017 13_23_31.csv', 1, 'C50:X20000');
file = C062517;
for i=1:22
    Data(1,i)=mean(file([1200:1400],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save C062517 C062517
save LoopData HEMJ
end
%% Helium Loop 6_25_2017 14_36_32 - Case 681
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 4.2 g/s, Ti=425, 1.4 MW/m^2, 1.25mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 681;    % Case number
D062517=xlsread('Helium Loop 6_25_2017 14_36_32.csv', 1, 'C50:X20000');
file = D062517;
for i=1:22
    Data(1,i)=mean(file([200:370],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save D062517 D062517
save LoopData HEMJ
end
%% Helium Loop 6_25_2017 14_42_56 - Case 682
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 3.4 g/s, Ti=425, 1.4 MW/m^2, 1.25mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 682;    % Case number
E062517=xlsread('Helium Loop 6_25_2017 14_42_56.csv', 1, 'C50:X20000');
file = E062517;
for i=1:22
    Data(1,i)=mean(file([2000:2200],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save E062517 E062517
save LoopData HEMJ
end
%% Helium Loop 6_26_2017 15_43_38 - Case 683
% Steady-State Experiment - WL10 - Integrated HEMJ
% One SS Experiment - 7.45 g/s, Ti=405, 1.1 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 683;    % Case number
A062617=xlsread('Helium Loop 6_26_2017 15_43_38.csv', 1, 'C50:X20000');
file = A062617;
for i=1:22
    Data(1,i)=mean(file([1500:1700],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save A062617 A062617
save LoopData HEMJ
end
%% Helium Loop 6_26_2017 16_08_55 - Case 684
% Steady-State Experiment - WL10 - Integrated HEMJ
% One SS Experiment - 7.0 g/s, Ti=405, 1.1 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 684;    % Case number
B062617=xlsread('Helium Loop 6_26_2017 16_08_55.csv', 1, 'C50:X20000');
file = B062617;
for i=1:22
    Data(1,i)=mean(file([820:1000],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save B062617 B062617
save LoopData HEMJ
end
%% Helium Loop 6_26_2017 16_24_06 - Case 685
% Steady-State Experiment - WL10 - Integrated HEMJ
% One SS Experiment - 6.1 g/s, Ti=405, 1.0 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 685;    % Case number
C062617=xlsread('Helium Loop 6_26_2017 16_24_06.csv', 1, 'C50:X20000');
file = C062617;
for i=1:22
    Data(1,i)=mean(file([1050:1200],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save C062617 C062617
save LoopData HEMJ
end
%% Helium Loop 6_26_2017 16_42_06 - Case 686
% Steady-State Experiment - WL10 - Integrated HEMJ
% One SS Experiment - 4.25 g/s, Ti=405, 1.0 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 686;    % Case number
D062617=xlsread('Helium Loop 6_26_2017 16_42_06.csv', 1, 'C50:X20000');
file = D062617;
for i=1:22
    Data(1,i)=mean(file([1640:1710],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save D062617 D062617
save LoopData HEMJ
end
%% Helium Loop 6_26_2017 17_13_15 - Case 687
% Steady-State Experiment - WL10 - Integrated HEMJ
% One SS Experiment - 3.6 g/s, Ti=405, 0.9 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 687;    % Case number
E062617=xlsread('Helium Loop 6_26_2017 17_13_15.csv', 1, 'C50:X20000');
file = E062617;
for i=1:22
    Data(1,i)=mean(file([405:517],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save E062617 E062617
save LoopData HEMJ
end
%% Helium Loop 6_26_2017 17_21_57 - Case 688
% Steady-State Experiment - WL10 - Integrated HEMJ
% One SS Experiment - 3.0 g/s, Ti=405, 0.8 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 688;    % Case number
F062617=xlsread('Helium Loop 6_26_2017 17_21_57.csv', 1, 'C50:X20000');
file = F062617;
for i=1:22
    Data(1,i)=mean(file([1030:1217],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save F062617 F062617
save LoopData HEMJ
end
%% Helium Loop 6_27_2017 12_20_31 - Case 689
% Steady-State Experiment - WL10 - Integrated HEMJ
% One SS Experiment - 7.6 g/s, Ti=400, 1.0 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 689;    % Case number
A062717=xlsread('Helium Loop 6_27_2017 12_20_31.csv', 1, 'C50:X20000');
file = A062717;
for i=1:22
    Data(1,i)=mean(file([2850:2960],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save A062717 A062717
save LoopData HEMJ
end
%% Helium Loop 8_19_2017 11_49_41 -                                        % Case 690
% Steady-State Experiment - WL10 - Integrated HEMJ
% One SS Experiment - 8.0 g/s, Ti=30, 0.3 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 690;    % Case number
A081917=xlsread('Helium Loop 8_19_2017 11_49_41.csv', 1, 'C50:X20000');
file = A081917;
for i=1:22
    Data(1,i)=mean(file([2717:2917],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save A081917 A081917
save LoopData HEMJ
end
%% Helium Loop 8_19_2017 12_33_30 - Case 691
% Steady-State Experiment - WL10 - Integrated HEMJ
% One SS Experiment - 8.0 g/s, Ti=30, 0.5 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 691;    % Case number
B081917=xlsread('Helium Loop 8_19_2017 12_33_30.csv', 1, 'C50:X20000');
file = B081917;
for i=1:22
    Data(1,i)=mean(file([2012:2212],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save B081917 B081917
save LoopData HEMJ
end
%% Helium Loop 8_19_2017 13_06_28 - Case 692
% Steady-State Experiment - WL10 - Integrated HEMJ
% One SS Experiment - 8.0 g/s, Ti=30, 0.9 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 692;    % Case number
C081917=xlsread('Helium Loop 8_19_2017 13_06_28.csv', 1, 'C50:X20000');
file = C081917;
for i=1:22
    Data(1,i)=mean(file([2100:2300],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save C081917 C081917
save LoopData HEMJ
end
%% Helium Loop 8_25_2017 11_28_01 - Case 693
% Steady-State Experiment - WL10 - Integrated HEMJ
% One SS Experiment - 6.4 g/s, Ti=400, 0.9 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 693;    % Case number
A082517=xlsread('Helium Loop 8_25_2017 11_28_01.csv', 1, 'C50:X20000');
file = A082517;
for i=1:22
    Data(1,i)=mean(file([3357:3557],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save A082517 A082517
save LoopData HEMJ
end
%% Helium Loop 8_25_2017 12_20_08 - Case 694
% Steady-State Experiment - WL10 - Integrated HEMJ
% One SS Experiment - 7.1 g/s, Ti=400, 0.9 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 694;    % Case number
B082517=xlsread('Helium Loop 8_25_2017 12_20_08.csv', 1, 'C50:X20000');
file = B082517;
for i=1:22
    Data(1,i)=mean(file([2120:2372],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save B082517 B082517
save LoopData HEMJ
end
%% Helium Loop 8_25_2017 12_55_03 - Case 695
% Steady-State Experiment - WL10 - Integrated HEMJ
% One SS Experiment - 8.0 g/s, Ti=400, 0.9 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 695;    % Case number
C082517=xlsread('Helium Loop 8_25_2017 12_55_03.csv', 1, 'C50:X20000');
file = C082517;
for i=1:22
    Data(1,i)=mean(file([1770:2070],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save C082517 C082517
save LoopData HEMJ
end
%% Helium Loop 8_25_2017 13_26_13 - Case 696
% Steady-State Experiment - WL10 - Integrated HEMJ
% One SS Experiment - 5.0 g/s, Ti=400, 0.9 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 696;    % Case number
D082517=xlsread('Helium Loop 8_25_2017 13_26_13.csv', 1, 'C50:X20000');
file = D082517;
for i=1:22
    Data(1,i)=mean(file([1880:2117],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save D082517 D082517
save LoopData HEMJ
end
%% Helium Loop 8_25_2017 13_57_30 - Case 697
% Steady-State Experiment - WL10 - Integrated HEMJ
% One SS Experiment - 4.0 g/s, Ti=400, 0.9 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 697;    % Case number
E082517=xlsread('Helium Loop 8_25_2017 13_57_30.csv', 1, 'C50:X20000');
file = E082517;
for i=1:22
    Data(1,i)=mean(file([1700:1900],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save E082517 E082517
save LoopData HEMJ
end
%% Helium Loop 8_25_2017 14_25_54 - Case 698
% Steady-State Experiment - WL10 - Integrated HEMJ
% One SS Experiment - 3.0 g/s, Ti=400, 0.9 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 698;    % Case number
F082517=xlsread('Helium Loop 8_25_2017 14_25_54.csv', 1, 'C50:X20000');
file = F082517;
for i=1:22
    Data(1,i)=mean(file([2127:2327],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save F082517 F082517
save LoopData HEMJ
end
%% Helium Loop 8_28_2017 14_57_16 - Case 699
% Steady-State Experiment - WL10 - Integrated HEMJ
% One SS Experiment - 6.0 g/s, Ti=400, 0.9 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 699;    % Case number
A082817=xlsread('Helium Loop 8_28_2017 14_57_16.csv', 1, 'C50:X20000');
file = A082817;
for i=1:22
    Data(1,i)=mean(file([1811:2011],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save A082817 A082817
save LoopData HEMJ
end
%% Helium Loop 8_28_2017 15_26_59 -                                        % Case 700
% Steady-State Experiment - WL10 - Integrated HEMJ
% One SS Experiment - 7.0 g/s, Ti=400, 0.9 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 700;    % Case number
B082817=xlsread('Helium Loop 8_28_2017 15_26_59.csv', 1, 'C50:X20000');
file = B082817;
for i=1:22
    Data(1,i)=mean(file([2300:2480],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save B082817 B082817
save LoopData HEMJ
end
%% Helium Loop 8_28_2017 16_10_47 - Case 701
% Steady-State Experiment - WL10 - Integrated HEMJ
% One SS Experiment - 8.0 g/s, Ti=400, 0.9 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 701;    % Case number
C082817=xlsread('Helium Loop 8_28_2017 16_10_47.csv', 1, 'C50:X20000');
file = C082817;
for i=1:22
    Data(1,i)=mean(file([1800:1950],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save C082817 C082817
save LoopData HEMJ
end
%% Helium Loop 8_30_2017 11_57_48 - Case 702
% Steady-State Experiment - WL10 - Integrated HEMJ
% One SS Experiment - 5.1 g/s, Ti=425, 0.9 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 702;    % Case number
A083017=xlsread('Helium Loop 8_30_2017 11_57_48.csv', 1, 'C50:X20000');
file = A083017;
for i=1:22
    Data(1,i)=mean(file([2500:2700],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save A083017 A083017
save LoopData HEMJ
end
%% Helium Loop 8_30_2017 12_37_47 - Case 703
% Steady-State Experiment - WL10 - Integrated HEMJ
% One SS Experiment - 4.1 g/s, Ti=425, 0.9 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 703;    % Case number
B083017=xlsread('Helium Loop 8_30_2017 12_37_47.csv', 1, 'C50:X20000');
file = B083017;
for i=1:22
    Data(1,i)=mean(file([2860:3130],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save B083017 B083017
save LoopData HEMJ
end
%% Helium Loop 8_30_2017 13_23_44 - Case 704
% Steady-State Experiment - WL10 - Integrated HEMJ
% One SS Experiment - 3.1 g/s, Ti=425, 0.9 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 704;    % Case number
C083017=xlsread('Helium Loop 8_30_2017 13_23_44.csv', 1, 'C50:X20000');
file = C083017;
for i=1:22
    Data(1,i)=mean(file([2700:2957],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save C083017 C083017
save LoopData HEMJ
end
%% Helium Loop 8_30_2017 14_57_31 - Case 705
% Steady-State Experiment - WL10 - Integrated HEMJ
% One SS Experiment - 6.0 g/s, Ti=425, 0.9 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 705;    % Case number
D083017=xlsread('Helium Loop 8_30_2017 14_57_31.csv', 1, 'C50:X20000');
file = D083017;
for i=1:22
    Data(1,i)=mean(file([231:411],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save D083017 D083017
save LoopData HEMJ
end
%% Helium Loop 8_30_2017 15_04_04 - Case 706
% Steady-State Experiment - WL10 - Integrated HEMJ
% One SS Experiment - 7.0 g/s, Ti=425, 0.9 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 706;    % Case number
E083017=xlsread('Helium Loop 8_30_2017 15_04_04.csv', 1, 'C50:X20000');
file = E083017;
for i=1:22
    Data(1,i)=mean(file([1560:1800],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save E083017 E083017
save LoopData HEMJ
end
%% Helium Loop 8_30_2017 15_30_45 - Case 707
% Steady-State Experiment - WL10 - Integrated HEMJ
% One SS Experiment - 8.0 g/s, Ti=425, 0.9 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 707;    % Case number
F083017=xlsread('Helium Loop 8_30_2017 15_30_45.csv', 1, 'C50:X20000');
file = F083017;
for i=1:22
    Data(1,i)=mean(file([833:1033],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save F083017 F083017
save LoopData HEMJ
end
%% Helium Loop 9_1_2017 11_37_39 - Case 708
% Steady-State Experiment - WL10 - Integrated HEMJ
% One SS Experiment - 5.0 g/s, Ti=425, 1 MW/m^2, 1.5mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 708;    % Case number
A090117=xlsread('Helium Loop 9_1_2017 11_37_39.csv', 1, 'C50:X20000');
file = A090117;
for i=1:22
    Data(1,i)=mean(file([3025:3225],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save A090117 A090117
save LoopData HEMJ
end
%% Helium Loop 9_1_2017 12_25_24 - Case 709
% Steady-State Experiment - WL10 - Integrated HEMJ
% One SS Experiment - 4.1 g/s, Ti=425, 1 MW/m^2, 1.5mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 709;    % Case number
B090117=xlsread('Helium Loop 9_1_2017 12_25_24.csv', 1, 'C50:X20000');
file = B090117;
for i=1:22
    Data(1,i)=mean(file([1150:1350],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save B090117 B090117
save LoopData HEMJ
end
%% Helium Loop 9_1_2017 12_45_36 -                                         % Case 710
% Steady-State Experiment - WL10 - Integrated HEMJ
% One SS Experiment - 3.1 g/s, Ti=425, 1 MW/m^2, 1.5mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 710;    % Case number
C090117=xlsread('Helium Loop 9_1_2017 12_45_36.csv', 1, 'C50:X20000');
file = C090117;
for i=1:22
    Data(1,i)=mean(file([1368:1568],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save C090117 C090117
save LoopData HEMJ
end
%% Helium Loop 9_1_2017 13_24_44 - Case 711
% Steady-State Experiment - WL10 - Integrated HEMJ
% One SS Experiment - 6.0 g/s, Ti=425, 1 MW/m^2, 1.5mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 711;    % Case number
D090117=xlsread('Helium Loop 9_1_2017 13_24_44.csv', 1, 'C50:X20000');
file = D090117;
for i=1:22
    Data(1,i)=mean(file([700:900],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save D090117 D090117
save LoopData HEMJ
end
%% Helium Loop 9_1_2017 14_04_44 - Case 712
% Steady-State Experiment - WL10 - Integrated HEMJ
% One SS Experiment - 7.0 g/s, Ti=425, 1 MW/m^2, 1.5mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 712;    % Case number
E090117=xlsread('Helium Loop 9_1_2017 14_04_44.csv', 1, 'C50:X20000');
file = E090117;
for i=1:22
    Data(1,i)=mean(file([219:419],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save E090117 E090117
save LoopData HEMJ
end
%% Helium Loop 9_1_2017 14_32_29 - Case 713
% Steady-State Experiment - WL10 - Integrated HEMJ
% One SS Experiment - 7.6 g/s, Ti=425, 1 MW/m^2, 1.5mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 713;    % Case number
F090117=xlsread('Helium Loop 9_1_2017 14_32_29.csv', 1, 'C50:X20000');
file = F090117;
for i=1:22
    Data(1,i)=mean(file([357:557],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save F090117 F090117
save LoopData HEMJ
end
%% Helium Loop 9_13_2017 16_34_18 - Case 714
% Steady-State Experiment - WL10 - Integrated HEMJ
% One SS Experiment - 6.0 g/s, Ti=30, 1 MW/m^2, 1.5mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 714;    % Case number
A091317=xlsread('Helium Loop 9_13_2017 16_34_18.csv', 1, 'C50:X20000');
file = A091317;
for i=1:22
    Data(1,i)=mean(file([700:900],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save A091317 A091317
save LoopData HEMJ
end
%% Helium Loop 9_13_2017 16_47_57 - Case 715
% Steady-State Experiment - WL10 - Integrated HEMJ
% One SS Experiment - 5.0 g/s, Ti=30, 1 MW/m^2, 1.5mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 715;    % Case number
B091317=xlsread('Helium Loop 9_13_2017 16_47_57.csv', 1, 'C50:X20000');
file = B091317;
for i=1:22
    Data(1,i)=mean(file([275:475],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save B091317 B091317
save LoopData HEMJ
end
%% Helium Loop 9_13_2017 17_04_33 - Case 716
% Steady-State Experiment - WL10 - Integrated HEMJ
% One SS Experiment - 4.1 g/s, Ti=30, 1 MW/m^2, 1.5mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 716;    % Case number
C091317=xlsread('Helium Loop 9_13_2017 17_04_33.csv', 1, 'C50:X20000');
file = C091317;
for i=1:22
    Data(1,i)=mean(file([470:670],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save C091317 C091317
save LoopData HEMJ
end
%% Helium Loop 9_13_2017 17_14_55 - Case 717
% Steady-State Experiment - WL10 - Integrated HEMJ
% One SS Experiment - 3.1 g/s, Ti=30, 1 MW/m^2, 1.5mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 717;    % Case number
D091317=xlsread('Helium Loop 9_13_2017 17_14_55.csv', 1, 'C50:X20000');
file = D091317;
for i=1:22
    Data(1,i)=mean(file([614:814],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save D091317 D091317
save LoopData HEMJ
end
%% Helium Loop 9_14_2017 15_08_10 - Case 718
% Steady-State Experiment - WL10 - Integrated HEMJ (Heat Flux Sensitivity)
% One SS Experiment - 8.5 g/s, Ti=30, 1.0 MW/m^2, 0.5mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 718;    % Case number
A091417=xlsread('Helium Loop 9_14_2017 15_08_10.csv', 1, 'C50:X20000');
file = A091417;
for i=1:22
    Data(1,i)=mean(file([1675:1794],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save A091417 A091417
save LoopData HEMJ
end
%% Helium Loop 9_14_2017 15_34_46 - Case 719
% Steady-State Experiment - WL10 - Integrated HEMJ (Heat Flux Sensitivity)
% One SS Experiment - 8.5 g/s, Ti=30, 2.0 MW/m^2, 0.5mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 719;    % Case number
B091417=xlsread('Helium Loop 9_14_2017 15_34_46.csv', 1, 'C50:X20000');
file = B091417;
for i=1:22
    Data(1,i)=mean(file([1325:1475],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save B091417 B091417
save LoopData HEMJ
end
%% Helium Loop 9_14_2017 15_57_19 -                                        % Case 720
% Steady-State Experiment - WL10 - Integrated HEMJ (Heat Flux Sensitivity)
% One SS Experiment - 8.5 g/s, Ti=30, 2.5 MW/m^2, 0.5mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 720;    % Case number
C091417=xlsread('Helium Loop 9_14_2017 15_57_19.csv', 1, 'C50:X20000');
file = C091417;
for i=1:22
    Data(1,i)=mean(file([725:825,875:940],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save C091417 C091417
save LoopData HEMJ
end
%% Helium Loop 9_15_2017 09_47_15 - Case 721
% Steady-State Experiment - WL10 - Integrated HEMJ (Heat Flux Sensitivity)
% One SS Experiment - 5.75 g/s, Ti=30, 1.0 MW/m^2, 0.5mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 721;    % Case number
A091517=xlsread('Helium Loop 9_15_2017 09_47_15.csv', 1, 'C50:X20000');
file = A091517;
for i=1:22
    Data(1,i)=mean(file([250:425],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save A091517 A091517
save LoopData HEMJ
end
%% Helium Loop 9_15_2017 09_54_36 - Case 722
% Steady-State Experiment - WL10 - Integrated HEMJ (Heat Flux Sensitivity)
% One SS Experiment - 5.75 g/s, Ti=30, 2.0 MW/m^2, 0.5mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 722;    % Case number
B091517=xlsread('Helium Loop 9_15_2017 09_54_36.csv', 1, 'C50:X20000');
file = B091517;
for i=1:22
    Data(1,i)=mean(file([1250:1440],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save B091517 B091517
save LoopData HEMJ
end
%% Helium Loop 9_15_2017 10_16_18 - Case 723
% Steady-State Experiment - WL10 - Integrated HEMJ (Heat Flux Sensitivity)
% One SS Experiment - 5.75 g/s, Ti=30, 2.5 MW/m^2, 0.5mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 723;    % Case number
C091517=xlsread('Helium Loop 9_15_2017 10_16_18.csv', 1, 'C50:X20000');
file = C091517;
for i=1:22
    Data(1,i)=mean(file([1150:1350],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save C091517 C091517
save LoopData HEMJ
end
%% Helium Loop 9_15_2017 11_08_23 - Case 724
% Steady-State Experiment - WL10 - Integrated HEMJ (Heat Flux Sensitivity)
% One SS Experiment - 3.1 g/s, Ti=30, 2.6 MW/m^2, 0.5mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 724;    % Case number
D091517=xlsread('Helium Loop 9_15_2017 11_08_23.csv', 1, 'C50:X20000');
file = D091517;
for i=1:22
    Data(1,i)=mean(file([250:530],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save D091517 D091517
save LoopData HEMJ
end
%% Helium Loop 9_15_2017 11_17_00 - Case 725
% Steady-State Experiment - WL10 - Integrated HEMJ (Heat Flux Sensitivity)
% One SS Experiment - 3.1 g/s, Ti=30, 2.0 MW/m^2, 0.5mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 725;    % Case number
E091517=xlsread('Helium Loop 9_15_2017 11_17_00.csv', 1, 'C50:X20000');
file = E091517;
for i=1:22
    Data(1,i)=mean(file([1525:1645],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save E091517 E091517
save LoopData HEMJ
end
%% Helium Loop 9_15_2017 11_47_04 - Case 726
% Steady-State Experiment - WL10 - Integrated HEMJ (Heat Flux Sensitivity)
% One SS Experiment - 3.1 g/s, Ti=30, 1.0 MW/m^2, 0.5mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 726;    % Case number
F091517=xlsread('Helium Loop 9_15_2017 11_47_04.csv', 1, 'C50:X20000');
file = F091517;
for i=1:22
    Data(1,i)=mean(file([1050:1080,1175:1260],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save F091517 F091517
save LoopData HEMJ
end
%% Helium Loop 9_16_2017 11_26_06 - Case 727
% Steady-State Experiment - WL10 - Integrated HEMJ (Heat Flux Sensitivity)
% One SS Experiment - 8.5 g/s, Ti=30, 1.0 MW/m^2, 0.25mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 727;    % Case number
A091617=xlsread('Helium Loop 9_16_2017 11_26_06.csv', 1, 'C50:X20000');
file = A091617;
for i=1:22
    Data(1,i)=mean(file([2020:2150],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save A091617 A091617
save LoopData HEMJ
end
%% Helium Loop 9_16_2017 11_58_16 - Case 728
% Steady-State Experiment - WL10 - Integrated HEMJ (Heat Flux Sensitivity)
% One SS Experiment - 8.5 g/s, Ti=30, 2.0 MW/m^2, 0.25mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 728;    % Case number
B091617=xlsread('Helium Loop 9_16_2017 11_58_16.csv', 1, 'C50:X20000');
file = B091617;
for i=1:22
    Data(1,i)=mean(file([1715:1880],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save B091617 B091617
save LoopData HEMJ
end
%% Helium Loop 9_16_2017 12_26_14 - Case 729
% Steady-State Experiment - WL10 - Integrated HEMJ (Heat Flux Sensitivity)
% One SS Experiment - 8.5 g/s, Ti=30, 2.5 MW/m^2, 0.25mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 729;    % Case number
C091617=xlsread('Helium Loop 9_16_2017 12_26_14.csv', 1, 'C50:X20000');
file = C091617;
for i=1:22
    Data(1,i)=mean(file([840:1090],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save C091617 C091617
save LoopData HEMJ
end
%% Helium Loop 9_16_2017 12_42_45 -                                        % Case 730
% Steady-State Experiment - WL10 - Integrated HEMJ (Heat Flux Sensitivity)
% One SS Experiment - 5.75 g/s, Ti=30, 2.5 MW/m^2, 0.25mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 730;    % Case number
D091617=xlsread('Helium Loop 9_16_2017 12_42_45.csv', 1, 'C50:X20000');
file = D091617;
for i=1:22
    Data(1,i)=mean(file([1450:1620],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save D091617 D091617
save LoopData HEMJ
end
%% Helium Loop 9_16_2017 13_07_01 - Case 731
% Steady-State Experiment - WL10 - Integrated HEMJ (Heat Flux Sensitivity)
% One SS Experiment - 5.75 g/s, Ti=30, 2.0 MW/m^2, 0.25mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 731;    % Case number
E091617=xlsread('Helium Loop 9_16_2017 13_07_01.csv', 1, 'C50:X20000');
file = E091617;
for i=1:22
    Data(1,i)=mean(file([570:810],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save E091617 E091617
save LoopData HEMJ
end
%% Helium Loop 9_16_2017 13_20_07 - Case 732
% Steady-State Experiment - WL10 - Integrated HEMJ (Heat Flux Sensitivity)
% One SS Experiment - 5.75 g/s, Ti=30, 1.0 MW/m^2, 0.25mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 732;    % Case number
F091617=xlsread('Helium Loop 9_16_2017 13_20_07.csv', 1, 'C50:X20000');
file = F091617;
for i=1:22
    Data(1,i)=mean(file([1015:1200],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save F091617 F091617
save LoopData HEMJ
end
%% Helium Loop 9_16_2017 13_38_25 - Case 733
% Steady-State Experiment - WL10 - Integrated HEMJ (Heat Flux Sensitivity)
% One SS Experiment - 3.2 g/s, Ti=30, 1.0 MW/m^2, 0.25mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 733;    % Case number
G091617=xlsread('Helium Loop 9_16_2017 13_38_25.csv', 1, 'C50:X20000');
file = G091617;
for i=1:22
    Data(1,i)=mean(file([1020:1364],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save G091617 G091617
save LoopData HEMJ
end
%% Helium Loop 9_16_2017 13_58_50 - Case 734
% Steady-State Experiment - WL10 - Integrated HEMJ (Heat Flux Sensitivity)
% One SS Experiment - 3.2 g/s, Ti=30, 2.0 MW/m^2, 0.25mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 734;    % Case number
H091617=xlsread('Helium Loop 9_16_2017 13_58_50.csv', 1, 'C50:X20000');
file = H091617;
for i=1:22
    Data(1,i)=mean(file([1150:1285],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save H091617 H091617
save LoopData HEMJ
end
%% Helium Loop 9_16_2017 14_18_11 - Case 735
% Steady-State Experiment - WL10 - Integrated HEMJ (Heat Flux Sensitivity)
% One SS Experiment - 3.2 g/s, Ti=30, 2.5 MW/m^2, 0.25mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 735;    % Case number
I091617=xlsread('Helium Loop 9_16_2017 14_18_11.csv', 1, 'C50:X20000');
file = I091617;
for i=1:22
    Data(1,i)=mean(file([500:774],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save I091617 I091617
save LoopData HEMJ
end
%% Helium Loop 10_23_2017 09_55_54 - Case 736
% Steady-State Experiment - WL10 - Integrated HEMJ (Heat Flux Sensitivity)
% One SS Experiment - 7.8 g/s, Ti=30, 2.0 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 736;    % Case number
A102317=xlsread('Helium Loop 10_23_2017 09_55_54.csv', 1, 'C50:X20000');
file = A102317;
for i=1:22
    Data(1,i)=mean(file([115:315],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save A102317 A102317
save LoopData HEMJ
end
%% Helium Loop 10_23_2017 10_08_27 - Case 737
% Steady-State Experiment - WL10 - Integrated HEMJ (Heat Flux Sensitivity)
% One SS Experiment - 7 g/s, Ti=30, 2.0 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 737;    % Case number
B102317=xlsread('Helium Loop 10_23_2017 10_08_27.csv', 1, 'C50:X20000');
file = B102317;
for i=1:22
    Data(1,i)=mean(file([5:285],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save B102317 B102317
save LoopData HEMJ
end
%% Helium Loop 10_23_2017 10_26_10 - Case 738
% Steady-State Experiment - WL10 - Integrated HEMJ (Heat Flux Sensitivity)
% One SS Experiment - 7 g/s, Ti=30, 2.0 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 738;    % Case number
C102317=xlsread('Helium Loop 10_23_2017 10_26_10.csv', 1, 'C50:X20000');
file = C102317;
for i=1:22
    Data(1,i)=mean(file([1620:1900],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save C102317 C102317
save LoopData HEMJ
end
%% Helium Loop 10_23_2017 10_54_47 - Case 739
% Steady-State Experiment - WL10 - Integrated HEMJ (Heat Flux Sensitivity)
% One SS Experiment - 7 g/s, Ti=30, 2.0 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 739;    % Case number
D102317=xlsread('Helium Loop 10_23_2017 10_54_47.csv', 1, 'C50:X20000');
file = D102317;
for i=1:22
    Data(1,i)=mean(file([250:500],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save D102317 D102317
save LoopData HEMJ
end
%% Helium Loop 10_23_2017 11_03_37 -                                        %Case 740
% Steady-State Experiment - WL10 - Integrated HEMJ (Heat Flux Sensitivity)
% One SS Experiment - 7 g/s, Ti=30, 2.0 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 740;    % Case number
E102317=xlsread('Helium Loop 2_16_2018 15_39_59.csv', 1, 'C50:X20000');
file = E102317;
for i=1:22
    Data(1,i)=mean(file([1110:1370],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save E102317 E102317
save LoopData HEMJ
end
%% Helium Loop 10_23_2017 11_24_10 - Case 741
% Steady-State Experiment - WL10 - Integrated HEMJ (Heat Flux Sensitivity)
% One SS Experiment - 7 g/s, Ti=30, 2.0 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 741;    % Case number
F102317=xlsread('Helium Loop 10_23_2017 11_24_10.csv', 1, 'C50:X20000');
file = F102317;
for i=1:22
    Data(1,i)=mean(file([840:1090],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save F102317 F102317
save LoopData HEMJ
end

%% Helium Loop 2_20_2018 11_34_12 - Case 742
% Steady-State Experiment - WL10 - Integrated HEMJ (Heat Flux Sensitivity)
% One SS Experiment - 8 g/s, Ti=30, 2.0 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 742;    % Case number
A022018=xlsread('Helium Loop 2_20_2018 11_34_12.csv', 1, 'C52:Z20000');
file = A022018;
for i=1:22
    Data(1,i)=mean(file([1:240],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save A022018 A022018
save LoopData HEMJ
end
%% Helium Loop 2_20_2018 11_39_43 - Case 743
% Steady-State Experiment - WL10 - Integrated HEMJ (Heat Flux Sensitivity)
% One SS Experiment - 7 g/s, Ti=30, 2.0 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 743;    % Case number
B022018=xlsread('Helium Loop 2_20_2018 11_39_43.csv', 1, 'C52:Z20000');
file = B022018;
for i=1:22
    Data(1,i)=mean(file([300:560],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save B022018 B022018
save LoopData HEMJ
end
%% Helium Loop 2_20_2018 12_00_13 - Case 744
% Steady-State Experiment - WL10 - Integrated HEMJ (Heat Flux Sensitivity)
% One SS Experiment - 6 g/s, Ti=30, 2.0 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 744;    % Case number
C022018=xlsread('Helium Loop 2_20_2018 12_00_13.csv', 1, 'C52:Z20000');
file = C022018;
for i=1:22
    Data(1,i)=mean(file([330:600],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save C022018 C022018
save LoopData HEMJ
end
%% Helium Loop 2_20_2018 12_11_13 - Case 745
% Steady-State Experiment - WL10 - Integrated HEMJ (Heat Flux Sensitivity)
% One SS Experiment - 5 g/s, Ti=30, 2.0 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 745;    % Case number
D022018=xlsread('Helium Loop 2_20_2018 12_11_13.csv', 1, 'C52:Z20000');
file = D022018;
for i=1:22
    Data(1,i)=mean(file([1030:1330],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save D022018 D022018
save LoopData HEMJ
end
%% Helium Loop 2_20_2018 12_34_50 - Case 746
% Steady-State Experiment - WL10 - Integrated HEMJ (Heat Flux Sensitivity)
% One SS Experiment - 4 g/s, Ti=30, 2.0 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 746;    % Case number
E022018=xlsread('Helium Loop 2_20_2018 12_34_50.csv', 1, 'C52:Z20000');
file = E022018;
for i=1:22
    Data(1,i)=mean(file([730:970],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save E022018 E022018
save LoopData HEMJ
end
%% Helium Loop 2_20_2018 12_51_06 - Case 747
% Steady-State Experiment - WL10 - Integrated HEMJ (Heat Flux Sensitivity)
% One SS Experiment - 3 g/s, Ti=30, 2.0 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 747;    % Case number
F022018=xlsread('Helium Loop 2_20_2018 12_51_06.csv', 1, 'C52:Z20000');
file = F022018;
for i=1:22
    Data(1,i)=mean(file([1709:1950],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save F022018 F022018
save LoopData HEMJ
end

%% Helium Loop 2_21_2018 15_31_48 - Case 748
% Steady-State Experiment - WL10 - Integrated HEMJ (Heat Flux Sensitivity)
% One SS Experiment - 3 g/s, Ti=30, 2.0 MW/m^2, 0.9mm
% 0.75 scan/second 
for m=1:1
clear; load LoopData; 
x = 748;    % Case number
A022118=xlsread('Helium Loop 2_21_2018 15_31_48.csv', 1, 'C52:Z20000');
file = A022118;
for i=1:22
    Data(1,i)=mean(file([4193:4436],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,8:9) Data(1,17) Data(1,12:13) 0 Data(1,16) 99000 0];
save A022118 A022118
save LoopData HEMJ
end
%% Helium Loop 4_20_2018 13_05_07 - Case 749
% Steady-State Experiment - WL10 - Integrated HEMJ (High Heat Flux at High Inlet Temperature)
% One SS Experiment - 8 g/s, Ti=300, 0 MW/m^2, 0.9mm
% 1.1 scan/second 
for m=1:1
clear; load LoopData; 
x = 749;    % Case number
A042018=xlsread('Helium Loop 4_20_2018 13_05_07.csv', 1, 'C51:Z20000');
file = A042018;
for i=1:22
    Data(1,i)=mean(file([4705:4706],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,9:10) Data(1,18) Data(1,13:14) 0 Data(1,17) 99000 0];
save A042018 A042018
save LoopData HEMJ
end
%% Helium Loop 4_20_2018 15_10_22 - Case 750
% Steady-State Experiment - WL10 - Integrated HEMJ (High Heat Flux at High Inlet Temperature)
% One SS Experiment - 8 g/s, Ti=300, 6.2 MW/m^2, 0.9mm
% 1.1 scan/second 
for m=1:1
clear; load LoopData; 
x = 750;    % Case number
B042018=xlsread('Helium Loop 4_20_2018 15_10_22.csv', 1, 'C51:Z20000');
file = B042018;
for i=1:22
    Data(1,i)=mean(file([35:250],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,9:10) Data(1,18) Data(1,13:14) 0 Data(1,17) 99000 0];
save B042018 B042018
save LoopData HEMJ
end
%% Helium Loop 4_20_2018 15_36_36 - Case 751
% Steady-State Experiment - WL10 - Integrated HEMJ (High Heat Flux at High Inlet Temperature)
% One SS Experiment - 7 g/s, Ti=300, 6.4 MW/m^2, 0.9mm
% 1.1 scan/second 
for m=1:1
clear; load LoopData; 
x = 751;    % Case number
C042018=xlsread('Helium Loop 4_20_2018 15_36_36.csv', 1, 'C51:Z20000');
file = C042018;
for i=1:22
    Data(1,i)=mean(file([63:318],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,9:10) Data(1,18) Data(1,13:14) 0 Data(1,17) 99000 0];
save C042018 C042018
save LoopData HEMJ
end
%% Helium Loop 4_20_2018 15_42_05 - Case 752
% Steady-State Experiment - WL10 - Integrated HEMJ (High Heat Flux at High Inlet Temperature)
% One SS Experiment - 6 g/s, Ti=300, 6.4 MW/m^2, 0.9mm
% 1.1 scan/second ****failed Experiment
for m=1:1
clear; load LoopData; 
x = 752;    % Case number
D042018=xlsread('Helium Loop 4_20_2018 15_42_05.csv', 1, 'C51:Z20000');
file = D042018;
for i=1:22
    Data(1,i)=mean(file([380:382],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,9:10) Data(1,18) Data(1,13:14) 0 Data(1,17) 99000 0];
save D042018 D042018
save LoopData HEMJ
end
%% Helium Loop 8_31_2018 14_11_47 - Case 753
% Steady-State Experiment - WL10 - Integrated HEMJ (High Heat Flux at High Inlet Temperature) 
% One SS Experiment - 8.4 g/s, Ti=300, 7.2 MW/m^2, 0.9mm
% 10 scan/second
for m=1:1
clear; load LoopData; 
x = 753;    % Case number
A083118=xlsread('Helium Loop 8_31_2018 14_11_47.csv', 1, 'C51:Z20000');
file = A083118;
for i=1:22
    Data(1,i)=mean(file([73:325],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,9:10) Data(1,18) Data(1,13:14) 0 Data(1,17) 99000 0];
save A083118 A083118
save LoopData HEMJ
end
%% Helium Loop 8_31_2018 14_46_53 - Case 754
% Steady-State Experiment - WL10 - Integrated HEMJ (High Heat Flux at High Inlet Temperature) 
% One SS Experiment - 7 g/s, Ti=300, 6 MW/m^2, 0.9mm
% 10 scan/second 
for m=1:1
clear; load LoopData; 
x = 754;    % Case number
B083118=xlsread('Helium Loop 8_31_2018 14_46_53.csv', 1, 'C51:z20000');
file = B083118;
for i=1:22
    Data(1,i)=mean(file([1110:1350],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,9:10) Data(1,18) Data(1,13:14) 0 Data(1,17) 99000 0];
save B083118 B083118
save LoopData HEMJ
end
%% Helium Loop 8_31_2018 15_50_44 - Case 755
% Steady-State Experiment - WL10 - Integrated HEMJ (High Heat Flux at High Inlet Temperature) 
% One SS Experiment - 6 g/s, Ti=300, 6 MW/m^2, 0.9mm
% 10 scan/second 
for m=1:1
clear; load LoopData; 
x = 755;    % Case number
C083118=xlsread('Helium Loop 8_31_2018 15_50_44.csv', 1, 'C51:z20000');
file = C083118;
for i=1:22
    Data(1,i)=mean(file([1:277],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,9:10) Data(1,18) Data(1,13:14) 0 Data(1,17) 99000 0];
save C083118 C083118
save LoopData HEMJ
end
%% Helium Loop 8_31_2018 16_17_12 - Case 756
% Steady-State Experiment - WL10 - Integrated HEMJ (High Heat Flux at High Inlet Temperature) 
% One SS Experiment - 5 g/s, Ti=300, 6 MW/m^2, 0.9mm
% 10 scan/second 
for m=1:1
clear; load LoopData; 
x = 756;    % Case number
D083118=xlsread('Helium Loop 8_31_2018 16_17_12.csv', 1, 'C51:z20000');
file = D083118;
for i=1:22
    Data(1,i)=mean(file([30:350],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,9:10) Data(1,18) Data(1,13:14) 0 Data(1,17) 99000 0];
save D083118 D083118
save LoopData HEMJ
end
%% Helium Loop 8_31_2018 16_46_30 - Case 757
% Steady-State Experiment - WL10 - Integrated HEMJ (High Heat Flux at High Inlet Temperature) 
% One SS Experiment - 4 g/s, Ti=300, 6 MW/m^2, 0.9mm
% 10 scan/second 
for m=1:1
clear; load LoopData; 
x = 757;    % Case number
E083118=xlsread('Helium Loop 8_31_2018 16_46_30.csv', 1, 'C51:z20000');
file = E083118;
for i=1:22
    Data(1,i)=mean(file([1:300],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,9:10) Data(1,18) Data(1,13:14) 0 Data(1,17) 99000 0];
save E083118 E083118
save LoopData HEMJ
end
%% Helium Loop 8_31_2018 17_41_27 - Case 758
% Steady-State Experiment - WL10 - Integrated HEMJ (High Heat Flux at High Inlet Temperature) 
% One SS Experiment - 3 g/s, Ti=300, 6 MW/m^2, 0.9mm
% 10 scan/second 
for m=1:1
clear; load LoopData; 
x = 758;    % Case number
F083118=xlsread('Helium Loop 8_31_2018 17_41_27.csv', 1, 'C51:z20000');
file = F083118;
for i=1:22
    Data(1,i)=mean(file([1:200],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,9:10) Data(1,18) Data(1,13:14) 0 Data(1,17) 99000 0];
save F083118 F083118
save LoopData HEMJ
end
%% Helium Loop 9_7_2018 14_03_13 - Case 759
% Steady-State Experiment - WL10 - Integrated HEMJ (High Heat Flux at High Inlet Temperature) 
% One SS Experiment - 8 g/s, Ti=350, 8 MW/m^2, 0.9mm
% 10 scan/second 
for m=1:1
clear; load LoopData; 
x = 759;    % Case number
A090718=xlsread('Helium Loop 9_7_2018 14_03_13.csv', 1, 'C51:z20000');
file = A090718;
for i=1:22
    Data(1,i)=mean(file([1493:1708],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,9:10) Data(1,18) Data(1,13:14) 0 Data(1,17) 99000 0];
save A090718 A090718
save LoopData HEMJ
end
%% Helium Loop 9_7_2018 15_04_22 - Case 760
% Steady-State Experiment - WL10 - Integrated HEMJ (High Heat Flux at High Inlet Temperature) 
% One SS Experiment - 7 g/s, Ti=350, 8 MW/m^2, 0.9mm
% 10 scan/second 
for m=1:1
clear; load LoopData; 
x = 760;    % Case number
B090718=xlsread('Helium Loop 9_7_2018 15_04_22.csv', 1, 'C51:z20000');
file = B090718;
for i=1:22
    Data(1,i)=mean(file([121:372],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,9:10) Data(1,18) Data(1,13:14) 0 Data(1,17) 99000 0];
save B090718 B090718
save LoopData HEMJ
end
%% Helium Loop 9_7_2018 15_46_12 - Case 761
% Steady-State Experiment - WL10 - Integrated HEMJ (High Heat Flux at High Inlet Temperature) 
% One SS Experiment - 6 g/s, Ti=350, 8 MW/m^2, 0.9mm
% 10 scan/second 
for m=1:1
clear; load LoopData; 
x = 761;    % Case number
C090718=xlsread('Helium Loop 9_7_2018 15_46_12.csv', 1, 'C51:z20000');
file = C090718;
for i=1:22
    Data(1,i)=mean(file([237:450],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,9:10) Data(1,18) Data(1,13:14) 0 Data(1,17) 99000 0];
save C090718 C090718
save LoopData HEMJ
end
%% Helium Loop 9_7_2018 16_44_44 - Case 762
% Steady-State Experiment - WL10 - Integrated HEMJ (High Heat Flux at High Inlet Temperature) 
% One SS Experiment - 5 g/s, Ti=350, 8 MW/m^2, 0.9mm
% 10 scan/second 
for m=1:1
clear; load LoopData; 
x = 762;    % Case number
D090718=xlsread('Helium Loop 9_7_2018 16_44_44.csv', 1, 'C51:z20000');
file = D090718;
for i=1:22
    Data(1,i)=mean(file([405:640],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,9:10) Data(1,18) Data(1,13:14) 0 Data(1,17) 99000 0];
save D090718 D090718
save LoopData HEMJ
end
%% Helium Loop 9_7_2018 16_55_48 - Case 763
% Steady-State Experiment - WL10 - Integrated HEMJ (High Heat Flux at High Inlet Temperature) 
% One SS Experiment - 4 g/s, Ti=350, 8 MW/m^2, 0.9mm
% 10 scan/second 
for m=1:1
clear; load LoopData; 
x = 763;    % Case number
E090718=xlsread('Helium Loop 9_7_2018 16_55_48.csv', 1, 'C51:z20000');
file = E090718;
for i=1:22
    Data(1,i)=mean(file([1364:1589],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,9:10) Data(1,18) Data(1,13:14) 0 Data(1,17) 99000 0];
save E090718 E090718
save LoopData HEMJ
end
%% Helium Loop 9_7_2018 17_20_51 - Case 764
% Steady-State NOT REACHED - WL10 - Integrated HEMJ (High Heat Flux at High Inlet Temperature) 
% One SS Experiment - 3 g/s, Ti=350, 8 MW/m^2, 0.9mm
% 10 scan/second 
for m=1:1
clear; load LoopData; 
x = 764;    % Case number
F090718=xlsread('Helium Loop 9_7_2018 17_20_51.csv', 1, 'C51:z20000');
file = F090718;
for i=1:22
    Data(1,i)=mean(file([1210:1330],i));
end
HEMJ(x,:) = [Data(1,1) 0 0 Data(1,2:5) zeros(1,4) Data(1,9:10) Data(1,18) Data(1,13:14) 0 Data(1,17) 99000 0];
save F090718 F090718
save LoopData HEMJ
end

%% Helium Loop 11_5_2018 19_57_12 - Case 765*** REV HF TEST
% Steady-State NOT REACHED - WL10 - Integrated HEMJ (High Heat Flux at High Inlet Temperature) 
% One SS Experiment - 3 g/s, Ti=350, 8 MW/m^2, 0.9mm
% 10 scan/second 
for m=1:1
clear; load LoopData; 
x = 765;    % Case number
A110518=xlsread('Helium Loop 11_5_2018 19_57_12.csv', 1, 'C32:z20000');
file = A110518;
for i=1:22
    Data(1,i)=mean(file([130:350],i));
end
Data(1, 7:8) = Data(1, 7:8)-273.15;
Data(1, 10:15) = Data(1, 10:15)-273.15;

HEMJ(x,:) = [Data(1,1) 0 0 Data(1,15) Data(1,12) Data(1,11) Data(1,10) zeros(1,4) Data(1,16) Data(1,4) Data(1,17) Data(1,8) Data(1,7) 0 Data(1,6) 99000 0];
save A110518 A110518
save LoopData HEMJ
end


% %% Helium Loop 11_5_2018 19_57_12 - Case 765*** REV HF TEST
% % Steady-State NOT REACHED - WL10 - Integrated HEMJ (High Heat Flux at High Inlet Temperature) 
% % One SS Experiment - 3 g/s, Ti=350, 8 MW/m^2, 0.9mm
% % 10 scan/second 
% for m=1:1
% clear; load LoopData; 
% x = 765;    % Case number
% A110518=xlsread('Helium Loop 11_5_2018 19_57_12.csv', 1, 'C32:z20000');
% file = A110518;
% for i=1:22
%     Data(1,i)=mean(file([130:350],i));
% end
% Data(1, 7:8) = Data(1, 7:8)-273.15;
% Data(1, 10:15) = Data(1, 10:15)-273.15;
% 
% HEMJ(x,:) = [Data(1,1) 0 0 Data(1,15) Data(1,12) Data(1,11) Data(1,10) zeros(1,4) Data(1,16) Data(1,4) Data(1,17) Data(1,8) Data(1,7) 0 Data(1,6) 99000 0];
% save A110518 A110518
% save LoopData HEMJ
% end


% %%
% x = 767; FName = 'Helium Loop 8_26_2019 15_28_19.csv';                       % Case number and File Name
% for m=1:1                                                                   % For loop used only for folding code section
% % Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% % One SS Experiment - 8.0 g/s, Ti=380, 4.7 MW/m^2, 1mm
% % 0.75 scan/second 
% load LoopData; 
% AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% % AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
% AD(1,18) = AD(1,18)*6894.75728;                                             % Convert Pressures to Pa     
% 
% HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
% save A08262019 AD
% save LoopData HEMJ
% end
% 
% %%
% x = 768; FName = 'Helium Loop 8_26_2019 16_28_27.csv';                       % Case number and File Name
% for m=1:1                                                                   % For loop used only for folding code section
% % Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% % One SS Experiment - 7.0 g/s, Ti=380, 4.7 MW/m^2, 1mm
% % 0.75 scan/second 
% load LoopData; 
% AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% % AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
% AD(1,18) = AD(1,18)*6894.75728;                                             % Convert Pressures to Pa     
% 
% HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
% save B08262019 AD
% save LoopData HEMJ
% end
% 
% 
% %%
% x = 769; FName = 'Helium Loop 8_26_2019 17_17_47.csv';                       % Case number and File Name
% for m=1:1                                                                   % For loop used only for folding code section
% % Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% % One SS Experiment - 6.0 g/s, Ti=380, 4.7 MW/m^2, 1mm
% % 0.75 scan/second 
% load LoopData; 
% AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% % AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
% AD(1,18) = AD(1,18)*6894.75728;                                             % Convert Pressures to Pa     
% 
% HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
% save C08262019 AD
% save LoopData HEMJ
% end
% 
% %%
% x = 770; FName = 'Helium Loop 8_26_2019 18_06_35.csv';                       % Case number and File Name
% for m=1:1                                                                   % For loop used only for folding code section
% % Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% % One SS Experiment - 5.0 g/s, Ti=380, 4.7 MW/m^2, 1mm
% % 0.75 scan/second 
% load LoopData; 
% AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% % AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
% AD(1,18) = AD(1,18)*6894.75728;                                             % Convert Pressures to Pa     
% 
% HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
% save D08262019 AD
% save LoopData HEMJ
% end
% 
% %%
% x = 771; FName = 'Helium Loop 8_26_2019 18_17_44.csv';                       % Case number and File Name
% for m=1:1                                                                   % For loop used only for folding code section
% % Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% % One SS Experiment - 4.0 g/s, Ti=380, 4.7 MW/m^2, 1mm
% % 0.75 scan/second 
% load LoopData; 
% AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% % AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
% AD(1,18) = AD(1,18)*6894.75728;                                             % Convert Pressures to Pa     
% 
% HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
% save E08262019 AD
% save LoopData HEMJ
% end
% 
% %%
% x = 772; FName = 'Helium Loop 8_26_2019 18_39_26.csv';                       % Case number and File Name
% for m=1:1                                                                   % For loop used only for folding code section
% % Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% % One SS Experiment - 3.0 g/s, Ti=380, 4.7 MW/m^2, 1mm
% % 0.75 scan/second 
% load LoopData; 
% AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% % AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
% AD(1,18) = AD(1,18)*6894.75728;                                             % Convert Pressures to Pa     
% 
% HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
% save F08262019 AD
% save LoopData HEMJ
% end

%%
x = 767; FName = 'Helium Loop 8_26_2019 15_28_19_dPtestcorrection.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 8.0 g/s, Ti=380, 4.7 MW/m^2, 1mm
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save A08262019 AD
save LoopData HEMJ
end

%%
x = 768; FName = 'Helium Loop 8_26_2019 16_28_27_dPtestcorrection.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 7.0 g/s, Ti=380, 4.7 MW/m^2, 1mm
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save B08262019 AD
save LoopData HEMJ
end

%%
x = 769; FName = 'Helium Loop 8_26_2019 17_17_47_dPtestcorrection.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 6.0 g/s, Ti=380, 4.7 MW/m^2, 1mm
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save C08262019 AD
save LoopData HEMJ
end

%%
x = 770; FName = 'Helium Loop 8_26_2019 18_06_35_dPtestcorrection.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 5.0 g/s, Ti=380, 4.7 MW/m^2, 1mm
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save D08262019 AD
save LoopData HEMJ
end

%%
x = 771; FName = 'Helium Loop 8_26_2019 18_17_44_dPtestcorrection.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 4.0 g/s, Ti=380, 4.7 MW/m^2, 1mm
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save E08262019 AD
save LoopData HEMJ
end

%%
x = 772; FName = 'Helium Loop 8_26_2019 18_39_26_dPtestcorrection.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 3.0 g/s, Ti=380, 4.7 MW/m^2, 1mm
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save F08262019 AD
save LoopData HEMJ
end

%%
x = 774; FName = 'Helium Loop 8_28_2019 12_35_18.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 8.0 g/s, Ti=380, 5 MW/m^2, 1mm
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save A08282019 AD
save LoopData HEMJ
end

%%
x = 775; FName = 'Helium Loop 8_28_2019 13_41_14.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 7.0 g/s, Ti=380, 5.2 MW/m^2, 1mm
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save B08282019 AD
save LoopData HEMJ
end

%%
x = 776; FName = 'Helium Loop 8_28_2019 14_39_32.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 6.0 g/s, Ti=380, 5.1 MW/m^2, 1mm
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save C08282019 AD
save LoopData HEMJ
end

%%
x = 777; FName = 'Helium Loop 8_28_2019 15_10_38.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 5.0 g/s, Ti=380, 5.0 MW/m^2, 1mm
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save D08282019 AD
save LoopData HEMJ
end

%%
x = 778; FName = 'Helium Loop 8_28_2019 15_55_11.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 4.0 g/s, Ti=380, 5.0 MW/m^2, 1mm
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save E08282019 AD
save LoopData HEMJ
end

%%
x = 779; FName = 'Helium Loop 8_28_2019 16_47_04.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 3.0 g/s, Ti=380, 5.1 MW/m^2, 1mm
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save F08282019 AD
save LoopData HEMJ
end

%%
x = 780; FName = 'Helium Loop 8_29_2019 13_23_00.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 8.0 g/s, Ti=400, 6.5 MW/m^2, 1mm
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save A08292019 AD
save LoopData HEMJ
end

%%
x = 781; FName = 'Helium Loop 8_29_2019 14_40_27.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 7.0 g/s, Ti=400, 6.2 MW/m^2, 1mm
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save B08292019 AD
save LoopData HEMJ
end

%%
x = 782; FName = 'Helium Loop 8_29_2019 15_09_18.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 6.0 g/s, Ti=400, 6.0 MW/m^2, 1mm
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save C08292019 AD
save LoopData HEMJ
end

%%
x = 783; FName = 'Helium Loop 8_29_2019 15_43_35.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 5.0 g/s, Ti=400, 5.9 MW/m^2, 1mm
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save D08292019 AD
save LoopData HEMJ
end

%%
x = 784; FName = 'Helium Loop 8_29_2019 16_14_05.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 4.0 g/s, Ti=400, 6.0 MW/m^2, 1mm
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save E08292019 AD
save LoopData HEMJ
end

%%
x = 785; FName = 'Helium Loop 8_29_2019 16_51_04.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 3.0 g/s, Ti=400, 5.8 MW/m^2, 1mm
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save F08292019 AD
save LoopData HEMJ
end

%%
x = 786; FName = 'Helium Loop 8_30_2019 13_49_33.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 8.0 g/s, Ti=400, 6.2 MW/m^2, 1mm
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save A08302019 AD
save LoopData HEMJ
end

%%
x = 787; FName = 'Helium Loop 8_30_2019 14_41_23.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 7.0 g/s, Ti=400, 6.1 MW/m^2, 1mm
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save B08302019 AD
save LoopData HEMJ
end

%%
x = 788; FName = 'Helium Loop 8_30_2019 15_00_24.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 6.0 g/s, Ti=400, 6.0 MW/m^2, 1mm
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save C08302019 AD
save LoopData HEMJ
end

%%
x = 789; FName = 'Helium Loop 8_30_2019 15_12_31.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 5.0 g/s, Ti=400, 5.9 MW/m^2, 1mm
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save D08302019 AD
save LoopData HEMJ
end

%%
x = 790; FName = 'Helium Loop 8_30_2019 15_28_40.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 4.0 g/s, Ti=400, 5.7 MW/m^2, 1mm
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save E08302019 AD
save LoopData HEMJ
end

%%
x = 791; FName = 'Helium Loop 8_30_2019 16_36_21.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 3.0 g/s, Ti=400, 5.6 MW/m^2, 1mm
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save F08302019 AD
save LoopData HEMJ
end

%%
x = 792; FName = 'Helium Loop 9_5_2019 13_05_13.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 3.0 g/s, Ti=380, 4.8 MW/m^2, 1mm
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save A09052019 AD
save LoopData HEMJ
end

%%
x = 793; FName = 'Helium Loop 9_5_2019 13_56_22.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 4.0 g/s, Ti=380, 4.8 MW/m^2, 1mm
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save B09052019 AD
save LoopData HEMJ
end

%%
x = 794; FName = 'Helium Loop 9_5_2019 14_17_55.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 5.0 g/s, Ti=380, 4.9 MW/m^2, 1mm
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save C09052019 AD
save LoopData HEMJ
end

%%
x = 795; FName = 'Helium Loop 9_5_2019 14_40_34.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 6.0 g/s, Ti=380, 5.0 MW/m^2, 1mm
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save D09052019 AD
save LoopData HEMJ
end

%%
x = 796; FName = 'Helium Loop 9_5_2019 15_03_52.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 7.0 g/s, Ti=380, 5.2 MW/m^2, 1mm
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save E09052019 AD
save LoopData HEMJ
end

%%
x = 797; FName = 'Helium Loop 9_5_2019 15_31_19.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 8.0 g/s, Ti=380, 5.3 MW/m^2, 1mm
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save F09052019 AD
save LoopData HEMJ
end

%%
x = 798; FName = 'Helium Loop 12_17_2019 14_30_11.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 3.0 g/s, Ti=200, 6.3 MW/m^2, 1.25mm
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save A12172019 AD
save LoopData HEMJ
end

%%
x = 799; FName = 'Helium Loop 12_17_2019 15_06_02.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 4.0 g/s, Ti=200, 6.3 MW/m^2, 1.25mm
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save B12172019 AD
save LoopData HEMJ
end

%%
x = 800; FName = 'Helium Loop 12_17_2019 15_28_51.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 5.0 g/s, Ti=200, 6.3 MW/m^2, 1.25mm
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save C12172019 AD
save LoopData HEMJ
end

%%
x = 801; FName = 'Helium Loop 12_17_2019 15_52_34.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 6.0 g/s, Ti=200, 6.3 MW/m^2, 1.25mm
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save D12172019 AD
save LoopData HEMJ
end

%%
x = 802; FName = 'Helium Loop 12_17_2019 16_18_20.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 7.0 g/s, Ti=200, 6.3 MW/m^2, 1.25mm
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save E12172019 AD
save LoopData HEMJ
end

%%
x = 803; FName = 'Helium Loop 12_17_2019 16_46_23.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 8.0 g/s, Ti=200, 6.3 MW/m^2, 1.25mm
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save F12172019 AD
save LoopData HEMJ
end

%%
x = 804; FName = 'Helium Loop 12_18_2019 11_58_27.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 8.0 g/s, Ti=400, 6.3 MW/m^2, 1.25mm
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save A12182019 AD
save LoopData HEMJ
end

%%
x = 805; FName = 'Helium Loop 12_18_2019 12_59_44.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 7.0 g/s, Ti=400, 6.3 MW/m^2, 1.25mm
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save B12182019 AD
save LoopData HEMJ
end

%%
x = 806; FName = 'Helium Loop 12_18_2019 13_09_32.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 6.0 g/s, Ti=400, 6.3 MW/m^2, 1.25mm
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save C12182019 AD
save LoopData HEMJ
end

%%
x = 807; FName = 'Helium Loop 12_18_2019 13_37_07.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 5.0 g/s, Ti=400, 6.3 MW/m^2, 1.25mm
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save D12182019 AD
save LoopData HEMJ
end

%%
x = 808; FName = 'Helium Loop 12_18_2019 14_49_51.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 4.0 g/s, Ti=400, 6.3 MW/m^2, 1.25mm
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save E12182019 AD
save LoopData HEMJ
end

%%
x = 809; FName = 'Helium Loop 12_18_2019 15_00_52.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 3.0 g/s, Ti=400, 6.3 MW/m^2, 1.25mm
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save F12182019 AD
save LoopData HEMJ
end

%%
x = 810; FName = 'Helium Loop 1_21_2020 16_03_44.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 3.0 g/s, Ti=200, 6.2 MW/m^2, 1.25mm
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save A01212020 AD
save LoopData HEMJ
end

%%
x = 811; FName = 'Helium Loop 1_21_2020 16_32_53.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 4.0 g/s, Ti=200, 6.4 MW/m^2, 1.25mm
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save B01212020 AD
save LoopData HEMJ
end

%%
x = 812; FName = 'Helium Loop 1_21_2020 17_05_19.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 5.0 g/s, Ti=200, 6.6 MW/m^2, 1.25mm
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save C01212020 AD
save LoopData HEMJ
end

%%
x = 813; FName = 'Helium Loop 1_21_2020 17_33_40.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 6.0 g/s, Ti=200, 6.8 MW/m^2, 1.25mm
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save D01212020 AD
save LoopData HEMJ
end

%%
x = 814; FName = 'Helium Loop 1_21_2020 18_02_54.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 7.0 g/s, Ti=200, 6.9 MW/m^2, 1.25mm
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save E01212020 AD
save LoopData HEMJ
end

%%
x = 815; FName = 'Helium Loop 1_21_2020 18_19_48.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 8.0 g/s, Ti=200, 7.0 MW/m^2, 1.25mm
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save F01212020 AD
save LoopData HEMJ
end

%%
x = 816; FName = 'Helium Loop 1_30_2020 14_48_52.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 8.0 g/s, Ti=100, 5.9 MW/m^2, 1.25mm
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save A01302020 AD
save LoopData HEMJ
end

%%
x = 817; FName = 'Helium Loop 1_30_2020 15_32_59.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 7.0 g/s, Ti=100, 6.0 MW/m^2, 1.25mm
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save B01302020 AD
save LoopData HEMJ
end

%%
x = 818; FName = 'Helium Loop 1_30_2020 15_57_06.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 6.0 g/s, Ti=100, 5.9 MW/m^2, 1.25mm
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save C01302020 AD
save LoopData HEMJ
end

%%
x = 819; FName = 'Helium Loop 1_30_2020 16_13_15.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 5.0 g/s, Ti=100, 5.9 MW/m^2, 1.25mm
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save D01302020 AD
save LoopData HEMJ
end

%%
x = 820; FName = 'Helium Loop 1_30_2020 16_28_43.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 4.0 g/s, Ti=100, 6.0 MW/m^2, 1.25mm
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save E01302020 AD
save LoopData HEMJ
end

%%
x = 821; FName = 'Helium Loop 1_30_2020 17_17_23.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 3.0 g/s, Ti=100, 6.3 MW/m^2, 1.25mm
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save F01302020 AD
save LoopData HEMJ
end

%%
x = 822; FName = 'Helium Loop 1_31_2020 15_16_41.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 8.0 g/s, Ti=300, 6.2 MW/m^2, 1.25mm
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save A01312020 AD
save LoopData HEMJ
end

%%
x = 823; FName = 'Helium Loop 1_31_2020 15_30_29.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 7.0 g/s, Ti=300, 6.0 MW/m^2, 1.25mm
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save B01312020 AD
save LoopData HEMJ
end

%%
x = 824; FName = 'Helium Loop 1_31_2020 15_50_04.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 6.0 g/s, Ti=300, 5.8 MW/m^2, 1.25mm
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save C01312020 AD
save LoopData HEMJ
end

%%
x = 825; FName = 'Helium Loop 1_31_2020 16_09_03.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 5.0 g/s, Ti=300, 6.0 MW/m^2, 1.25mm
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save D01312020 AD
save LoopData HEMJ
end

%%
x = 826; FName = 'Helium Loop 1_31_2020 16_29_33.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 4.0 g/s, Ti=300, 6.0 MW/m^2, 1.25mm
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save E01312020 AD
save LoopData HEMJ
end

%%
x = 827; FName = 'Helium Loop 1_31_2020 16_51_07.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 3.0 g/s, Ti=300, 6.0 MW/m^2, 1.25mm
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save F01312020 AD
save LoopData HEMJ
end

%%
x = 828; FName = 'Helium Loop 2_26_2020 13_02_50.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 3.0 g/s, Ti=100, 6.0 MW/m^2, 1.25mm
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B360:AB20000',3,7,8);           %Changed to B360 to avoid data before heating % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save A02262020 AD
save LoopData HEMJ
end

%%
x = 829; FName = 'Helium Loop 2_26_2020 14_16_17.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 4.0 g/s, Ti=100, 5.9 MW/m^2, 1.25mm
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save B02262020 AD
save LoopData HEMJ
end

%%
x = 830; FName = 'Helium Loop 2_26_2020 14_35_00.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 5.0 g/s, Ti=100, 5.9 MW/m^2, 1.25mm
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save C02262020 AD
save LoopData HEMJ
end

%%
x = 831; FName = 'Helium Loop 2_26_2020 15_15_02.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 6.0 g/s, Ti=100, 5.9 MW/m^2, 1.25mm
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save D02262020 AD
save LoopData HEMJ
end

%%
x = 832; FName = 'Helium Loop 2_26_2020 15_37_12.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 7.0 g/s, Ti=100, 5.9 MW/m^2, 1.25mm
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save E02262020 AD
save LoopData HEMJ
end

%%
x = 833; FName = 'Helium Loop 2_26_2020 15_53_02.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 8.0 g/s, Ti=100, 6.0 MW/m^2, 1.25mm
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save F02262020 AD
save LoopData HEMJ
end

%%
x = 834; FName = 'Helium Loop 2_26_2020 16_07_46.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 8.0 g/s, Ti=200, 6.1 MW/m^2, 1.25mm
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save A02272020 AD
save LoopData HEMJ
end

%%
x = 835; FName = 'Helium Loop 2_26_2020 16_46_44.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 7.0 g/s, Ti=200, 6.0 MW/m^2, 1.25mm
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save B02272020 AD
save LoopData HEMJ
end

%%
x = 836; FName = 'Helium Loop 2_26_2020 17_05_16.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 6.0 g/s, Ti=200, 6.0 MW/m^2, 1.25mm
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save C02272020 AD
save LoopData HEMJ
end

%%
x = 837; FName = 'Helium Loop 2_26_2020 17_26_11.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 5.0 g/s, Ti=200, 5.9 MW/m^2, 1.25mm
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save D02272020 AD
save LoopData HEMJ
end

%%
x = 838; FName = 'Helium Loop 2_26_2020 17_37_31.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 4.0 g/s, Ti=200, 6.1 MW/m^2, 1.25mm
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save E02272020 AD
save LoopData HEMJ
end

%%
x = 839; FName = 'Helium Loop 2_26_2020 17_53_35.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 3.0 g/s, Ti=200, 6.0 MW/m^2, 1.25mm
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save F02272020 AD
save LoopData HEMJ
end

%%
x = 840; FName = 'Helium Loop 3_2_2020 15_41_08.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 8.0 g/s, Ti=100, 6.1 MW/m^2, 1.25mm
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save A03022020 AD
save LoopData HEMJ
end

%%
x = 841; FName = 'Helium Loop 3_2_2020 15_58_23.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 7.0 g/s, Ti=100, 6.1 MW/m^2, 1.25mm
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save B03022020 AD
save LoopData HEMJ
end

%%
x = 842; FName = 'Helium Loop 3_2_2020 16_16_25.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 6.0 g/s, Ti=100, 6.1 MW/m^2, 1.25mm
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save C03022020 AD
save LoopData HEMJ
end

%%
x = 843; FName = 'Helium Loop 3_2_2020 16_48_22.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 5.0 g/s, Ti=100, 6.1 MW/m^2, 1.25mm
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save D03022020 AD
save LoopData HEMJ
end

%%
x = 844; FName = 'Helium Loop 3_2_2020 17_10_16.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 4.0 g/s, Ti=100, 6.1 MW/m^2, 1.25mm
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save E03022020 AD
save LoopData HEMJ
end

%%
x = 845; FName = 'Helium Loop 3_2_2020 17_29_03.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 3.0 g/s, Ti=100, 6.3 MW/m^2, 1.25mm
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save F03022020 AD
save LoopData HEMJ
end

%%
x = 846; FName = 'Helium Loop 3_4_2020 15_07_20.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 8.0 g/s, Ti=300, 6.2 MW/m^2, 1.25mm
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save A03042020 AD
save LoopData HEMJ
end

%%
x = 847; FName = 'Helium Loop 3_4_2020 15_26_15.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 7.0 g/s, Ti=300, 6.1 MW/m^2, 1.25mm
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save B03042020 AD
save LoopData HEMJ
end

%%
x = 848; FName = 'Helium Loop 3_4_2020 15_38_07.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 6.0 g/s, Ti=300, 6.0 MW/m^2, 1.25mm
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save C03042020 AD
save LoopData HEMJ
end

%%
x = 849; FName = 'Helium Loop 3_4_2020 15_56_12.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 5.0 g/s, Ti=300, 5.9 MW/m^2, 1.25mm
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save D03042020 AD
save LoopData HEMJ
end

%%
x = 850; FName = 'Helium Loop 3_4_2020 16_18_00.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 4.0 g/s, Ti=300, 5.8 MW/m^2, 1.25mm
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save E03042020 AD
save LoopData HEMJ
end

%%
x = 851; FName = 'Helium Loop 3_4_2020 16_39_48.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 3.0 g/s, Ti=300, 5.7 MW/m^2, 1.25mm
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save F03042020 AD
save LoopData HEMJ
end

%%
x = 852; FName = 'Helium Loop 3_10_2020 15_15_07.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 3.0 g/s, Ti=300, 6.0 MW/m^2, 1.25mm
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save A03102020 AD
save LoopData HEMJ
end

%%
x = 853; FName = 'Helium Loop 3_10_2020 15_32_11.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 4.0 g/s, Ti=300, 6.0 MW/m^2, 1.25mm
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save B03102020 AD
save LoopData HEMJ
end

%%
x = 854; FName = 'Helium Loop 3_10_2020 16_04_39.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 5.0 g/s, Ti=300, 5.9 MW/m^2, 1.25mm
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save C03102020 AD
save LoopData HEMJ
end

%%
x = 855; FName = 'Helium Loop 3_10_2020 16_25_56.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 6.0 g/s, Ti=300, 5.8 MW/m^2, 1.25mm
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save D03102020 AD
save LoopData HEMJ
end

%%
x = 856; FName = 'Helium Loop 3_10_2020 17_05_06.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 7.0 g/s, Ti=300, 5.7 MW/m^2, 1.25mm
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save E03102020 AD
save LoopData HEMJ
end

%%
x = 857; FName = 'Helium Loop 3_10_2020 17_32_35.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 8.0 g/s, Ti=300, 5.7 MW/m^2, 1.25mm
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save F03102020 AD
save LoopData HEMJ
end

%%
x = 858; FName = 'Helium Loop 9_8_2020 14_08_09.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 8.0 g/s, Ti=100, 4.4 MW/m^2, 1.25mm, 
% New induction heater testing (US SOLID)
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save A09082020 AD
save LoopData HEMJ
end

%%
x = 859; FName = 'Helium Loop 9_8_2020 15_10_11.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 7.0 g/s, Ti=100, 4.5 MW/m^2, 1.25mm, 
% New induction heater testing (US SOLID)
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save B09082020 AD
save LoopData HEMJ
end

%%
x = 860; FName = 'Helium Loop 9_8_2020 15_22_27.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 6.0 g/s, Ti=100, 4.5 MW/m^2, 1.25mm, 
% New induction heater testing (US SOLID)
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save C09082020 AD
save LoopData HEMJ
end

%%
x = 861; FName = 'Helium Loop 9_8_2020 15_34_58.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 5.0 g/s, Ti=100, 4.6 MW/m^2, 1.25mm, 
% New induction heater testing (US SOLID)
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save D09082020 AD
save LoopData HEMJ
end

%%
x = 862; FName = 'Helium Loop 9_8_2020 15_49_27.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 4.0 g/s, Ti=100, 4.7 MW/m^2, 1.25mm, 
% New induction heater testing (US SOLID)
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save E09082020 AD
save LoopData HEMJ
end

%%
x = 863; FName = 'Helium Loop 9_8_2020 16_12_36.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 3.0 g/s, Ti=100, 5.0 MW/m^2, 1.25mm, 
% New induction heater testing (US SOLID)
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save F09082020 AD
save LoopData HEMJ
end

%%
x = 864; FName = 'Helium Loop 3_31_2021 15_39_35.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 3.0 g/s, Ti=24, 0.0 MW/m^2, ~1.25mm, 
% New dP transducer testing (Omega PX3005)
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,4) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];  %*Using Dwn stream P (AD(1,4))
save A03312021 AD
save LoopData HEMJ
end

%%
x = 865; FName = 'Helium Loop 3_31_2021 15_59_11.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 4.0 g/s, Ti=24, 0.0 MW/m^2, ~1.25mm, 
% New dP transducer testing (Omega PX3005)
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,4) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];  %*Using Dwn stream P (AD(1,4))
save B03312021 AD
save LoopData HEMJ
end

%%
x = 866; FName = 'Helium Loop 3_31_2021 16_12_51.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 5.0 g/s, Ti=24, 0.0 MW/m^2, ~1.25mm, 
% New dP transducer testing (Omega PX3005)
% 0.75 scan/second 
load LoopData; 
AD = averreg_fix(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,4) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];  %*Using Dwn stream P (AD(1,4))
save C03312021 AD
save LoopData HEMJ
end

%%
x = 867; FName = 'Helium Loop 3_31_2021 16_18_38.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 6.0 g/s, Ti=24, 0.0 MW/m^2, ~1.25mm, 
% New dP transducer testing (Omega PX3005)
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,4) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];  %*Using Dwn stream P (AD(1,4))
save D03312021 AD
save LoopData HEMJ
end

%%
x = 868; FName = 'Helium Loop 3_31_2021 16_25_00.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 7.0 g/s, Ti=24, 0.0 MW/m^2, ~1.25mm, 
% New dP transducer testing (Omega PX3005)
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,4) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];  %*Using Dwn stream P (AD(1,4))
save E03312021 AD
save LoopData HEMJ
end

%%
x = 869; FName = 'Helium Loop 3_31_2021 16_34_04.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 8.0 g/s, Ti=24, 0.0 MW/m^2, ~1.25mm, 
% New dP transducer testing (Omega PX3005)
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,4) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];  %*Using Dwn stream P (AD(1,4))
save F03312021 AD
save LoopData HEMJ
end

%%
x = 870; FName = 'Helium Loop 4_6_2021 15_58_42.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 3.0 g/s, Ti=21, 0 MW/m^2, ~1.25mm
% New dP transducer testing (Omega PX3005)
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save A04062021 AD
save LoopData HEMJ
end

%%
x = 871; FName = 'Helium Loop 4_6_2021 16_12_28.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 4.0 g/s, Ti=22, 0 MW/m^2, ~1.25mm
% New dP transducer testing (Omega PX3005)
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save B04062021 AD
save LoopData HEMJ
end

%%
x = 872; FName = 'Helium Loop 4_6_2021 16_19_30.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 5.0 g/s, Ti=24, 0 MW/m^2, ~1.25mm
% New dP transducer testing (Omega PX3005)
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save C04062021 AD
save LoopData HEMJ
end

%%
x = 873; FName = 'Helium Loop 4_6_2021 16_27_44.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 6.0 g/s, Ti=25, 0 MW/m^2, ~1.25mm
% New dP transducer testing (Omega PX3005)
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save D04062021 AD
save LoopData HEMJ
end

%%
x = 874; FName = 'Helium Loop 4_6_2021 16_38_37.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 7.0 g/s, Ti=25, 0 MW/m^2, ~1.25mm
% New dP transducer testing (Omega PX3005)
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save E04062021 AD
save LoopData HEMJ
end

%%
x = 875; FName = 'Helium Loop 4_6_2021 16_46_01.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 8.0 g/s, Ti=25, 0 MW/m^2, ~1.25mm
% New dP transducer testing (Omega PX3005)
% 0.75 scan/second 
load LoopData; 
AD = averreg_fix(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save F04062021 AD
save LoopData HEMJ
end

%%
x = 876; FName = 'Helium Loop 4_6_2021 17_01_40.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 8.0 g/s, Ti=25, 0 MW/m^2, ~1.25mm
% New dP transducer testing (Omega PX3005)
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save A04072021 AD
save LoopData HEMJ
end

%%
x = 877; FName = 'Helium Loop 4_6_2021 17_07_49.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 7.0 g/s, Ti=25, 0 MW/m^2, ~1.25mm
% New dP transducer testing (Omega PX3005)
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save B04072021 AD
save LoopData HEMJ
end

%%
x = 878; FName = 'Helium Loop 4_6_2021 17_13_43.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 6.0 g/s, Ti=25, 0 MW/m^2, ~1.25mm
% New dP transducer testing (Omega PX3005)
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save C04072021 AD
save LoopData HEMJ
end

%%
x = 879; FName = 'Helium Loop 4_6_2021 17_19_22.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 5.0 g/s, Ti=25, 0 MW/m^2, ~1.25mm
% New dP transducer testing (Omega PX3005)
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save D04072021 AD
save LoopData HEMJ
end

%%
x = 880; FName = 'Helium Loop 4_6_2021 17_25_28.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 4.0 g/s, Ti=25, 0 MW/m^2, ~1.25mm
% New dP transducer testing (Omega PX3005)
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save E04072021 AD
save LoopData HEMJ
end

%%
x = 881; FName = 'Helium Loop 4_6_2021 17_31_21.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 3.0 g/s, Ti=25, 0 MW/m^2, ~1.25mm
% New dP transducer testing (Omega PX3005)
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save F04072021 AD
save LoopData HEMJ
end

%%
x = 882; FName = 'Helium Loop 6_15_2021 15_30_35.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 3.0 g/s, Ti=25, 0 MW/m^2, NO JET CARTRIDGE
% New dP transducer testing (Omega PX3005-150)
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save A06162021 AD
save LoopData HEMJ
end

%%
x = 883; FName = 'Helium Loop 6_15_2021 15_43_35.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 4.0 g/s, Ti=25, 0 MW/m^2, NO JET CARTRIDGE
% New dP transducer testing (Omega PX3005-150)
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save B06162021 AD
save LoopData HEMJ
end

%%
x = 884; FName = 'Helium Loop 6_15_2021 15_50_44.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 5.0 g/s, Ti=25, 0 MW/m^2, NO JET CARTRIDGE
% New dP transducer testing (Omega PX3005-150)
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save C06162021 AD
save LoopData HEMJ
end

%%
x = 885; FName = 'Helium Loop 6_15_2021 15_56_44.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 6.0 g/s, Ti=25, 0 MW/m^2, NO JET CARTRIDGE
% New dP transducer testing (Omega PX3005-150)
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save D06162021 AD
save LoopData HEMJ
end

%%
x = 886; FName = 'Helium Loop 6_15_2021 16_41_41.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 7.0 g/s, Ti=25, 0 MW/m^2, NO JET CARTRIDGE
% New dP transducer testing (Omega PX3005-150)
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save E06162021 AD
save LoopData HEMJ
end

%%
x = 887; FName = 'Helium Loop 6_15_2021 16_48_43.csv';                       % Case number and File Name
for m=1:1                                                                   % For loop used only for folding code section
% Steady-State Experiment - WL10 - Flat Jet Design (FR1H07)
% One SS Experiment - 8.0 g/s, Ti=25, 0 MW/m^2, NO JET CARTRIDGE
% New dP transducer testing (Omega PX3005-150)
% 0.75 scan/second 
load LoopData; 
AD = averreg(FName,'B36:AB20000',3,7,8);                                    % run 'averreg.m'
% AD(1,[7:12]) = AD(1,[7:12])-273.15;                                             % Convert Temperatures to C     
AD(1,17:18) = AD(1,17:18)*6894.75728;                                             % Convert Pressures to Pa     

HEMJ(x,:) = [AD(1,1) 0 0 AD(1,9:12) zeros(1,4) AD(1,17) AD(1,3) AD(1,18) AD(1,8) AD(1,7) 0 AD(1,5) 99000 1];
save F06162021 AD
save LoopData HEMJ
end

%% Plotting

% Plotting for old DAQ exports
% plot(1:length(file),file(:,14),1:length(file),file(:,15),1:length(file),file(:,21))
% 14 Tout / 15 Tin / 21 mdot

% New DAQ configuration (fewer channels)
% plot(1:length(file),file(:,12),1:length(file),file(:,13),1:length(file),file(:,18))     % 412 - 421
% plot(1:length(file),file(:,12),1:length(file),file(:,13),1:length(file),file(:,19))     % 422 - 589

% DAQ Configuration w/ Vacuum Chamber Setup (24 channels)
% plot(1:length(file),file(:,12),1:length(file),file(:,13),1:length(file),file(:,20),1:length(file),file(:,17))
% plot(1:length(file),file(:,12),1:length(file),file(:,13),1:length(file),file(:,20))
% New Daq Setup
% plot(1:length(file),file(:,9),1:length(file),file(:,10),1:length(file),file(:,23))
% Reversed Heat Flux
plot(1:length(file),file(:,14),1:length(file),file(:,13))


%Extra Figures
for m=1:0
    
    % figure(1)
    % hold on
    % plot([1:221].*.75,A041613(4520:4740,18),'-k','LineWidth',2)
    % set(gca,'FontSize',28), box on
    % title('Mass Flow Rate Over Time During an Experiment')
    % xlabel('Time (s)','FontSize',28), ylabel('Mass Flow Rate (g/s)','FontSize',28)
    % axis([0 160 3.5 4.25])
    % hold off

    % A=xlsread('Helium Loop 1_15_2014 17_37_38.csv', 1, 'C30:Y20000');
    % figure(1)
    % hold on
    % plot([1000:1400].*.75,A(1000:1400,21)./1e6,'-k','LineWidth',2)
    % set(gca,'FontSize',28), box on
    % title('Induction Heater CV Heat Flux Over Time')
    % xlabel('Time (s)','FontSize',28), ylabel('CV Heat Flux (MW/m^2)','FontSize',28)
    % hold off

    % A=4;
    % % [B C]=fit(([2735:2935]'-2734).*.75,A050214(2735:2935,A)-min(A050214(2735:2935,A)),'exp1')
    % [B C]=fit(([2735:2750]'-2734).*.75,A050214(2735:2750,A)-min(A050214(2735:2935,A)),'exp1')
    % figure(1)
    % hold on
    % % plot(1:length(A050214),A050214(:,15),'-k','LineWidth',2) %#ok<NBRAK>
    % % plot(([2735:2935]-2734).*.75,A050214(2735:2935,A)-min(A050214(2735:2935,A)),'-k','LineWidth',3) %#ok<NBRAK>\
    % plot(([2735:2750]-2734).*.75,A050214(2735:2750,A)-min(A050214(2735:2935,A)),'-k','LineWidth',3) %#ok<NBRAK>
    % % plot(([2735:2935]-2734).*.75,A050214(2735:2935,15)-min(A050214(2735:2935,15)),'--k','LineWidth',3) %#ok<NBRAK>
    % fplot(@(x)B.a*exp(B.b*x),[1 30])
    % set(gca,'FontSize',28), box on
    % xlabel('Time (s)','FontSize',28), ylabel('Temperature Difference (\circC)','FontSize',28)
    % legend('Cooled Surface Temperature','Outlet Temperature','Location','Northeast')
    % hold off
% 
%     % Induction Heater Distribution
% %     plot(1:length(A050914),A050914(:,23))
% %     plot(1:length(A051614),A051614(:,23))
%     figure(1)
%     plot([0,5,10,15],IHD.*(0.017.^2).*pi./4.*1e6,'ks','MarkerSize',16,'MarkerFaceColor','k')
%     set(gca,'FontSize',28), box on
%     xlabel('Distance of coil from surface (mm)','FontSize',28), ylabel('Thermal Power (W)','FontSize',28)
%     title('Power entering the Test Section from the Induction Heater','FontSize',28)
%     axis([-1 16 0 500])
    

end

% toc
 
