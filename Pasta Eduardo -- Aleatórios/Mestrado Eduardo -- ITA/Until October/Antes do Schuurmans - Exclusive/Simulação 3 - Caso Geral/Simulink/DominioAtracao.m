function [sys,past_x0,str,ts] = DominioAtracao(t, past_x, inputs, flag, A, B, S, R, H, Umax, T, rho)
% erl
% Para esta função em espefícico, o que teremos de passar, em cada rodada
% de simulação, são os valores de:
% 
%   - S; (da norma quadrática de xk).
%   - R; (da norma quadrática de uk).
%   - A; (da composição concatenada ddas matrizes 'As').
%   - B; (da composição concatenada ddas matrizes 'Bs').
%   - H; (leva ao espaço nulo da matriz Aeq).
%   - Umax; (dos limites dos valores de entrada).
%   - T; (passo da Simulação).

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
% --------------------------------------------------

xk = inputs(1:end);       % Estado medido x(k)

Ssqrt = sqrt(S);   % Diagonal matrix
Rsqrt = sqrt(R);   % Diagonal matrix

E = eye(p);        % Matriz Identidade de ordem p.

% -------------------------------------
% (a) Inicializa as Variáveis das LMIs.
% -------------------------------------
setlmis([]);

[g, m1, sg]     = lmivar(1,[1 0]);         % Variável a ser minimizada '(g)amma'.
[Q, m2, sQ]     = lmivar(1,[n 1]);         % Q (nxn) simétrica full-block.
[Y, m3, sY]     = lmivar(2,[p n]);         % Y (pxn) retangular; 
[X, m4, sX]     = lmivar(1,[p 1]);         % X (pxp) simétrica full-block.

[Eta, m5, sEta] = lmivar(1,[1 0]);         % Variável a ser minimizada 'Eta' no Custo.
[z, m6, sz]     = lmivar(1,[1 0]);         % z (nx1)- Variável que gostaremos de minimizar.


% -------------------
% (b) LMI do Kothare.
% -------------------
%  | Q  x(k)-H.z | >= 0               
%  | *      1    | 
LMI_Kothare = newlmi;
lmiterm([-LMI_Kothare 1 1 Q],1,1);    % Direita da LMI(-), pos (1,1), Var (Q).
lmiterm([-LMI_Kothare 1 2 0],xk);     % Direita da LMI(-), pos (1,2), Const (x(k)).
lmiterm([-LMI_Kothare 1 2 z],H,-1);   % Direita da LMI(-), pos (1,2), -H.z.
lmiterm([-LMI_Kothare 2 2 0],1);      % Direita da LMI(-), pos (1,2), Const '1'
                                     
% -------------------------------                                     
% (c) LMIs da Combinação Convexa.
% -------------------------------
%     | Q  0  0  (AjQ + BjY) |          
%     | *  gI 0   S^(1/2)Q   | >= 0    
%     | *  *  gI  R^(1/2)Y   |
%     | *  *  *        Q     |
%     para todo J = 1,...,N (=qA*qB);
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

% --------------------------                                     
% (c) LMI do "Steady State".
% --------------------------
%     | I   H.z | >= 0                 
%     | *   Eta | 
LMIss   = newlmi;
I = eye(size(A,2));              % I (nxn)
lmiterm([-LMIss 1 1 0],I);
lmiterm([-LMIss 1 2 z],H,1);     % Direita da LMI(-), pos (1,2), -Hz.
lmiterm([-LMIss 2 2 Eta],1,1);

% -------------------------------                                     
% (d) LMI dos limites da entrada.
% -------------------------------
%     | X  Y |  >= 0                  
%     | *  Q |
InputConst = newlmi;
lmiterm([-InputConst 1 1 X],1,1);    % Direita da LMI(-), pos (1,1), Var (X).
lmiterm([-InputConst 1 2 Y],1,1);    % Direita da LMI(-), pos (1,2), Var (Y).
lmiterm([-InputConst 2 2 Q],1,1);    % Direita da LMI(-), pos (1,2), Var (Q).

% -------------------------------                                     
% (e) LMI dos limites da entrada.
% -------------------------------
RestX = newlmi;                      % Restrições em X.
for i = 1:p
    e = E(:,i);                      % Aqui pega só a base canônica 'e'.
    lmiterm([RestX i i X],e',e);     % Lado esquerdo da desigualdade (+).
    lmiterm([-RestX i i 0],Umax^2);  % Lado direito da desigualdade (-).
end

% -------------------------------                                     
% (e) LMI dos limites da entrada.
% -------------------------------
RestX = newlmi;                      % Restrições em X.
for i = 1:p
    e = E(:,i);                      % Aqui pega só a base canônica 'e'.
    lmiterm([RestX i i X],e',e);     % Lado esquerdo da desigualdade (+).
    lmiterm([-RestX i i 0],Umax^2);  % Lado direito da desigualdade (-).
end

% ----------------------------------
% (END) Pega as LMI definidas acima.
% ----------------------------------
SistemaLMIs = getlmis;

%% =========================================================================

numvar = decnbr(SistemaLMIs);  % Quantidade total de variáveis do sistema.
c    = zeros(numvar,1);
c(1) = rho;                    % Cost = rho*gamma
c(8) = 1;                      % Cost = Eta

options = [0 1000 0 0 1];       % Trace off
% options = [0 1000 0 0 0];      % Trace on

% tic            
[Copt, Xopt] = mincx(SistemaLMIs, c, options);
% toc

Ysol = dec2mat(SistemaLMIs,Xopt,Y);
Qsol = dec2mat(SistemaLMIs,Xopt,Q);
z   = Xopt(9);
Eta = Xopt(8);


F = Ysol*inv(Qsol);
Xss_sol = H*z;
uk = F*(xk - Xss_sol);


% if t<1
%    XssIntermed = H*z;
%    uk = F*(xk - H*z);
% else
%    XssIntermed = XssIntermed;
%    uk = F*(xk - XssIntermed);
% end

% sys =  [uk XssIntermed']; % S-function output (control value)
sys =  uk; 

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