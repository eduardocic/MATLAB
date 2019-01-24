function [sys, past_x0, str, ts] = LMI_ComRestricaoEntrada(t, past_x, inputs, flag, A, B, H, rho, T)

switch flag
    
case 0
n = size(A,2);               % Ordem das matrizes 'A';
p = size(B,2);               % Parâmetro da quantidade de entradas.
[sys,past_x0,str,ts] = mdlInitializeSizes(T,p,n); % S-function Initialization

case 2
sys = mdlUpdate(t,inputs);

case {1,4,9}
sys = []; % Unused Flags

case 3 % Evaluate Function
   
[n, p, qA, qB, N] = ProcessamentoMatrizesEstado(A, B);

xk = inputs;       % Estado medido x(k)

%% ------------------------------------------------------------------------ 
%                           (1) Inicializa LMIs.
% -------------------------------------------------------------------------

S  = eye(n);   Ssqrt = sqrt(S);    % S^(-1/2)
R  = eye(p);   Rsqrt = sqrt(R);    % R^(-1/2)
E  = eye(p);   % Importante para os valores da LMI (iv). 


% 1.c) Inicializar um conjunto de LMIs.
setlmis([]);

%% ------------------------------------------------------------------------
%                       (2) Definição das variáveis.
% -------------------------------------------------------------------------
[g, m1, sg] = lmivar(1,[1 0]);     % '(g)amma'.
[Q, m2, sQ] = lmivar(1,[n 1]);     % Q (nxn) simétrica full-block.
[Y, m3, sY] = lmivar(2,[p n]);     % Y (pxn) retangular; 
[z, m4, sz]     = lmivar(1,[1 0]);         % z (nx1)- Variável que gostaremos de minimizar.
[Eta, m5, sEta] = lmivar(1,[1 0]);         % Variável a ser minimizada 'Eta' no Custo.


%% ------------------------------------------------------------------------
%                      (3) Determinação das LMI.
% -------------------------------------------------------------------------
% ++++++++++++++++++++++++
% 3.a) LMI do Kothare.   +
%                        +
%  | Q  x(k)-H.z | >= 0  +             
%  | *      1    |       +
% ++++++++++++++++++++++++
LMI_Kothare = newlmi;
lmiterm([-LMI_Kothare 1 1 Q],1,1);    % Direita da LMI(-), pos (1,1), Var (Q).
lmiterm([-LMI_Kothare 1 2 0],xk);     % Direita da LMI(-), pos (1,2), Const (x(k)).
lmiterm([-LMI_Kothare 1 2 z],H,-1);   % Direita da LMI(-), pos (1,2), -H.z.
lmiterm([-LMI_Kothare 2 2 0],1);      % Direita da LMI(-), pos (1,2), Const '1'

% +++++++++++++++++++++++++++++++++++++++++++                                     
% 3.b) LMI das incertezas                   +
%                                           +
%     | Q  0  0  (AjQ + BjY) |              +
%     | *  gI 0   S^(1/2)Q   | >= 0    (ii) +
%     | *  *  gI  R^(1/2)Y   |              +
%     | *  *  *        Q     |              +
%     para todo j = 1,...,N ( = qA*qB);     +
% +++++++++++++++++++++++++++++++++++++++++++                                     
for i=1:N
    ConjLMICombConvex(i) = newlmi;
    lmiterm([-ConjLMICombConvex(i) 1 1 Q],1,1);
    [Aj, Bj] = Vertice(A,B,n,qB,i);            
    lmiterm([-ConjLMICombConvex(i) 1 4 Q],Aj,1);
    lmiterm([-ConjLMICombConvex(i) 1 4 Y],Bj,1);
    lmiterm([-ConjLMICombConvex(i) 2 2 g],1,1);
    lmiterm([-ConjLMICombConvex(i) 2 4 Q],Ssqrt,1);
    lmiterm([-ConjLMICombConvex(i) 3 3 g],1,1);
    lmiterm([-ConjLMICombConvex(i) 3 4 Y],Rsqrt,1);
    lmiterm([-ConjLMICombConvex(i) 4 4 Q],1,1);
end

% ++++++++++++++++++++++++++++                                                                         
% 3.c) LMI do "Steady State" +
%                            +
%     | I   H.z | >= 0       +          
%     | *   Eta |            +
% ++++++++++++++++++++++++++++
LMIss   = newlmi;
I = eye(size(A,2));              % I (nxn)
lmiterm([-LMIss 1 1 0],I);
lmiterm([-LMIss 1 2 z],H,1);     % Direita da LMI(-), pos (1,2), -Hz.
lmiterm([-LMIss 2 2 Eta],1,1);

%% ------------------------------------------------------------------------
%                      (4) Pega as LMI definidas acima.
% -------------------------------------------------------------------------

SistemaLMIs = getlmis;

%% ------------------------------------------------------------------------
%      (5) Calcula a quantidade de variáveis a serem encontradas.
% -------------------------------------------------------------------------

NumVar = decnbr(SistemaLMIs);  % Quantidade total de variáveis do sistema.
c = zeros(NumVar,1);           %   Vetor de zeros.

%++ ------ Custo ------ +++
%   J = Eta + rho*gamma   +
% -------------------------
c(1) = rho;     % rho*gamma
c(end) = 1;     % 1*Eta                                 


% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++                                     
% 5.b) Usa-se o 'tic' e o 'toc' para que possamos fazer o cálculo +
%      de quanto tempo demora o processo de OTIMIZAÇÃO em cada    +
%      laço da simulação.                                         +
options = [0 200 0 0 1];      % Trace off                         +
% tic                                                             % +
[Copt, Xopt] = mincx(SistemaLMIs, c, options);                  % +               
% toc                                                             % +
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

Ysol = dec2mat(SistemaLMIs, Xopt, Y);
Qsol = dec2mat(SistemaLMIs, Xopt, Q);
z   = dec2mat(SistemaLMIs,Xopt,z);
Eta = dec2mat(SistemaLMIs,Xopt,Eta);

%% Determinação da Matriz F, tal que: u*(k) = F.x(k)
F = Ysol*inv(Qsol);

%% Saída de Controle.
xss = z*H;

uk = F*(xk - xss);

% Colocarei na Saída os seguite vetor [u' F]
sys =  [uk xss' F]; % S-function output (control value)

end

%%%%%%%%%%%%%%%%%%%%%%%%

%=============================================================================
% mdlInitializeSizes
% Return the sizes, initial conditions, and sample times for the S-function.
%=============================================================================
%
function [sys,past_x0,str,ts] = mdlInitializeSizes(T,p,n)

%
% call simsizes for a sizes structure, fill it in and convert it to a
% sizes array.
%
%
sizes = simsizes;

sizes.NumContStates  = 0;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = (p + 2*n);  % uk +  Xss + F
sizes.NumInputs      = n;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1;   % Just one sample time

sys = simsizes(sizes);

%
% initialize the initial conditions
%
past_x0  = []; 

%
% str is always an empty matrix
%
str = [];

%
% initialize the array of sample times
%
ts  = [T 0];

% end mdlInitializeSizes

%=======================================================================
% mdlUpdate
% Handle discrete state updates, sample time hits, and major time step
% requirements.
%=======================================================================
%
function sys = mdlUpdate(t,inputs)

% Housekeeping
sys = [];

%end mdlUpdate