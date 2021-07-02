%% Calculations for Helium Loop HEMJ Experiments
% M.E. Ph.D. Research
% Updated byAc [mm2]: Bailey Zhao (2017)

% Initializations
clc, clear, close all
Main='Q:\HEMJ Data Processing\Programs';
BaseData='Q:\HEMJ Data Processing\Programs\Database';

% Loading Variables
cd(BaseData);
load GASPROPTABLE3                                                         % GASPROPTABLE - NIST/Incropera data @ 0.1 MPa He                 
load LoopData                                                              % GASPROPTABLE3 - NIST data @ 10 MPa He
load LoopConstants
cd(Main);
%% Calculating SS values and error

Air = [49:52,60:63,71:79];                                                 % Case numbers for given fluid
Helium = [1:48,53:59,88:1000];
Argon = [64:70,80:87];
Brass = [49:70];                                                           % Case numbers for given solid
Steel = [71:93];
MT185 = [1:48,94:181,228:338,537:577];

WL10 = [182:227,339:536,578:647,683:764];
WL10flat = [648:682, 765:1000];

% Calculating Values and Error
for i=1:size(HEMJ,1)
    %-------------------------- Initial Cases -----------------------------
    if (i<=48 || i>93) && i<=181
        if ~HEMJ(i,17),                                                    % Converting Units to SI
            HEMJ(i,[2:7,10,12:13])=HEMJ(i,[2:7,10,12:13])+273.15;
            if i<43
                HEMJ(i,8)=((HEMJ(i,8)+25)/6250)*(100/((.02+(0.235*HEMJ(i,9)/1e6))-.004))-...
                          (100/((.02+(0.235*HEMJ(i,9)/1e6))-.004))*.004;   % dP Test Section Correction - 100 psi
            else
                HEMJ(i,8)=((HEMJ(i,8)+5.9175)/1491.69)*(23.867/((0.019967+(0.131*HEMJ(i,9)/1e6))-0.003967))-...
                          (23.867/((0.019967+(0.131*HEMJ(i,9)/1e6))-0.003967))*0.003967; %dP Test Section Correction - 30 psi
            end
            HEMJ(i,14)=((HEMJ(i,14)+1493)/373250)*(5972.16/((.02+(0.285*HEMJ(i,9)/1e6))-.004))-...
                       (5972.16/((.02+(0.285*HEMJ(i,9)/1e6))-.004))*.004;  % dP Main Correction
            HEMJ(i,[8,9,11])=HEMJ(i,[8,9,11])*6894.75728; 
            HEMJ(i,17)=1;
        end
        [Tvent,Th8,Tm8,Tl8,T6,T4,T2,dPtest,Pvent,Ptest,To,Ti,dPmain,dPbypass,Pa] = ...
            deal(HEMJ(i,1),HEMJ(i,2),HEMJ(i,3),HEMJ(i,4),HEMJ(i,5),HEMJ(i,6),HEMJ(i,7),HEMJ(i,8),HEMJ(i,9),...
            HEMJ(i,11),HEMJ(i,12),HEMJ(i,13),HEMJ(i,14),HEMJ(i,15),HEMJ(i,16)); 
        Pi=Ptest+dPtest+Pa;                                                % Absolute Inlet Pressure
        Po=Ptest+Pa;                                                       % Absolute Outlet Pressure
        Pvent=Pvent+Pa;                                                    % Absolute Venturi Pressure
    %-------------------------- Jordan's Cases ----------------------------
    elseif i>=49 && i<=93                                                  
        if ~HEMJ(i,17),                                                    % Converting Units to SI
            HEMJ(i,[2:7,12,13])=HEMJ(i,[2:7,12,13])+273.15;
            HEMJ(i,[8,11])=HEMJ(i,[8,11])*6894.75728;
            HEMJ(i,16)=HEMJ(i,16)*133.322368;
            HEMJ(i,17)=1;
        end
        [mdot,Th8,Tm8,Tl8,T6,T4,T2,dPtest,Ptest,To,Ti,Pa] = deal(HEMJ(i,1),...
            HEMJ(i,2),HEMJ(i,3),HEMJ(i,4),HEMJ(i,5),HEMJ(i,6),HEMJ(i,7),HEMJ(i,8),...
            HEMJ(i,11),HEMJ(i,12),HEMJ(i,13),HEMJ(i,16));
        Pi=Ptest+Pa;
        Po=Ptest-dPtest+Pa;
    %-------------------------- Current Cases -----------------------------
    elseif i>=182 
        if ~HEMJ(i,20),                                                    % Converting Units to SI
            HEMJ(i,[2:11,15:16])=HEMJ(i,[2:11,15:16])+273.15;
            HEMJ(i,12)=((HEMJ(i,12)+5.9175)/1491.69)*(23.867/((0.019967+(0.131*HEMJ(i,13)/1e6))-0.003967))-...
                       (23.867/((0.019967+(0.131*HEMJ(i,13)/1e6))-0.003967))*0.003967;              % dP Test Section Correction - 30 psi
            HEMJ(i,18)=((HEMJ(i,18)+1493)/373250)*(5972.16/((.02+(0.285*HEMJ(i,13)/1e6))-.004))-...
                       (5972.16/((.02+(0.285*HEMJ(i,13)/1e6))-.004))*.004;                          % dP Main Correction
            HEMJ(i,[12:14])=HEMJ(i,[12:14])*6894.75728; 
            HEMJ(i,20)=1;
        end
        [Tvent,Th8,Tm8,Tl8,T6,T4,T2,Tw4,Tw3,Tw2,Tw1,dPtest,Pvent,Ptest,To,Ti,dPmain,Pa]=deal(HEMJ(i,1),...
            HEMJ(i,2),HEMJ(i,3),HEMJ(i,4),HEMJ(i,5),HEMJ(i,6),HEMJ(i,7),HEMJ(i,8),HEMJ(i,9),HEMJ(i,10),...
            HEMJ(i,11),HEMJ(i,12),HEMJ(i,13),HEMJ(i,14),HEMJ(i,15),HEMJ(i,16),HEMJ(i,18),HEMJ(i,19));
        Pi=Ptest+dPtest+Pa;                                                % Absolute Inlet Pressure
        Po=Ptest+Pa;                                                       % Absolute Outlet Pressure
        Pvent=Pvent+Pa;                                                    % Absolute Venturi Pressure
    end
    
    % Labeling the gas
    if max(Air==i)>0
        gas='air';
        gamma=1.4;
    elseif max(Helium==i)>0
        gas='he';
        gamma=5/3;
    elseif max(Argon==i)>0
        gas='ar';
        gamma=5/3;
    end

    % Labeling the test section material and dimensions
    if max(Brass==i)>0
        k=@(T) -2.0778e-4*T^2 + 3.3154e-1*T + 17.324;                      % ORNL
        LTC8=0.0007874; LTC6=0.0008249; LTC4=0.0007448; LTC2=0.0005723;    % TC Distance to CS
%         AACS=@(CS8,CS6,CS4,CS2)0.0253*CS8+0.2127*CS6+0.4755*CS4+0.2843*CS2; Ac=1.232e-4;
        AACS=@(CS8,CS6,CS4,CS2)0.0169*CS8+0.1423*CS6+0.3181*CS4+0.5227*CS2; Ac=1.8421e-4;
    elseif max(Steel==i)>0
        k=@(T) -6.5232e-8*T^3 + 1.1371e-4*T^2 - 8.8186e-2*T + 68.435;      % ORNL
        LTC8=0.0007874; LTC6=0.0008249; LTC4=0.0007448; LTC2=0.0006354;    % TC Distance to CS
%         AACS=@(CS8,CS6,CS4,CS2)0.0253*CS8+0.2127*CS6+0.4755*CS4+0.2843*CS2; Ac=1.232e-4;
        AACS=@(CS8,CS6,CS4,CS2)0.0169*CS8+0.1423*CS6+0.3181*CS4+0.5227*CS2; Ac=1.8421e-4;
    elseif max(MT185==i)>0 && i<228 
%         k=@(T)-2.2156e-5*T^2+4.1165e-2*T+7.0245e1; %ORNL
        k=@(T) 5.325e-8*T^3 - 1.261e-4*T^2 + 0.1045*T + 58.36;             % ORNL2
        LTC8=0.000788; LTC6=0.0008264; LTC4=0.0007468; LTC2=0.0005730;     % TC Distance to CS
%         AACS=@(CS8,CS6,CS4,CS2)0.0253*CS8+0.2127*CS6+0.4755*CS4+0.2843*CS2; Ac=1.232e-4;
        AACS=@(CS8,CS6,CS4,CS2)0.0169*CS8+0.1423*CS6+0.3181*CS4+0.5227*CS2; Ac=1.8421e-4;
    elseif max(MT185==i)>0 && i>=228                             % Integrated TS
        k=@(T) 5.325e-8*T^3 - 1.261e-4*T^2 + 0.1045*T + 58.36;             % ORNL2
        LTC8=0.000788; LTC6=0.0008264; LTC4=0.0007468; LTC2=0.0005730;     % TC Distance to CS
%         AACS=@(CS8,CS6,CS4,CS2)0.0375*CS8+0.2308*CS6+0.4615*CS4+0.2702*CS2; Ac=1.2672e-4;
%         AACS=@(CS8,CS6,CS4,CS2)0.0258*CS8+0.1587*CS6+0.3175*CS4+0.4980*CS2; Ac=1.8421e-4;
        AACS=@(CS8,CS6,CS4,CS2)0.0169*CS8+0.1423*CS6+0.3181*CS4+0.5227*CS2; Ac=1.8421e-4;
    elseif max(WL10==i)>0
        k=@(T) (3.37238e-5*T^2 - 1.14272e-1*T + 206.822);                  % Roedig
%         k=@(T) 1.3804e-5*T^2 - 4.8151e-2*T + 1.3594e2;                     % Norajitra
        LTC8=0.000788; LTC6=0.0008264; LTC4=0.0007468; LTC2=0.0005730;     % TC Distance to CS
%         AACS=@(CS8,CS6,CS4,CS2)0.0253*CS8+0.2127*CS6+0.4755*CS4+0.2843*CS2; Ac=1.232e-4;
%         AACS=@(CS8,CS6,CS4,CS2)0.0169*CS8+0.1423*CS6+0.8408*CS4; Ac=1.8421e-4;   % Area-averaging based on 3 TCs
        AACS=@(CS8,CS6,CS4,CS2)0.0169*CS8+0.1423*CS6+0.3181*CS4+0.5227*CS2; Ac=1.8421e-4;
    elseif max(WL10flat==i)>0
        k=@(T) (3.37238e-5*T^2 - 1.14272e-1*T + 206.822);                  % Roedig
        LTC8=0.0008; LTC6=0.0008; LTC4=0.0008; LTC2=0.00104;               % TC Distance to CS
        AACS=@(CS8,CS6,CS4,CS2)0.02244*CS8+0.1862*CS6+0.4007*CS4+0.3907*CS2; Ac=1.5424e-4;
    end

    Tave = (Ti+To)/2;                                                      % Define Avg Temp
    
    if i>=49 && i<=93                                                      % Mass Flow Rate
        ANS(i,1)=mdot;                                                                                  % Jordan's Cases
    else
        ANS(i,1)=Cd*A1*sqrt(2*Pvent*dPmain/(((A1/A2)^2-1)*GASPROP3(300,'R',gas,Prop,PropData)*Tvent));  % All other cases
    end
    
    if max(WL10flat==i)>0
        ANS(i,2)=ANS(i,1)*Dflat/(Aj*GASPROP3(Ti,'mu',gas,Prop,PropData));  % Reynolds Number (Dflat, FR1H07)
    else
        ANS(i,2)=ANS(i,1)*Dj/(Aj*GASPROP3(Ti,'mu',gas,Prop,PropData));     % Re for all other cases
    end
    ANS(i,3)=ANS(i,1)*GASPROP3(Tave,'cp',gas,Prop,PropData)*(To-Ti)/Ah;    % CV Heat Flux
    HF=ANS(i,3);
    
    % Cooled Surface Temperature Extrapolation 
    Tl8g=500; T6g=500; T4g=500; T2g=500;
    error8=1; error6=1; error4=1; error2=1; iter=0;
    while error8>=1e-4 || error6>=1e-4 || error4>=1e-4 || error2>=1e-4
        ANS(i,4)=-HF*LTC8/k((Tl8g+Tl8)/2)+Tl8; % TC8
        ANS(i,5)=-HF*LTC6/k((T6g+T6)/2)+T6; % TC6
        ANS(i,6)=-HF*LTC4/k((T4g+T4)/2)+T4; % TC4
        ANS(i,7)=-HF*LTC2/k((T2g+T2)/2)+T2; % TC2
%         ANS(i,4)=-HF*LTC/k((Tl8g+Tl8)/2)+Tl8; % TC8                      % Extrapolation assuming same LTC for all TCs
%         ANS(i,5)=-HF*LTC/k((T6g+T6)/2)+T6;    % TC6
%         ANS(i,6)=-HF*LTC/k((T4g+T4)/2)+T4;    % TC4
%         ANS(i,7)=-HF*LTC/k((T2g+T2)/2)+T2;    % TC2
        error8=abs(ANS(i,4)-Tl8g)/Tl8g;
        error6=abs(ANS(i,5)-T6g)/T6g;
        error4=abs(ANS(i,6)-T4g)/T4g;
        error2=abs(ANS(i,7)-T2g)/T2g;
        Tl8g=ANS(i,4);                        % T_CS_1
        T6g=ANS(i,5);                         % T_CS_2
        T4g=ANS(i,6);                         % T_CS_3
        T2g=ANS(i,7);                         % T_CS_4
        iter=iter+1;
        if iter>=1000; error('Temp extrapolation is not converging.'), end
    end 

    ANS(i,8)=AACS(ANS(i,4),ANS(i,5),ANS(i,6),ANS(i,7));                    % Test-Section dependent area averaging
    ANS(i,9)=HF*(Ah/Ac)/(ANS(i,8)-Ti);                                     % Average HTC
    if max(WL10flat==i)>0
        ANS(i,10)=ANS(i,9)*Dflat/GASPROP3(Tave,'k',gas,Prop,PropData);     % Average Nu (FR1H07)
    else
        ANS(i,10)=ANS(i,9)*Dj/GASPROP3(Tave,'k',gas,Prop,PropData);        % Average Nu (all other cases)
    end
    HTCalt(i,1) = HF/(ANS(i,8)-Ti);
    HTCalt(i,2) = HTCalt(i,1)*0.0954/GASPROP3(Tave,'k',gas,Prop,PropData);
    
    ANS(i,11)=k(ANS(i,8))/GASPROP3(Tave,'k',gas,Prop,PropData);            % Kappa
    ANS(i,12)=ANS(i,10)/ANS(i,11)^0.19;                                    % Fit using only Loop Data
    HTCalt(i,3) = HTCalt(i,2)/ANS(i,11)^0.19;
    ANS(i,13)=Po/(GASPROP3(300,'R',gas,Prop,PropData)*Ti);                 % Pressure Drop Density
    ANS(i,14)=ANS(i,1)/(ANS(i,13)*Aj);                                     % Average Jet Velocity
    ANS(i,15)=2*dPtest/(ANS(i,13)*ANS(i,14)^2);                            % K_L
    ANS(i,16)=GASPROP3(Tave,'mu',gas,Prop,PropData)/...                    % Fluid viscosity / Solid (@ T_CS) viscosity
              GASPROP3(ANS(i,8),'mu',gas,Prop,PropData);
    ANS(i,17)=GASPROP3(Ti,'mu',gas,Prop,PropData);                         % Inlet Viscosity
    ANS(i,18)=GASPROP3(To,'mu',gas,Prop,PropData);                         % Outlet Viscosity
    ANS(i,19)=GASPROP3(Tave,'Pr',gas,Prop,PropData);                       % Prantdl Number
    ANS(i,20)=ANS(i,10)/(ANS(i,11)^0.25);                                  % Nu*K^(-0.25)
    ANS(i,21)=(GASPROP3(Tave,'mu',gas,Prop,PropData)*ANS(i,14)^2)/...      % Brinkman Number
              (GASPROP3(Tave,'k',gas,Prop,PropData)*(ANS(i,8)-Ti));
