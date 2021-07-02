%% Initializations
clc, clear, close all

% Ph.D. Research
% Calculations for He-Cooled, HEMJ Divertor Extrapolations
% By: Brantley Mills
% Updated by: Bailey Zhao (09/2017)
% Updated by: Daniel Lee (09/2020)

% How to use (by DL)
%1.Change Ti (600/700C) from this block
%2.Change correlation and avg K_L from 'HEMJEX2.m' function file and save
%3.Run each block from this file. Last block will output a figure
% On the figure dialog, click on T_S(black) line and find a point
%that shows X:2.2e+04. This is Re_P. Y value on that point is q"max
% From that point, interpolate the distance between neighboring beta curves
%to find required beta.


%#ok<*AGROW>
%#ok<*FNDSB>
%#ok<*USENS>
%#ok<*NBRAK>
%#ok<*NOPTS>
Main='Q:\HEMJ Data Processing\Programs';
BaseData='Q:\HEMJ Data Processing\Programs\Database';

% Loading Constants, Data, 
cd(BaseData);
load LoopConstants
load LoopData
load GASPROPTABLE3
cd(Main);

Ti=600+273.15;      % K (change this value to desired He inlet temperature)

%% Extrapolating Performance

tic
LWA=.001;           % m (Thickness of W-alloy pressure boundary)
Pi=10e6;            % Pa
ReLOW=1e4;          % Lowest reynolds number to test
ReSTEP=5e2;
ReHIGH=5e4;         % Highest reynolds number to test
qppMIN=5e4;
qppSTEP=5e4;
qppMAX=3e7;


for m=1:1 % MJ = Multi-Jet
    [MJ.qpp MJ.Re MJ.Tin MJ.Pin MJ.mdot MJ.Tout MJ.hact MJ.eta MJ.heff MJ.Tc MJ.Tpb MJ.dP MJ.Wpump MJ.beta]=...
        HEMJEX2(ReLOW,ReSTEP,ReHIGH,qppMIN,qppSTEP,qppMAX,Ti,Pi,LWA,Main,BaseData);
%         baref=toc
    toc

    cd(BaseData);
    if Ti==600+273.15
        save AHF6HEMJ MJ                % Naming - A; HF = Heat Flux; # = Ti x 0.01; etc..
    elseif Ti==700+273.15
        save AHF7HEMJ MJ
    end
    cd(Main);
end % Extrapolating values at each Re and q"

%% Finding and Creating Relevant Vectors for Plots

tic

cd(BaseData);
if Ti==600+273.15
    load AHF6HEMJ MJ                % Naming - A; HF = Heat Flux; # = Ti x 0.01; etc..
elseif Ti==700+273.15
    load AHF7HEMJ MJ
end
cd(Main);

% Naming - Case y x Constant axis
for m=1:1

Re1=2.14e4;
Re2=3.14e4;
Re3=4.14e4;
Tpb1=1100+273.15;
Tpb2=1200+273.15;
Tpb3=1300+273.15;
beta5=.2;
beta4=.15;
beta3=.10;
beta2=.05;
beta1=.03;
Tout1=650+273.15;
Tout2=700+273.15;
Tout3=750+273.15;


