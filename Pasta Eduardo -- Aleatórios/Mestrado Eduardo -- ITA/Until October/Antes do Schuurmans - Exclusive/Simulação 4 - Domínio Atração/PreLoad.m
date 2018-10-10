clear; close all; clc;

%% ------------------------------------------------------------------------
%               (1) Definição das matrizes incertas.
% -------------------------------------------------------------------------

A1 = [   0   1;
      -1.5 2.5];
  
A2 = [   0   1;
      -0.8 1.8];  

B = [0;
     1];
   
B1 = [0;
      1];
  
%% ------------------------------------------------------------------------
%                   (2) Determinação do politopo G.
% -------------------------------------------------------------------------

n = size(A1,2);     % Ordem das matrizes 'A' (n x n). Pego o valor de 'n';
p = size(B1,2);      % Parâmetro de entradas de B (n x p). Pego o valor de 'p';

% -----------------------
% (1) Matrizes de Estado.
% -----------------------
A = [A1;
     A2];
B = [B1];
C = [1 0; 0 1];
D = zeros(size(C,1), size(B,2));

% ---------------------------------
% (2) Matrizes de Custo Quadrático.
% ---------------------------------
S  = [1 0; 0 1];    Ssqrt = sqrt(S);    % S^(-1/2)
R  = [1];           Rsqrt = sqrt(R);    % R^(-1/2)

alfa = size(A,1);
beta = size(B,1);
qA   = alfa/n;                 % # da matrizes 'A' (A1 e A2);
qB   = beta/n;                 % # da matrizes 'B' (B);
N    = qA*qB;                  % # Vértices Politopo ('2' de A e '1' de B);

% ---------------------------------------------
% (3) Constantes utilizadas e Condição Inicial.
% ---------------------------------------------
Umax = 1;          % Limite para a entrada.
T    = 1;          % Passo de Simulação.
rho  = 1000;          % Peso dado a variável 'gamma'.


xk0  = [1.999;0];     % Não Factível em Main - Diverge
% xk0  = [2; 0];



% ------------------------------------------------
% (4) Matrizes que serão utilizadas na otimização.
% ------------------------------------------------
I   = eye(size(A,2));
Aeq = [(I-A1);
       (I-A2)];   
H   = null(Aeq);
% H = [-0.7071;
%      -0.7071];


 