%     ANS(i,22) = ANS(i,14)^2/(GASPROP3(Tave,'cp',gas,Prop,PropData)*(To-Ti)); % Eckert number
    ANS(i,22) = (9.81*.0025436*(HF*Ah/Ac)*0.00647^4)/(GASPROP3(Tave,'k',gas,Prop,PropData)*GASPROP3(Tave,'nu',gas,Prop,PropData)^2); % Grashof Number
    ANS(i,23) = ANS(i,22)/((ANS(i,2)*Dh/Dj)^3.425*GASPROP3(Tave,'Pr',gas,Prop,PropData)^0.8);                                       % Richardson Number/Buoyancy Parameter
    if max(WL10flat==i)>0
    ANS(i,24) = (4*HF*Ah/Ac*GASPROP3(Tave,'mu',gas,Prop,PropData)*GASPROP3(Tave,'cp',gas,Prop,PropData)*Tave)/...
                (ANS(i,2)*Di/Dflat*ANS(i,1)/Ai*GASPROP3(Ti,'cp',gas,Prop,PropData)^2*Ti^2*GASPROP3(Ti,'mu',gas,Prop,PropData)); % Acceleration parameter, K
    else
    ANS(i,24) = (4*HF*Ah/Ac*GASPROP3(Tave,'mu',gas,Prop,PropData)*GASPROP3(Tave,'cp',gas,Prop,PropData)*Tave)/...
                (ANS(i,2)*Di/Dj*ANS(i,1)/Ai*GASPROP3(Ti,'cp',gas,Prop,PropData)^2*Ti^2*GASPROP3(Ti,'mu',gas,Prop,PropData));
    end
    ANS(i,25) = (HF*Ah/Ac)/(ANS(i,1)/(pi/4*0.00954^2)*Ti*GASPROP3(Ti,'cp',gas,Prop,PropData));  % q+
    ANS(i,26)=ANS(i,1)*Dj/(Aj*GASPROP3(Tave,'mu',gas,Prop,PropData));     % Re based on Tave
    ANS(i,27)=ANS(i,9)*Dj/GASPROP3(Ti,'k',gas,Prop,PropData);        % Nu based on Ti
    ANS(i,28)=ANS(i,1)*GASPROP3(Ti,'cp',gas,Prop,PropData)*(To-Ti)/Ah;    % CV Heat Flux at Ti
    
    
    % Error in Measurements
    if (i<=48 || i>93) && i<=181
        if HEMJ(i,1)<=548.15, eTvent=1.1; else eTvent=(HEMJ(i,1)-273.15)*.004; end
        if HEMJ(i,2)<=548.15, eTh8=1.1; else eTh8=(HEMJ(i,2)-273.15)*.004; end
        if HEMJ(i,3)<=548.15, eTm8=1.1; else eTm8=(HEMJ(i,3)-273.15)*.004; end
        if HEMJ(i,4)<=548.15, eTl8=1.1; else eTl8=(HEMJ(i,4)-273.15)*.004; end
        if HEMJ(i,5)<=548.15, eT6=1.1; else eT6=(HEMJ(i,5)-273.15)*.004; end
        if HEMJ(i,6)<=548.15, eT4=1.1; else eT4=(HEMJ(i,6)-273.15)*.004; end
        if HEMJ(i,7)<=548.15, eT2=1.1; else eT2=(HEMJ(i,7)-273.15)*.004; end
        eTo=0.15+0.002*(HEMJ(i,12)-273.15); eTi=0.15+0.002*(HEMJ(i,13)-273.15);
        edPtest=3.291e2; ePvent=3.447e4; ePtest=3.447e4*2; edPmain=12; ePa=1e3;
        ePi=sqrt(ePtest^2+edPtest^2+ePa^2);
        ePo=sqrt(ePtest^2+ePa^2);
        ePvent=sqrt(ePvent^2+ePa^2);
    elseif i>=182
        if HEMJ(i,1)<=548.15, eTvent=1.1; else eTvent=(HEMJ(i,1)-273.15)*.004; end
        if HEMJ(i,2)<=548.15, eTh8=1.1; else eTh8=(HEMJ(i,2)-273.15)*.004; end
        if HEMJ(i,3)<=548.15, eTm8=1.1; else eTm8=(HEMJ(i,3)-273.15)*.004; end
        if HEMJ(i,4)<=548.15, eTl8=1.1; else eTl8=(HEMJ(i,4)-273.15)*.004; end
        if HEMJ(i,5)<=548.15, eT6=1.1; else eT6=(HEMJ(i,5)-273.15)*.004; end
        if HEMJ(i,6)<=548.15, eT4=1.1; else eT4=(HEMJ(i,6)-273.15)*.004; end
        if HEMJ(i,7)<=548.15, eT2=1.1; else eT2=(HEMJ(i,7)-273.15)*.004; end
        edPtest=3.291e2; ePvent=3.447e4; ePtest=3.447e4*2;
        if i<=100
            if HEMJ(i,12)<=548.15, eTo=1.1; else eTo=(HEMJ(i,12)-273.15)*.004; end
            if HEMJ(i,13)<=523.15, eTi=1; else eTi=(HEMJ(i,13)-273.15)*.004; end
        else
            eTo=0.15+0.002*(HEMJ(i,15)-273.15);
            eTi=0.15+0.002*(HEMJ(i,16)-273.15);
        end %Inlet/Outlet Temperature
        edPmain=12; ePa=1e3;
        ePi=sqrt(ePtest^2+edPtest^2+ePa^2);
        ePo=sqrt(ePtest^2+ePa^2);
        ePvent=sqrt(ePvent^2+ePa^2);
    else
        eTvent=0;
        eTh8=0;
        eTm8=0;
        eTl8=0;
        eT6=0;
        eT4=0;
        eT2=0;
        edPtest=0;
        ePvent=0;
        ePtest=0;
        eTo=0;
        eTi=0;
        edPmain=0;
        ePa=0;
        ePi=sqrt(ePtest^2+edPtest^2+ePa^2);
        ePo=sqrt(ePtest^2+ePa^2);
        ePvent=sqrt(ePvent^2+ePa^2);
    end
    
    eANS(i,1)=sqrt((Cd*A1/2*(2*Pvent*dPmain/(((A1/A2)^2-1)*GASPROP3(300,'R',gas,Prop,PropData)*Tvent))^(-1/2)*2*dPmain/(((A1/A2)^2-1)*GASPROP3(300,'R',gas,Prop,PropData)*Tvent)*ePvent)^2+(Cd*A1/2*(2*Pvent*dPmain/(((A1/A2)^2-1)*GASPROP3(300,'R',gas,Prop,PropData)*Tvent))^(-1/2)*2*Pvent/(((A1/A2)^2-1)*GASPROP3(300,'R',gas,Prop,PropData)*Tvent)*edPmain)^2+(-Cd*A1/2*(2*Pvent*dPmain/(((A1/A2)^2-1)*GASPROP3(300,'R',gas,Prop,PropData)*Tvent))^(-1/2)*2*dPmain*Pvent/(((A1/A2)^2-1)*GASPROP3(300,'R',gas,Prop,PropData)*Tvent^2)*eTvent)^2);
    if max(WL10flat==i)>0
    eANS(i,2)=sqrt((Dflat/(Aj*GASPROP3(Ti,'mu',gas,Prop,PropData))*eANS(i,1))^2+(ANS(i,1)/(Aj*GASPROP3(Ti,'mu',gas,Prop,PropData))*eDflat)^2+(-ANS(i,1)*Dflat/(Aj^2*GASPROP3(Ti,'mu',gas,Prop,PropData))*eAj)^2+(-ANS(i,1)*Dflat/(Aj*GASPROP3(Ti,'mu',gas,Prop,PropData)^2)*GASPROP3(Ti,'mu',gas,Prop,PropData)*0.1)^2);
    else
    eANS(i,2)=sqrt((Dj/(Aj*GASPROP3(Ti,'mu',gas,Prop,PropData))*eANS(i,1))^2+(ANS(i,1)/(Aj*GASPROP3(Ti,'mu',gas,Prop,PropData))*eDj)^2+(-ANS(i,1)*Dj/(Aj^2*GASPROP3(Ti,'mu',gas,Prop,PropData))*eAj)^2+(-ANS(i,1)*Dj/(Aj*GASPROP3(Ti,'mu',gas,Prop,PropData)^2)*GASPROP3(Ti,'mu',gas,Prop,PropData)*0.1)^2);
    end
    eANS(i,3)=sqrt((GASPROP3(Tave,'cp',gas,Prop,PropData)*(To-Ti)/Ah*eANS(i,1))^2+(ANS(i,1)*GASPROP3(Tave,'cp',gas,Prop,PropData)/Ah*eTi)^2+(ANS(i,1)*GASPROP3(Tave,'cp',gas,Prop,PropData)/Ah*eTo)^2+(-ANS(i,1)*GASPROP3(Tave,'cp',gas,Prop,PropData)*(To-Ti)/Ah^2*eAh)^2+(ANS(i,1)*(To-Ti)/Ah*GASPROP3(Tave,'cp',gas,Prop,PropData)*0.1)^2);
    eHF=eANS(i,3);
    eANS(i,4)=sqrt((-LTC8/k((ANS(i,4)+Tl8)/2)*eHF)^2+(-HF/k((ANS(i,4)+Tl8)/2)*eLTC8)^2+(HF*LTC8/k((ANS(i,4)+Tl8)/2)^2*(k((ANS(i,4)+Tl8)/2)*0.05))^2+(eTl8)^2);
    eANS(i,5)=sqrt((-LTC6/k((ANS(i,5)+T6)/2)*eHF)^2+(-HF/k((ANS(i,5)+T6)/2)*eLTC6)^2+(HF*LTC6/k((ANS(i,5)+T6)/2)^2*(k((ANS(i,5)+T6)/2)*0.05))^2+(eT6)^2);
    eANS(i,6)=sqrt((-LTC4/k((ANS(i,6)+T4)/2)*eHF)^2+(-HF/k((ANS(i,6)+T4)/2)*eLTC4)^2+(HF*LTC4/k((ANS(i,6)+T4)/2)^2*(k((ANS(i,6)+T4)/2)*0.05))^2+(eT4)^2);
    eANS(i,7)=sqrt((-LTC2/k((ANS(i,7)+T2)/2)*eHF)^2+(-HF/k((ANS(i,7)+T2)/2)*eLTC2)^2+(HF*LTC2/k((ANS(i,7)+T2)/2)^2*(k((ANS(i,7)+T2)/2)*0.05))^2+(eT2)^2);
    if max(WL10flat==i)>0
    eANS(i,8)=sqrt(0.002244*eANS(i,4))^2+(0.1862*eANS(i,5))^2+(0.4007*eANS(i,6))^2+(0.3907*eANS(i,7))^2;
    else
    eANS(i,8)=sqrt(0.0169*eANS(i,4))^2+(0.1423*eANS(i,5))^2+(0.3181*eANS(i,6))^2+(0.5227*eANS(i,7))^2;
    end
    eANS(i,9)=sqrt(((Ah/Ac)/(ANS(i,8)-Ti)*eHF)^2+(HF*(1/Ac)/(ANS(i,8)-Ti)*eAh)^2+(-HF*(Ah/Ac^2)/(ANS(i,8)-Ti)*eAc)^2+(-HF*(Ah/Ac)/(ANS(i,8)-Ti)^2*eANS(i,8))^2+(HF*(Ah/Ac)/(ANS(i,8)-Ti)^2*eTi)^2);
    if max(WL10flat==i)>0
    eANS(i,10)=sqrt((Dflat/GASPROP3(Tave,'k',gas,Prop,PropData)*eANS(i,9))^2+(ANS(i,9)/GASPROP3(Tave,'k',gas,Prop,PropData)*eDflat)^2+(-ANS(i,9)*Dflat/GASPROP3(Tave,'k',gas,Prop,PropData)^2*(0.05*GASPROP3(Tave,'k',gas,Prop,PropData)))^2);
    else
    eANS(i,10)=sqrt((Dj/GASPROP3(Tave,'k',gas,Prop,PropData)*eANS(i,9))^2+(ANS(i,9)/GASPROP3(Tave,'k',gas,Prop,PropData)*eDj)^2+(-ANS(i,9)*Dj/GASPROP3(Tave,'k',gas,Prop,PropData)^2*(0.05*GASPROP3(Tave,'k',gas,Prop,PropData)))^2);
    end
    eANS(i,11)=sqrt((1/GASPROP3(Tave,'k',gas,Prop,PropData)*(0.05*k(ANS(i,8))))^2+(k(ANS(i,8))/GASPROP3(Tave,'k',gas,Prop,PropData)^2*(0.05*GASPROP3(Tave,'k',gas,Prop,PropData)))^2);
    eANS(i,12)=sqrt((1/ANS(i,11)^0.1927*eANS(i,10))^2+(-0.1927*ANS(i,10)/ANS(i,11)^1.1927*eANS(i,11))^2);
    eANS(i,13)=sqrt((1/(GASPROP3(300,'R',gas,Prop,PropData)*Ti)*ePo)^2+(-Po/(GASPROP3(300,'R',gas,Prop,PropData)*Ti^2)*eTi)^2);
    eANS(i,14)=sqrt((1/(ANS(i,13)*Aj)*eANS(i,1))^2+(-ANS(i,1)/(ANS(i,13)^2*Aj)*eANS(i,13))^2+(ANS(i,1)/(ANS(i,13)*Aj^2)*eAj)^2);
    eANS(i,15)=sqrt((2/(ANS(i,13)*ANS(i,14)^2)*edPtest)^2+(-2*dPtest/(ANS(i,13)^2*ANS(i,14)^2)*eANS(i,13))^2+(-4*dPtest/(ANS(i,13)*ANS(i,14)^3)*eANS(i,14))^2);
    
end

% Saving Values in Structures
for o=1:1 
    % Loop Experiments (using Flame and Induction Heater [IH] sources)
    % MT-185 flame (142 & 143 were IH experiments)
    hemj.mtflrt=ANS([133,137,139,144,149],:); 
    hemj.mtfl100=ANS([134,138,145,150],:);
    hemj.mtfl200=ANS([135,146,151,156:157],:);
    hemj.mtfl250=ANS([140,141,152:154],:);
    hemj.mtfl300=ANS([132,136,147:148,155],:);
    hemj.wlflrt=ANS([347:351],:);                   % WL10 repeats for temp profile comparison    
    hemj.mtflall=ANS([132:141,144:157],:);
    % MT-185 IH, graphite workpiece
    hemj.mtihrt=ANS([160:170],:);                   % 158 & 159 - high Re
    hemj.mtih100=ANS([171:173],:);                  % 174 not steady-state
    hemj.mtih200=ANS([175:178],:);
    hemj.mtif250=ANS([179:181],:);
    hemj.mtihall=ANS([158:173,175:181],:);
    % WL10 IH, graphite workpiece
    hemj.wlgrt=ANS([191:193],:);                % 182:184, 194:198 Thrown out
    hemj.wlg100=ANS([185:187],:);
    hemj.wlg200=ANS([188:190],:);
    hemj.wlgall=ANS([185:193],:); 
    % WL10 IH, tungsten workpiece
    hemj.wlrt=ANS([200:205,218:219,225],:);    % 199 - Time constant experiment
    hemj.wl100=ANS([206:209,220:221],:);
    hemj.wl200=ANS([210:213,227],:);
    hemj.wl250=ANS([214:217,226],:);
    hemj.wl300=ANS(222:224,:);
    hemj.wlall=ANS([200:227],:); 
    % MT-185 Integrated, 0.5 mm gap (~0.45 mm gap)
    hemj.mt5intrt=ANS([289:293],:);
    hemj.mt5int100=ANS([294:298],:);
    hemj.mt5int200=ANS([299:304],:);
    hemj.mt5int250=ANS([305:310],:);
    hemj.mt5int300=ANS([311:315],:);
    hemj.mt5intall=ANS([289:315],:);
    % MT-185 Integrated, 0.25 mm gap
    hemj.mt25intrt=ANS([316:320],:);
    hemj.mt25int100=ANS([325:328],:);
    hemj.mt25int200=ANS([321:324],:);
    hemj.mt25int250=ANS([332:334],:);
    hemj.mt25int300=ANS([329:331],:);
    hemj.mt25intall=ANS([316:334],:);
    % WL10 IH, new jet cartridge
    hemj.wlnjrt=ANS(339:342,:);
    hemj.wlnj200=ANS(343:346,:);
    % WL10 (NJPT Test Section), 1.28 mm gap
    hemj.wl128t300=ANS(479:484,:);
    hemj.wl128t400=ANS(473:478,:);
    % WL10 (NJPT Test Section), 0.5 mm gap
    hemj.wl5t300=ANS(491:496,:);
    hemj.wl5t400=ANS(485:490,:);
    % WL10 (NJPT Test Section), 0.9 mm gap repeat
    hemj.wl9t300=ANS(503:508,:);
    hemj.wl9t400=ANS(497:502,:);
    % WL10 (NJPT), IH, HHF, First 400C attempts
    hemj.wlnjrt=ANS(440:444,:);
    hemj.wlnj100=ANS(434:439,:);
    hemj.wlnj200=ANS(422:427,:);
    hemj.wlnj300=ANS(428:433,:);
    hemj.wlnj400=ANS(445:450,:);
    hemj.wlnjall=ANS(422:450,:); 
    % WL10 (NJPT HEMJ), IH, Vacuum Chamber, First series up to 425C
    hemj.wlvcrt=ANS(600:605,:);
    hemj.wlvc100=ANS(624:629,:);
    hemj.wlvc200=ANS(606:611,:);
    hemj.wlvc300=ANS(612:617,:);
    hemj.wlvc400=ANS(696:701,:);
    hemj.wlvc425=ANS(702:707,:);
    % WL10 (FR1H07), IH, Vacuum Chamber, First series up to 425C
    hemj.wlfvcrt=ANS(654:659,:);
    hemj.wlfvc100=ANS([649:653,677],:);
    hemj.wlfvc200=ANS(660:665,:);
    hemj.wlfvc300=ANS(666:671,:);
    hemj.wlfvc400=ANS(672:676,:);
    hemj.wlfvc425=ANS(678:682,:);
    % Totals
    hemj.total=ANS([132:141,144:157,160:173,175:181,185:193,200:227],:);
    hemj.total2=ANS([132:141,144:157,200:227],:);
    hemj.totalwl10=ANS([132:141,144:157,200:227,361:400,422:450],:);
    hemj.total2015=ANS([422:450],:);
    hemj.sum=ANS([132:141,144:157,200:227,289:315,339:351],:);
    hemj.lamin=ANS([103,102,104,120,119],:);
    hemj.totalvc=ANS([600:617,624:629,696:701],:);
    hemj.totalvc425=ANS([600:617,624:629,696:707],:);
    flat.totalvc425=ANS(649:682,:);
    
    % ------------------- Loop Experiment Error ---------------------------
    
    % MT-185 flame experiments (142 & 143 were IH expts)
    hemj.mtflrte=eANS([133,137,139,144,149],:); 
    hemj.mtfl100e=eANS([134,138,145,150],:);
    hemj.mtfl200e=eANS([135,146,151,156:157],:);
    hemj.mtfl250e=eANS([140,141,152:154],:);
    hemj.mtfl300e=eANS([132,136,147:148,155],:);
    hemj.mtflalle=eANS([132:141,144:157],:);
    % MT-185 IH experiments, graphite workpiece
    hemj.mtihrte=eANS([160:170],:); % 158 & 159 - high Re
    hemj.mtih100e=eANS([171:173],:);  % 174 not steady-state
    hemj.mtih200e=eANS([175:178],:);
    hemj.mtif250e=eANS([179:181],:);
    hemj.mtihalle=eANS([158:173,175:181],:);
    % WL10 IH experiments, graphite workpiece
    hemj.wlgrte=eANS([191:193],:); % 182:184, 194:198 Thrown out
    hemj.wlg100e=eANS([185:187],:);
    hemj.wlg200e=eANS([188:190],:);
    hemj.wlgalle=eANS([185:193],:); 
    % WL10 IH experiments, tungsten workpiece
    hemj.wlrte=eANS([200:205,218:219,225],:); % 199 - Time constant experiment
    hemj.wl100e=eANS([206:209,220:221],:);
    hemj.wl200e=eANS([210:213,227],:);
    hemj.wl250e=eANS([214:217,226],:);
    hemj.wl300e=eANS(222:224,:);
    hemj.wlalle=eANS([200:227],:); 
    % MT-185 Integrated experiments, 0.5 mm gap (~0.45 mm gap)
    hemj.mt5intrte=eANS([289:293],:);
    hemj.mt5int100e=eANS([294:298],:);
    hemj.mt5int200e=eANS([299:304],:);
    hemj.mt5int250e=eANS([305:310],:);
    hemj.mt5int300e=eANS([311:315],:);
    hemj.mt5intalle=eANS([289:315],:);
    % MT-185 Integrated experiments, 0.25 mm gap
    hemj.mt25intrte=eANS([316:320],:);
    hemj.mt25int100e=eANS([325:328],:);
    hemj.mt25int200e=eANS([321:324],:);
    hemj.mt25int250e=eANS([332:334],:);
    hemj.mt25int300e=eANS([329:331],:);
    hemj.mt25intalle=eANS([316:334],:);
    % WL10 IH, new jet cartridge
    hemj.wlnjrte=eANS(339:342,:);
    hemj.wlnj200e=eANS(343:346,:);
    % WL10 (NJPT Test Section), 1.28 mm gap
    hemj.wl128t300e=eANS(479:484,:);
    hemj.wl128t400e=eANS(473:478,:);
    % WL10 (NJPT Test Section), 0.5 mm gap
    hemj.wl5t300e=eANS(491:496,:);
    hemj.wl5t400e=eANS(485:490,:);
    % WL10 (NJPT Test Section), 0.9 mm gap repeat
    hemj.wl9t300e=eANS(503:508,:);
    hemj.wl9t400e=eANS(497:502,:);
    % WL10 (NJPT), IH, HHF, First 400C attempts
    hemj.wlnjrte=eANS(440:444,:);
    hemj.wlnj100e=eANS(434:439,:);
    hemj.wlnj200e=eANS(422:427,:);
    hemj.wlnj300e=eANS(428:433,:);
    hemj.wlnj400e=eANS(445:450,:);
    hemj.wlnjalle=eANS(422:450,:);
    % WL10 (NJPT HEMJ), IH, Vacuum Chamber, First series up to 425C
    hemj.wlvcrte=eANS(600:605,:);
    hemj.wlvc100e=eANS(624:629,:);
    hemj.wlvc200e=eANS(606:611,:);
    hemj.wlvc300e=eANS(612:617,:);
    hemj.wlvc400e=eANS(696:701,:);
    hemj.wlvc425e=eANS(702:707,:);
    % WL10 (FR1H07), IH, Vacuum Chamber, First series up to 425C
    hemj.wlfvcrte=eANS(654:659,:);
    hemj.wlfvc100e=eANS([649:653,677],:);
    hemj.wlfvc200e=eANS(660:665,:);
    hemj.wlfvc300e=eANS(666:671,:);
    hemj.wlfvc400e=eANS(672:676,:);
    hemj.wlfvc425e=eANS(678:682,:);
    % Totals
    hemj.totale=eANS([132:141,144:157,160:173,175:181,185:193,200:227],:);
    hemj.total2e=eANS([132:141,144:157,200:227],:);
    hemj.laminerror=eANS([103,102,104,120,119],:);
    hemj.totalvce=eANS([600:617,624:629,696:701],:);
    hemj.totalvc425e=eANS([600:617,624:629,696:707],:);
    flat.totalvc425e=ANS(649:682,:);
    
    % Jordan's Experiments
    hemj.JDRairbr=ANS([49:52,60:63],:); hemj.JDRhebr=ANS(53:59,:); hemj.JDRarbr=ANS(64:70,:);
    hemj.JDRairst=ANS(71:79,:); hemj.JDRhest=ANS(88:93,:); hemj.JDRarst=ANS(80:87,:);
    hemj.JDRall=ANS(49:93,:);
end

cd(BaseData);
save LoopData HEMJ ANS eANS hemj
cd(Main);

%% Fitting

% X1=hemj.JDRall(:,2); %Re
% Y1=hemj.JDRall(:,10); %Nu
% Z1=hemj.JDRall(:,11); %kappa
% 
% JDRFit=mvregress([ones(length(X1),1),log([X1,Z1])],log(Y1),'algorithm','cwls');

% X1=hemj.totalwl10(:,2);    % Re
% Y1=hemj.totalwl10(:,10);   % Nu
% Z1=hemj.totalwl10(:,11);   % Kappa
% A1=hemj.all(:,16);    % mumu
% B1=hemj.all(:,19);    % Pr
% X1=hemj.total2015(:,2);    % Re
% Y1=hemj.total2015(:,10);   % Nu
% Z1=hemj.total2015(:,11);   % Kappa

% Fit New Correlation excluding 425C Data
% X1=hemj.totalvc(:,2);    % Re 
% Y1=hemj.totalvc(:,10);   % Nu
% Z1=hemj.totalvc(:,11);   % Kappa
% F1=hemj.totalvc(:,12);   % Nu*Kappa^(-0.19)

% Fit New Correlation including 425C Data
X1=hemj.totalvc425(:,2);    % Re 
Y1=hemj.totalvc425(:,10);   % Nu
Z1=hemj.totalvc425(:,11);   % Kappa
F1=hemj.totalvc425(:,12);   % Nu*Kappa^(-0.19)

% Correlation for Flat Design including 425C Data
% X1=flat.totalvc425(:,2);    % Re 
% Y1=flat.totalvc425(:,10);   % Nu
% Z1=flat.totalvc425(:,11);   % Kappa
% F1=flat.totalvc425(:,12);   % Nu*Kappa^(-0.19)


% Fit=mvregress([ones(length(ANS(129:136,2)),1),log([ANS(129:136,2),ANS(129:136,11)])],log(ANS(129:136,10)),'algorithm','cwls');
% Fit=mvregress([ones(length(X1),1),log([X1,A1,B1])],log(Y1),'algorithm','cwls') % Mu and Pr data 
% Fit=mvregress([ones(length(X1),1),log([X1,Z1])],log(Y1),'algorithm','cwls')     % Nu and Kappa data
% [Nu_FITA Nu_FITB]=fit(hemj.totalwl10(:,2),hemj.totalwl10(:,12),'power1')         	% Nu coefficients
% [KL_FITA KL_FITB]=fit(hemj.all(:,2),hemj.all(:,15),'power1')                        % K_L coefficients

% Fit=mvregress([ones(length(X1),1),log([X1,Z1])],log(Y1),'algorithm','cwls')     % Nu and Kappa data
[Nu_FITA Nu_FITB]=fit(X1,F1,'power1')              % Nu coefficients

%% Plotting

set(0,'DefaultFigureWindowStyle','docked')

%Dissertation Plots
for m=1:0
    
%     %Nu vs. Re w/ Kappa
%     figure(1)
%     hold on
%     fplot(@(x)0.196*x^0.537,[1e4 6e4],'-k')
%     set(findobj(gca,'Type','Line','Color','k'),'LineWidth',2);
%     errorbar(hemj.troom(:,2),hemj.troom(:,12),hemj.troome(:,12),'bd','MarkerSize',16,'MarkerFaceColor','b')
%     errorbar(hemj.t100(:,2),hemj.t100(:,12),hemj.t100e(:,12),'g^','MarkerSize',16,'MarkerFaceColor','g')
%     errorbar(hemj.t200(:,2),hemj.t200(:,12),hemj.t200e(:,12),'ks','MarkerSize',16,'MarkerFaceColor','k')
%     errorbar(hemj.t250(:,2),hemj.t250(:,12),hemj.t250e(:,12),'mp','MarkerSize',16,'MarkerFaceColor','m')
%     errorbar(hemj.t300(:,2),hemj.t300(:,12),hemj.t300e(:,12),'ro','MarkerSize',16,'MarkerFaceColor','r')
%     fplot(@(x)(0.196*x^0.537)*1.1,[1e4 6e4],'--k')
%     fplot(@(x)(0.196*x^0.537)*0.9,[1e4 6e4],'--k')
%     set(gca,'FontSize',28), box on
%     xlabel('\itRe','FontSize',28), ylabel('{\itNu\kappa^{-0.19}}','FontSize',28)
%     axis([1e4 4e4 0 80])
%     hold off
    