for i=1:size(MJ.Tpb,2)
    
    % Bare Forward
    for j=1:size(MJ.Tpb,1)
        if j~=size(MJ.Tpb,1) && MJ.Tpb(j,i)<Tpb1 && MJ.Tpb(j+1,i)>Tpb1, MJ.V.qppReTpb1100y(i)=MJ.qpp(j+1,i); MJ.V.qppReTpb1100x(i)=MJ.Re(j+1,i); MJ.V.betaReTpb1100y(i)=MJ.beta(j+1,i); MJ.V.betaReTpb1100x(i)=MJ.Re(j+1,i); end
        if j~=size(MJ.Tpb,1) && MJ.Tpb(j,i)<Tpb2 && MJ.Tpb(j+1,i)>Tpb2, MJ.V.qppReTpb1200y(i)=MJ.qpp(j+1,i); MJ.V.qppReTpb1200x(i)=MJ.Re(j+1,i); MJ.V.betaReTpb1200y(i)=MJ.beta(j+1,i); MJ.V.betaReTpb1200x(i)=MJ.Re(j+1,i); end
        if j~=size(MJ.Tpb,1) && MJ.Tpb(j,i)<Tpb3 && MJ.Tpb(j+1,i)>Tpb3, MJ.V.qppReTpb1300y(i)=MJ.qpp(j+1,i); MJ.V.qppReTpb1300x(i)=MJ.Re(j+1,i); MJ.V.betaReTpb1300y(i)=MJ.beta(j+1,i); MJ.V.betaReTpb1300x(i)=MJ.Re(j+1,i); break, end
    end
    for k=1:size(MJ.Tpb,1)
        if MJ.beta(j,i)>beta5, MJ.V.qppRebeta20y(i)=NaN; MJ.V.qppRebeta20x(i)=MJ.Re(k,i); elseif MJ.beta(k,i)>beta5 && MJ.beta(k+1,i)<=beta5,  MJ.V.qppRebeta20y(i)=MJ.qpp(k+1,i); MJ.V.qppRebeta20x(i)=MJ.Re(k,i); end
        if MJ.beta(j,i)>beta4, MJ.V.qppRebeta15y(i)=NaN; MJ.V.qppRebeta15x(i)=MJ.Re(k,i); elseif MJ.beta(k,i)>beta4 && MJ.beta(k+1,i)<=beta4,  MJ.V.qppRebeta15y(i)=MJ.qpp(k+1,i); MJ.V.qppRebeta15x(i)=MJ.Re(k,i); end
        if MJ.beta(j,i)>beta3, MJ.V.qppRebeta10y(i)=NaN; MJ.V.qppRebeta10x(i)=MJ.Re(k,i); elseif MJ.beta(k,i)>beta3 && MJ.beta(k+1,i)<=beta3,  MJ.V.qppRebeta10y(i)=MJ.qpp(k+1,i); MJ.V.qppRebeta10x(i)=MJ.Re(k,i); end
        if MJ.beta(j,i)>beta2, MJ.V.qppRebeta05y(i)=NaN; MJ.V.qppRebeta05x(i)=MJ.Re(k,i); elseif MJ.beta(k,i)>beta2 && MJ.beta(k+1,i)<=beta2,  MJ.V.qppRebeta05y(i)=MJ.qpp(k+1,i); MJ.V.qppRebeta05x(i)=MJ.Re(k,i); end
        if MJ.beta(j,i)>beta1, MJ.V.qppRebeta03y(i)=NaN; MJ.V.qppRebeta03x(i)=MJ.Re(k,i); elseif MJ.beta(k,i)>beta1 && MJ.beta(k+1,i)<=beta1,  MJ.V.qppRebeta03y(i)=MJ.qpp(k+1,i); MJ.V.qppRebeta03x(i)=MJ.Re(k,i); break, end
    end
    

end %HEMJ

