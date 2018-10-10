%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                           MATRIZES DE ESTADO
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
T = 0.5;
%## 1) Matrizes Incertas A ##%
A1 = [   1   T;
         0   1];
  
% A2 = [   1   0.1;
%          0    0];     


%## 2) Matrizes Incertas B ##%
B1 = 0.9*[(T^2)/2;
          T];
      
B2 = 1.1*[(T^2)/2;
          T];
    
 

%## Matrizes Espaço de Estado. ##%
A = [A1];
B = [B1; B2];

n = size(A,2);

Cstate = eye(n);
Dstate = 0*Cstate(:,n);

%%% Que vai diretamente para o cálculo das variáveis.
C = [1 0.2];