%     %Nu vs. Re
%     figure(2)
%     hold on
%     errorbar(hemj.troom(:,2),hemj.troom(:,10),hemj.troome(:,10),'bd','MarkerSize',16,'MarkerFaceColor','b')
%     errorbar(hemj.t100(:,2),hemj.t100(:,10),hemj.t100e(:,10),'g^','MarkerSize',16,'MarkerFaceColor','g')
%     errorbar(hemj.t200(:,2),hemj.t200(:,10),hemj.t200e(:,10),'ks','MarkerSize',16,'MarkerFaceColor','k')
%     errorbar(hemj.t250(:,2),hemj.t250(:,10),hemj.t250e(:,10),'mp','MarkerSize',16,'MarkerFaceColor','m')
%     errorbar(hemj.t300(:,2),hemj.t300(:,10),hemj.t300e(:,10),'ro','MarkerSize',16,'MarkerFaceColor','r')
%     set(gca,'FontSize',28), box on
%     xlabel('\itRe','FontSize',28), ylabel('{\itNu}','FontSize',28)
%     hold off
    
%     %h vs. Re
%     figure(3)
%     hold on
%     errorbar(hemj.troom(:,2),hemj.troom(:,9),hemj.troome(:,9),'bd','MarkerSize',16,'MarkerFaceColor','b')
%     errorbar(hemj.t100(:,2),hemj.t100(:,9),hemj.t100e(:,9),'g^','MarkerSize',16,'MarkerFaceColor','g')
%     errorbar(hemj.t200(:,2),hemj.t200(:,9),hemj.t200e(:,9),'ks','MarkerSize',16,'MarkerFaceColor','k')
%     errorbar(hemj.t250(:,2),hemj.t250(:,9),hemj.t250e(:,9),'mp','MarkerSize',16,'MarkerFaceColor','m')
%     errorbar(hemj.t300(:,2),hemj.t300(:,9),hemj.t300e(:,9),'ro','MarkerSize',16,'MarkerFaceColor','r')
%     set(gca,'FontSize',28), box on
%     xlabel('\itRe','FontSize',28), ylabel('{\ith}','FontSize',28)
%     axis([1e4 4e4 1e4 5e4])
%     hold off

%     %K_L vs. Re
%     figure(4)
%     hold on
%     errorbar(hemj.troom(:,2),hemj.troom(:,15),hemj.troome(:,15),'bd','MarkerSize',16,'MarkerFaceColor','b')
%     errorbar(hemj.t100(:,2),hemj.t100(:,15),hemj.t100e(:,15),'g^','MarkerSize',16,'MarkerFaceColor','g')
%     errorbar(hemj.t200(:,2),hemj.t200(:,15),hemj.t200e(:,15),'ks','MarkerSize',16,'MarkerFaceColor','k')
%     errorbar(hemj.t250(:,2),hemj.t250(:,15),hemj.t250e(:,15),'mp','MarkerSize',16,'MarkerFaceColor','m')
%     errorbar(hemj.t300(:,2),hemj.t300(:,15),hemj.t300e(:,15),'ro','MarkerSize',16,'MarkerFaceColor','r')
%     set(gca,'FontSize',28), box on
%     xlabel('\itRe','FontSize',28), ylabel('{\itK_L}','FontSize',28)
%     axis([1e4 4e4 1.8 2.8])
%     hold off

%     %Nu vs. Re w/ Kappa + Induction
%     figure(5)
%     hold on
%     fplot(@(x)0.196*x^0.537,[1e4 6e4],'-k')
%     set(findobj(gca,'Type','Line','Color','k'),'LineWidth',2);
%     errorbar(hemj.introom(:,2),hemj.introom(:,12),hemj.introome(:,12),'bd','MarkerSize',16,'MarkerFaceColor','b')
%     errorbar(hemj.int100(:,2),hemj.int100(:,12),hemj.int100e(:,12),'g^','MarkerSize',16,'MarkerFaceColor','g')
%     errorbar(hemj.int200(:,2),hemj.int200(:,12),hemj.int200e(:,12),'ks','MarkerSize',16,'MarkerFaceColor','k')
%     errorbar(hemj.int250(:,2),hemj.int250(:,12),hemj.int250e(:,12),'mp','MarkerSize',16,'MarkerFaceColor','m')
%     errorbar(hemj.troom(:,2),hemj.troom(:,12),hemj.troome(:,12),'bd','MarkerSize',16)
%     errorbar(hemj.t100(:,2),hemj.t100(:,12),hemj.t100e(:,12),'g^','MarkerSize',16)
%     errorbar(hemj.t200(:,2),hemj.t200(:,12),hemj.t200e(:,12),'ks','MarkerSize',16)
%     errorbar(hemj.t250(:,2),hemj.t250(:,12),hemj.t250e(:,12),'mp','MarkerSize',16)
%     errorbar(hemj.t300(:,2),hemj.t300(:,12),hemj.t300e(:,12),'ro','MarkerSize',16)
%     fplot(@(x)(0.196*x^0.537)*1.1,[1e4 6e4],'--k')
%     fplot(@(x)(0.196*x^0.537)*0.9,[1e4 6e4],'--k')
%     set(gca,'FontSize',28), box on
%     xlabel('\itRe','FontSize',28), ylabel('{\itNu\kappa^{-0.19}}','FontSize',28)
%     axis([1e4 4e4 0 80])
%     hold off
    
%     %K_L vs. Re + Induction
%     figure(6)
%     hold on
%     errorbar(hemj.introom(:,2),hemj.introom(:,15),hemj.introome(:,15),'bd','MarkerSize',16,'MarkerFaceColor','b')
%     errorbar(hemj.int100(:,2),hemj.int100(:,15),hemj.int100e(:,15),'g^','MarkerSize',16,'MarkerFaceColor','g')
%     errorbar(hemj.int200(:,2),hemj.int200(:,15),hemj.int200e(:,15),'ks','MarkerSize',16,'MarkerFaceColor','k')
%     errorbar(hemj.int250(:,2),hemj.int250(:,15),hemj.int250e(:,15),'mp','MarkerSize',16,'MarkerFaceColor','m')
%     errorbar(hemj.troom(:,2),hemj.troom(:,15),hemj.troome(:,15),'bd','MarkerSize',16)
%     errorbar(hemj.t100(:,2),hemj.t100(:,15),hemj.t100e(:,15),'g^','MarkerSize',16)
%     errorbar(hemj.t200(:,2),hemj.t200(:,15),hemj.t200e(:,15),'ks','MarkerSize',16)
%     errorbar(hemj.t250(:,2),hemj.t250(:,15),hemj.t250e(:,15),'mp','MarkerSize',16)
%     errorbar(hemj.t300(:,2),hemj.t300(:,15),hemj.t300e(:,15),'ro','MarkerSize',16)
%     set(gca,'FontSize',28), box on
%     xlabel('\itRe','FontSize',28), ylabel('{\itK_L}','FontSize',28)
%     axis([1e4 4e4 1.8 2.8])
%     hold off

%     %q" vs. Re
%     figure(7)
%     hold on
%     errorbar(hemj.introom(:,2),hemj.introom(:,3)./1e6,hemj.introome(:,3)./1e6,'bd','MarkerSize',16,'MarkerFaceColor','b')
%     errorbar(hemj.int100(:,2),hemj.int100(:,3)./1e6,hemj.int100e(:,3)./1e6,'g^','MarkerSize',16,'MarkerFaceColor','g')
%     errorbar(hemj.int200(:,2),hemj.int200(:,3)./1e6,hemj.int200e(:,3)./1e6,'ks','MarkerSize',16,'MarkerFaceColor','k')
%     errorbar(hemj.int250(:,2),hemj.int250(:,3)./1e6,hemj.int250e(:,3)./1e6,'mp','MarkerSize',16,'MarkerFaceColor','m')
%     errorbar(hemj.troom(:,2),hemj.troom(:,3)./1e6,hemj.troome(:,3)./1e6,'bd','MarkerSize',16)
%     errorbar(hemj.t100(:,2),hemj.t100(:,3)./1e6,hemj.t100e(:,3)./1e6,'g^','MarkerSize',16)
%     errorbar(hemj.t200(:,2),hemj.t200(:,3)./1e6,hemj.t200e(:,3)./1e6,'ks','MarkerSize',16)
%     errorbar(hemj.t250(:,2),hemj.t250(:,3)./1e6,hemj.t250e(:,3)./1e6,'mp','MarkerSize',16)
%     errorbar(hemj.t300(:,2),hemj.t300(:,3)./1e6,hemj.t300e(:,3)./1e6,'ro','MarkerSize',16)
%     set(gca,'FontSize',28), box on
%     xlabel('\itRe','FontSize',28), ylabel('{\itq"} (MW/m^2)','FontSize',28)
%     axis([1e4 4e4 1 6])
%     hold off

end

%Defense Plots
for m=1:0
    
%     %Nu vs. Re w/ Kappa + Induction
%     figure(5)
%     hold on
%     fplot(@(x)0.0586*x^0.669,[1e4 6e4],'-r')
%     set(findobj(gca,'Type','Line','Color','r'),'LineWidth',2);
%     fplot(@(x)0.196*x^0.537,[1e4 6e4],'-k')
%     set(findobj(gca,'Type','Line','Color','k'),'LineWidth',2);
%     errorbar(hemj.introom(:,2),hemj.introom(:,12),hemj.introome(:,12),'bd','MarkerSize',16,'MarkerFaceColor','b')
%     errorbar(hemj.int100(:,2),hemj.int100(:,12),hemj.int100e(:,12),'g^','MarkerSize',16,'MarkerFaceColor','g')
%     errorbar(hemj.int200(:,2),hemj.int200(:,12),hemj.int200e(:,12),'ks','MarkerSize',16,'MarkerFaceColor','k')
%     errorbar(hemj.int250(:,2),hemj.int250(:,12),hemj.int250e(:,12),'mp','MarkerSize',16,'MarkerFaceColor','m')
%     errorbar(hemj.troom(:,2),hemj.troom(:,12),hemj.troome(:,12),'bd','MarkerSize',16)
%     errorbar(hemj.t100(:,2),hemj.t100(:,12),hemj.t100e(:,12),'g^','MarkerSize',16)
%     errorbar(hemj.t200(:,2),hemj.t200(:,12),hemj.t200e(:,12),'ks','MarkerSize',16)
%     errorbar(hemj.t250(:,2),hemj.t250(:,12),hemj.t250e(:,12),'mp','MarkerSize',16)
%     errorbar(hemj.t300(:,2),hemj.t300(:,12),hemj.t300e(:,12),'ro','MarkerSize',16)
%     fplot(@(x)(0.196*x^0.537)*1.1,[1e4 6e4],'--k')
%     fplot(@(x)(0.196*x^0.537)*0.9,[1e4 6e4],'--k')
%     set(gca,'FontSize',28), box on
%     xlabel('\itRe','FontSize',28), ylabel('{\itNu\kappa^{-0.19}}','FontSize',28)
%     axis([1e4 4e4 0 80])
%     hold off
%     
%     %K_L vs. Re + Induction
%     figure(6)
%     hold on
%     fplot(@(x)1.39*(x/1e4)^-0.5+1.32,[1e4 6e4],'-r')
%     set(findobj(gca,'Type','Line','Color','r'),'LineWidth',2);
%     fplot(@(x)2.34,[1e4 6e4],'-k')
%     set(findobj(gca,'Type','Line','Color','k'),'LineWidth',2);
%     errorbar(hemj.introom(:,2),hemj.introom(:,15),hemj.introome(:,15),'bd','MarkerSize',16,'MarkerFaceColor','b')
%     errorbar(hemj.int100(:,2),hemj.int100(:,15),hemj.int100e(:,15),'g^','MarkerSize',16,'MarkerFaceColor','g')
%     errorbar(hemj.int200(:,2),hemj.int200(:,15),hemj.int200e(:,15),'ks','MarkerSize',16,'MarkerFaceColor','k')
%     errorbar(hemj.int250(:,2),hemj.int250(:,15),hemj.int250e(:,15),'mp','MarkerSize',16,'MarkerFaceColor','m')
%     errorbar(hemj.troom(:,2),hemj.troom(:,15),hemj.troome(:,15),'bd','MarkerSize',16)
%     errorbar(hemj.t100(:,2),hemj.t100(:,15),hemj.t100e(:,15),'g^','MarkerSize',16)
%     errorbar(hemj.t200(:,2),hemj.t200(:,15),hemj.t200e(:,15),'ks','MarkerSize',16)
%     errorbar(hemj.t250(:,2),hemj.t250(:,15),hemj.t250e(:,15),'mp','MarkerSize',16)
%     errorbar(hemj.t300(:,2),hemj.t300(:,15),hemj.t300e(:,15),'ro','MarkerSize',16)
%     set(gca,'FontSize',28), box on
%     xlabel('\itRe','FontSize',28), ylabel('{\itK_L}','FontSize',28)
%     axis([1e4 4e4 1.8 2.8])
%     hold off

end

%TOFE 21 Plots - Mills Paper
for m=1:1
    
    %Figure 3 - Open/Torch,Closed/IH,Red/0.84,Blue/0.9,Green/0.5,o/WL10,s/MT185
    figure(3)
    hold on
    errorbar(hemj.all(:,2),hemj.all(:,12),hemj.alle(:,12),'ko','MarkerSize',16)
    errorbar(hemj.intallt(:,2),hemj.intallt(:,12),hemj.intallte(:,12),'ko','MarkerSize',16,'MarkerFaceColor','k')
    errorbar(hemj.mt5tall(:,2),hemj.mt5tall(:,12),hemj.mt5talle(:,12),'ks','MarkerSize',16,'MarkerFaceColor','k')
    errorbar(ANS(347:351,2),ANS(347:351,12),eANS(347:351,12),'kd','MarkerSize',16)
    errorbar(ANS(339:342,2),ANS(339:342,12),eANS(339:342,12),'kd','MarkerSize',16,'MarkerFaceColor','k')
    errorbar(ANS(343:346,2),ANS(343:346,12),eANS(343:346,12),'kd','MarkerSize',16,'MarkerFaceColor','k')
    fplot(@(x)0.085*x^0.5897,[0.5e4 6e4],'-k')
    fplot(@(x)(0.085*x^0.5897)*.9,[0.5e4 6e4],'--k')
    fplot(@(x)(0.085*x^0.5897)*1.1,[0.5e4 6e4],'--k')
%     legend('MT185 - Torch','WL10 - IH','WL10 - Torch','Location','Northwest')
    set(gca,'FontSize',26), box on
    xlabel('\itRe','FontSize',26), ylabel('{\itNu\kappa^{-0.19}}','FontSize',26)
    axis([1e4 5e4 10 60])
    hold off
    
    %Figure 4 - Open/Torch,Closed/IH,Red/0.84,Blue/0.9,Green/0.5,o/WL10,s/MT185
    figure(4)
    hold on
    errorbar(hemj.all(:,2),hemj.all(:,15),hemj.alle(:,15),'ko','MarkerSize',16)
    errorbar(hemj.intallt(:,2),hemj.intallt(:,15),hemj.intallte(:,15),'ko','MarkerSize',16,'MarkerFaceColor','k')
    errorbar(hemj.mt5tall(:,2),hemj.mt5tall(:,15),hemj.mt5talle(:,15),'ks','MarkerSize',16,'MarkerFaceColor','k')
    errorbar(ANS(347:351,2),ANS(347:351,15),eANS(347:351,15),'kd','MarkerSize',16)
    errorbar(ANS(339:342,2),ANS(339:342,15),eANS(339:342,15),'kd','MarkerSize',16,'MarkerFaceColor','k')
    errorbar(ANS(343:346,2),ANS(343:346,15),eANS(343:346,15),'kd','MarkerSize',16,'MarkerFaceColor','k')
%     legend('MT185 - Torch','WL10 - IH','WL10 - Torch','Location','Northwest')
    set(gca,'FontSize',26), box on
    xlabel('\itRe','FontSize',26), ylabel('{\itK_L}','FontSize',26)
    axis([1e4 5e4 1 5])
    hold off
    
end

%TOFE 21 Plots - Mills Presentation
for m=1:0
    
    %Figure 3 - Open/Torch,Closed/IH,Red/0.84,Blue/0.9,Green/0.5,o/WL10,s/MT185
    figure(3)
    hold on
%     errorbar(hemj.all(:,2),hemj.all(:,10),hemj.alle(:,10),'rs','MarkerSize',16)
%     errorbar(hemj.intallt(:,2),hemj.intallt(:,10),hemj.intallte(:,10),'ro','MarkerSize',16,'MarkerFaceColor','r')
    errorbar(hemj.mt5tall(:,2),hemj.mt5tall(:,10),hemj.mt5talle(:,10),'gs','MarkerSize',16,'MarkerFaceColor','g')
    errorbar(hemj.mt25tall(:,2),hemj.mt25tall(:,10),hemj.mt25talle(:,10),'ms','MarkerSize',16)%,'MarkerFaceColor','m')
    errorbar(ANS(347:351,2),ANS(347:351,10),eANS(347:351,10),'bo','MarkerSize',16)
    errorbar(ANS(339:342,2),ANS(339:342,10),eANS(339:342,10),'bo','MarkerSize',16,'MarkerFaceColor','b')
    errorbar(ANS(343:346,2),ANS(343:346,10),eANS(343:346,10),'bo','MarkerSize',16,'MarkerFaceColor','b')
    set(findobj(gca,'Type','Line','Color','b'),'LineWidth',2);
%     fplot(@(x)0.085*x^0.5897,[0.5e4 6e4],'-k')
%     fplot(@(x)(0.085*x^0.5897)*.9,[0.5e4 6e4],'--k')
%     fplot(@(x)(0.085*x^0.5897)*1.1,[0.5e4 6e4],'--k')
%     legend('MT185 - Torch','WL10 - IH','WL10 - Torch','Location','Northwest')
    set(gca,'FontSize',26), box on
    xlabel('\itRe','FontSize',26), % ylabel('{\itNu\kappa^{-0.19}}','FontSize',26)
    ylabel('{\itNu}','FontSize',26)
%     axis([1e4 5e4 10 70])
    axis([1e4 5e4 40 240])
    hold off
    
    %Figure 4 - Open/Torch,Closed/IH,Red/0.84,Blue/0.9,Green/0.5,o/WL10,s/MT185
    figure(4)
    hold on
    errorbar(hemj.all(:,2),hemj.all(:,15),hemj.alle(:,15),'rs','MarkerSize',16)
    errorbar(hemj.intallt(:,2),hemj.intallt(:,15),hemj.intallte(:,15),'ro','MarkerSize',16,'MarkerFaceColor','r')
    errorbar(hemj.mt5tall(:,2),hemj.mt5tall(:,15),hemj.mt5talle(:,15),'gs','MarkerSize',16,'MarkerFaceColor','g')
    errorbar(hemj.mt25tall(:,2),hemj.mt25tall(:,15),hemj.mt25talle(:,15),'ms','MarkerSize',16,'MarkerFaceColor','m')
    errorbar(ANS(347:351,2),ANS(347:351,15),eANS(347:351,15),'bs','MarkerSize',16)
    errorbar(ANS(339:342,2),ANS(339:342,15),eANS(339:342,15),'bo','MarkerSize',16,'MarkerFaceColor','b')
    errorbar(ANS(343:346,2),ANS(343:346,15),eANS(343:346,15),'bo','MarkerSize',16,'MarkerFaceColor','b')
%     legend('MT185 - Torch','WL10 - IH','WL10 - Torch','Location','Northwest')
    set(gca,'FontSize',26), box on
    xlabel('\itRe','FontSize',26), ylabel('{\itK_L}','FontSize',26)
    axis([1e4 5e4 1 9])
    hold off
    
end

%% Extra Plots

set(0,'DefaultFigureWindowStyle','docked')

for m=1:0
    
    % Local Nu vs. Re w/ Kappa + Induction
%     figure(1)
%     hold on
%     plot(hemj.all(:,2),hemj.all(:,10),'kp','MarkerSize',16,'MarkerFaceColor','k')
% %     plot(hemj.intall(:,2),hemj.intall(:,10),'bd','MarkerSize',16,'MarkerFaceColor','b')
% %     plot(hemj.intallg(:,2),hemj.intallg(:,10),'kd','MarkerSize',16,'MarkerFaceColor','k')
% %     plot(hemj.intallt(:,2),hemj.intallt(:,10),'kd','MarkerSize',16,'MarkerFaceColor','k')
%     plot(ANS(294:298,2),ANS(294:298,10),'kd','MarkerSize',16,'MarkerFaceColor','k')
%     plot(hemj.JDRairbr(:,2),hemj.JDRairbr(:,10),'rs','MarkerSize',16,'MarkerFaceColor','r')
%     plot(hemj.JDRhebr(:,2),hemj.JDRhebr(:,10),'ro','MarkerSize',16,'MarkerFaceColor','r')
%     plot(hemj.JDRarbr(:,2),hemj.JDRarbr(:,10),'r^','MarkerSize',16,'MarkerFaceColor','r')
%     plot(hemj.JDRairst(:,2),hemj.JDRairst(:,10),'rs','MarkerSize',16)
%     plot(hemj.JDRhest(:,2),hemj.JDRhest(:,10),'ro','MarkerSize',16)
%     plot(hemj.JDRarst(:,2),hemj.JDRarst(:,10),'r^','MarkerSize',16)
%     legend('MT185 - Flame','WL10 - Tungsten','JDR - Air/Brass','JDR - He/Brass','JDR - Ar/Brass','JDR - Air/Steel','JDR - He/Steel','JDR - Ar/Steel','Location','Northwest')
%     set(gca,'FontSize',24), box on
%     xlabel('\itRe','FontSize',28), ylabel('Stagnation {\itNu}','FontSize',28)
%     hold off
%     
    % Temperature profiles
    figure(2)
    subplot(2,2,1)
    hold on
    plot([0 2.11 4.29 6.43],hemj.intallt(5,4:7),'ko','MarkerSize',16,'MarkerFaceColor','k')
%     plot([0 2.11 4.29 6.43],hemj.all(1,4:7)./min(hemj.all(1,4:7)),'gd','MarkerSize',16,'MarkerFaceColor','g')
%     plot([0 2.11 4.29 6.43],hemj.all(5,4:7)./min(hemj.all(5,4:7)),'go','MarkerSize',16,'MarkerFaceColor','g')
%     plot([0 2.11 4.29 6.43],hemj.all(8,4:7)./min(hemj.all(8,4:7)),'gs','MarkerSize',16,'MarkerFaceColor','g')
    xlabel('\itr (mm)','FontSize',24), ylabel('Temperature (K)','FontSize',24), title('WL10 Original - 27\circC','FontSize',24)
    set(gca,'FontSize',24), box on
    subplot(2,2,2)
    hold on
    plot([0 2.11 4.29 6.43],hemj.intallt(13,4:7),'ko','MarkerSize',16,'MarkerFaceColor','k')