for i=1:size(MJ.Tpb,1)
%     
%     % Bare Forward
%     if BF.beta(i,round((Ref1-BF.Re(1,1))/(BF.Re(1,2)-BF.Re(1,1))+1))>1, BF.V.betaqppRe66y(i)=NaN; BF.V.betaqppRe66x(i)=BF.qpp(i,round((Ref1-BF.Re(1,1))/(BF.Re(1,2)-BF.Re(1,1))+1)); else BF.V.betaqppRe66y(i)=BF.beta(i,round((Ref1-BF.Re(1,1))/(BF.Re(1,2)-BF.Re(1,1))+1)); BF.V.betaqppRe66x(i)=BF.qpp(i,round((Ref1-BF.Re(1,1))/(BF.Re(1,2)-BF.Re(1,1))+1)); end
%     if BF.beta(i,round((Ref2-BF.Re(1,1))/(BF.Re(1,2)-BF.Re(1,1))+1))>1, BF.V.betaqppRe76y(i)=NaN; BF.V.betaqppRe76x(i)=BF.qpp(i,round((Ref2-BF.Re(1,1))/(BF.Re(1,2)-BF.Re(1,1))+1)); else BF.V.betaqppRe76y(i)=BF.beta(i,round((Ref2-BF.Re(1,1))/(BF.Re(1,2)-BF.Re(1,1))+1)); BF.V.betaqppRe76x(i)=BF.qpp(i,round((Ref2-BF.Re(1,1))/(BF.Re(1,2)-BF.Re(1,1))+1)); end
%     if BF.beta(i,round((Ref3-BF.Re(1,1))/(BF.Re(1,2)-BF.Re(1,1))+1))>1, BF.V.betaqppRe86y(i)=NaN; BF.V.betaqppRe86x(i)=BF.qpp(i,round((Ref3-BF.Re(1,1))/(BF.Re(1,2)-BF.Re(1,1))+1)); else BF.V.betaqppRe86y(i)=BF.beta(i,round((Ref3-BF.Re(1,1))/(BF.Re(1,2)-BF.Re(1,1))+1)); BF.V.betaqppRe86x(i)=BF.qpp(i,round((Ref3-BF.Re(1,1))/(BF.Re(1,2)-BF.Re(1,1))+1)); end
%     for j=1:size(BF.Tpb,2)
%         if j~=size(BF.Tpb,2) && BF.Tpb(i,j)>Tpb3 && BF.Tpb(i,j+1)<Tpb3, BF.V.betaqppTpb1300y(i)=BF.beta(i,j); BF.V.betaqppTpb1300x(i)=BF.qpp(i,j); elseif (j==1 && BF.Tpb(i,j)<Tpb3) || (j==size(BF.Tpb,2) && BF.Tpb(i,j)>Tpb3), BF.V.betaqppTpb1300y(i)=NaN; BF.V.betaqppTpb1300x(i)=BF.qpp(i,j); end,
%         if j~=size(BF.Tpb,2) && BF.Tpb(i,j)>Tpb2 && BF.Tpb(i,j+1)<Tpb2, BF.V.betaqppTpb1200y(i)=BF.beta(i,j); BF.V.betaqppTpb1200x(i)=BF.qpp(i,j); elseif (j==1 && BF.Tpb(i,j)<Tpb2) || (j==size(BF.Tpb,2) && BF.Tpb(i,j)>Tpb2), BF.V.betaqppTpb1200y(i)=NaN; BF.V.betaqppTpb1200x(i)=BF.qpp(i,j); end,
%         if j~=size(BF.Tpb,2) && BF.Tpb(i,j)>Tpb1 && BF.Tpb(i,j+1)<Tpb1, BF.V.betaqppTpb1100y(i)=BF.beta(i,j); BF.V.betaqppTpb1100x(i)=BF.qpp(i,j); break, elseif (j==1 && BF.Tpb(i,j)<Tpb1) || (j==size(BF.Tpb,2) && BF.Tpb(i,j)>Tpb1), BF.V.betaqppTpb1100y(i)=NaN; BF.V.betaqppTpb1100x(i)=BF.qpp(i,j); end,
%     end
%     
    
end %HEMJ

end % Constant Re/Ts for q" vs. beta

cd(BaseData);
if Ti==600+273.15
    save AHF6HEMJ MJ
elseif Ti==700+273.15
    save AHF7HEMJ MJ
end
cd(Main);

toc

%% Creating Fits for All Vectors

