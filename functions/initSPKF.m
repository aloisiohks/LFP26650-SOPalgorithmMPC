function spkfData = initSPKF(SigmaX0,SigmaV,SigmaW,model,SOC0,Tc0,Ts0)
% Initial state description

ir0 = 0; 
hk0 = 0; 
spkfData.zkInd = 1;
spkfData.irInd = 2;
spkfData.hkInd = 3;
spkfData.TcInd =4;
spkfData.TsInd =5;

% Assuming that the initial temperature of the cell 
% is in equilibrium Tc = Ts
spkfData.xhat = [SOC0 ir0 hk0 Tc0 Ts0]'; % initial state
% Covariance values
spkfData.SigmaX = SigmaX0;
spkfData.SigmaV = SigmaV;
spkfData.SigmaW = SigmaW;
spkfData.Snoise = real(chol(diag([diag(SigmaW); diag(SigmaV)]),'lower'));
spkfData.Qbump = 5;
% SPKF specific parameters
Nx = length(spkfData.xhat); spkfData.Nx = Nx; % state-vector length
Ny = 1; spkfData.Ny = Ny; % measurement-vector length
Nu = 1; spkfData.Nu = Nu; % input-vector length
Nw = size(SigmaW,1); spkfData.Nw = Nw; % process-noise-vector length
Nv = size(SigmaV,1); spkfData.Nv = Nv; % sensor-noise-vector length
Na = Nx+Nw+Nv; spkfData.Na = Na; % augmented-state-vector length
h = sqrt(3); spkfData.h = h; % SPKF/CDKF tuning factor
Weight1 = (h*h-Na)/(h*h); % weighting factors when computing mean
Weight2 = 1/(2*h*h); % and covariance
spkfData.Wm = [Weight1; Weight2*ones(2*Na,1)]; % mean
spkfData.Wc = spkfData.Wm; % covar
% previous value of current
spkfData.priorI = 0;
spkfData.signIk = 0;
% store model data structure too
spkfData.model = model;
spkfData.Bounds = diag(3*sqrt(SigmaX0));
spkfData.vk = [];
end