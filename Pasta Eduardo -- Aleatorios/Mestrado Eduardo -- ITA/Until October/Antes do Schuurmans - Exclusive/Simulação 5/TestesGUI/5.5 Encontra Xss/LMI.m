function [sys, past_x0, str, ts] = LMI(t, past_x, inputs, flag, A, B, Umax, T)

%erl 
% - A: Matriz de Estado Completa A;
% - B: Matriz de Estado Completa B;
% - Epsilon: Vetor com a dire��o a ser minimizado.

switch flag

% =========================================================================    
case 0

n = size(A,2);               % Ordem das matrizes 'A';
p = size(B,2);               % Par�metro da quantidade de entradas.
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
%                         RESOLU��O DAS LMIs
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

[n, p, qA, qB, N] = ProcessamentoMatrizesEstado(A, B);

%% ------------------------------------------------------------------------ 
%                           (1) Inicializa LMIs.
% -------------------------------------------------------------------------

S  = eye(n);   Ssqrt = sqrt(S);    % S^(-1/2)
R  = eye(p);   Rsqrt = sqrt(R);    % R^(-1/2)
E  = eye(p);   % Importante para os valores da LMI (iv). 

    % 1.a) Limites Vari�veis de Entrada.
    % Umax = 7;      % Pois no caso, o -1 <= U <= 1.

    % 1.b) Limites Vari�veis de Sa�da.

% 1.c) Inicializar um conjunto de LMIs.
setlmis([]);


%% ------------------------------------------------------------------------
%                       (2) Defini��o das vari�veis.
% -------------------------------------------------------------------------
[g, m1, sg]     = lmivar(1,[1 0]);     % '(g)amma'.
[Q, m2, sQ]     = lmivar(1,[n 1]);     % Q (nxn) sim�trica full-block.
[Y, m3, sY]     = lmivar(2,[p n]);     % Y (pxn) retangular; 
[X, m4, sX]     = lmivar(1,[p 1]);     % X (pxp) sim�trica full-block.

[Xss, m4, sXss] = lmivar(2,[n 1]); 

[Eta, m5, sEta] = lmivar(1,[1 0]);     % Vari�vel a ser minimizada 'Eta' no Custo.

%% ------------------------------------------------------------------------
%                      (3) Determina��o das LMI.
% -------------------------------------------------------------------------


% +++++++++++++++++++++++++++++++++++++++++++
% (b) LMI do Kothare.
% -------------------
%  | Q  x(k)-Xss | >= 0               
%  | *      1    | 
% +++++++++++++++++++++++++++++++++++++++++++ 
LMI_Kothare = newlmi;
lmiterm([-LMI_Kothare 1 1 Q],1,1);    % Direita da LMI(-), pos (1,1), Var (Q).
lmiterm([-LMI_Kothare 1 2 0],xk);     % Direita da LMI(-), pos (1,2), Const (x(k)).
lmiterm([-LMI_Kothare 1 2 Xss],1,-1); % Direita da LMI(-), pos (1,2), -H.z.
lmiterm([-LMI_Kothare 2 2 0],1);      % Direita da LMI(-), pos (1,2), Const '1'
                                                   
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



% +++++++++++++++++++++++++++++++++++++++++++                                                                         
% 3.c) LMI do "Steady State".
% --------------------------
%     | I   Xss | >= 0                 
%     | *   Eta | 
LMIss   = newlmi;
I = eye(size(A,2));                % I (nxn)
lmiterm([-LMIss 1 1 0],I);
lmiterm([-LMIss 1 2 Xss],1,1);     % Direita da LMI(-), pos (1,2), Xss.
lmiterm([-LMIss 2 2 Eta],1,1);


% +++++++++++++++++++++++++++++++++++++++++++                                     
% 3.d) LMI (iii);                           +
%                                           +
%     | X  Y |  >= 0                  (iii) +   
%     | *  Q |                              +
% +++++++++++++++++++++++++++++++++++++++++++                                     
InputConst = newlmi;
lmiterm([-InputConst 1 1 X],1,1);    % Direita da LMI(-), pos (1,1), Var (X).
lmiterm([-InputConst 1 2 Y],1,1);    % Direita da LMI(-), pos (1,2), Var (Y).
lmiterm([-InputConst 2 2 Q],1,1);    % Direita da LMI(-), pos (1,2), Var (Q).

% +++++++++++++++++++++++++++++++++++++++++++++++++                                     
% 3.e) LMI (iv);                                  +
%                                                 +
%  Essa LMI faz juz ao limitante de entrada.      +
%                                                 +
%     | 1   Umax,l  | <= 0              (iv)      + 
%     | *    X,ll   |                             +
%     para todo l = 1,...,p.                      +
% +++++++++++++++++++++++++++++++++++++++++++++++++
RestX = newlmi;                      % Restri��es em X.
for i = 1:p
    e = E(:,i);                      % Aqui pega s� a base can�nica 'e'.
    lmiterm([RestX i i X],e',e);     % Lado esquerdo da desigualdade (+).
    lmiterm([-RestX i i 0],Umax^2);  % Lado direito da desigualdade (-).
end



%% ------------------------------------------------------------------------
%                      (4) Pega as LMI definidas acima.
% -------------------------------------------------------------------------

SistemaLMIs = getlmis;


%% ------------------------------------------------------------------------
%      (5) Calcula a quantidade de vari�veis a serem encontradas.
% -------------------------------------------------------------------------

NumVar = decnbr(SistemaLMIs);  % Quantidade total de vari�veis do sistema.
c = zeros(NumVar,1);           %   Vetor de zeros.
c(end) = 1;                    %   Apenas o primeiro elemento do vetor como 1,
                               % pois o mesmo ser� multiplicado por 'Beta'.

% +++++++++++++++++++++++++++++++++++++++++++++++++                                     
% 5.a) Op��es para vizualiza��o dos resultados.   +
%                                                 +
options = [0 200 1e15 0 1];      % Trace off         
% +++++++++++++++++++++++++++++++++++++++++++++++++                                     

% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++                                     
% 5.b) Usa-se o 'tic' e o 'toc' para que possamos fazer o c�lculo +
%      de quanto tempo demora o processo de OTIMIZA��O em cada    +
%      la�o da simula��o.                                         +
%                                                                 +
% tic                                                             % +
[Copt, Xopt] = mincx(SistemaLMIs, c, options);                  % +               
% toc                                                             % +
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

Ysol = dec2mat(SistemaLMIs, Xopt, Y);
Qsol = dec2mat(SistemaLMIs, Xopt, Q);
Eta = dec2mat(SistemaLMIs,Xopt,Eta);
Xss = dec2mat(SistemaLMIs,Xopt,Xss);

%% Determina��o da Matriz F, tal que: u*(k) = F.x(k)
F = Ysol*inv(Qsol);

%% Sa�da de Controle.


u = F*(xk - Xss);

%% Sa�da do sistema.
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