for m=1:0
    
    tic
    
    %Selecting the Vector to be Analyzed
    Cases={'BF' 'FF' 'BR' 'FR' 'B2' 'B5' 'F2' 'F5' 'BFID' 'FFID' 'BRID' 'FRID' 'B2ID' 'B5ID' 'F2ID' 'F5ID'};
    for k=1:length(Cases)/2
        Names=fieldnames(orderfields(getfield(eval(Cases{k}),'V'))); %#ok<GFLD>
        for i=1:2:length(Names)
            NameX=Names{i};
            NameY=Names{i+1};
            FIT.(Cases{k+length(Cases)/2}){(i+1)/2,1}=NameY(1:end-1);
            %Determine if Y Vector Needs to be trimmed
            YVEC=getfield(eval(Cases{k}),'V',NameY);
            XVEC=getfield(eval(Cases{k}),'V',NameX);
            if sum(isnan(YVEC))>0 || ~isempty(YVEC(YVEC<=0))
                countf=0;
                countb=0;
                for j=1:length(YVEC)
                    if isnan(YVEC(j)) || YVEC(j)<=0, countf=countf+1; else break, end
                end
                for j=0:length(YVEC)-1
                    if isnan(YVEC(end-j)) || YVEC(end-j)<=0, countb=countb+1; else break, end
                end
                YVEC=YVEC(countf+1:end-countb-1);
                XVEC=XVEC(countf+1:end-countb-1);
            end
            %Determine if X Vector Needs to be trimmed further
            if sum(isnan(XVEC))>0
                countf=0;
                countb=0;
                for j=1:length(XVEC)
                    if isnan(XVEC(j)), countf=countf+1; else break, end
                end
                for j=0:length(XVEC)-1
                    if isnan(XVEC(end-j)), countb=countb+1; else break, end
                end
                YVEC=YVEC(countf+1:end-countb-1);
                XVEC=XVEC(countf+1:end-countb-1);
            end
            [Power PowerR]=fit(XVEC',YVEC','power2');
            [Exp ExpR]=fit(XVEC',YVEC','exp1');
            if PowerR.rsquare>=ExpR.rsquare && Power.a>1e-15 
                FIT.(Cases{k+length(Cases)/2}){(i+1)/2,2}='power2';
                FIT.(Cases{k})((i+1)/2,1)=Power.a;
                FIT.(Cases{k})((i+1)/2,2)=Power.b;
                FIT.(Cases{k})((i+1)/2,3)=Power.c;
                FIT.(Cases{k})((i+1)/2,4)=PowerR.rsquare;
            else
                if ExpR.rsquare<.95, fprintf('Low R2 for %s-%s\n\n',Cases{k},NameY(1:end-1)); end
                FIT.(Cases{k+length(Cases)/2}){(i+1)/2,2}='exp1';
                FIT.(Cases{k})((i+1)/2,1)=Exp.a;
                FIT.(Cases{k})((i+1)/2,2)=Exp.b;
                FIT.(Cases{k})((i+1)/2,3)=0;
                FIT.(Cases{k})((i+1)/2,4)=ExpR.rsquare;
            end
        end
    end
       
    toc
  
end
%% Structure to Array (added by DL 8/16/2020)
vCell = struct2cell(MJ.V);
vArray = cell2mat(vCell);
vFields = fieldnames(MJ.V);

%% Plotting

% Re vs. q" 
for m=1:1
    
%%%%% HEMJ %%%%%%
    
figure(109)
hold on
plot(MJ.V.qppReTpb1100x,MJ.V.qppReTpb1100y./1e6,'-k','LineWidth',3)
plot(MJ.V.qppReTpb1200x,MJ.V.qppReTpb1200y./1e6,'-k','LineWidth',3)
plot(MJ.V.qppReTpb1300x,MJ.V.qppReTpb1300y./1e6,'-k','LineWidth',3)
plot(MJ.V.qppRebeta20x,MJ.V.qppRebeta20y./1e6,'--r','LineWidth',3)
plot(MJ.V.qppRebeta15x,MJ.V.qppRebeta15y./1e6,'--r','LineWidth',3)
plot(MJ.V.qppRebeta10x,MJ.V.qppRebeta10y./1e6,'--r','LineWidth',3)
plot(MJ.V.qppRebeta05x,MJ.V.qppRebeta05y./1e6,'--r','LineWidth',3)
% title('Parametric Pumping Power Curves for Finger-Type Divertor','FontSize',24)
xlabel('Re','FontSize',24), ylabel('q" (MW/m^2)','FontSize',24)
text(5.05e4,13.8,'5%','FontSize',20), text(6.6e4,16.1,'10%','FontSize',20), text(7.6e4,17.1,'15%','FontSize',20), text(8.5e4,18,'20%','FontSize',20)
text(9.75e4,27.9,'1300\circC','FontSize',20), text(9.75e4,23.7,'1200\circC','FontSize',20), text(9.75e4,19.6,'1100\circC','FontSize',20)
box on, set(gca,'FontSize',28), axis([1e4 5e4 0 25])
hold off

end

% Dissertation Plots
for m=1:0
    
close all
set(0,'DefaultFigureWindowStyle','docked')

