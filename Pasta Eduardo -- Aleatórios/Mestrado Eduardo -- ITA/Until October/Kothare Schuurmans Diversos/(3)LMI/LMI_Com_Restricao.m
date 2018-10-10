function [sys, past_x0, str, ts] = LMI_Com_Restricao(t, past_x, inputs, flag, A, B, Umax, T)

switch flag
    
case 0
n = size(A,2);               % Ordem das matrizes 'A';
p = size(B,2);               % Par�metro da quantidade de entradas.
[sys,past_x0,str,ts] = mdlInitializeSizes(T,p,n); % S-function Initialization

case 2
sys = mdlUpdate(t,inputs);

case {1,4,9}
sys = []; % Unused Flags

case 3 % Evaluate Function
   
[n, p, qA, qB, N] = ParametersSteadyState(A, B);
    
xk = inputs;       % Estado medido x(k)
   
S  = eye(n);   Ssqrt = sqrt(S);    % S^(-1/2)
R  = eye(p);   Rsqrt = sqrt(R);    % R^(-1/2)
E  = eye(p);   % Importante para os valores da LMI (iv). 

setlmis([]);


%% (2) Defini��o das vari�veis.
[g, m1, sg] = lmivar(1,[1 0]);     % Vari�vel a ser minimizada '(g)amma'.
[Q, m2, sQ] = lmivar(1,[n 1]);     % Q (nxn) sim�trica full-block.
[Y, m3, sY] = lmivar(2,[p n]);     % Y (pxn) retangular; 
[X, m4, sX] = lmivar(1,[p 1]);     % X (pxp) sim�trica full-block.

% +++++++++++++++++++++++++++++++++++++++++++
% (a) LMI do Kothare.
% -------------------
%  | Q  x(k) | >= 0               
%  | *   1   | 
% +++++++++++++++++++++++++++++++++++++++++++ 
LMI_Kothare = newlmi;
lmiterm([-LMI_Kothare 1 1 Q],1,1);   % Direita da LMI(-), pos (1,1), Var (Q).
lmiterm([-LMI_Kothare 1 2 0],xk);    % Direita da LMI(-), pos (1,2), Const (x(k)).
lmiterm([-LMI_Kothare 2 2 0],1);     % Direita da LMI(-), pos (1,2), Const '1' 
                                     % para representar a 'I', na dimens�o apropriada.

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
    [Aj, Bj] = Vertice(A,B,n,qB,i);              
    lmiterm([-ConjLMICombConvex(i) 1 4 Q],Aj,1);
    lmiterm([-ConjLMICombConvex(i) 1 4 Y],Bj,1);
    lmiterm([-ConjLMICombConvex(i) 2 2 g],1,1);
    lmiterm([-ConjLMICombConvex(i) 2 4 Q],Ssqrt,1);
    lmiterm([-ConjLMICombConvex(i) 3 3 g],1,1);
    lmiterm([-ConjLMICombConvex(i) 3 4 Y],Rsqrt,1);
    lmiterm([-ConjLMICombConvex(i) 4 4 Q],1,1);
end

% +++++++++++++++++++++++++++++++++++++++++++                                     
% 3.c) LMI (iii);                           +
%                                           +
%     | X  Y |  >= 0                  (iii) +   
%     | *  Q |                              +
% +++++++++++++++++++++++++++++++++++++++++++              
InputConstraint = newlmi;
lmiterm([-InputConstraint 1 1 X],1,1);    % Direita da LMI(-), pos (1,1), Var (X).
lmiterm([-InputConstraint 1 2 Y],1,1);    % Direita da LMI(-), pos (1,2), Var (Y).
lmiterm([-InputConstraint 2 2 Q],1,1);    % Direita da LMI(-), pos (1,2), Var (Q).

% +++++++++++++++++++++++++++++++++++++++++++++++++                                     
% 3.d) LMI (iv);                                  +
%                                                 +
%  Essa LMI faz juz ao limitante de entrada.      +
%                                                 +
%     | 1   Umax,l  | <= 0              (iv)      + 
%     | *    X,ll   |                             +
%     para todo l = 1,...,p.                      +
% +++++++++++++++++++++++++++++++++++++++++++++++++
for i = 1:p
    RestX(i) = newlmi;
    e = E(:,i);                         % Aqui pega s� a base can�nica 'e'.
    lmiterm([RestX(i) i i X],e',e);     % Lado esquerdo da desigualdade (+).
    lmiterm([-RestX(i) i i 0],Umax^2);  % Lado direito da desigualdade (-).
end

%% 4) Pega as LMI definidas acima.
SistemaLMIs = getlmis;

NumVar = decnbr(SistemaLMIs);
c = zeros(NumVar,1);
c(1) = 1;                   

options = [0 200 0 0 1];           
[Copt, Xopt] = mincx(SistemaLMIs, c, options);

Ysol = dec2mat(SistemaLMIs, Xopt, Y);
Qsol = dec2mat(SistemaLMIs, Xopt, Q);

F = Ysol*inv(Qsol);
uk = F*xk;

% Colocarei na Sa�da os seguite vetor [u' F]
sys =  [uk F];              % S-function output (control value)

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
sizes.NumOutputs     = (p + n); % u + F
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