%     plot([0 2.11 4.29 6.43],hemj.intall(1,4:7)./min(hemj.intall(1,4:7)),'bd','MarkerSize',16,'MarkerFaceColor','b')
%     plot([0 2.11 4.29 6.43],hemj.intall(5,4:7)./min(hemj.intall(5,4:7)),'bo','MarkerSize',16,'MarkerFaceColor','b')
%     plot([0 2.11 4.29 6.43],hemj.intall(9,4:7)./min(hemj.intall(9,4:7)),'bs','MarkerSize',16,'MarkerFaceColor','b')
    xlabel('\itr (mm)','FontSize',24), ylabel('Temperature (K)','FontSize',24), title('WL10 Original - 200\circC','FontSize',24)
    set(gca,'FontSize',24), box on
    subplot(2,2,3)
    hold on
%     plot([0 2.11 4.29 6.43],ANS(341,4:7),'ko','MarkerSize',16,'MarkerFaceColor','k')
    plot([0 2.11 4.29 6.43],ANS(340,4:7),'ko','MarkerSize',16,'MarkerFaceColor','k')
%     plot([0 2.11 4.29 6.43],hemj.intallg(1,4:7)./min(hemj.intallg(1,4:7)),'kd','MarkerSize',16,'MarkerFaceColor','k')
%     plot([0 2.11 4.29 6.43],hemj.intallg(5,4:7)./min(hemj.intallg(5,4:7)),'ko','MarkerSize',16,'MarkerFaceColor','k')
%     plot([0 2.11 4.29 6.43],hemj.intallg(9,4:7)./min(hemj.intallg(9,4:7)),'ks','MarkerSize',16,'MarkerFaceColor','k')
    xlabel('\itr (mm)','FontSize',24), ylabel('Temperature (K)','FontSize',24), title('WL10 New - 27\circC','FontSize',24)
    set(gca,'FontSize',24), box on
    subplot(2,2,4)
    hold on
%     plot([0 2.11 4.29 6.43],ANS(342,4:7),'ko','MarkerSize',16,'MarkerFaceColor','k')
    plot([0 2.11 4.29 6.43],ANS(345,4:7),'ko','MarkerSize',16,'MarkerFaceColor','k')
%     plot([0 2.11 4.29 6.43],hemj.intallt(1,4:7)./min(hemj.intallt(1,4:7)),'rd','MarkerSize',16,'MarkerFaceColor','r')
%     plot([0 2.11 4.29 6.43],hemj.intallt(5,4:7)./min(hemj.intallt(5,4:7)),'ro','MarkerSize',16,'MarkerFaceColor','r')
%     plot([0 2.11 4.29 6.43],hemj.intallt(9,4:7)./min(hemj.intallt(9,4:7)),'rs','MarkerSize',16,'MarkerFaceColor','r')
%     plot([0 2.11 4.29 6.43],hemj.intallt(14,4:7)./min(hemj.intallt(14,4:7)),'cd','MarkerSize',16,'MarkerFaceColor','c')
%     plot([0 2.11 4.29 6.43],hemj.intallt(19,4:7)./min(hemj.intallt(19,4:7)),'co','MarkerSize',16,'MarkerFaceColor','c')
%     plot([0 2.11 4.29 6.43],hemj.intallt(22,4:7)./min(hemj.intallt(22,4:7)),'cs','MarkerSize',16,'MarkerFaceColor','c')
    xlabel('\itr (mm)','FontSize',24), ylabel('Temperature (K)','FontSize',24), title('WL10 New - 200\circC','FontSize',24)
    set(gca,'FontSize',24), box on
    hold off
    
% %     close figure 3
%     figure(3)
%     hold on
%     plot([0 2.11 4.29 6.43],hemj.all(19,4:7)./min(hemj.all(19,4:7)),'ks','MarkerSize',16,'MarkerFaceColor','k')
%     plot([0 2.11 4.29 6.43],hemj.intallt(6,4:7)./min(hemj.intallt(6,4:7)),'ro','MarkerSize',16,'MarkerFaceColor','r')
%     plot([0 2.11 4.29 6.43],ANS(298,4:7)./min(ANS(298,4:7)),'bd','MarkerSize',16,'MarkerFaceColor','b')
%     xlabel('\itr (mm)','FontSize',28), ylabel('Local Temperature / Minimum Temperature','FontSize',28),% title('MT185 Graphite','FontSize',28)
%     set(gca,'FontSize',28), box on
%     legend('MT185 Flame','WL10 IH','MT185 IH Integrated','Location','Northeast')
%     hold off

end     % Local Nu and Thermocouple Profiles

for m=1:1
   % Nu vs. Re w/ Kappa + Induction
    figure(7)
    hold on
%     errorbar(hemj.total(:,2),hemj.total(:,12),hemj.totale(:,12),'rd','MarkerSize',16)
%     errorbar(hemj.mt5tall(:,2),hemj.mt5tall(:,12),hemj.mt5talle(:,12),'ks','MarkerSize',16)%,'MarkerFaceColor','k')
%     errorbar(hemj.mt25tall(:,2),hemj.mt25tall(:,12),hemj.mt25talle(:,12),'ko','MarkerSize',16)%,'MarkerFaceColor','k')
%     errorbar(hemj.all(:,2),hemj.all(:,12),hemj.alle(:,12),'b*','MarkerSize',16)%,'MarkerFaceColor','r')        % Flame Experiments
%     errorbar(hemj.intallt(:,2),hemj.intallt(:,12),hemj.intallte(:,12),'ko','MarkerSize',16)%,'MarkerFaceColor','r')  % First WL10 Exps with New Coil
%     errorbar(ANS(339:342,2),ANS(339:342,12),eANS(339:342,12),'ko','MarkerSize',16)%,'MarkerFaceColor','k')      % WL10 with newer jet cartridge RT
%     errorbar(ANS(343:346,2),ANS(343:346,12),eANS(343:346,12),'ks','MarkerSize',16)%,'MarkerFaceColor','k')      %                               200
% %       errorbar(hemj.wlrt(:,2),hemj.wlrt(:,12),hemj.wlrte(:,12),'bo','MarkerSize',12)%,'MarkerFaceColor','b')   % First WL10 RT
% %       errorbar(hemj.wl100(:,2),hemj.wl100(:,12),hemj.wl100e(:,12),'b^','MarkerSize',12)%,'MarkerFaceColor','b')      %            100
% %       errorbar(hemj.wl200(:,2),hemj.wl200(:,12),hemj.wl200e(:,12),'bs','MarkerSize',12)%,'MarkerFaceColor','b')      %            200
% %       errorbar(hemj.wl300(:,2),hemj.wl300(:,12),hemj.wl300e(:,12),'bd','MarkerSize',12)%,'MarkerFaceColor','b')      %            300
%     errorbar(ANS(352:356,2),ANS(352:356,12),eANS(352:356,12),'gs','MarkerSize',16,'MarkerFaceColor','g')    % WL10 (New jets cartridge, manifold)
%     errorbar(ANS(357:360,2),ANS(357:360,12),eANS(357:360,12),'g^','MarkerSize',16,'MarkerFaceColor','g')    % WL10 (New jets cartridge, manifold)
%     errorbar(ANS(367:372,2),ANS(367:372,12),eANS(367:372,12),'ro','MarkerSize',12,'MarkerFaceColor','r')    % 0.9mm WL10, ball valve, repeats, RT
%     errorbar(ANS(361:366,2),ANS(361:366,12),eANS(361:366,12),'r^','MarkerSize',12,'MarkerFaceColor','r')    %                                  100
%     errorbar(ANS(373:378,2),ANS(373:378,12),eANS(373:378,12),'rs','MarkerSize',12,'MarkerFaceColor','r')    %                                  200
%     errorbar(ANS(379:383,2),ANS(379:383,12),eANS(379:383,12),'rd','MarkerSize',12,'MarkerFaceColor','r')    %                                  300
    errorbar(ANS(440:444,2),ANS(440:444,12),eANS(440:444,12),'ro','MarkerSize',12,'MarkerFaceColor','r')    % 0.9mm WL10, New RT
    errorbar(ANS(434:439,2),ANS(434:439,12),eANS(434:439,12),'r^','MarkerSize',12,'MarkerFaceColor','r')    %                                  100
    errorbar(ANS(422:427,2),ANS(422:427,12),eANS(422:427,12),'rs','MarkerSize',12,'MarkerFaceColor','r')    %                                  200
    errorbar(ANS(428:433,2),ANS(428:433,12),eANS(428:433,12),'rd','MarkerSize',12,'MarkerFaceColor','r')    %                                  300
    errorbar(ANS(445:450,2),ANS(445:450,12),eANS(445:450,12),'rp','MarkerSize',12,'MarkerFaceColor','r')    %                                  400
%     errorbar(ANS(451:455,2),ANS(451:455,12),eANS(451:455,12),'ro','MarkerSize',12)%,'MarkerFaceColor','r')    %                                  RT repeats
%     errorbar(ANS(456:462,2),ANS(456:462,12),eANS(456:462,12),'rp','MarkerSize',12)%,'MarkerFaceColor','r')    %                                  400 repeats
%     errorbar(ANS(467,2),ANS(467,12),eANS(467,12),'ro','MarkerSize',12,'MarkerFaceColor','r')    % 0.9mm WL10, no Alphaform
%     errorbar(ANS(466,2),ANS(466,12),eANS(466,12),'r^','MarkerSize',12,'MarkerFaceColor','r')    %                                  100
%     errorbar(ANS(465,2),ANS(465,12),eANS(465,12),'rs','MarkerSize',12,'MarkerFaceColor','r')    %                                  200
%     errorbar(ANS(464,2),ANS(464,12),eANS(464,12),'rd','MarkerSize',12,'MarkerFaceColor','r')    %                                  300
%     errorbar(ANS(463,2),ANS(463,12),eANS(463,12),'rp','MarkerSize',12,'MarkerFaceColor','r')    %                                  400
%     errorbar(ANS(470,2),ANS(470,12),eANS(470,12),'ro','MarkerSize',12)%,'MarkerFaceColor','r')    % 0.9mm WL10, with Alphaform
%     errorbar(ANS(469,2),ANS(469,12),eANS(469,12),'r^','MarkerSize',12)%,'MarkerFaceColor','r')    %                                  100
%     errorbar(ANS(468,2),ANS(468,12),eANS(468,12),'rs','MarkerSize',12)%,'MarkerFaceColor','r')    %                                  200
%     errorbar(ANS(472,2),ANS(472,12),eANS(472,12),'rd','MarkerSize',12)%,'MarkerFaceColor','r')    %                                  300
%     errorbar(ANS(471,2),ANS(471,12),eANS(471,12),'rp','MarkerSize',12)%,'MarkerFaceColor','r')    %                                  400
    errorbar(ANS(388:394,2),ANS(388:394,12),eANS(388:394,12),'go','MarkerSize',12,'MarkerFaceColor','g')    % 1.5mm WL10 RT
    errorbar(ANS(384:387,2),ANS(384:387,12),eANS(384:387,12),'g^','MarkerSize',12,'MarkerFaceColor','g')    % 1.5mm WL10 100
    errorbar(ANS(395:400,2),ANS(395:400,12),eANS(395:400,12),'gs','MarkerSize',12,'MarkerFaceColor','g')    % 1.5mm WL10 200
    errorbar(ANS(407:411,2),ANS(407:411,12),eANS(407:411,12),'gd','MarkerSize',12,'MarkerFaceColor','g')    % 1.5mm WL10 300
%     errorbar(ANS(401:406,2),ANS(401:406,12),eANS(401:406,12),'yd','MarkerSize',12,'MarkerFaceColor','y')    % 1.5mm WL10 200 Repeats
%     errorbar(ANS(228:233,2),ANS(228:233,12),eANS(228:233,12),'ko','MarkerSize',16,'MarkerFaceColor','k') % 0.9mm RT
%     errorbar(ANS(234:237,2),ANS(234:237,12),eANS(234:237,12),'bo','MarkerSize',16,'MarkerFaceColor','b') % 0.5mm RT
%     errorbar(ANS(274:277,2),ANS(274:277,12),eANS(274:277,12),'gs','MarkerSize',16,'MarkerFaceColor','g') % 0.5mm RT Repeats, cleaned loop
%     errorbar(ANS(278:282,2),ANS(278:282,12),eANS(278:282,12),'gs','MarkerSize',16,'MarkerFaceColor','g') % 0.5mm RT Repeats, cleaned loop, repacked valves
%     errorbar(ANS(289:293,2),ANS(289:293,12),eANS(289:293,12),'m^','MarkerSize',16,'MarkerFaceColor','m') % 0.5mm RT Repeats for Temp Profiles
%     errorbar(ANS(294:298,2),ANS(294:298,12),eANS(294:298,12),'m^','MarkerSize',16,'MarkerFaceColor','m') % 0.5mm RT Repeats for Temp Profiles
%     errorbar(ANS(412:415,2),ANS(412:415,12),eANS(412:415,12),'bo','MarkerSize',12,'MarkerFaceColor','b')    % 0.9mm WL10 (11/2015) RT
%     errorbar(ANS(416:421,2),ANS(416:421,12),eANS(416:421,12),'b^','MarkerSize',12,'MarkerFaceColor','b')    % 0.9mm WL10 (11/2015) 100
%     fplot(@(x)0.196*x^0.537,[0.5e4 6e4],'-k')                      % Brantley's Previous Correlation c.2013-14
%     fplot(@(x)(0.196*x^0.537)*.9,[0.5e4 6e4],'--k')
%     fplot(@(x)(0.196*x^0.537)*1.1,[0.5e4 6e4],'--k')
%     fplot(@(x)0.085*x^0.59,[0.5e4 6e4],'-k')                         % Latest Correlation c.2014-15
%     fplot(@(x)(0.085*x^0.59)*.9,[0.5e4 6e4],'--k')
%     fplot(@(x)(0.085*x^0.59)*1.1,[0.5e4 6e4],'--k')
    fplot(@(x)0.09419*x^0.5809,[0.5e4 6e4],'-k')                         % Latest Correlation c.2014-15
    fplot(@(x)(0.09419*x^0.5809)*.9,[0.5e4 6e4],'--k')
    fplot(@(x)(0.09419*x^0.5809)*1.1,[0.5e4 6e4],'--k')
%     legend('T_i=27\circC','T_i=100\circC','T_i=200\circC','T_i=250\circC','T_i=300\circC','0.9 mm','0.5 mm','0.5 mm Repeat','Flame','0.5 mm Repeats for Temp Profile','Location','Northwest')
%     legend('0.5 mm','0.25 mm','0.25 mm - Copper','0.25 mm - W/O Copper','Location','Northwest')
%     legend('WL10 Initial - 27 \circC','100 \circC','200 \circC','300 \circC','2015 Repeats - 27 \circC','100 \circC','200 \circC','300 \circC','Location','Northwest')
    legend('27 \circC','100 \circC','200 \circC','300 \circC','400 \circC','Location','Northwest')
    set(gca,'FontSize',26), box on
    xlabel('\itRe','FontSize',26), ylabel('{\itNu\kappa^{-0.19}}','FontSize',26)
%     axis([1e4 5.5e4 10 70])
    hold off
    
    % K_L vs. Re
    figure(8)
    hold on
%     errorbar(ANS([200:205,218:219,225],2),ANS([200:205,218:219,225],15),eANS([200:205,218:219,225],15),'rd','MarkerSize',16)%,'MarkerFaceColor','r')
%     errorbar(ANS([206:209,220:221],2),ANS([206:209,220:221],15),eANS([206:209,220:221],15),'r^','MarkerSize',16)%,'MarkerFaceColor','r')
%     errorbar(ANS([210:213,227],2),ANS([210:213,227],15),eANS([210:213,227],15),'rs','MarkerSize',16)%,'MarkerFaceColor','r')
%     errorbar(ANS([214:217,226],2),ANS([214:217,226],15),eANS([214:217,226],15),'rp','MarkerSize',16)%,'MarkerFaceColor','r')
%     errorbar(ANS(222:224,2),ANS(222:224,15),eANS(222:224,15),'ro','MarkerSize',16)%,'MarkerFaceColor','r')
%     errorbar(ANS(228:233,2),ANS(228:233,15),eANS(228:233,15),'kd','MarkerSize',16)%,'MarkerFaceColor','k')
%     errorbar(ANS(234:237,2),ANS(234:237,15),eANS(234:237,15),'rd','MarkerSize',16)%,'MarkerFaceColor','r') % 0.5mm RT
%     errorbar(ANS(238:243,2),ANS(238:243,15),eANS(238:243,15),'bs','MarkerSize',16)%,'MarkerFaceColor','b') % Cold 0.5mm Repeats
%     errorbar(ANS(244:248,2),ANS(244:248,15),eANS(244:248,15),'rd','MarkerSize',16,'MarkerFaceColor','r') % Cold 0.9mm Repeats, Debris present
%     errorbar(ANS(249:254,2),ANS(249:254,15),eANS(249:254,15),'gd','MarkerSize',16,'MarkerFaceColor','g') % Cold 0.9mm Repeats, still some debris
%     errorbar(ANS(255:260,2),ANS(255:260,15),eANS(255:260,15),'bd','MarkerSize',16,'MarkerFaceColor','b') % Cold 0.9mm Repeats, Old jet cartridge, some debris
%     errorbar(ANS(264:267,2),ANS(264:267,15),eANS(264:267,15),'y^','MarkerSize',16)%,'MarkerFaceColor','y') % Cold 0.9mm Repeats, Old jet cartridge
%     errorbar(ANS(268:273,2),ANS(268:273,15),eANS(268:273,15),'ms','MarkerSize',16)%,'MarkerFaceColor','m') % Cold 0.5mm Repeats, New jet cartridge
%     errorbar(ANS(274:277,2),ANS(274:277,15),eANS(274:277,15),'gs','MarkerSize',16,'MarkerFaceColor','g') % 0.5mm RT Repeats, cleaned loop
%     errorbar(ANS(278:282,2),ANS(278:282,15),eANS(278:282,15),'go','MarkerSize',16,'MarkerFaceColor','g') % 0.5mm RT Repeats, cleaned loop, repacked valves
%     errorbar(ANS(289:293,2),ANS(289:293,15),eANS(289:293,15),'m^','MarkerSize',16,'MarkerFaceColor','m') % 0.5mm RT Repeats for Temp profiles    
%     errorbar(ANS(352:356,2),ANS(352:356,15),eANS(352:356,15),'gs','MarkerSize',16,'MarkerFaceColor','g') % WL10 (New jets cartridge, manifold)
%     errorbar(ANS(357:360,2),ANS(357:360,15),eANS(357:360,15),'g^','MarkerSize',16,'MarkerFaceColor','g') % WL10 (New jets cartridge, manifold) #2
%       errorbar(hemj.wlrt(:,2),hemj.wlrt(:,15),hemj.wlrte(:,15),'bo','MarkerSize',12)%,'MarkerFaceColor','b')   % First WL10 RT
%       errorbar(hemj.wl100(:,2),hemj.wl100(:,15),hemj.wl100e(:,15),'b^','MarkerSize',12)%,'MarkerFaceColor','b')      %            100
%       errorbar(hemj.wl200(:,2),hemj.wl200(:,15),hemj.wl200e(:,15),'bs','MarkerSize',12)%,'MarkerFaceColor','b')      %            200
%       errorbar(hemj.wl300(:,2),hemj.wl300(:,15),hemj.wl300e(:,15),'bd','MarkerSize',12)%,'MarkerFaceColor','b')      %            300
%     errorbar(ANS(367:372,2),ANS(367:372,15),eANS(367:372,15),'ro','MarkerSize',12)%,'MarkerFaceColor','r')    % WL10 (New parts, repeats, RT)
%     errorbar(ANS(361:366,2),ANS(361:366,15),eANS(361:366,15),'r^','MarkerSize',12)%,'MarkerFaceColor','r')    % WL10 (New parts, repeats, 100)
%     errorbar(ANS(373:378,2),ANS(373:378,15),eANS(373:378,15),'rs','MarkerSize',12)%,'MarkerFaceColor','r')    % WL10 (New parts, repeats, 200)
%     errorbar(ANS(379:383,2),ANS(379:383,15),eANS(379:383,15),'rd','MarkerSize',12)%,'MarkerFaceColor','r')    % WL10 (New parts, repeats, 300)
    errorbar(ANS(388:394,2),ANS(388:394,15),eANS(388:394,15),'go','MarkerSize',12,'MarkerFaceColor','g')    % 1.5mm WL10 (New parts, RT)
    errorbar(ANS(384:387,2),ANS(384:387,15),eANS(384:387,15),'g^','MarkerSize',12,'MarkerFaceColor','g')    % 1.5mm WL10 (New parts, 100)
    errorbar(ANS(395:400,2),ANS(395:400,15),eANS(395:400,15),'gs','MarkerSize',12,'MarkerFaceColor','g')    % 1.5mm WL10 (New parts, 200)
    errorbar(ANS(401:406,2),ANS(401:406,15),eANS(401:406,15),'ys','MarkerSize',12,'MarkerFaceColor','y')    % 1.5mm WL10 200 Repeats
    errorbar(ANS(407:411,2),ANS(407:411,15),eANS(407:411,15),'gd','MarkerSize',12,'MarkerFaceColor','g')    % 1.5mm WL10 300
%     errorbar(ANS(412:415,2),ANS(412:415,15),eANS(412:415,15),'bo','MarkerSize',12,'MarkerFaceColor','b')    % 0.9mm WL10 (11/2015) RT
%     errorbar(ANS(416:421,2),ANS(416:421,15),eANS(416:421,15),'b^','MarkerSize',12,'MarkerFaceColor','b')    % 0.9mm WL10 (11/2015) 100
%     errorbar(hemj.total(:,2),hemj.total(:,15),hemj.totale(:,15),'kd','MarkerSize',16)
    errorbar(ANS(440:444,2),ANS(440:444,15),eANS(440:444,15),'ro','MarkerSize',12,'MarkerFaceColor','r')    % 0.9mm WL10, New RT
    errorbar(ANS(434:439,2),ANS(434:439,15),eANS(434:439,15),'r^','MarkerSize',12,'MarkerFaceColor','r')    %                                  100
    errorbar(ANS(422:427,2),ANS(422:427,15),eANS(422:427,15),'rs','MarkerSize',12,'MarkerFaceColor','r')    %                                  200
    errorbar(ANS(428:433,2),ANS(428:433,15),eANS(428:433,15),'rd','MarkerSize',12,'MarkerFaceColor','r')    %                                  300
    errorbar(ANS(445:450,2),ANS(445:450,15),eANS(445:450,15),'rp','MarkerSize',12,'MarkerFaceColor','r')    %                                  400
