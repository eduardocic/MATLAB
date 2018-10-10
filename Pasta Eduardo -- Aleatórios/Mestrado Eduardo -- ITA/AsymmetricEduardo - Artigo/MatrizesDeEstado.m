%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                           MATRIZES DE ESTADO
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% Matrizes Incertas A
A{1} = [ 1   T;
         0   1];
  
% A{2} = [ 1   0.1;
%          0    0];     


%%% Matrizes Incertas B 
B{1} = 0.9*[(T^2)/2;
             T];
      
B{2} = 1.1*[(T^2)/2;
             T];

%%% Matriz C do meu sistema de interesse.
C = [1 0.2];

n = max(size(A{1}));
Cstate = eye(n);        % Matriz utilizada no Simulink apenas.
Dstate = 0*Cstate(:,n); % Matriz utilizada no Simulink apenas.



