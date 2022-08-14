%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This software performs state of power (SOP) estimation using model 
% predictive control and a coupled electro-thermal model for a cylindrical 
% cell A123 26650 2.5 Ah (LPF chemistry)
%
% Copyright (c) 2021 by Aloisio Kawakita de Souza of the
% University of Colorado Colorado Springs (UCCS). This work is licensed
% under a MIT license. It is provided "as is", without express or implied
% warranty, for educational and informational purposes only.
%
% This file is provided as a supplement to: 
%
% [1] Kawakita de Souza, A. (2020). Advanced Predictive Control Strategies for 
%  Lithium-Ion Battery Management Using a Coupled Electro-Thermal Model 
%  [Master thesis, University of Colorado, Colorado Springs].ProQuest Dissertations Publishing.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 


clear all;close all;clc;

addpath(genpath('./'));



load('A123CETmodel.mat'); % loads "model" of cell
load('A004_DYN_P30_FSAE'); % loads data


%% Load UDDS experimental data
tinit = 1;
tend = 1300;
time = Data.time(tinit:tend); deltaT = time(2)-time(1);
time = time-time(1); % start time at 0
current = -Data.current(tinit:tend); % discharge > 0; charge < 0.
voltage = Data.voltage(tinit:tend); % Voltage
Tf = Data.Tf(tinit:tend);          % Ambient temperature
Ts = Data.Ts(tinit:tend);          % Battery surface temperature
Nsim = length(0:deltaT:10)+1;


%% SPKF initialization

SOC0 = 0.95;   % SOC initial guess
Tc0 = 30;      % Tc initial guess
Ts0 = 30;      % Ts initial guess
% Covariance values
SigmaX0 = diag([.5e-2 1e-5 1e-4 1e-1 1e-1]); % uncertainty of initial state
SigmaV = diag([1e-1 2e-5]);                  % Uncertainty of voltage sensor, output equation
SigmaW = diag([1e-5 1e-4 1e-4 1e-2 1e-3]);   % Uncertainty of current sensor, state equation
spkfData = initSPKF(SigmaX0,SigmaV,SigmaW,model,SOC0,Tc0,Ts0);

%% SOP limits
mpcData.const.z_max = 0.9;     % Max SOC
mpcData.const.z_min = 0.1;     % Min SOC
mpcData.const.u_max = 50;      % Max discharging current
mpcData.const.u_min =  -25;    % Max charging current 
mpcData.const.v_min = 2.4;     % Min voltage
mpcData.const.v_max = 3.7;     % Max voltage
mpcData.const.tc_max = 50;     % Max temperature
mpcData.Tfk = Tf;

%% MPC Configuration
mpcData.adap = 1;   % 1 - Adaptive input weighting, 0 - Standard input weighting Ru
mpcData.Ru = 1e-5;  % Input weighting (only used if adapFlag=0)
mpcData.Np = 3;     % MPC prediction horizon
mpcData.Nc = 2;     % MPC control horizon
mpcData.Sigma = tril(ones(mpcData.Nc,mpcData.Nc));
mpcData.deltaT = deltaT;
mpcData.model = model;

%% Storing variables
X_MPC_Dis = zeros(9,Nsim,length(current));
X_MPC_Chg = zeros(9,Nsim,length(current));
V_MPC_Dis = zeros(1,Nsim,length(current));
V_MPC_Chg = zeros(1,Nsim,length(current));
I_MPC_Dis = zeros(1,Nsim,length(current));
I_MPC_Chg = zeros(1,Nsim,length(current));



hwait = waitbar(0,'Computing Power Estimation...');
auxDis = zeros(1,length(current));
auxChg = zeros(1,length(current));
tic

mpcData2 = mpcData;
for i=1:length(current)

v = voltage(i); % "measure"  voltage
ik = current(i); % "measure" current
Tfk = Tf(i);
Ts_k = Ts(i);    
    
% Update model states
[spkfData] = iterSPKF(v,ik,spkfData.xhat(4),Tfk,Ts_k,deltaT,spkfData);


irck(i) = spkfData.xhat(1);  % irc current estimate
hk(i) = spkfData.xhat(2);    % hysteresis estimate
zk(i) = spkfData.xhat(3);    % SOC estimate
Tck(i) = spkfData.xhat(4);   % Core temperature estimate
Tsk(i) = spkfData.xhat(5);   % Surface temperature estimate

x0 = spkfData.xhat(:,end);

x0_dis = spkfData.xhat(:,end)+spkfData.Bounds(:,end);
x0_chg = spkfData.xhat(:,end)-spkfData.Bounds(:,end);

%______________________________________________________________________________
% % % %*****************************************************************************
% % % MPC BEGINNING
% % % Discharge Power Estimation - MPC
% 



[Ydis,Xdis,Udis,DelU,Pavg,Pinst,mpcData] = iterMPC_dis(x0,mpcData,Nsim,deltaT);

Ru_MPC_Dis(i,:) = mpcData.Ru_store; % Store adaptive input weighting Ru
X_MPC_Dis(:,:,i) = Xdis;    % Store states
V_MPC_Dis(:,:,i) = Ydis;    % Store output
I_MPC_Dis(:,:,i) = Udis;    % Store control input
P_MPC_Dis(i) = Pavg;        % Store power

% % Charge Power Estimation - MPC
[Ychg,Xchg,Uchg,DelU,Pavg,Pinst,mpcData2] = iterMPC_chg(x0,mpcData2,Nsim,deltaT);

Ru_MPC_Chg(i,:) = mpcData2.Ru_store;  % Store adaptive input weighting Ru
X_MPC_Chg(:,:,i) = Xchg;  % Store states
V_MPC_Chg(:,:,i) = Ychg;  % Store output
I_MPC_Chg(:,:,i) = Uchg;  % Store control input
P_MPC_Chg(i) = Pavg;      % Store power

% % % MPC END
% % % ****************************************************************************

   % Update progress
   if mod(i,10)==0, waitbar(i/length(current),hwait); end;
end
toc
%%
F = findall(0,'type','figure','tag','TMWWaitbar');
delete(F);

figure()
% Discharge
plot(time,P_MPC_Dis);hold on;
% Charge
plot(time,P_MPC_Chg);hold on;
xlabel('Time (s)'); ylabel('Power (W)');
xlim([0 time(end)]);
title('State of power')
legend('SOP discharge','SOP charge','Location','best')
plotFormat;