cd(BaseData);
load AHF6HEMJ
cd(Main);

figure(1)
hold on
plot(MJ.V.qppReTpb1100x,MJ.V.qppReTpb1100y./1e6,'-k','LineWidth',3)
plot(MJ.V.qppReTpb1200x,MJ.V.qppReTpb1200y./1e6,'-k','LineWidth',3)
plot(MJ.V.qppReTpb1300x,MJ.V.qppReTpb1300y./1e6,'-k','LineWidth',3)
plot(MJ.V.qppRebeta20x,MJ.V.qppRebeta20y./1e6,'--r','LineWidth',3)
plot(MJ.V.qppRebeta15x,MJ.V.qppRebeta15y./1e6,'--r','LineWidth',3)
plot(MJ.V.qppRebeta10x,MJ.V.qppRebeta10y./1e6,'--r','LineWidth',3)
plot(MJ.V.qppRebeta05x,MJ.V.qppRebeta05y./1e6,'--r','LineWidth',3)
xlabel('\itRe','FontSize',24), ylabel('{\itq"_{max}} (MW/m^2)','FontSize',24)
text(4.4e4,13.8,'5%','FontSize',20), text(4.4e4,13.8,'10%','FontSize',20), text(4.4e4,13.8,'15%','FontSize',20), text(4.4e4,13.8,'20%','FontSize',20)
text(4.4e4,13.8,'1300 \circC','FontSize',20), text(4.4e4,13.8,'1200 \circC','FontSize',20), text(4.4e4,13.8,'1100 \circC','FontSize',20)
box on, set(gca,'FontSize',28), axis([1e4 5e4 0 25])
hold off

    
cd(BaseData);
load AHF7HEMJ
cd(Main);

figure(2)
hold on
plot(MJ.V.qppReTpb1100x,MJ.V.qppReTpb1100y./1e6,'-k','LineWidth',3)
plot(MJ.V.qppReTpb1200x,MJ.V.qppReTpb1200y./1e6,'-k','LineWidth',3)
plot(MJ.V.qppReTpb1300x,MJ.V.qppReTpb1300y./1e6,'-k','LineWidth',3)
plot(MJ.V.qppRebeta20x,MJ.V.qppRebeta20y./1e6,'--r','LineWidth',3)
plot(MJ.V.qppRebeta15x,MJ.V.qppRebeta15y./1e6,'--r','LineWidth',3)
plot(MJ.V.qppRebeta10x,MJ.V.qppRebeta10y./1e6,'--r','LineWidth',3)
plot(MJ.V.qppRebeta05x,MJ.V.qppRebeta05y./1e6,'--r','LineWidth',3)
xlabel('\itRe','FontSize',24), ylabel('{\itq"_{max}} (MW/m^2)','FontSize',24)
text(4.4e4,13.8,'5%','FontSize',20), text(4.4e4,13.8,'10%','FontSize',20), text(4.4e4,13.8,'15%','FontSize',20), text(4.4e4,13.8,'20%','FontSize',20)
text(4.4e4,13.8,'1300 \circC','FontSize',20), text(4.4e4,13.8,'1200 \circC','FontSize',20), text(4.4e4,13.8,'1100 \circC','FontSize',20)
box on, set(gca,'FontSize',28), axis([1e4 5e4 0 25])
hold off
    
end

% Defense Plots
for m=1:0
    
% close all
% set(0,'DefaultFigureWindowStyle','docked')