%     errorbar(ANS(451:455,2),ANS(451:455,15),eANS(451:455,15),'ro','MarkerSize',12)%,'MarkerFaceColor','r')    %                                  RT repeats
%     errorbar(ANS(456:462,2),ANS(456:462,15),eANS(456:462,15),'rp','MarkerSize',12)%,'MarkerFaceColor','r')    %                                  400 repeats
%     errorbar(ANS(467,2),ANS(467,15),eANS(467,15),'ro','MarkerSize',12,'MarkerFaceColor','r')    % 0.9mm WL10, no Alphaform
%     errorbar(ANS(466,2),ANS(466,15),eANS(466,15),'r^','MarkerSize',12,'MarkerFaceColor','r')    %                                  100
%     errorbar(ANS(465,2),ANS(465,15),eANS(465,15),'rs','MarkerSize',12,'MarkerFaceColor','r')    %                                  200
%     errorbar(ANS(464,2),ANS(464,15),eANS(464,15),'rd','MarkerSize',12,'MarkerFaceColor','r')    %                                  300
%     errorbar(ANS(463,2),ANS(463,15),eANS(463,15),'rp','MarkerSize',12,'MarkerFaceColor','r')    %                                  400
%     errorbar(ANS(470,2),ANS(470,15),eANS(470,15),'ro','MarkerSize',12)%,'MarkerFaceColor','r')    % 0.9mm WL10, with Alphaform
%     errorbar(ANS(469,2),ANS(469,15),eANS(469,15),'r^','MarkerSize',12)%,'MarkerFaceColor','r')    %                                  100
%     errorbar(ANS(468,2),ANS(468,15),eANS(468,15),'rs','MarkerSize',12)%,'MarkerFaceColor','r')    %                                  200
%     errorbar(ANS(472,2),ANS(472,15),eANS(472,15),'rd','MarkerSize',12)%,'MarkerFaceColor','r')    %                                  300
%     errorbar(ANS(471,2),ANS(471,15),eANS(471,15),'rp','MarkerSize',12)%,'MarkerFaceColor','r')    %                                  400
%     errorbar(hemj.introom(:,2),hemj.introom(:,15),hemj.introome(:,15),'kd','MarkerSize',16)
%     errorbar(hemj.int100(:,2),hemj.int100(:,15),hemj.int100e(:,15),'k^','MarkerSize',16)
%     errorbar(hemj.int200(:,2),hemj.int200(:,15),hemj.int200e(:,15),'ks','MarkerSize',16)
%     errorbar(hemj.int250(:,2),hemj.int250(:,15),hemj.int250e(:,15),'kp','MarkerSize',16)
%     errorbar(ANS(316:334,2),ANS(316:334,15),eANS(316:334,15),'ko','MarkerSize',16,'MarkerFaceColor','k')       % 0.25 mm
%     plot(hemj.JDRall(:,2),hemj.JDRall(:,15),'kx','MarkerSize',16,'MarkerFaceColor','k')
    set(gca,'FontSize',16), box on
%     fplot(@(x)1.39*(x/1e4)^-0.5+1.32,[1e4 4e4],'-k')
%     set(findobj(gca,'Type','Line','Color','k'),'LineWidth',3);
    xlabel('\itRe','FontSize',28), ylabel('{\itK_L}','FontSize',28)
%     legend('T_i=27\circC','T_i=100\circC','T_i=200\circC','T_i=250\circC','T_i=300\circC','Location','Southeast')
%     axis([0.5e4 5.5e4 2 3])
%     legend('WL10 - T_i=27\circC','T_i=100\circC','T_i=200\circC','T_i=250\circC','T_i=300\circC','2015 Repeats - 27 \circC','100 \circC','200 \circC','300 \circC','Location','Northwest')
    legend('T_i=27\circC','T_i=100\circC','T_i=200\circC','T_i=300\circC','T_i=400\circC','Location','Northwest')
    hold off
end     % General Nu*K and K_L Plots

for m=1:0
   % Nu vs. Re + Induction
    figure(7)
    hold on
%     errorbar(hemj.total(:,2),hemj.total(:,12),hemj.totale(:,12),'rd','MarkerSize',16)
%     errorbar(hemj.mt5tall(:,2),hemj.mt5tall(:,10),hemj.mt5talle(:,10),'k*','MarkerSize',16,'MarkerFaceColor','k')
%     errorbar(hemj.mt25tall(:,2),hemj.mt25tall(:,10),hemj.mt25talle(:,10),'ko','MarkerSize',16)%,'MarkerFaceColor','k')
%     errorbar(ANS(337:338,2),ANS(337:338,10),eANS(337:338,10),'ko','MarkerSize',16,'MarkerFaceColor','k')       % 0.25mm
%     errorbar(ANS(321:334,2),ANS(321:334,10),eANS(321:334,10),'ko','MarkerSize',16,'MarkerFaceColor','k')       % 0.25 mm
%     errorbar(ANS(299:315,2),ANS(299:315,10),eANS(299:315,10),'bs','MarkerSize',16,'MarkerFaceColor','b')       % 0.5 mm
%     errorbar(hemj.all(:,2),hemj.all(:,10),hemj.alle(:,10),'b*','MarkerSize',16)%,'MarkerFaceColor','r')        % Flame Experiments
%     errorbar(hemj.intallt(:,2),hemj.intallt(:,12),hemj.intallte(:,12),'ko','MarkerSize',16)%,'MarkerFaceColor','r')  % First WL10 Exps with New Coil
%     errorbar(ANS(339:342,2),ANS(339:342,10),eANS(339:342,10),'ks','MarkerSize',16)%,'MarkerFaceColor','k')      % WL10 with newer jet cartridge RT
%     errorbar(ANS(343:346,2),ANS(343:346,10),eANS(343:346,10),'kd','MarkerSize',16)%,'MarkerFaceColor','k')      %                               200
%     errorbar(hemj.mt5intrt(:,2),hemj.mt5intrt(:,10),hemj.mt5intrte(:,10),'ks','MarkerSize',12,'MarkerFaceColor','k')    % 0.5mm MT185 RT
%     errorbar(hemj.mt5int100(:,2),hemj.mt5int100(:,10),hemj.mt5int100e(:,10),'k^','MarkerSize',12,'MarkerFaceColor','k')       % 0.5mm MT185 100
%     errorbar(hemj.mt5int200(:,2),hemj.mt5int200(:,10),hemj.mt5int200e(:,10),'kd','MarkerSize',12,'MarkerFaceColor','k')       % 0.5mm MT185 200
%     errorbar(hemj.mt5int300(:,2),hemj.mt5int300(:,10),hemj.mt5int300e(:,10),'ko','MarkerSize',12,'MarkerFaceColor','k')       % 0.5mm MT185 300
    errorbar(hemj.wlrt(:,2),hemj.wlrt(:,10),hemj.wlrte(:,10),'bs','MarkerSize',12,'MarkerFaceColor','b')   % First 0.9mm WL10 RT
    errorbar(hemj.wl100(:,2),hemj.wl100(:,10),hemj.wl100e(:,10),'b^','MarkerSize',12,'MarkerFaceColor','b')      %                  100
    errorbar(hemj.wl200(:,2),hemj.wl200(:,10),hemj.wl200e(:,10),'bd','MarkerSize',12,'MarkerFaceColor','b')      %                  200
    errorbar(hemj.wl300(:,2),hemj.wl300(:,10),hemj.wl300e(:,10),'bo','MarkerSize',12,'MarkerFaceColor','b')      %                  300
%     errorbar(ANS(367:372,2),ANS(367:372,10),eANS(367:372,10),'rs','MarkerSize',12,'MarkerFaceColor','r')    % 0.9mm WL10, ball valve, repeats, RT
%     errorbar(ANS(361:366,2),ANS(361:366,10),eANS(361:366,10),'r^','MarkerSize',12,'MarkerFaceColor','r')    % 0.9mm WL10                       100
%     errorbar(ANS(373:378,2),ANS(373:378,10),eANS(373:378,10),'rd','MarkerSize',12,'MarkerFaceColor','r')    % 0.9mm WL10                       200
%     errorbar(ANS(379:383,2),ANS(379:383,10),eANS(379:383,10),'ro','MarkerSize',12,'MarkerFaceColor','r')    % 0.9mm WL10                       300
%     errorbar(ANS(388:394,2),ANS(388:394,10),eANS(388:394,10),'gs','MarkerSize',12,'MarkerFaceColor','g')    % 1.5mm WL10 RT
%     errorbar(ANS(384:387,2),ANS(384:387,10),eANS(384:387,10),'g^','MarkerSize',12,'MarkerFaceColor','g')    % 1.5mm WL10 100
%     errorbar(ANS(395:406,2),ANS(395:406,10),eANS(395:406,10),'gd','MarkerSize',12,'MarkerFaceColor','g')    % 1.5mm WL10 200
%     errorbar(ANS(407:411,2),ANS(407:411,10),eANS(407:411,10),'go','MarkerSize',12,'MarkerFaceColor','g')    % 1.5mm WL10 300
    errorbar(ANS([412:415 440:444 451:455],2),ANS([412:415 440:444 451:455],10),eANS([412:415 440:444 451:455],10),'ms','MarkerSize',12)%,'MarkerFaceColor','m')    % 0.9mm WL10, new heater, RT
    errorbar(ANS([416:421 434:439],2),ANS([416:421 434:439],10),eANS([416:421 434:439],10),'m^','MarkerSize',12)%,'MarkerFaceColor','m')    % 0.9mm WL10                       100
    errorbar(ANS(422:427,2),ANS(422:427,10),eANS(422:427,10),'md','MarkerSize',12)%,'MarkerFaceColor','m')    % 0.9mm WL10                       200
    errorbar(ANS(428:433,2),ANS(428:433,10),eANS(428:433,10),'mo','MarkerSize',12)%,'MarkerFaceColor','m')    % 0.9mm WL10                       300
    errorbar(ANS(445:450,2),ANS(445:450,10),eANS(445:450,10),'mp','MarkerSize',12)%,'MarkerFaceColor','m')    % 0.9mm WL10                       400
    errorbar(ANS(456:462,2),ANS(456:462,10),eANS(456:462,10),'mp','MarkerSize',12)%,'MarkerFaceColor','m')    % 0.9mm WL10                       400 , 4 MW/m2
%     errorbar(ANS(228:233,2),ANS(228:233,10),eANS(228:233,10),'kd','MarkerSize',16,'MarkerFaceColor','k') % 0.9mm RT
%     errorbar(ANS(234:237,2),ANS(234:237,10),eANS(234:237,10),'ks','MarkerSize',16,'MarkerFaceColor','k') % 0.5mm RT
%     errorbar(ANS(274:277,2),ANS(274:277,10),eANS(274:277,10),'ks','MarkerSize',16,'MarkerFaceColor','k') % 0.5mm RT Repeats, cleaned loop
%     errorbar(ANS(278:282,2),ANS(278:282,10),eANS(278:282,10),'ks','MarkerSize',16,'MarkerFaceColor','k') % 0.5mm RT Repeats, cleaned loop, repacked valves
%     errorbar(hemj.all(:,2),hemj.all(:,12),hemj.alle(:,12),'yd','MarkerSize',16,'MarkerFaceColor','y')    % Flame experiments
%     errorbar(ANS(289:293,2),ANS(289:293,12),eANS(289:293,12),'m^','MarkerSize',16,'MarkerFaceColor','m') % 0.5mm RT Repeats for Temp Profiles
%     errorbar(ANS(294:298,2),ANS(294:298,12),eANS(294:298,12),'m^','MarkerSize',16,'MarkerFaceColor','m') % 0.5mm RT Repeats for Temp Profiles
%     fplot(@(x)0.196*x^0.537,[0.5e4 6e4],'-k')                      % Brantley's Previous Correlation c.2013-14
%     fplot(@(x)(0.196*x^0.537)*.9,[0.5e4 6e4],'--k')
%     fplot(@(x)(0.196*x^0.537)*1.1,[0.5e4 6e4],'--k')
%     fplot(@(x)0.085*x^0.59,[0.5e4 6e4],'-k')                         % Latest Correlation c.2014-15
%     fplot(@(x)(0.085*x^0.59)*.9,[0.5e4 6e4],'--k')
%     fplot(@(x)(0.085*x^0.59)*1.1,[0.5e4 6e4],'--k')
%     legend('T_i=27\circC','T_i=100\circC','T_i=200\circC','T_i=250\circC','T_i=300\circC','0.9 mm','0.5 mm','0.5 mm Repeat','Flame','0.5 mm Repeats for Temp Profile','Location','Northwest')
%     legend('0.5 mm','0.25 mm','0.25 mm - Copper','0.25 mm - W/O Copper','Location','Northwest')
%     legend('WL10 Initial - 27 \circC','100 \circC','200 \circC','300 \circC','2015 Repeats - 27 \circC','100 \circC','200 \circC','300 \circC','Location','Northwest')
    legend('27 \circC','100 \circC','200 \circC','300 \circC','Location','Northwest')
    set(gca,'FontSize',26), box on
    xlabel('\itRe','FontSize',26), ylabel('{\itNu}','FontSize',26)
%     axis([1e4 5.5e4 10 70])
    hold off
    
    figure(8)
    hold on
    errorbar(hemj.wlrt(:,2),hemj.wlrt(:,15),hemj.wlrte(:,15),'bs','MarkerSize',12,'MarkerFaceColor','b')   % First 0.9mm WL10 RT
    errorbar(hemj.wl100(:,2),hemj.wl100(:,15),hemj.wl100e(:,15),'b^','MarkerSize',12,'MarkerFaceColor','b')      %                  100
    errorbar(hemj.wl200(:,2),hemj.wl200(:,15),hemj.wl200e(:,15),'bd','MarkerSize',12,'MarkerFaceColor','b')      %                  200
    errorbar(hemj.wl300(:,2),hemj.wl300(:,15),hemj.wl300e(:,15),'bo','MarkerSize',12,'MarkerFaceColor','b')      %                  300
%     errorbar(ANS(367:372,2),ANS(367:372,15),eANS(367:372,15),'rs','MarkerSize',12,'MarkerFaceColor','r')    % 0.9mm WL10, ball valve, repeats, RT
%     errorbar(ANS(361:366,2),ANS(361:366,15),eANS(361:366,15),'r^','MarkerSize',12,'MarkerFaceColor','r')    % 0.9mm WL10                       100
%     errorbar(ANS(373:378,2),ANS(373:378,15),eANS(373:378,15),'rd','MarkerSize',12,'MarkerFaceColor','r')    % 0.9mm WL10                       200
%     errorbar(ANS(379:383,2),ANS(379:383,15),eANS(379:383,15),'ro','MarkerSize',12,'MarkerFaceColor','r')    % 0.9mm WL10                       300
%     errorbar(ANS(388:394,2),ANS(388:394,15),eANS(388:394,15),'gs','MarkerSize',12,'MarkerFaceColor','g')    % 1.5mm WL10 RT
%     errorbar(ANS(384:387,2),ANS(384:387,15),eANS(384:387,15),'g^','MarkerSize',12,'MarkerFaceColor','g')    % 1.5mm WL10 100
%     errorbar(ANS(395:406,2),ANS(395:406,15),eANS(395:406,15),'gd','MarkerSize',12,'MarkerFaceColor','g')    % 1.5mm WL10 200
%     errorbar(ANS(407:411,2),ANS(407:411,15),eANS(407:411,15),'go','MarkerSize',12,'MarkerFaceColor','g')    % 1.5mm WL10 300
    errorbar(ANS([412:415 440:444 451:455],2),ANS([412:415 440:444 451:455],15),eANS([412:415 440:444 451:455],15),'ms','MarkerSize',12)%,'MarkerFaceColor','m')    % 0.9mm WL10, new heater, RT
    errorbar(ANS([416:421 434:439],2),ANS([416:421 434:439],15),eANS([416:421 434:439],15),'m^','MarkerSize',12)%,'MarkerFaceColor','m')    % 0.9mm WL10                       100
    errorbar(ANS(422:427,2),ANS(422:427,15),eANS(422:427,15),'md','MarkerSize',12)%,'MarkerFaceColor','m')    % 0.9mm WL10                       200
    errorbar(ANS(428:433,2),ANS(428:433,15),eANS(428:433,15),'mo','MarkerSize',12)%,'MarkerFaceColor','m')    % 0.9mm WL10                       300
    errorbar(ANS(445:450,2),ANS(445:450,15),eANS(445:450,15),'mp','MarkerSize',12)%,'MarkerFaceColor','m')    % 0.9mm WL10                       400
    errorbar(ANS(456:462,2),ANS(456:462,15),eANS(456:462,15),'mp','MarkerSize',12)%,'MarkerFaceColor','m')    % 0.9mm WL10                       400 , 4 MW/m2
%     legend('T_i=27\circC','T_i=100\circC','T_i=200\circC','T_i=250\circC','T_i=300\circC','0.9 mm','0.5 mm','0.5 mm Repeat','Flame','0.5 mm Repeats for Temp Profile','Location','Northwest')
%     legend('0.5 mm','0.25 mm','0.25 mm - Copper','0.25 mm - W/O Copper','Location','Northwest')
%     legend('WL10 Initial - 27 \circC','100 \circC','200 \circC','300 \circC','2015 Repeats - 27 \circC','100 \circC','200 \circC','300 \circC','Location','Northwest')
    legend('27 \circC','100 \circC','200 \circC','300 \circC','Location','Northwest')
    set(gca,'FontSize',26), box on
    xlabel('\itRe','FontSize',26), ylabel('{\itK_L}','FontSize',26)
%     axis([1e4 5.5e4 10 70])
    hold off
    
end     % Pure Nu vs Re

for m=1:0
%     %q" vs. Re
%     figure(7)
%     hold on
%     errorbar(hemj.introom(:,2),hemj.introom(:,3)./1e6,hemj.introome(:,3)./1e6,'kd','MarkerSize',16,'MarkerFaceColor','k')
%     errorbar(hemj.int100(:,2),hemj.int100(:,3)./1e6,hemj.int100e(:,3)./1e6,'k^','MarkerSize',16,'MarkerFaceColor','k')
%     errorbar(hemj.int200(:,2),hemj.int200(:,3)./1e6,hemj.int200e(:,3)./1e6,'ks','MarkerSize',16,'MarkerFaceColor','k')
%     errorbar(hemj.int250(:,2),hemj.int250(:,3)./1e6,hemj.int250e(:,3)./1e6,'kp','MarkerSize',16,'MarkerFaceColor','k')
%     errorbar(hemj.troom(:,2),hemj.troom(:,3)./1e6,hemj.troome(:,3)./1e6,'kd','MarkerSize',16)
%     errorbar(hemj.t100(:,2),hemj.t100(:,3)./1e6,hemj.t100e(:,3)./1e6,'k^','MarkerSize',16)
%     errorbar(hemj.t200(:,2),hemj.t200(:,3)./1e6,hemj.t200e(:,3)./1e6,'ks','MarkerSize',16)
%     errorbar(hemj.t250(:,2),hemj.t250(:,3)./1e6,hemj.t250e(:,3)./1e6,'kp','MarkerSize',16)
%     errorbar(hemj.t300(:,2),hemj.t300(:,3)./1e6,hemj.t300e(:,3)./1e6,'ko','MarkerSize',16)
%     set(gca,'FontSize',28), box on
%     legend('T_i=27\circC','T_i=100\circC','T_i=200\circC','T_i=250\circC','Location','Northwest')
%     xlabel('\itRe','FontSize',28), ylabel('{\itq"} (MW/m^2)','FontSize',28)
%     axis([1e4 4e4 1 6])
%     hold off
%     
%     figure(3)
%     hold on
%     errorbar(hemj.lamin([1,4],2),hemj.lamin([1,4],10),hemj.laminerror([1,4],10),'bd','MarkerSize',16,'MarkerFaceColor','b')
%     errorbar(hemj.lamin([2],2),hemj.lamin([2],10),hemj.laminerror([2],10),'g^','MarkerSize',16,'MarkerFaceColor','g')
%     errorbar(hemj.lamin([3,5],2),hemj.lamin([3,5],10),hemj.laminerror([3,5],10),'ro','MarkerSize',16,'MarkerFaceColor','r')
%     set(gca,'FontSize',28), box on
% %     title('Low {\itRe} Laminarization Experiments')
%     xlabel('\itRe','FontSize',28), ylabel('{\itNu}','FontSize',28)
% %     legend('0.7 MW/m^2','1.8 MW/m^2','2.6 MW/m^2','Location','Northwest')
%     axis([2e3 9e3 0 100])
%     hold off
end     % Extrapolation Plots
  
%% More Plots

for m=1:1
   % Pure Nu vs. Re
    figure(7)
    hold on
%     errorbar(ANS(440:444,2),ANS(440:444,10),eANS(440:444,10),'ro','MarkerSize',12,'MarkerFaceColor','r')    % 0.9mm WL10, New RT
%     errorbar(ANS(434:439,2),ANS(434:439,10),eANS(434:439,10),'r^','MarkerSize',12,'MarkerFaceColor','r')    %                     100
%     errorbar(ANS(422:427,2),ANS(422:427,10),eANS(422:427,10),'rs','MarkerSize',12,'MarkerFaceColor','r')    %                     200
%     errorbar(ANS(428:433,2),ANS(428:433,10),eANS(428:433,10),'rd','MarkerSize',12,'MarkerFaceColor','r')    %                     300
    errorbar(ANS(445:450,2),ANS(445:450,10),eANS(445:450,10),'rp','MarkerSize',12,'MarkerFaceColor','r')    %                     400
    errorbar(ANS(457:462,2),ANS(457:462,10),eANS(457:462,10),'rp','MarkerSize',12)%,'MarkerFaceColor','r')    %                      400
%     errorbar(hemj.wl5t300(:,2),hemj.wl5t300(:,10),hemj.wl5t300e(:,10),'rd','MarkerSize',12,'MarkerFaceColor','r')    % 0.5mm WL10 New 300
%     errorbar(hemj.wl5t400(:,2),hemj.wl5t400(:,10),hemj.wl5t400e(:,10),'rp','MarkerSize',12,'MarkerFaceColor','r')    %                400
    errorbar(hemj.wl9t300(:,2),hemj.wl9t300(:,10),hemj.wl9t300e(:,10),'kd','MarkerSize',12,'MarkerFaceColor','k')    % 0.9mm WL10 New, Repeat 300
    errorbar(hemj.wl9t400(:,2),hemj.wl9t400(:,10),hemj.wl9t400e(:,10),'kp','MarkerSize',12,'MarkerFaceColor','k')    %                        400
