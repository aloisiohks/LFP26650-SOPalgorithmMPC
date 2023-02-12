% This function builds the matrices M and gamma to solve the MPC
% optimization problem. 

function [ M, gamma ] = constraints( dx, linMatrices, mpcData,uk,rflag)

% tic
    Np = mpcData.Np;
    Nc = mpcData.Nc;
    Sigma = tril(ones(Nc,Nc));
    model=mpcData.model;
    
    Am = linMatrices.A;
    Bm = linMatrices.B;
   
    
    C_z = linMatrices.C_z;
    D_z = linMatrices.D_z;
    C_v = linMatrices.C_v;
    D_v = linMatrices.D_v;
    C_Tc = linMatrices.C_Tc;
    D_Tc = linMatrices.D_Tc;
    
    
    [Phi_Tc,G_Tc] = predMat(Am,Bm,C_Tc,D_Tc,Nc,Np);
    [Phi_v,G_v] = predMat(Am,Bm,C_v,D_v,Nc,Np);
    [Phi_z,G_z] = predMat(Am,Bm,C_z,D_z,Nc,Np);
    

     
    OCV =  OCVfromSOCtemp(dx(1),dx(4),model); 
    
    %****************************************************************************        
        % CHARGE
    if strcmp(rflag,'charge')
        umax = 0;
        umin = mpcData.const.u_min;
        
        M = [
                 % u constraints
                 -Sigma;         % i  > i_min
                  Sigma;         % i  < i_max
                 % v constraints
                    G_v;         % v  < v_max
                 % Tc constraint
                   G_Tc;        % Tc < Tc_max
                  ] ;
        
        gamma = [ 
            
                % u constraints
              -umin*ones(Nc,1) + uk*ones(Nc,1);
               umax*ones(Nc,1) - uk*ones(Nc,1);
                % v constraints
               mpcData.const.v_max*ones(Np ,1) - Phi_v*dx - OCV*ones(Np,1) ;
               % Tc constraint
               mpcData.const.tc_max - Phi_Tc*dx ;
                 ];
        
    end
        
%****************************************************************************        
        % DISCHARGE
   if strcmp(rflag,'discharge')    
        
        umax = mpcData.const.u_max;
        umin = 0;
         
                M = [
                   -Sigma;         % i  > i_min
                    Sigma;         % i  < i_max
                   -G_v  ;         % v  > v_min
                    G_Tc;          % Tc < Tc_max 
%                     -G_z;          % z > z_min
                     ] ;
        
         gamma = [ 
                 -umin*ones(Nc,1) + uk*ones(Nc,1);     % i  > i_min
                  umax*ones(Nc,1) - uk*ones(Nc,1);     % i  < i_max
                 -mpcData.const.v_min + Phi_v*dx  + OCV*ones(Np,1);   % v  > v_min
                   mpcData.const.tc_max - Phi_Tc*dx ;      % Tc < Tc_max
%                    -mpcData.const.z_min + Phi_z*dx;
                    ];
        
        
    end
       

end

