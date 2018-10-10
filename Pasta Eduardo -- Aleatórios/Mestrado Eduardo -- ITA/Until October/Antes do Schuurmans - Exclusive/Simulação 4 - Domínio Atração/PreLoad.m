clear; close all; clc;

%% ------------------------------------------------------------------------
%               (1) Defini��o das matrizes incertas.
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
%                   (2) Determina��o do politopo G.
% -------------------------------------------------------------------------

n = size(A1,2);     % Ordem das matrizes 'A' (n x n). Pego o valor de 'n';
p = size(B1,2);      % Par�metro de entradas de B (n x p). Pego o valor de 'p';

% -----------------------
% (1) Matrizes de Estado.
% -----------------------
A = [A1;
     A2];
B = [B1];
C = [1 0; 0 1];
D = zeros(size(C,1), size(B,2));

% ---------------------------------
% (2) Matrizes de Custo Quadr�tico.
% ---------------------------------
S  = [1 0; 0 1];    Ssqrt = sqrt(S);    % S^(-1/2)
R  = [1];           Rsqrt = sqrt(R);    % R^(-1/2)

alfa = size(A,1);
beta = size(B,1);
qA   = alfa/n;                 % # da matrizes 'A' (A1 e A2);
qB   = beta/n;                 % # da matrizes 'B' (B);
N    = qA*qB;                  % # V�rtices Politopo ('2' de A e '1' de B);

% ---------------------------------------------
% (3) Constantes utilizadas e Condi��o Inicial.
% ---------------------------------------------
Umax = 1;          % Limite para a entrada.
T    = 1;          % Passo de Simula��o.
rho  = 1000;          % Peso dado a vari�vel 'gamma'.


xk0  = [1.999;0];     % N�o Fact�vel em Main - Diverge
% xk0  = [2; 0];



% ------------------------------------------------
% (4) Matrizes que ser�o utilizadas na otimiza��o.
% ------------------------------------------------
I   = eye(size(A,2));
Aeq = [(I-A1);
       (I-A2)];   
H   = null(Aeq);
% H = [-0.7071;
%      -0.7071];


 