% cd(BaseData);
% load AHF6HEMJ
% cd(Main);
% 
% figure(1)
% hold on
% plot(MJ.V.qppReTpb1100x,MJ.V.qppReTpb1100y./1e6,'-k','LineWidth',3)
% plot(MJ.V.qppReTpb1200x,MJ.V.qppReTpb1200y./1e6,'-k','LineWidth',3)
% plot(MJ.V.qppReTpb1300x,MJ.V.qppReTpb1300y./1e6,'-k','LineWidth',3)
% plot(MJ.V.qppRebeta20x,MJ.V.qppRebeta20y./1e6,'--r','LineWidth',3)
% plot(MJ.V.qppRebeta15x,MJ.V.qppRebeta15y./1e6,'--r','LineWidth',3)
% plot(MJ.V.qppRebeta10x,MJ.V.qppRebeta10y./1e6,'--r','LineWidth',3)
% plot(MJ.V.qppRebeta05x,MJ.V.qppRebeta05y./1e6,'--r','LineWidth',3)
% xlabel('\itRe','FontSize',24), ylabel('{\itq"_{max}} (MW/m^2)','FontSize',24)
% text(4.4e4,13.8,'5%','FontSize',20), text(4.4e4,13.8,'10%','FontSize',20), text(4.4e4,13.8,'15%','FontSize',20), text(4.4e4,13.8,'20%','FontSize',20)
% text(4.4e4,13.8,'1300 \circC','FontSize',20), text(4.4e4,13.8,'1200 \circC','FontSize',20), text(4.4e4,13.8,'1100 \circC','FontSize',20)
% box on, set(gca,'FontSize',28), axis([1e4 5e4 0 25])
% hold off

    
cd(BaseData);
load AHF7HEMJ
cd(Main);

figure(2)
hold on
plot(MJ.V.qppReTpb1100x,MJ.V.qppReTpb1100y./1e6,'-k','LineWidth',3)
plot(MJ.V.qppReTpb1200x,MJ.V.qppReTpb1200y./1e6,'-k','LineWidth',3)
plot(MJ.V.qppReTpb1300x,MJ.V.qppReTpb1300y./1e6,'-k','LineWidth',3)
plot(MJ.V.qppRebeta20x,MJ.V.qppRebeta20y./1e6,'--r','LineWidth',3)
plot(MJ.V.qppRebeta15x,MJ.V.qppRebeta15y./1e6,'--r','LineWidth',3)
plot(MJ.V.qppRebeta10x,MJ.V.qppRebeta10y./1e6,'--r','LineWidth',3)
plot(MJ.V.qppRebeta05x,MJ.V.qppRebeta05y./1e6,'--r','LineWidth',3)
xlabel('\itRe','FontSize',24), ylabel('{\itq"_{max}} (MW/m^2)','FontSize',24)
text(4.4e4,13.8,'5%','FontSize',20), text(4.4e4,13.8,'10%','FontSize',20), text(4.4e4,13.8,'15%','FontSize',20), text(4.4e4,13.8,'20%','FontSize',20)
text(4.4e4,13.8,'1300 \circC','FontSize',20), text(4.4e4,13.8,'1200 \circC','FontSize',20), text(4.4e4,13.8,'1100 \circC','FontSize',20)
box on, set(gca,'FontSize',28), axis([1e4 5e4 0 25])
hold off
    
end

% Plots for Mills TOFE 21 Paper
for m=1:0
    
    cd(BaseData);
    load AHF6HEMJ
    cd(Main);
    
    %Ti=600 C
    figure(101)
    hold on
    plot(MJ.V.qppReTpb1100x,MJ.V.qppReTpb1100y./1e6,'-k','LineWidth',3)
    plot(MJ.V.qppReTpb1200x,MJ.V.qppReTpb1200y./1e6,'-k','LineWidth',3)
    plot(MJ.V.qppReTpb1300x,MJ.V.qppReTpb1300y./1e6,'-k','LineWidth',3)
    plot(MJ.V.qppRebeta20x,MJ.V.qppRebeta20y./1e6,'--r','LineWidth',3)
    plot(MJ.V.qppRebeta15x,MJ.V.qppRebeta15y./1e6,'--r','LineWidth',3)
    plot(MJ.V.qppRebeta10x,MJ.V.qppRebeta10y./1e6,'--r','LineWidth',3)
    plot(MJ.V.qppRebeta05x,MJ.V.qppRebeta05y./1e6,'--r','LineWidth',3)
    xlabel('{\itRe}','FontSize',24), ylabel('{\itq"} (MW/m^2)','FontSize',24)
    box on, set(gca,'FontSize',28,'FontName','Times New Roman'), axis([1e4 5e4 0 25])
    hold off
    
    cd(BaseData);
    load AHF7HEMJ
    cd(Main);
    
    %Ti=700 C
    figure(102)
    hold on
    plot(MJ.V.qppReTpb1100x,MJ.V.qppReTpb1100y./1e6,'-k','LineWidth',3)
    plot(MJ.V.qppReTpb1200x,MJ.V.qppReTpb1200y./1e6,'-k','LineWidth',3)
    plot(MJ.V.qppReTpb1300x,MJ.V.qppReTpb1300y./1e6,'-k','LineWidth',3)
    plot(MJ.V.qppRebeta20x,MJ.V.qppRebeta20y./1e6,'--r','LineWidth',3)
    plot(MJ.V.qppRebeta15x,MJ.V.qppRebeta15y./1e6,'--r','LineWidth',3)
    plot(MJ.V.qppRebeta10x,MJ.V.qppRebeta10y./1e6,'--r','LineWidth',3)
    plot(MJ.V.qppRebeta05x,MJ.V.qppRebeta05y./1e6,'--r','LineWidth',3)
    xlabel('{\itRe}','FontSize',24), ylabel('{\itq"} (MW/m^2)','FontSize',24)
    box on, set(gca,'FontSize',28,'FontName','Times New Roman'), axis([1e4 5e4 0 25])
    hold off
    