%     errorbar(hemj.wl128t300(:,2),hemj.wl128t300(:,10),hemj.wl128t300e(:,10),'bd','MarkerSize',12,'MarkerFaceColor','b')    % 1.28mm WL10 New 300
%     errorbar(hemj.wl128t400(:,2),hemj.wl128t400(:,10),hemj.wl128t400e(:,10),'bp','MarkerSize',12,'MarkerFaceColor','b')    %                 400
    errorbar(ANS(384:387,2),ANS(384:387,10),eANS(384:387,10),'mo','MarkerSize',12,'MarkerFaceColor','m')    % 1.5mm WL10 RT (1st runs at 1.5)
    errorbar(ANS(388:394,2),ANS(388:394,10),eANS(388:394,10),'m^','MarkerSize',12,'MarkerFaceColor','m')    % 1.5mm WL10 100
    errorbar(ANS(395:406,2),ANS(395:406,10),eANS(395:406,10),'ms','MarkerSize',12,'MarkerFaceColor','m')    % 1.5mm WL10 200
    errorbar(ANS(407:411,2),ANS(407:411,10),eANS(407:411,10),'md','MarkerSize',12,'MarkerFaceColor','m')    % 1.5mm WL10 300
    errorbar(ANS(531:536,2),ANS(531:536,10),eANS(531:536,10),'bp','MarkerSize',12)%,'MarkerFaceColor','b')   0 % 1.5mm WL10 New, Repeat 400
%     errorbar(ANS(509:513,2),ANS(509:513,10),eANS(509:513,10),'gd','MarkerSize',12)%,'MarkerFaceColor','g')    % 0.5mm WL10 New, Repeat 300
%     errorbar(ANS(514:519,2),ANS(514:519,10),eANS(514:519,10),'gp','MarkerSize',12)%,'MarkerFaceColor','g')    %                        400
    errorbar(ANS(520:525,2),ANS(520:525,10),eANS(520:525,10),'kd','MarkerSize',12)%,'MarkerFaceColor','k')    % 0.9mm WL10 New, Repeat 2 300
    errorbar(ANS(526:530,2),ANS(526:530,10),eANS(526:530,10),'kp','MarkerSize',12)%,'MarkerFaceColor','k')    %                          400
%     errorbar(ANS(537:542,2),ANS(537:542,10),eANS(537:542,10),'bp','MarkerSize',12,'MarkerFaceColor','b')    % 0.25mm MT-185 400
%     errorbar(ANS(543:547,2),ANS(543:547,10),eANS(543:547,10),'bs','MarkerSize',12,'MarkerFaceColor','b')    %               350
%     errorbar(ANS(548:552,2),ANS(548:552,10),eANS(548:552,10),'bo','MarkerSize',12,'MarkerFaceColor','b')    %               30
%     errorbar(ANS(553:558,2),ANS(553:558,10),eANS(553:558,10),'bp','MarkerSize',12)%,'MarkerFaceColor','b')    %             400 low q"
%     errorbar(ANS(559:564,2),ANS(559:564,10),eANS(559:564,10),'bo','MarkerSize',12)%,'MarkerFaceColor','b')    %             30 low q"
%     errorbar(ANS(565:571,2),ANS(565:571,10),eANS(565:571,10),'rp','MarkerSize',12,'MarkerFaceColor','r')    % 0.9mm MT185, 400, low q"
%     errorbar(ANS(572:577,2),ANS(572:577,10),eANS(572:577,10),'rd','MarkerSize',12,'MarkerFaceColor','r')    % 0.9mm MT185, 300, low q"    
%     errorbar(ANS(578:583,2),ANS(578:583,10),eANS(578:583,10),'gp','MarkerSize',12,'MarkerFaceColor','g')    % 0.9mm WL10,  400 low q"
%     errorbar(ANS(584:589,2),ANS(584:589,10),eANS(584:589,10),'gd','MarkerSize',12,'MarkerFaceColor','g')    %              300 low q"
    %     legend('27 \circC','100 \circC','200 \circC','300 \circC','400 \circC','Location','Northwest')
    legend('300 \circC','400 \circC','Location','Northwest')
    set(gca,'FontSize',26), box on
    xlabel('\itRe','FontSize',26), ylabel('{\itNu}','FontSize',26)
%     axis([1e4 4e4 0 160])
    hold off
    
    % K_L vs. Re
    figure(8)
    hold on
%     errorbar(ANS(440:444,2),ANS(440:444,15),eANS(440:444,15),'ro','MarkerSize',12,'MarkerFaceColor','r')    % 0.9mm WL10, New RT
%     errorbar(ANS(434:439,2),ANS(434:439,15),eANS(434:439,15),'r^','MarkerSize',12,'MarkerFaceColor','r')    %                     100
%     errorbar(ANS(422:427,2),ANS(422:427,15),eANS(422:427,15),'rs','MarkerSize',12,'MarkerFaceColor','r')    %                     200
%     errorbar(ANS(428:433,2),ANS(428:433,15),eANS(428:433,15),'rd','MarkerSize',12,'MarkerFaceColor','r')    %                     300
%     errorbar(ANS(445:450,2),ANS(445:450,15),eANS(445:450,15),'rp','MarkerSize',12,'MarkerFaceColor','r')    %                     400
%     errorbar(ANS(457:462,2),ANS(457:462,15),eANS(457:462,15),'rp','MarkerSize',12)%,'MarkerFaceColor','r')    %                     400
%     errorbar(hemj.wl5t300(:,2),hemj.wl5t300(:,15),hemj.wl5t300e(:,15),'rd','MarkerSize',12,'MarkerFaceColor','r')    % 0.5mm WL10 New 300
%     errorbar(hemj.wl5t400(:,2),hemj.wl5t400(:,15),hemj.wl5t400e(:,15),'rp','MarkerSize',12,'MarkerFaceColor','r')    %                400
    errorbar(hemj.wl9t300(:,2),hemj.wl9t300(:,15),hemj.wl9t300e(:,15),'kd','MarkerSize',12,'MarkerFaceColor','k')    % 0.9mm WL10 New, Repeat 300
    errorbar(hemj.wl9t400(:,2),hemj.wl9t400(:,15),hemj.wl9t400e(:,15),'kp','MarkerSize',12,'MarkerFaceColor','k')    %                        400
%     errorbar(hemj.wl128t300(:,2),hemj.wl128t300(:,15),hemj.wl128t300e(:,15),'bd','MarkerSize',12,'MarkerFaceColor','b')    %  1.28 WL10 New 300
%     errorbar(hemj.wl128t400(:,2),hemj.wl128t400(:,15),hemj.wl128t400e(:,15),'bp','MarkerSize',12,'MarkerFaceColor','b')    %                400
    errorbar(ANS(384:387,2),ANS(384:387,15),eANS(384:387,15),'mo','MarkerSize',12,'MarkerFaceColor','m')    % 1.5mm WL10 RT (1st runs at 1.5)
    errorbar(ANS(388:394,2),ANS(388:394,15),eANS(388:394,15),'m^','MarkerSize',12,'MarkerFaceColor','m')    % 1.5mm WL10 100
    errorbar(ANS(395:406,2),ANS(395:406,15),eANS(395:406,15),'ms','MarkerSize',12,'MarkerFaceColor','m')    % 1.5mm WL10 200
    errorbar(ANS(407:411,2),ANS(407:411,15),eANS(407:411,15),'md','MarkerSize',12,'MarkerFaceColor','m')    % 1.5mm WL10 300
    errorbar(ANS(531:536,2),ANS(531:536,15),eANS(531:536,15),'bp','MarkerSize',12)%,'MarkerFaceColor','b')    % 1.5mm WL10 New, Repeat 400
%     errorbar(ANS(509:513,2),ANS(509:513,15),eANS(509:513,15),'gd','MarkerSize',12)%,'MarkerFaceColor','g')    % 0.5mm WL10 New, Repeat 300
%     errorbar(ANS(514:519,2),ANS(514:519,15),eANS(514:519,15),'gp','MarkerSize',12)%,'MarkerFaceColor','g')    %                        400
%     errorbar(ANS(520:525,2),ANS(520:525,15),eANS(520:525,15),'kd','MarkerSize',12)%,'MarkerFaceColor','k')    % 0.9mm WL10 New, Repeat 2 300
%     errorbar(ANS(526:530,2),ANS(526:530,15),eANS(526:530,15),'kp','MarkerSize',12)%,'MarkerFaceColor','k')    %                          400
%     errorbar(ANS(537:542,2),ANS(537:542,15),eANS(537:542,15),'bp','MarkerSize',12,'MarkerFaceColor','b')    % 0.25mm MT-185 400
%     errorbar(ANS(543:547,2),ANS(543:547,15),eANS(543:547,15),'bs','MarkerSize',12,'MarkerFaceColor','b')    %               350
    errorbar(ANS(548:552,2),ANS(548:552,15),eANS(548:552,15),'bo','MarkerSize',12,'MarkerFaceColor','b')    %               30
%     errorbar(ANS(553:558,2),ANS(553:558,15),eANS(553:558,15),'bp','MarkerSize',12)%,'MarkerFaceColor','b')    %              400 low q"
%     errorbar(ANS(559:564,2),ANS(559:564,15),eANS(559:564,15),'bo','MarkerSize',12)%,'MarkerFaceColor','b')    %              30 low q"
    errorbar(ANS(565:571,2),ANS(565:571,15),eANS(565:571,15),'rp','MarkerSize',12,'MarkerFaceColor','r')    % 0.9mm MT185, 400, low q"
    errorbar(ANS(572:577,2),ANS(572:577,15),eANS(572:577,15),'rd','MarkerSize',12,'MarkerFaceColor','r')    % 0.9mm MT185, 300, low q"
    errorbar(ANS(578:583,2),ANS(578:583,15),eANS(578:583,15),'gp','MarkerSize',12,'MarkerFaceColor','g')    % 0.9mm WL10,  400 low q"
    errorbar(ANS(584:589,2),ANS(584:589,15),eANS(584:589,15),'gd','MarkerSize',12,'MarkerFaceColor','g')    %              300 low q"
    set(gca,'FontSize',26), box on
    xlabel('\itRe','FontSize',26), ylabel('{\itK_L}','FontSize',26)
    axis([1e4 5.5e4 1.5 2.4])
%     legend('27 \circC','100 \circC','200 \circC','300 \circC','400 \circC','Location','Northwest')
    legend('300 \circC','400 \circC','Location','Northwest')
    hold off
end

for m=1:0
   % Nu*Kappa vs. Re
    figure(7)
    hold on
%     errorbar(ANS(440:444,2),ANS(440:444,12),eANS(440:444,12),'ro','MarkerSize',12,'MarkerFaceColor','r')    % 0.9mm WL10, New RT
%     errorbar(ANS(434:439,2),ANS(434:439,12),eANS(434:439,12),'r^','MarkerSize',12,'MarkerFaceColor','r')    %                                  100
%     errorbar(ANS(422:427,2),ANS(422:427,12),eANS(422:427,12),'rs','MarkerSize',12,'MarkerFaceColor','r')    %                                  200
%     errorbar(ANS(428:433,2),ANS(428:433,12),eANS(428:433,12),'rd','MarkerSize',12,'MarkerFaceColor','r')    %                                  300
%     errorbar(ANS(445:450,2),ANS(445:450,12),eANS(445:450,12),'rp','MarkerSize',12,'MarkerFaceColor','r')    %                                  400
%     errorbar(ANS(457:462,2),ANS(457:462,12),eANS(457:462,12),'rp','MarkerSize',12)%,'MarkerFaceColor','r')    %                                  400
    errorbar(hemj.wl5t300(:,2),hemj.wl5t300(:,12),hemj.wl5t300e(:,12),'rd','MarkerSize',12,'MarkerFaceColor','r')    % 0.5mm WL10 New                  300
    errorbar(hemj.wl5t400(:,2),hemj.wl5t400(:,12),hemj.wl5t400e(:,12),'rp','MarkerSize',12,'MarkerFaceColor','r')    %                                 400
    errorbar(hemj.wl9t300(:,2),hemj.wl9t300(:,12),hemj.wl9t300e(:,12),'kd','MarkerSize',12,'MarkerFaceColor','k')    % 0.9mm WL10 New, Repeat          300
    errorbar(hemj.wl9t400(:,2),hemj.wl9t400(:,12),hemj.wl9t400e(:,12),'kp','MarkerSize',12,'MarkerFaceColor','k')    %                                 400
    errorbar(hemj.wl128t300(:,2),hemj.wl128t300(:,12),hemj.wl128t300e(:,12),'bd','MarkerSize',12,'MarkerFaceColor','b')    % 1.28mm WL10 New                  300
    errorbar(hemj.wl128t400(:,2),hemj.wl128t400(:,12),hemj.wl128t400e(:,12),'bp','MarkerSize',12,'MarkerFaceColor','b')    %                                  400
%     errorbar(ANS(407:411,2),ANS(407:411,12),eANS(407:411,12),'mo','MarkerSize',12,'MarkerFaceColor','m')    % 1.5mm WL10 300
%     errorbar(ANS(531:536,2),ANS(531:536,12),eANS(531:536,12),'bp','MarkerSize',12)%,'MarkerFaceColor','b')    % 1.5mm WL10 New, Repeat                        400
%     errorbar(ANS(509:513,2),ANS(509:513,12),eANS(509:513,12),'gd','MarkerSize',12)%,'MarkerFaceColor','g')    % 0.5mm WL10 New, Repeat                 300
%     errorbar(ANS(514:519,2),ANS(514:519,12),eANS(514:519,12),'gp','MarkerSize',12)%,'MarkerFaceColor','g')    %                                        400
%     errorbar(ANS(520:525,2),ANS(520:525,12),eANS(520:525,12),'kd','MarkerSize',12)%,'MarkerFaceColor','k')    % 0.9mm WL10 New, Repeat 2        300
%     errorbar(ANS(526:530,2),ANS(526:530,12),eANS(526:530,12),'kp','MarkerSize',12)%,'MarkerFaceColor','k')    %                                 400
    fplot(@(x)0.085*x^0.59,[0.5e4 5e4],'-k')                         % Latest Correlation c.2014-15
    fplot(@(x)(0.085*x^0.59)*.9,[0.5e4 5e4],'--k')
    fplot(@(x)(0.085*x^0.59)*1.1,[0.5e4 5e4],'--k')
%     legend('27 \circC','100 \circC','200 \circC','300 \circC','400 \circC','Location','Northwest')
%     legend('300 \circC','400 \circC','Location','Northwest')
    set(gca,'FontSize',26), box on
    xlabel('\itRe','FontSize',26), ylabel('{\itNu\kappa^{-0.19}}','FontSize',26)
%     axis([1e4 4e4 0 160])
    hold off
    
    % K_L vs. Re
    figure(8)
    hold on
%     errorbar(ANS(440:444,2),ANS(440:444,15),eANS(440:444,15),'ro','MarkerSize',12,'MarkerFaceColor','r')    % 0.9mm WL10, New RT
%     errorbar(ANS(434:439,2),ANS(434:439,15),eANS(434:439,15),'r^','MarkerSize',12,'MarkerFaceColor','r')    %                                  100
%     errorbar(ANS(422:427,2),ANS(422:427,15),eANS(422:427,15),'rs','MarkerSize',12,'MarkerFaceColor','r')    %                                  200
%     errorbar(ANS(428:433,2),ANS(428:433,15),eANS(428:433,15),'rd','MarkerSize',12,'MarkerFaceColor','r')    %                                  300
%     errorbar(ANS(445:450,2),ANS(445:450,15),eANS(445:450,15),'rp','MarkerSize',12,'MarkerFaceColor','r')    %                                  400
%     errorbar(ANS(457:462,2),ANS(457:462,15),eANS(457:462,15),'rp','MarkerSize',12)%,'MarkerFaceColor','r')    %                                  400
    errorbar(hemj.wl5t300(:,2),hemj.wl5t300(:,15),hemj.wl5t300e(:,15),'rd','MarkerSize',12,'MarkerFaceColor','r')    % 0.5mm WL10 New                  300
    errorbar(hemj.wl5t400(:,2),hemj.wl5t400(:,15),hemj.wl5t400e(:,15),'rp','MarkerSize',12,'MarkerFaceColor','r')    %                                  400
    errorbar(hemj.wl9t300(:,2),hemj.wl9t300(:,15),hemj.wl9t300e(:,15),'kd','MarkerSize',12,'MarkerFaceColor','k')    % 0.9mm WL10 New, Repeat          300
    errorbar(hemj.wl9t400(:,2),hemj.wl9t400(:,15),hemj.wl9t400e(:,15),'kp','MarkerSize',12,'MarkerFaceColor','k')    %                                 400
    errorbar(hemj.wl128t300(:,2),hemj.wl128t300(:,15),hemj.wl128t300e(:,15),'bd','MarkerSize',12,'MarkerFaceColor','b')    %  1.28 WL10 New                   300
    errorbar(hemj.wl128t400(:,2),hemj.wl128t400(:,15),hemj.wl128t400e(:,15),'bp','MarkerSize',12,'MarkerFaceColor','b')    %                                  400
%     errorbar(ANS(407:411,2),ANS(407:411,15),eANS(407:411,15),'mo','MarkerSize',12,'MarkerFaceColor','m')    % 1.5mm WL10 300
%     errorbar(ANS(531:536,2),ANS(531:536,15),eANS(531:536,15),'bp','MarkerSize',12)%,'MarkerFaceColor','b')    % 1.5mm WL10 New, Repeat                        400
%     errorbar(ANS(509:513,2),ANS(509:513,15),eANS(509:513,15),'gd','MarkerSize',12)%,'MarkerFaceColor','g')    % 0.5mm WL10 New, Repeat                 300
%     errorbar(ANS(514:519,2),ANS(514:519,15),eANS(514:519,15),'gp','MarkerSize',12)%,'MarkerFaceColor','g')    %                                        400
%     errorbar(ANS(520:525,2),ANS(520:525,15),eANS(520:525,15),'kd','MarkerSize',12)%,'MarkerFaceColor','k')    % 0.9mm WL10 New, Repeat 2        300
%     errorbar(ANS(526:530,2),ANS(526:530,15),eANS(526:530,15),'kp','MarkerSize',12)%,'MarkerFaceColor','k')    %                                 400
    set(gca,'FontSize',26), box on
    xlabel('\itRe','FontSize',26), ylabel('{\itK_L}','FontSize',26)
    axis([1e4 4e4 1.5 2.2])
%     legend('27 \circC','100 \circC','200 \circC','300 \circC','400 \circC','Location','Northwest')
%     legend('300 \circC','400 \circC','Location','Northwest')
    hold off
end

%% Plots (2017)

for m=1:1
   % Pure Nu vs. Re
    figure(7)
    hold on
%     errorbar(ANS(347:351,2),ANS(347:351,10),eANS(347:351,10),'go','MarkerSize',12,'MarkerFaceColor','g')    % 0.9mm WL10, Flame, RT

%     errorbar(ANS(457:462,2),ANS(457:462,10),eANS(457:462,10),'rp','MarkerSize',12)%,'MarkerFaceColor','r')    %                      400
%     errorbar(hemj.wl9t300(:,2),hemj.wl9t300(:,10),hemj.wl9t300e(:,10),'kd','MarkerSize',12,'MarkerFaceColor','k')    % 0.9mm WL10 New, Repeat 300
%     errorbar(hemj.wl9t400(:,2),hemj.wl9t400(:,10),hemj.wl9t400e(:,10),'kp','MarkerSize',12,'MarkerFaceColor','k')    %                        400
%     errorbar(ANS(520:525,2),ANS(520:525,10),eANS(520:525,10),'kd','MarkerSize',12)%,'MarkerFaceColor','k')    % 0.9mm WL10 New, Repeat 2 300
%     errorbar(ANS(526:530,2),ANS(526:530,10),eANS(526:530,10),'kp','MarkerSize',12)%,'MarkerFaceColor','k')    %                          400
%     errorbar(ANS(590:597,2),ANS(590:597,10),eANS(590:597,10),'bo','MarkerSize',12,'MarkerFaceColor','b')    % 0.9mm WL10, Vacuum Chamber, RT
%     errorbar(ANS(595:599,2),ANS(595:599,10),eANS(595:599,10),'bs','MarkerSize',12,'MarkerFaceColor','b')    % 0.9mm WL10, Vacuum Chamber, RT
    errorbar(ANS(600:605,2),ANS(600:605,10),eANS(600:605,10),'bo','MarkerSize',12,'MarkerFaceColor','b')    % 0.9mm WL10 Int, Vac Cham, RT
    errorbar(ANS(624:629,2),ANS(624:629,10),eANS(624:629,10),'b^','MarkerSize',12,'MarkerFaceColor','b')    % 0.9mm WL10 Int, Vac Cham, 100
    errorbar(ANS(606:611,2),ANS(606:611,10),eANS(606:611,10),'bs','MarkerSize',12,'MarkerFaceColor','b')    % 0.9mm WL10 Int, Vac Cham, 200
    errorbar(ANS(612:617,2),ANS(612:617,10),eANS(612:617,10),'bd','MarkerSize',12,'MarkerFaceColor','b')    % 0.9mm WL10 Int, Vac Cham, 300
%     errorbar(ANS(630:635,2),ANS(630:635,10),eANS(630:635,10),'b<','MarkerSize',12,'MarkerFaceColor','b')    % 0.9mm WL10 Int, Vac Cham, 350
%     errorbar(ANS(642:647,2),ANS(642:647,10),eANS(642:647,10),'b>','MarkerSize',12,'MarkerFaceColor','b')    % 0.9mm WL10 Int, Vac Cham, 375
%     errorbar(ANS(618:623,2),ANS(618:623,10),eANS(618:623,10),'bp','MarkerSize',12,'MarkerFaceColor','b')    % 0.9mm WL10 Int, Vac Cham, 400
%     errorbar(ANS(689,2),ANS(689,10),eANS(689,10),'bp','MarkerSize',12,'MarkerFaceColor','b')    % 0.9mm WL10 Int, Vac Cham, 400
    errorbar(ANS(693:698,2),ANS(693:698,10),eANS(693:698,10),'rp','MarkerSize',12,'MarkerFaceColor','r')    % 0.9mm WL10 Int, Vac Cham, 400 Repeat
    errorbar(ANS(699:701,2),ANS(699:701,10),eANS(699:701,10),'gp','MarkerSize',12)%,'MarkerFaceColor','g')    % 0.9mm WL10 Int, Vac Cham, 400 Repeat

