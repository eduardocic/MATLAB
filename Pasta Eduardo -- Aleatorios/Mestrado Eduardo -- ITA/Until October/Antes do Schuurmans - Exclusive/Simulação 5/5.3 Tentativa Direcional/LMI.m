function [sys, past_x0, str, ts] = LMI(t, past_x, inputs, flag, A, B, Umax, T)

%erl 
% - A: Matriz de Estado Completa A;
% - B: Matriz de Estado Completa B;
% - Epsilon: Vetor com a direção a ser minimizado.

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


xk = inputs(1:end);       % Estado medido x(k)    
    
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%
%                         RESOLUÇÃO DAS LMIs
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

[n, p, qA, qB, N] = ProcessamentoMatrizesEstado(A, B);

%% ------------------------------------------------------------------------ 
%                           (1) Inicializa LMIs.
% -------------------------------------------------------------------------

S  = eye(n);   Ssqrt = sqrt(S);    % S^(-1/2)
R  = eye(p);   Rsqrt = sqrt(R);    % R^(-1/2)
E  = eye(p);   % Importante para os valores da LMI (iv). 

    % 1.a) Limites Variáveis de Entrada.
    % Umax = 7;      % Pois no caso, o -1 <= U <= 1.

    % 1.b) Limites Variáveis de Saída.

% 1.c) Inicializar um conjunto de LMIs.
setlmis([]);


%% ------------------------------------------------------------------------
%                       (2) Definição das variáveis.
% -------------------------------------------------------------------------
[g, m1, sg] = lmivar(1,[1 0]);     % '(g)amma'.
[Q, m2, sQ] = lmivar(1,[n 1]);     % Q (nxn) simétrica full-block.
[Y, m3, sY] = lmivar(2,[p n]);     % Y (pxn) retangular; 


%% ------------------------------------------------------------------------
%                      (3) Determinação das LMI.
% -------------------------------------------------------------------------


% +++++++++++++++++++++++++++++++++++++++++++
% 3.a) LMI (i)                              +
%                                           +    
%     | Q  x(k)|  >= 0                  (i) +
%     | *   1  |                            +
% +++++++++++++++++++++++++++++++++++++++++++
LMI_Kothare = newlmi;
lmiterm([-LMI_Kothare 1 1 Q],1,1);           % Direita da LMI(-), P(1,1), Var (Q).
lmiterm([-LMI_Kothare 1 2 0],xk);            % Direita da LMI(-), P(1,2).
lmiterm([-LMI_Kothare 2 2 0],1);             % Direita da LMI(-), pos (1,2), '1' 
                                             % Representar 'I', na dim. apropriada.
                                                   
% +++++++++++++++++++++++++++++++++++++++++++                                     
% 3.b) LMI (ii);                            +
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
    [Aj, Bj] = vertice(A,B,n,qB,i);            
    lmiterm([-ConjLMICombConvex(i) 1 4 Q],Aj,1);
    lmiterm([-ConjLMICombConvex(i) 1 4 Y],Bj,1);
    lmiterm([-ConjLMICombConvex(i) 2 2 g],1,1);
    lmiterm([-ConjLMICombConvex(i) 2 4 Q],Ssqrt,1);
    lmiterm([-ConjLMICombConvex(i) 3 3 g],1,1);
    lmiterm([-ConjLMICombConvex(i) 3 4 Y],Rsqrt,1);
    lmiterm([-ConjLMICombConvex(i) 4 4 Q],1,1);
end


%% ------------------------------------------------------------------------
%                      (4) Pega as LMI definidas acima.
% -------------------------------------------------------------------------

SistemaLMIs = getlmis;


%% ------------------------------------------------------------------------
%      (5) Calcula a quantidade de variáveis a serem encontradas.
% -------------------------------------------------------------------------

NumVar = m3;                %   Quantidade total de variáveis do sistema.
c = zeros(NumVar,1);        %   Vetor de zeros.
c(1) = 1;                   %   Apenas o primeiro elemento do vetor como 1,
                            % pois o mesmo será multiplicado por 'Beta'.

% +++++++++++++++++++++++++++++++++++++++++++++++++                                     
% 5.a) Opções para vizualização dos resultados.   +
%                                                 +
options = [0 200 1e15 0 0];      % Trace off         
% +++++++++++++++++++++++++++++++++++++++++++++++++                                     

% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++                                     
% 5.b) Usa-se o 'tic' e o 'toc' para que possamos fazer o cálculo +
%      de quanto tempo demora o processo de OTIMIZAÇÃO em cada    +
%      laço da simulação.                                         +
%                                                                 +
% tic                                                             % +
[Copt, Xopt] = mincx(SistemaLMIs, c, options);                  % +               
% toc                                                             % +
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

Ysol = dec2mat(SistemaLMIs, Xopt, Y);
Qsol = dec2mat(SistemaLMIs, Xopt, Q);

%% Determinação da Matriz F, tal que: u*(k) = F.x(k)
F = Ysol*inv(Qsol);

%% Saída de Controle.
u = F*xk;


%% Saída do sistema.
sys = u;

end


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
