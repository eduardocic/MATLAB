function [sys,past_x0,str,ts] = RLMI_entrada(t, past_x, inputs, flag, S, R, A, B, Umax, T)
%        [sys,past_x0,str,ts] = mpc_lmi(t,past_x,inputs,flag, S, R, A, B, C, Umax, ymax, T)
% erl
% 
% Para esta função em espefícico, o que teremos de passar, em cada rodada
% de simulação, são os valores de:
% 
%   - S; (da norma quadrática de xk).
%   - R; (da norma quadrática de uk).
%   - A; (da composição concatenada ddas matrizes 'As').
%   - B; (da composição concatenada ddas matrizes 'Bs').
%   - Umax (dos limites dos valores de entrada).
%   - T passo da Simulação.

switch flag

% =========================================================================    
case 0

n = size(A,2);               % Ordem das matrizes 'A';
p = size(B,2);               % Parâmetro da quantidade de entradas.
[sys,past_x0,str,ts] = mdlInitializeSizes(T,p,n); % S-function Initialization

% =========================================================================
case 2
sys = mdlUpdate(t,inputs);

% =========================================================================
case {1,4,9}
sys = []; % Unused Flags

% =========================================================================
case 3 % Evaluate Function
   
n = size(A,2);               % Ordem das matrizes 'A';
p = size(B,2);               % Parâmetro da quantidade de entradas.

alfa = size(A,1);            % # de linhas total de A.
beta = size(B,1);            % # de linhas total de B

qA = alfa/n;                 % # da matrizes 'A' (A1 e A2);
qB = beta/n;                 % # da matrizes 'B' (B1 e B2);
N  = qA*qB;                  % # Vértices Politopo ('2' de A e '2' de B);    
    
    
%% 1) Entrada dos 'sensores' (relativo aos estados).
xk = inputs;       % Estado medido x(k)
   
Ssqrt = sqrt(S);   % Diagonal matrix
Rsqrt = sqrt(R);   % Diagonal matrix

% Essa matriz será importante para fazer a 'restrição dos valores de
% entrada'.
E = eye(p);      % Identity matrix. en = nth column of E

setlmis([]);

%% (2) Definição das variáveis.

[g, m1, sg] = lmivar(1,[1 0]);     % Variável a ser minimizada '(g)amma'.
[Q, m2, sQ] = lmivar(1,[n 1]);     % Q (nxn) simétrica full-block.
[Y, m3, sY] = lmivar(2,[p n]);     % Y (pxn) retangular; 
[X, m4, sX] = lmivar(1,[p 1]);     % X (pxp) simétrica full-block.

%% (3) Determinação das LMI.
% (a) LMI (i)
LMI_Kothare = newlmi;
lmiterm([-LMI_Kothare 1 1 Q],1,1);   % Direita da LMI(-), pos (1,1), Var (Q).
lmiterm([-LMI_Kothare 1 2 0],xk);    % Direita da LMI(-), pos (1,2), Const (x(k)).
lmiterm([-LMI_Kothare 2 2 0],1);     % Direita da LMI(-), pos (1,2), Const '1' 
                                     % para representar a 'I', na dimensão apropriada.

% (b) LMI (ii);
for i=1:N
    ConjLMICombConvex(i) = newlmi;
    lmiterm([-ConjLMICombConvex(i) 1 1 Q],1,1);
    [Aj, Bj] = vertice(A,B,n,qB,i);              
    lmiterm([-ConjLMICombConvex(i) 1 4 Q],Aj,1);
    lmiterm([-ConjLMICombConvex(i) 1 4 Y],Bj,1);
    lmiterm([-ConjLMICombConvex(i) 2 2 g],1,1);
    lmiterm([-ConjLMICombConvex(i) 2 4 Q],Ssqrt,1);
    lmiterm([-ConjLMICombConvex(i) 3 3 g],1,1);
    lmiterm([-ConjLMICombConvex(i) 3 4 Y],Rsqrt,1);
    lmiterm([-ConjLMICombConvex(i) 4 4 Q],1,1);
end

% (c) LMI (iii);
InputConstraint = newlmi;
lmiterm([-InputConstraint 1 1 X],1,1);    % Direita da LMI(-), pos (1,1), Var (X).
lmiterm([-InputConstraint 1 2 Y],1,1);    % Direita da LMI(-), pos (1,2), Var (Y).
lmiterm([-InputConstraint 2 2 Q],1,1);    % Direita da LMI(-), pos (1,2), Var (Q).

% (d) LMI (iv);
for i = 1:p
    RestX(i) = newlmi;
    e = E(:,i);                         % Aqui pega só a base canônica 'e'.
    lmiterm([RestX(i) i i X],e',e);     % Lado esquerdo da desigualdade (+).
    lmiterm([-RestX(i) i i 0],Umax^2);  % Lado direito da desigualdade (-).
end

%% 4) Pega as LMI definidas acima.
SistemaLMIs = getlmis;


%% 5) Calcula a quantidade de variáveis a serem encontradas;
% Perceba que do jeito que aqui está escrito, o que temos diz respeito a
% minimização do valor do 'gamma'. Uma vez que o 'gamma' foi determinado
% como a 'PRIMEIRA lmivar', o seu valor será multiplicado pelo vetor de
% estados x(k) para que se minimize a função [c'x] sujeito as LMIs 
% programadas logo acima (SistemaLMIs).

numvar = m4;                % Quantidade total de variáveis do sistema.
c = zeros(numvar,1);
c(1) = 1;                   % Cost = 1*gamma

% options = [0 0 0 0 1];      % Trace off
options = [0 1000 0 0 1];   % Trace on

% Usa-se o 'tic' e o 'toc' para que possamos fazer o cálculo de quanto tempo
% demora o processo de otimizaçao em cada laçoa simulação.
tic            
[Copt, Xopt] = mincx(SistemaLMIs, c, options);
toc

Ysol = dec2mat(SistemaLMIs,Xopt,Y);
Qsol = dec2mat(SistemaLMIs,Xopt,Q);

K = Ysol*inv(Qsol)
uk = K*xk;

sys =  uk; % S-function output (control value)

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
sizes.NumOutputs     = p;
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