%     errorbar(ANS(683:688,2),ANS(683:688,10),eANS(683:688,10),'bv','MarkerSize',12,'MarkerFaceColor','b')    % 0.9mm WL10 Int, Vac Cham, 405
    errorbar(ANS(636:641,2),ANS(636:641,10),eANS(636:641,10),'bh','MarkerSize',12,'MarkerFaceColor','b')    % 0.9mm WL10 Int, Vac Cham, 425
    errorbar(ANS(702:707,2),ANS(702:707,10),eANS(702:707,10),'bh','MarkerSize',12)%,'MarkerFaceColor','b')    % 0.9mm WL10 Int, Vac Cham, 425 Repeat

    errorbar(ANS(714:717,2),ANS(714:717,10),eANS(714:717,10),'mo','MarkerSize',12,'MarkerFaceColor','m')    % 1.5mm WL10 Int, Vac Cham, 30
    errorbar(ANS(708:713,2),ANS(708:713,10),eANS(708:713,10),'mh','MarkerSize',12,'MarkerFaceColor','m')    % 1.5mm WL10 Int, Vac Cham, 425
    
    errorbar(ANS(718:726,2),ANS(718:726,10),eANS(718:726,10),'yo','MarkerSize',12,'MarkerFaceColor','y')    % 0.5mm WL10 Int, Vac Cham, 30

%     errorbar(ANS(440:444,2),ANS(440:444,10),eANS(440:444,10),'ro','MarkerSize',12,'MarkerFaceColor','w')    % 0.9mm WL10, New RT
%     errorbar(ANS(434:439,2),ANS(434:439,10),eANS(434:439,10),'r^','MarkerSize',12,'MarkerFaceColor','w')    %                     100
%     errorbar(ANS(422:427,2),ANS(422:427,10),eANS(422:427,10),'rs','MarkerSize',12,'MarkerFaceColor','w')    %                     200
%     errorbar(ANS(428:433,2),ANS(428:433,10),eANS(428:433,10),'rd','MarkerSize',12,'MarkerFaceColor','w')    %                     300
%     errorbar(ANS(445:450,2),ANS(445:450,10),eANS(445:450,10),'rp','MarkerSize',12,'MarkerFaceColor','w')    %                     400
%     
%     errorbar(ANS(654:659,2),ANS(654:659,10),eANS(654:659,10),'ko','MarkerSize',12,'MarkerFaceColor','k')    % 1.25mm WL10 Flat, RT
%     errorbar(ANS([649:653,677],2),ANS([649:653,677],10),eANS([649:653,677],10),'k^','MarkerSize',12,'MarkerFaceColor','k')    %                     100
%     errorbar(ANS(660:665,2),ANS(660:665,10),eANS(660:665,10),'ks','MarkerSize',12,'MarkerFaceColor','k')    %                     200
%     errorbar(ANS(666:671,2),ANS(666:671,10),eANS(666:671,10),'kd','MarkerSize',12,'MarkerFaceColor','k')    %                     300
%     errorbar(ANS(672:676,2),ANS(672:676,10),eANS(672:676,10),'kv','MarkerSize',12,'MarkerFaceColor','k')    %                     400
%     errorbar(ANS(678:682,2),ANS(678:682,10),eANS(678:682,10),'kh','MarkerSize',12,'MarkerFaceColor','k')    %                     425
% %     legend('27 \circC','100 \circC','200 \circC','300 \circC','350 \circC','375 \circC','400 \circC','405 \circC','425 \circC','Location','Northwest')
    legend('27 \circC','100 \circC','200 \circC','300 \circC','400 \circC','400 \circC Repeat','425 \circC','425 \circC Repeat','Location','Northwest')
%     legend('300 \circC','400 \circC','Location','Northwest')
    set(gca,'FontSize',26,'FontName','Times New Roman'), box on; xlabel('\itRe'), ylabel('$$\overline{Nu}$$','Interpreter','latex'); hold off
%     axis([1e4 4e4 0 160])

    % K_L vs. Re
    figure(8)
    hold on
%     errorbar(ANS(347:351,2),ANS(347:351,15),eANS(347:351,15),'go','MarkerSize',12,'MarkerFaceColor','g')    % 0.9mm WL10, Flame, RT

%     errorbar(ANS(457:462,2),ANS(457:462,15),eANS(457:462,15),'rp','MarkerSize',12)%,'MarkerFaceColor','r')    %                     400
%     errorbar(hemj.wl9t300(:,2),hemj.wl9t300(:,15),hemj.wl9t300e(:,15),'kd','MarkerSize',12,'MarkerFaceColor','k')    % 0.9mm WL10 New, Repeat 300
%     errorbar(hemj.wl9t400(:,2),hemj.wl9t400(:,15),hemj.wl9t400e(:,15),'kp','MarkerSize',12,'MarkerFaceColor','k')    %                        400
%     errorbar(ANS(520:525,2),ANS(520:525,15),eANS(520:525,15),'kd','MarkerSize',12)%,'MarkerFaceColor','k')    % 0.9mm WL10 New, Repeat 2 300
%     errorbar(ANS(526:530,2),ANS(526:530,15),eANS(526:530,15),'kp','MarkerSize',12)%,'MarkerFaceColor','k')    %                          400
%     errorbar(ANS(590:597,2),ANS(590:597,15),eANS(590:597,15),'bo','MarkerSize',12,'MarkerFaceColor','b')    % 0.9mm WL10, Vacuum Chamber, RT
%     errorbar(ANS(595:599,2),ANS(595:599,15),eANS(595:599,15),'bs','MarkerSize',12,'MarkerFaceColor','b')    % 0.9mm WL10, Vacuum Chamber, RT
    errorbar(ANS(600:605,2),ANS(600:605,15),eANS(600:605,15),'bo','MarkerSize',12,'MarkerFaceColor','b')    % 0.9mm WL10 Int, Vac Cham, RT
    errorbar(ANS(624:629,2),ANS(624:629,15),eANS(624:629,15),'b^','MarkerSize',12,'MarkerFaceColor','b')    % 0.9mm WL10 Int, Vac Cham, 100
    errorbar(ANS(606:611,2),ANS(606:611,15),eANS(606:611,15),'bs','MarkerSize',12,'MarkerFaceColor','b')    % 0.9mm WL10 Int, Vac Cham, 200
    errorbar(ANS(612:617,2),ANS(612:617,15),eANS(612:617,15),'bd','MarkerSize',12,'MarkerFaceColor','b')    % 0.9mm WL10 Int, Vac Cham, 300
%     errorbar(ANS(630:635,2),ANS(630:635,15),eANS(630:635,15),'b<','MarkerSize',12,'MarkerFaceColor','b')    % 0.9mm WL10 Int, Vac Cham, 350
%     errorbar(ANS(642:647,2),ANS(642:647,15),eANS(642:647,15),'b>','MarkerSize',12,'MarkerFaceColor','b')    % 0.9mm WL10 Int, Vac Cham, 375
%     errorbar(ANS(618:623,2),ANS(618:623,15),eANS(618:623,15),'bv','MarkerSize',12,'MarkerFaceColor','b')    % 0.9mm WL10 Int, Vac Cham, 400
    errorbar(ANS(693:698,2),ANS(693:698,15),eANS(693:698,15),'rp','MarkerSize',12,'MarkerFaceColor','r')    % 0.9mm WL10 Int, Vac Cham, 400 Repeat
    errorbar(ANS(699:701,2),ANS(699:701,15),eANS(699:701,15),'gp','MarkerSize',12)%,'MarkerFaceColor','g')    % 0.9mm WL10 Int, Vac Cham, 400 Repeat

%     errorbar(ANS(683:688,2),ANS(683:688,15),eANS(683:688,15),'bv','MarkerSize',12,'MarkerFaceColor','b')    % 0.9mm WL10 Int, Vac Cham, 405
    errorbar(ANS(636:641,2),ANS(636:641,15),eANS(636:641,15),'bh','MarkerSize',12,'MarkerFaceColor','b')    % 0.9mm WL10 Int, Vac Cham, 425
    errorbar(ANS(702:707,2),ANS(702:707,15),eANS(702:707,15),'bh','MarkerSize',12)%,'MarkerFaceColor','b')    % 0.9mm WL10 Int, Vac Cham, 425 Repeat
        
    errorbar(ANS(714:717,2),ANS(714:717,15),eANS(714:717,15),'mo','MarkerSize',12,'MarkerFaceColor','m')    % 1.5mm WL10 Int, Vac Cham, 30
    errorbar(ANS(708:713,2),ANS(708:713,15),eANS(708:713,15),'mh','MarkerSize',12,'MarkerFaceColor','m')    % 1.5mm WL10 Int, Vac Cham, 425

%     errorbar(ANS(440:444,2),ANS(440:444,15),eANS(440:444,15),'ro','MarkerSize',12,'MarkerFaceColor','w')    % 0.9mm WL10, New RT
%     errorbar(ANS(434:439,2),ANS(434:439,15),eANS(434:439,15),'r^','MarkerSize',12,'MarkerFaceColor','w')    %                     100
%     errorbar(ANS(422:427,2),ANS(422:427,15),eANS(422:427,15),'rs','MarkerSize',12,'MarkerFaceColor','w')    %                     200
%     errorbar(ANS(428:433,2),ANS(428:433,15),eANS(428:433,15),'rd','MarkerSize',12,'MarkerFaceColor','w')    %                     300
%     errorbar(ANS(445:450,2),ANS(445:450,15),eANS(445:450,15),'rp','MarkerSize',12,'MarkerFaceColor','w')    %                     400
%     
%     errorbar(ANS(654:659,2),ANS(654:659,15),eANS(654:659,15),'ko','MarkerSize',12,'MarkerFaceColor','k')    % 1.25mm WL10 Flat, RT
%     errorbar(ANS([649:653,677],2),ANS([649:653,677],15),eANS([649:653,677],15),'k^','MarkerSize',12,'MarkerFaceColor','k')    %                     100
%     errorbar(ANS(660:665,2),ANS(660:665,15),eANS(660:665,15),'ks','MarkerSize',12,'MarkerFaceColor','k')    %                     200
%     errorbar(ANS(666:671,2),ANS(666:671,15),eANS(666:671,15),'kd','MarkerSize',12,'MarkerFaceColor','k')    %                     300
%     errorbar(ANS(672:676,2),ANS(672:676,15),eANS(672:676,15),'kv','MarkerSize',12,'MarkerFaceColor','k')    %                     400
%     errorbar(ANS(678:682,2),ANS(678:682,15),eANS(678:682,15),'kh','MarkerSize',12,'MarkerFaceColor','k')    %                     425
%     legend('27 \circC','100 \circC','200 \circC','300 \circC','350 \circC','375 \circC','400 \circC','405 \circC','425 \circC','Location','Northwest')
    legend('27 \circC','100 \circC','200 \circC','300 \circC','400 \circC','400 \circC Repeat','425 \circC','425 \circC Repeat','Location','Northwest')
%     legend('300 \circC','400 \circC','Location','Northwest')
    set(gca,'FontSize',26,'FontName','Times New Roman'), box on; xlabel('\itRe'), ylabel('{\itK_L}'); hold off
%     axis([1e4 5.5e4 1.5 2.4])    
end

for m=1:0
    figure(9)
    hold on
%     errorbar(ANS(347:351,2),ANS(347:351,12),eANS(347:351,12),'go','MarkerSize',12,'MarkerFaceColor','g')    % 0.9mm WL10, Flame, RT

%     errorbar(ANS(457:462,2),ANS(457:462,12),eANS(457:462,12),'rp','MarkerSize',12)%,'MarkerFaceColor','r')    %                      400
%     errorbar(hemj.wl9t300(:,2),hemj.wl9t300(:,12),hemj.wl9t300e(:,12),'kd','MarkerSize',12,'MarkerFaceColor','k')    % 0.9mm WL10 New, Repeat 300
%     errorbar(hemj.wl9t400(:,2),hemj.wl9t400(:,12),hemj.wl9t400e(:,12),'kp','MarkerSize',12,'MarkerFaceColor','k')    %                        400
%     errorbar(ANS(520:525,2),ANS(520:525,12),eANS(520:525,12),'kd','MarkerSize',12)%,'MarkerFaceColor','k')    % 0.9mm WL10 New, Repeat 2 300
%     errorbar(ANS(526:530,2),ANS(526:530,12),eANS(526:530,12),'kp','MarkerSize',12)%,'MarkerFaceColor','k')    %                          400
%     errorbar(ANS(590:597,2),ANS(590:597,12),eANS(590:597,12),'bo','MarkerSize',12,'MarkerFaceColor','b')    % 0.9mm WL10, Vacuum Chamber, RT
%     errorbar(ANS(595:599,2),ANS(595:599,12),eANS(595:599,12),'bs','MarkerSize',12,'MarkerFaceColor','b')    % 0.9mm WL10, Vacuum Chamber, RT
    errorbar(ANS(600:605,2),ANS(600:605,12),eANS(600:605,12),'bo','MarkerSize',12,'MarkerFaceColor','b')    % 0.9mm WL10 Int, Vac Cham, RT
    errorbar(ANS(624:629,2),ANS(624:629,12),eANS(624:629,12),'b^','MarkerSize',12,'MarkerFaceColor','b')    % 0.9mm WL10 Int, Vac Cham, 100
    errorbar(ANS(606:611,2),ANS(606:611,12),eANS(606:611,12),'bs','MarkerSize',12,'MarkerFaceColor','b')    % 0.9mm WL10 Int, Vac Cham, 200
    errorbar(ANS(612:617,2),ANS(612:617,12),eANS(612:617,12),'bd','MarkerSize',12,'MarkerFaceColor','b')    % 0.9mm WL10 Int, Vac Cham, 300
    errorbar(ANS(630:635,2),ANS(630:635,12),eANS(630:635,12),'b<','MarkerSize',12,'MarkerFaceColor','b')    % 0.9mm WL10 Int, Vac Cham, 350
    errorbar(ANS(642:647,2),ANS(642:647,12),eANS(642:647,12),'b>','MarkerSize',12,'MarkerFaceColor','b')    % 0.9mm WL10 Int, Vac Cham, 375
    errorbar(ANS(618:623,2),ANS(618:623,12),eANS(618:623,12),'bv','MarkerSize',12,'MarkerFaceColor','b')    % 0.9mm WL10 Int, Vac Cham, 400
    errorbar(ANS(683:688,2),ANS(683:688,12),eANS(683:688,12),'bp','MarkerSize',12,'MarkerFaceColor','w')    % 0.9mm WL10 Int, Vac Cham, 405
    errorbar(ANS(636:641,2),ANS(636:641,12),eANS(636:641,12),'bh','MarkerSize',12,'MarkerFaceColor','b')    % 0.9mm WL10 Int, Vac Cham, 425    
    errorbar(ANS(693:698,2),ANS(693:698,12),eANS(693:698,12),'rv','MarkerSize',12,'MarkerFaceColor','r')    % 0.9mm WL10 Int, Vac Cham, 400 Repeat
    
%     errorbar(ANS(440:444,2),ANS(440:444,12),eANS(440:444,12),'ro','MarkerSize',12,'MarkerFaceColor','w')    % 0.9mm WL10, New RT
%     errorbar(ANS(434:439,2),ANS(434:439,12),eANS(434:439,12),'r^','MarkerSize',12,'MarkerFaceColor','w')    %                     100
%     errorbar(ANS(422:427,2),ANS(422:427,12),eANS(422:427,12),'rs','MarkerSize',12,'MarkerFaceColor','w')    %                     200
%     errorbar(ANS(428:433,2),ANS(428:433,12),eANS(428:433,12),'rd','MarkerSize',12,'MarkerFaceColor','w')    %                     300
%     errorbar(ANS(445:450,2),ANS(445:450,12),eANS(445:450,12),'rp','MarkerSize',12,'MarkerFaceColor','w')    %                     400
    
    errorbar(ANS(654:659,2),ANS(654:659,12),eANS(654:659,12),'ko','MarkerSize',12,'MarkerFaceColor','k')    % 1.25mm WL10 Flat, RT
    errorbar(ANS([649:653,677],2),ANS([649:653,677],12),eANS([649:653,677],12),'k^','MarkerSize',12,'MarkerFaceColor','k')    %                     100
    errorbar(ANS(660:665,2),ANS(660:665,12),eANS(660:665,12),'ks','MarkerSize',12,'MarkerFaceColor','k')    %                     200
    errorbar(ANS(666:671,2),ANS(666:671,12),eANS(666:671,12),'kd','MarkerSize',12,'MarkerFaceColor','k')    %                     300
    errorbar(ANS(672:676,2),ANS(672:676,12),eANS(672:676,12),'kp','MarkerSize',12,'MarkerFaceColor','k')    %                     400
    errorbar(ANS(678:682,2),ANS(678:682,12),eANS(678:682,12),'kh','MarkerSize',12,'MarkerFaceColor','k')    %                     425
%     fplot(@(x)0.085*x^0.59,[0.5e4 5e4],'-k')                         % Latest Correlation c.2014-15
%     fplot(@(x)(0.085*x^0.59)*.9,[0.5e4 5e4],'--k')
%     fplot(@(x)(0.085*x^0.59)*1.1,[0.5e4 5e4],'--k')
    fplot(@(x)0.04543*x^0.6667,[0.5e4 5e4],'-k')                         % New Correlation c.2017
    fplot(@(x)(0.04543*x^0.6667)*.9,[0.5e4 5e4],'--k')
    fplot(@(x)(0.04543*x^0.6667)*1.1,[0.5e4 5e4],'--k')
    legend('27 \circC','100 \circC','200 \circC','300 \circC','350 \circC','375 \circC','400 \circC','405 \circC','425 \circC','Location','Northwest')
%     legend('300 \circC','400 \circC','Location','Northwest')
    set(gca,'FontSize',26), box on; xlabel('\itRe','FontSize',26), ylabel('{\itNu\kappa^{-0.19}}','FontSize',26); hold off
    axis([1e4 5e4 10 70])

end

%% Plots (2018)

for m=1:1
   % Pure Nu vs. Re
    figure(7)
    hold on
%     errorbar(ANS(347:351,2),ANS(347:351,10),eANS(347:351,10),'go','MarkerSize',12,'MarkerFaceColor','g')    % 0.9mm WL10, Flame, RT

%     errorbar(ANS(457:462,2),ANS(457:462,10),eANS(457:462,10),'rp','MarkerSize',12)%,'MarkerFaceColor','r')    %                      400
%     errorbar(hemj.wl9t300(:,2),hemj.wl9t300(:,10),hemj.wl9t300e(:,10),'kd','MarkerSize',12,'MarkerFaceColor','k')    % 0.9mm WL10 New, Repeat 300
%     errorbar(hemj.wl9t400(:,2),hemj.wl9t400(:,10),hemj.wl9t400e(:,10),'kp','MarkerSize',12,'MarkerFaceColor','k')    %                        400
%     errorbar(ANS(520:525,2),ANS(520:525,10),eANS(520:525,10),'kd','MarkerSize',12)%,'MarkerFaceColor','k')    % 0.9mm WL10 New, Repeat 2 300
%     errorbar(ANS(526:530,2),ANS(526:530,10),eANS(526:530,10),'kp','MarkerSize',12)%,'MarkerFaceColor','k')    %                          400
%     errorbar(ANS(590:597,2),ANS(590:597,10),eANS(590:597,10),'bo','MarkerSize',12,'MarkerFaceColor','b')    % 0.9mm WL10, Vacuum Chamber, RT
%     errorbar(ANS(595:599,2),ANS(595:599,10),eANS(595:599,10),'bs','MarkerSize',12,'MarkerFaceColor','b')    % 0.9mm WL10, Vacuum Chamber, RT
    errorbar(ANS(600:605,2),ANS(600:605,10),eANS(600:605,10),'bo','MarkerSize',12,'MarkerFaceColor','b')    % 0.9mm WL10 Int, Vac Cham, RT
    errorbar(ANS(624:629,2),ANS(624:629,10),eANS(624:629,10),'b^','MarkerSize',12,'MarkerFaceColor','b')    % 0.9mm WL10 Int, Vac Cham, 100
    errorbar(ANS(606:611,2),ANS(606:611,10),eANS(606:611,10),'bs','MarkerSize',12,'MarkerFaceColor','b')    % 0.9mm WL10 Int, Vac Cham, 200
    errorbar(ANS(612:617,2),ANS(612:617,10),eANS(612:617,10),'bd','MarkerSize',12,'MarkerFaceColor','b')    % 0.9mm WL10 Int, Vac Cham, 300
%     errorbar(ANS(630:635,2),ANS(630:635,10),eANS(630:635,10),'b<','MarkerSize',12,'MarkerFaceColor','b')    % 0.9mm WL10 Int, Vac Cham, 350
%     errorbar(ANS(642:647,2),ANS(642:647,10),eANS(642:647,10),'b>','MarkerSize',12,'MarkerFaceColor','b')    % 0.9mm WL10 Int, Vac Cham, 375
%     errorbar(ANS(618:623,2),ANS(618:623,10),eANS(618:623,10),'bp','MarkerSize',12,'MarkerFaceColor','b')    % 0.9mm WL10 Int, Vac Cham, 400
%     errorbar(ANS(689,2),ANS(689,10),eANS(689,10),'bp','MarkerSize',12,'MarkerFaceColor','b')    % 0.9mm WL10 Int, Vac Cham, 400
%     errorbar(ANS(693:698,2),ANS(693:698,10),eANS(693:698,10),'rp','MarkerSize',12,'MarkerFaceColor','r')    % 0.9mm WL10 Int, Vac Cham, 400 Repeat
    errorbar(ANS(699:701,2),ANS(699:701,10),eANS(699:701,10),'bp','MarkerSize',12,'MarkerFaceColor','b')    % 0.9mm WL10 Int, Vac Cham, 400 Repeat

