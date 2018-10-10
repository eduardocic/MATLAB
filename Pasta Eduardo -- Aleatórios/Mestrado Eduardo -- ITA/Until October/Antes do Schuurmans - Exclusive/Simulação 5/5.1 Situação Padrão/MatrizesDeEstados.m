% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%
%                           MATRIZES DE ESTADO
%
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

%% -------------------
% Matrizes Incertas A.
% --------------------
A1 = [   0   1;
      -1.5 2.5];
  
A2 = [   0   1;
      -0.8 1.8];  

%% -------------------
% Matrizes Incertas B.
% --------------------  
B1 = [0;
     1];

 
 
 
 

%% ---------------------
% Concatena as Matrizes.
% ----------------------
A = [A1;
     A2];
B = [B1]; 


%% --------------------------------
% Dados para dimensões da matrizes.
% ---------------------------------
n = size(A,2);     % Ordem das matrizes "A's" (n x n). 
p = size(B,2);      % Parâmetro de entradas de "B's" (n x p).

alfa = size(A,1);
beta = size(B,1);
qA = alfa/n;                 % # da matrizes 'A' (A1 e A2);
qB = beta/n;                 % # da matrizes 'B' (B);
N  = qA*qB;                  % # Vértices Politopo ('2' de A e '1' de B);