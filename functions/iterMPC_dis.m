
%   iterMPC computes SOP discharge at time k
%
%   xk_1: current state
%   mpcData: mpcData configuration
%   Nsim: prediction interval
%   deltaT: sampling time

function [Y,X,U,DelU,Pavg,Pinst,mpcData] = iterMPC_dis(xk_1,mpcData,Nsim,deltaT)


    % Load MPC data
    Np = mpcData.Np;
    Nc = mpcData.Nc;
    Sigma = mpcData.Sigma;
    Tfk = mean(mpcData.Tfk);    
    model = mpcData.model;
    DelU = zeros(1,Nsim+1);
    Ru  = mpcData.Ru;
    Ref = mpcData.const.z_min*ones(Np,1);
    uk = mpcData.const.u_max;
    mpcData.uk_1 = uk;

        

if ((xk_1(1) > mpcData.const.z_min) && (xk_1(4) < (mpcData.const.tc_max )))
   
   % Calculate intial state and output values
   [v,x,~,~] = iterModel(xk_1, uk,Tfk, model,deltaT);
   Y(:,1) = v;
   Xf = [xk_1;Tfk; 1; sign(uk); uk];
   X(:,1) = Xf;
   U(:,1) = uk;
   xold = xk_1;
   u = uk;
   
   %*************************************************************************
   % MAIN LOOP
   for kk = 2:Nsim
       
    % Obtain SS matrices
    [linMatrices] = linMat_Ts(xold,mpcData);
    Az = linMatrices.A;
    Bz = linMatrices.B;
    Cz = linMatrices.C_z;
    Dz = linMatrices.D_z;
    mpcData.linMatrices = linMatrices;
  
   % Compute SOC prediction matrices
   [Phi,G,~]  = predMat(Az,Bz,Cz,Dz,Nc,Np);
      
   F = -G'*(Ref - Phi*X(:,kk-1) );
   if mpcData.adap 
       [~,S,~] = svd(G'*G);
       [m,n] = size(S);
       Ru = abs((norm(F,2)/(2*mpcData.const.du_max*sqrt(Nc)))-(S(m,n)));
   end
   E = (G'*G + Ru*eye(mpcData.Nc,mpcData.Nc)); 
   
   DU = -E\F;
   
    % Augmented state vector
    dx = [xold; Tfk; 1; sign(u); u];
   
   [M,gamma] = constraints(dx,linMatrices,mpcData,u,'discharge');
   
  
    if sum(M*DU - gamma > 0) > 0
        [DU,lambda,nexec] = hildreth(E,F,M,gamma,[],150);
         mpcData.lambda = lambda;
         mpcData.nexec = nexec;
    else 
        mpcData.nexec = 0;
    end
      
    du = DU(1);
    DelU(:,kk) = du;
    u = du + U(:,kk-1) ;
    U(:,kk) = u;
  
    [v,x,~,~] = iterModel(xold, u,Tfk, model,deltaT);
    xold = x;
    Y(:,kk) = v;
    X(:,kk) = [x;Tfk; 1; sign(u) ;u];
    mpcData.uk_1 = u;
    mpcData.v = v;
    mpcData.Ru_store(kk) = Ru;

   end
   %*************************************************************************
   
    %POWER COMPUTATION
    Pinst = Y(2:Nsim).*U(1,2:Nsim);  % Compute instantaneous power over prediction horizon
    Etot = trapz(Pinst);             % Compute corresponding total energy
    Pavg = Etot/11;                   % Compute max (average) sustained power over interval


else

u = 0;
[v,x,~,~] = iterModel(xk_1, uk,Tfk, model,deltaT);

mpcData.Ru_store = repmat(0,1,Nsim);
Y(:,1:Nsim) = repmat(v,1,Nsim);
X(:,1:Nsim) = repmat([x; Tfk; 1; sign(uk); uk],1,Nsim);
U(1:Nsim) = u*ones(1,Nsim);
Pavg = 0;
Pinst = [];    

end

%     toc
%     disp('iterMPC')
end