%     errorbar(ANS(683:688,2),ANS(683:688,10),eANS(683:688,10),'bv','MarkerSize',12,'MarkerFaceColor','b')    % 0.9mm WL10 Int, Vac Cham, 405
%     errorbar(ANS(636:641,2),ANS(636:641,10),eANS(636:641,10),'bh','MarkerSize',12,'MarkerFaceColor','b')    % 0.9mm WL10 Int, Vac Cham, 425
%     errorbar(ANS(702:707,2),ANS(702:707,10),eANS(702:707,10),'bh','MarkerSize',12)%,'MarkerFaceColor','b')    % 0.9mm WL10 Int, Vac Cham, 425 Repeat

%     errorbar(ANS(714:717,2),ANS(714:717,10),eANS(714:717,10),'mo','MarkerSize',12,'MarkerFaceColor','m')    % 1.5mm WL10 Int, Vac Cham, 30
%     errorbar(ANS(708:713,2),ANS(708:713,10),eANS(708:713,10),'mh','MarkerSize',12,'MarkerFaceColor','m')    % 1.5mm WL10 Int, Vac Cham, 425
%     
%     errorbar(ANS(718:726,2),ANS(718:726,10),eANS(718:726,10),'yo','MarkerSize',12,'MarkerFaceColor','y')    % 0.5mm WL10 Int, Vac Cham, 30

%     errorbar(ANS(440:444,2),ANS(440:444,10),eANS(440:444,10),'ro','MarkerSize',12,'MarkerFaceColor','w')    % 0.9mm WL10, New RT
%     errorbar(ANS(434:439,2),ANS(434:439,10),eANS(434:439,10),'r^','MarkerSize',12,'MarkerFaceColor','w')    %                     100
%     errorbar(ANS(422:427,2),ANS(422:427,10),eANS(422:427,10),'rs','MarkerSize',12,'MarkerFaceColor','w')    %                     200
%     errorbar(ANS(428:433,2),ANS(428:433,10),eANS(428:433,10),'rd','MarkerSize',12,'MarkerFaceColor','w')    %                     300
%     errorbar(ANS(445:450,2),ANS(445:450,10),eANS(445:450,10),'rp','MarkerSize',12,'MarkerFaceColor','w')    %                     400
%     
%     errorbar(ANS(654:659,2),ANS(654:659,10),eANS(654:659,10),'ko','MarkerSize',12,'MarkerFaceColor','k')    % 1.25mm WL10 Flat, RT
%     errorbar(ANS([649:653,677],2),ANS([649:653,677],10),eANS([649:653,677],10),'k^','MarkerSize',12,'MarkerFaceColor','k')    %                     100
%     errorbar(ANS(660:665,2),ANS(660:665,10),eANS(660:665,10),'ks','MarkerSize',12,'MarkerFaceColor','k')    %                     200
%     errorbar(ANS(666:671,2),ANS(666:671,10),eANS(666:671,10),'kd','MarkerSize',12,'MarkerFaceColor','k')    %                     300
%     errorbar(ANS(672:676,2),ANS(672:676,10),eANS(672:676,10),'kv','MarkerSize',12,'MarkerFaceColor','k')    %                     400
%     errorbar(ANS(678:682,2),ANS(678:682,10),eANS(678:682,10),'kh','MarkerSize',12,'MarkerFaceColor','k')    %                     425
%     errorbar(ANS(736:741,2),ANS(736:741,10),eANS(736:741,10),'bo','MarkerSize',12,'MarkerFaceColor','g','MarkerEdgeColor','g','Color','g')    % 0.9mm WL10 Int, Vac Cham, RT
%     errorbar(ANS(742:747,2),ANS(742:747,10),eANS(742:747,10),'bo','MarkerSize',12,'MarkerFaceColor','r','MarkerEdgeColor','r','Color','r')    % 0.9mm WL10 Int, Glass Vac Cham, RT
%     errorbar(ANS(748:748,2),ANS(748:748,10),eANS(748:748,10),'bo','MarkerSize',12,'MarkerFaceColor','c','MarkerEdgeColor','c','Color','c')    % 0.9mm WL10 Int, Glass Vac Cham, RT
%     errorbar(ANS(750:752,2),ANS(750:752,10),eANS(750:752,10),'bo','MarkerSize',12,'MarkerEdgeColor','k','Color','k')    % 0.9mm WL10 Int, Glass Vac Cham, RT
    errorbar(ANS(753,2),ANS(753,10),eANS(753,10),'bo','MarkerSize',12,'MarkerEdgeColor','m','Color','m')    % 0.9mm WL10 REVERSED HEAT FLUX
%     legend('27 \circC','100 \circC','200 \circC','300 \circC','350 \circC','375 \circC','400 \circC','405 \circC','425 \circC','Location','Northwest')
%     legend('27 \circC','100 \circC','200 \circC','300 \circC','400 \circC','400 \circC Repeat','425 \circC','425 \circC Repeat','f','as','27 \circC','Location','Northwest')
    legend('27 \circC','100 \circC','200 \circC','300 \circC','400 \circC','RevHF 200 \circC','Location','Northwest')
%     legend('300 \circC','400 \circC','Location','Northwest')
    set(gca,'FontSize',26,'FontName','Times New Roman'), box on; xlabel('\itRe'), ylabel('$$\overline{Nu}$$','Interpreter','latex'); hold off
%     axis([1e4 4e4 0 160])

    % K_L vs. Re
    figure(8)
    hold on
%     errorbar(ANS(347:351,2),ANS(347:351,15),eANS(347:351,15),'go','MarkerSize',12,'MarkerFaceColor','g')    % 0.9mm WL10, Flame, RT

%     errorbar(ANS(457:462,2),ANS(457:462,15),eANS(457:462,15),'rp','MarkerSize',12)%,'MarkerFaceColor','r')    %                     400
%     errorbar(hemj.wl9t300(:,2),hemj.wl9t300(:,15),hemj.wl9t300e(:,15),'kd','MarkerSize',12,'MarkerFaceColor','k')    % 0.9mm WL10 New, Repeat 300
%     errorbar(hemj.wl9t400(:,2),hemj.wl9t400(:,15),hemj.wl9t400e(:,15),'kp','MarkerSize',12,'MarkerFaceColor','k')    %                        400
%     errorbar(ANS(520:525,2),ANS(520:525,15),eANS(520:525,15),'kd','MarkerSize',12)%,'MarkerFaceColor','k')    % 0.9mm WL10 New, Repeat 2 300
%     errorbar(ANS(526:530,2),ANS(526:530,15),eANS(526:530,15),'kp','MarkerSize',12)%,'MarkerFaceColor','k')    %                          400
%     errorbar(ANS(590:597,2),ANS(590:597,15),eANS(590:597,15),'bo','MarkerSize',12,'MarkerFaceColor','b')    % 0.9mm WL10, Vacuum Chamber, RT
%     errorbar(ANS(595:599,2),ANS(595:599,15),eANS(595:599,15),'bs','MarkerSize',12,'MarkerFaceColor','b')    % 0.9mm WL10, Vacuum Chamber, RT
    errorbar(ANS(600:605,2),ANS(600:605,15),eANS(600:605,15),'bo','MarkerSize',12,'MarkerFaceColor','b')    % 0.9mm WL10 Int, Vac Cham, RT
    errorbar(ANS(624:629,2),ANS(624:629,15),eANS(624:629,15),'b^','MarkerSize',12,'MarkerFaceColor','b')    % 0.9mm WL10 Int, Vac Cham, 100
    errorbar(ANS(606:611,2),ANS(606:611,15),eANS(606:611,15),'bs','MarkerSize',12,'MarkerFaceColor','b')    % 0.9mm WL10 Int, Vac Cham, 200
    errorbar(ANS(612:617,2),ANS(612:617,15),eANS(612:617,15),'bd','MarkerSize',12,'MarkerFaceColor','b')    % 0.9mm WL10 Int, Vac Cham, 300
%     errorbar(ANS(630:635,2),ANS(630:635,15),eANS(630:635,15),'b<','MarkerSize',12,'MarkerFaceColor','b')    % 0.9mm WL10 Int, Vac Cham, 350
%     errorbar(ANS(642:647,2),ANS(642:647,15),eANS(642:647,15),'b>','MarkerSize',12,'MarkerFaceColor','b')    % 0.9mm WL10 Int, Vac Cham, 375
%     errorbar(ANS(618:623,2),ANS(618:623,15),eANS(618:623,15),'bv','MarkerSize',12,'MarkerFaceColor','b')    % 0.9mm WL10 Int, Vac Cham, 400
%     errorbar(ANS(693:698,2),ANS(693:698,15),eANS(693:698,15),'rp','MarkerSize',12,'MarkerFaceColor','r')    % 0.9mm WL10 Int, Vac Cham, 400 Repeat
    errorbar(ANS(699:701,2),ANS(699:701,15),eANS(699:701,15),'bp','MarkerSize',12,'MarkerFaceColor','b')    % 0.9mm WL10 Int, Vac Cham, 400 Repeat

%     errorbar(ANS(683:688,2),ANS(683:688,15),eANS(683:688,15),'bv','MarkerSize',12,'MarkerFaceColor','b')    % 0.9mm WL10 Int, Vac Cham, 405
%     errorbar(ANS(636:641,2),ANS(636:641,15),eANS(636:641,15),'bh','MarkerSize',12,'MarkerFaceColor','b')    % 0.9mm WL10 Int, Vac Cham, 425
%     errorbar(ANS(702:707,2),ANS(702:707,15),eANS(702:707,15),'bh','MarkerSize',12)%,'MarkerFaceColor','b')    % 0.9mm WL10 Int, Vac Cham, 425 Repeat
%         
%     errorbar(ANS(714:717,2),ANS(714:717,15),eANS(714:717,15),'mo','MarkerSize',12,'MarkerFaceColor','m')    % 1.5mm WL10 Int, Vac Cham, 30
%     errorbar(ANS(708:713,2),ANS(708:713,15),eANS(708:713,15),'mh','MarkerSize',12,'MarkerFaceColor','m')    % 1.5mm WL10 Int, Vac Cham, 425

%     errorbar(ANS(440:444,2),ANS(440:444,15),eANS(440:444,15),'ro','MarkerSize',12,'MarkerFaceColor','w')    % 0.9mm WL10, New RT
%     errorbar(ANS(434:439,2),ANS(434:439,15),eANS(434:439,15),'r^','MarkerSize',12,'MarkerFaceColor','w')    %                     100
%     errorbar(ANS(422:427,2),ANS(422:427,15),eANS(422:427,15),'rs','MarkerSize',12,'MarkerFaceColor','w')    %                     200
%     errorbar(ANS(428:433,2),ANS(428:433,15),eANS(428:433,15),'rd','MarkerSize',12,'MarkerFaceColor','w')    %                     300
%     errorbar(ANS(445:450,2),ANS(445:450,15),eANS(445:450,15),'rp','MarkerSize',12,'MarkerFaceColor','w')    %                     400
    
%     
%     errorbar(ANS(654:659,2),ANS(654:659,15),eANS(654:659,15),'ko','MarkerSize',12,'MarkerFaceColor','k')    % 1.25mm WL10 Flat, RT
%     errorbar(ANS([649:653,677],2),ANS([649:653,677],15),eANS([649:653,677],15),'k^','MarkerSize',12,'MarkerFaceColor','k')    %                     100
%     errorbar(ANS(660:665,2),ANS(660:665,15),eANS(660:665,15),'ks','MarkerSize',12,'MarkerFaceColor','k')    %                     200
%     errorbar(ANS(666:671,2),ANS(666:671,15),eANS(666:671,15),'kd','MarkerSize',12,'MarkerFaceColor','k')    %                     300
%     errorbar(ANS(672:676,2),ANS(672:676,15),eANS(672:676,15),'kv','MarkerSize',12,'MarkerFaceColor','k')    %                     400
%     errorbar(ANS(678:682,2),ANS(678:682,15),eANS(678:682,15),'kh','MarkerSize',12,'MarkerFaceColor','k')    %                     425
%       errorbar(ANS(736:741,2),ANS(736:741,15),eANS(736:741,15),'bo','MarkerSize',12,'MarkerFaceColor','g','MarkerEdgeColor','g','Color','g')    % 0.9mm WL10 Int, Glass Vac Cham, RT
%       errorbar(ANS(742:747,2),ANS(742:747,15),eANS(742:747,15),'bo','MarkerSize',12,'MarkerFaceColor','r','MarkerEdgeColor','r','Color','r')    % 0.9mm WL10 Int, Glass Vac Cham, RT
%       errorbar(ANS(750:752,2),ANS(750:752,15),eANS(750:752,15),'bo','MarkerSize',12,'MarkerEdgeColor','k','Color','k')    % 0.9mm WL10 Int, Glass Vac Cham, RT      
      errorbar(ANS(753,2),ANS(753,15),eANS(753,15),'bo','MarkerSize',12,'MarkerEdgeColor','m','Color','m')    % 0.9mm WL10 REVERSED HEAT FLUX     
      
%     legend('27 \circC','100 \circC','200 \circC','300 \circC','350 \circC','375 \circC','400 \circC','405 \circC','425 \circC','Location','Northwest')
    legend('27 \circC','100 \circC','200 \circC','300 \circC','400 \circC','RevHF 200 \circC','Location','Northwest')
%     legend('300 \circC','400 \circC','Location','Northwest')
    set(gca,'FontSize',26,'FontName','Times New Roman'), box on; xlabel('\itRe'), ylabel('{\itK_L}'); hold off
%     axis([1e4 5.5e4 1.5 2.4])    
end

for m=1:1
    figure(10)
    hold on
%     errorbar(ANS(347:351,2),ANS(347:351,12),eANS(347:351,12),'go','MarkerSize',12,'MarkerFaceColor','g')    % 0.9mm WL10, Flame, RT

%     errorbar(ANS(457:462,2),ANS(457:462,12),eANS(457:462,12),'rp','MarkerSize',12)%,'MarkerFaceColor','r')    %                      400
%     errorbar(hemj.wl9t300(:,2),hemj.wl9t300(:,12),hemj.wl9t300e(:,12),'kd','MarkerSize',12,'MarkerFaceColor','k')    % 0.9mm WL10 New, Repeat 300
%     errorbar(hemj.wl9t400(:,2),hemj.wl9t400(:,12),hemj.wl9t400e(:,12),'kp','MarkerSize',12,'MarkerFaceColor','k')    %                        400
%     errorbar(ANS(520:525,2),ANS(520:525,12),eANS(520:525,12),'kd','MarkerSize',12)%,'MarkerFaceColor','k')    % 0.9mm WL10 New, Repeat 2 300
%     errorbar(ANS(526:530,2),ANS(526:530,12),eANS(526:530,12),'kp','MarkerSize',12)%,'MarkerFaceColor','k')    %                          400
%     errorbar(ANS(590:597,2),ANS(590:597,12),eANS(590:597,12),'bo','MarkerSize',12,'MarkerFaceColor','b')    % 0.9mm WL10, Vacuum Chamber, RT
%     errorbar(ANS(595:599,2),ANS(595:599,12),eANS(595:599,12),'bs','MarkerSize',12,'MarkerFaceColor','b')    % 0.9mm WL10, Vacuum Chamber, RT
    errorbar(ANS(600:605,2),ANS(600:605,12),eANS(600:605,12),'bo','MarkerSize',12,'MarkerFaceColor','b')    % 0.9mm WL10 Int, Vac Cham, RT
    errorbar(ANS(624:629,2),ANS(624:629,12),eANS(624:629,12),'b^','MarkerSize',12,'MarkerFaceColor','b')    % 0.9mm WL10 Int, Vac Cham, 100
    errorbar(ANS(606:611,2),ANS(606:611,12),eANS(606:611,12),'bs','MarkerSize',12,'MarkerFaceColor','b')    % 0.9mm WL10 Int, Vac Cham, 200
    errorbar(ANS(612:617,2),ANS(612:617,12),eANS(612:617,12),'bd','MarkerSize',12,'MarkerFaceColor','b')    % 0.9mm WL10 Int, Vac Cham, 300
%     errorbar(ANS(630:635,2),ANS(630:635,12),eANS(630:635,12),'b<','MarkerSize',12,'MarkerFaceColor','b')    % 0.9mm WL10 Int, Vac Cham, 350
%     errorbar(ANS(642:647,2),ANS(642:647,12),eANS(642:647,12),'b>','MarkerSize',12,'MarkerFaceColor','b')    % 0.9mm WL10 Int, Vac Cham, 375
%     errorbar(ANS(618:623,2),ANS(618:623,12),eANS(618:623,12),'bv','MarkerSize',12,'MarkerFaceColor','b')    % 0.9mm WL10 Int, Vac Cham, 400
%     errorbar(ANS(683:688,2),ANS(683:688,12),eANS(683:688,12),'bp','MarkerSize',12,'MarkerFaceColor','w')    % 0.9mm WL10 Int, Vac Cham, 405
%     errorbar(ANS(636:641,2),ANS(636:641,12),eANS(636:641,12),'bh','MarkerSize',12,'MarkerFaceColor','b')    % 0.9mm WL10 Int, Vac Cham, 425    
%     errorbar(ANS(693:698,2),ANS(693:698,12),eANS(693:698,12),'bp','MarkerSize',12,'MarkerFaceColor','b')    % 0.9mm WL10 Int, Vac Cham, 400 Repeat
    errorbar(ANS(699:701,2),ANS(699:701,12),eANS(699:701,12),'bp','MarkerSize',12,'MarkerFaceColor','b')    % 0.9mm WL10 Int, Vac Cham, 400 Repeat
    
%     errorbar(ANS(440:444,2),ANS(440:444,12),eANS(440:444,12),'ro','MarkerSize',12,'MarkerFaceColor','w')    % 0.9mm WL10, New RT
%     errorbar(ANS(434:439,2),ANS(434:439,12),eANS(434:439,12),'r^','MarkerSize',12,'MarkerFaceColor','w')    %                     100
%     errorbar(ANS(422:427,2),ANS(422:427,12),eANS(422:427,12),'rs','MarkerSize',12,'MarkerFaceColor','w')    %                     200
%     errorbar(ANS(428:433,2),ANS(428:433,12),eANS(428:433,12),'rd','MarkerSize',12,'MarkerFaceColor','w')    %                     300
%     errorbar(ANS(445:450,2),ANS(445:450,12),eANS(445:450,12),'rp','MarkerSize',12,'MarkerFaceColor','w')    %                     400
    
%     errorbar(ANS(654:659,2),ANS(654:659,12),eANS(654:659,12),'ko','MarkerSize',12,'MarkerFaceColor','k')    % 1.25mm WL10 Flat, RT
%     errorbar(ANS([649:653,677],2),ANS([649:653,677],12),eANS([649:653,677],12),'k^','MarkerSize',12,'MarkerFaceColor','k')    %                     100
%     errorbar(ANS(660:665,2),ANS(660:665,12),eANS(660:665,12),'ks','MarkerSize',12,'MarkerFaceColor','k')    %                     200
%     errorbar(ANS(666:671,2),ANS(666:671,12),eANS(666:671,12),'kd','MarkerSize',12,'MarkerFaceColor','k')    %                     300
%     errorbar(ANS(672:676,2),ANS(672:676,12),eANS(672:676,12),'kp','MarkerSize',12,'MarkerFaceColor','k')    %                     400
%     errorbar(ANS(678:682,2),ANS(678:682,12),eANS(678:682,12),'kh','MarkerSize',12,'MarkerFaceColor','k')    %                     425
%      errorbar(ANS(736:741,2),ANS(736:741,12),eANS(736:741,12),'bo','MarkerSize',12,'MarkerFaceColor','g','MarkerEdgeColor','g','Color','g')    % 0.9mm WL10 Int, Glass Vac Cham, RT
%      errorbar(ANS(742:747,2),ANS(742:747,12),eANS(742:747,12),'bo','MarkerSize',12,'MarkerFaceColor','r','MarkerEdgeColor','r','Color','r')    % 0.9mm WL10 Int, Glass Vac Cham, RT    
%      errorbar(ANS(750:752,2),ANS(750:752,12),eANS(750:752,12),'bo','MarkerSize',12,'MarkerEdgeColor','k','Color','k')    % 0.9mm WL10 Int, Glass Vac Cham, RT    
      errorbar(ANS(753,2),ANS(753,12),eANS(753,12),'bo','MarkerSize',12,'MarkerEdgeColor','m','Color','m')    % 0.9mm WL10 REVERSED HEAT FLUX   
%     fplot(@(x)0.085*x^0.59,[0.5e4 5e4],'-k')                         % Latest Correlation c.2014-15
%     fplot(@(x)(0.085*x^0.59)*.9,[0.5e4 5e4],'--k')
%     fplot(@(x)(0.085*x^0.59)*1.1,[0.5e4 5e4],'--k')
    fplot(@(x)0.04543*x^0.6667,[0.5e4 5e4],'-k')                         % New Correlation c.2017
    fplot(@(x)(0.04543*x^0.6667)*.9,[0.5e4 5e4],'--k')
    fplot(@(x)(0.04543*x^0.6667)*1.1,[0.5e4 5e4],'--k')
    legend('27 \circC','100 \circC','200 \circC','300 \circC','400 \circC','RevHF 200 \circC','Location','Northwest')
%     legend('300 \circC','400 \circC','Location','Northwest')
    set(gca,'FontSize',26), box on; xlabel('\itRe','FontSize',26), ylabel('{\itNu\kappa^{-0.19}}','FontSize',26); hold off
    axis([1e4 5e4 10 70])

end

%% Correlation fitting (2020)
fitRange = [780:791,798:857];               % Specify data range to fit
%fitRange = [780:791,804:809,822:827,846:857];               % Ti=300-400 C only
%fitRange = [422:450];                       % Test case (Bailey's old HEMJ correlation - Open)
%fitRange = [600:617,624:629,696:707];       % Test case (Bailey's new HEMJ correlation - Sealed chamber)
%fitRange = [649:669,672,682];               % Test case (Bailey's Flat correlation)

fitReval = zeros(1,size(fitRange,2));
fitNuval = zeros(1,size(fitRange,2));
fitKval = zeros(1,size(fitRange,2));
fitNuKval = zeros(1,size(fitRange,2));

for i=1:size(fitRange,2)
    fitReval(i) = ANS(fitRange(i),2);        % Store Re values within the range
    fitNuval(i) = ANS(fitRange(i),10);       % Store Nu values within the range
    fitKval(i) = ANS(fitRange(i),11);       % Store Kappa values within the range
    fitNuKval(i) = ANS(fitRange(i),12);     % Store Nu*Kappa^-0.19 values within the range
end
% enter 'cftool' on command line
plot(fitReval,fitNuKval);
plot(fitReval,fitNuval);
    
    