end

% Plots for Mills TOFE 21 Presentation
for m=1:0
    
    % Ti=600 C
    cd(BaseData);
    load AHF6HEMJ
    cd(Main);
    
    figure(101)
    hold on
    plot(MJ.V.qppReTpb1100x,MJ.V.qppReTpb1100y./1e6,'-k','LineWidth',3)
    plot(MJ.V.qppReTpb1200x,MJ.V.qppReTpb1200y./1e6,'-k','LineWidth',3)
    plot(MJ.V.qppReTpb1300x,MJ.V.qppReTpb1300y./1e6,'-k','LineWidth',3)
    plot(MJ.V.qppRebeta20x,MJ.V.qppRebeta20y./1e6,'--r','LineWidth',3)
    plot(MJ.V.qppRebeta15x,MJ.V.qppRebeta15y./1e6,'--r','LineWidth',3)
    plot(MJ.V.qppRebeta10x,MJ.V.qppRebeta10y./1e6,'--r','LineWidth',3)
    plot(MJ.V.qppRebeta05x,MJ.V.qppRebeta05y./1e6,'--r','LineWidth',3)
%     plot(MJ.V.qppRebeta05x,MJ.V.qppRebeta03y./1e6,'--k','LineWidth',3)
    xlabel('{\itRe}','FontSize',24), ylabel('{\itq"} [MW/m^2]','FontSize',24)
    box on, set(gca,'FontSize',28,'FontName','Times New Roman','XTick',1e4:1e4:5e4), axis([1e4 5e4 0 25])
    hold off
    
    % Ti=700 C
    cd(BaseData);
    load AHF7HEMJ
    cd(Main);
    
    figure(102)
    hold on
    plot(MJ.V.qppReTpb1100x,MJ.V.qppReTpb1100y./1e6,'-k','LineWidth',3)
    plot(MJ.V.qppReTpb1200x,MJ.V.qppReTpb1200y./1e6,'-k','LineWidth',3)
    plot(MJ.V.qppReTpb1300x,MJ.V.qppReTpb1300y./1e6,'-k','LineWidth',3)
    plot(MJ.V.qppRebeta20x,MJ.V.qppRebeta20y./1e6,'--r','LineWidth',3)
    plot(MJ.V.qppRebeta15x,MJ.V.qppRebeta15y./1e6,'--r','LineWidth',3)
    plot(MJ.V.qppRebeta10x,MJ.V.qppRebeta10y./1e6,'--r','LineWidth',3)
    plot(MJ.V.qppRebeta05x,MJ.V.qppRebeta05y./1e6,'--r','LineWidth',3)
%     plot(MJ.V.qppRebeta05x,MJ.V.qppRebeta03y./1e6,'--k','LineWidth',3)
    xlabel('{\itRe}','FontSize',24), ylabel('{\itq"} [MW/m^2]','FontSize',24)
    box on, set(gca,'FontSize',28,'FontName','Times New Roman','XTick',1e4:1e4:5e4), axis([1e4 5e4 0 25])
    hold off
    
end

  