function [sys,past_x0,str,ts] = ForaDominioAtracao(t, past_x, inputs, flag, S, R, A, B, Umax, T, rho, epsilon)
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



% -------------------------------------
% (b) Inicializa as Variáveis das LMIs.
% -------------------------------------
setlmis([]);

[g, m1, sg]     = lmivar(1,[1 0]);     % Variável a ser minimizada '(g)amma' no Custo.
[Eta, m2, sEta] = lmivar(1,[1 0]);     % Variável a ser minimizada 'Eta' no Custo.
[Xss, m3, sXss] = lmivar(2,[n 1]);     % Xss (nx1)- Steady State que desejo encontrar.
[Uss, m4, sUss] = lmivar(2,[p 1]);     % Uss (px1)- Steady State que desejo encontrar.
[Q, m5, sQ]     = lmivar(1,[n 1]);     % Q (nxn) simétrica full-block.
[Y, m6, sY]     = lmivar(2,[p n]);     % Y (pxn) retangular; 
[X, m7, sX]     = lmivar(1,[p 1]);     % X (pxp) simétrica full-block.

% -------------------
% (c) LMI do Kothare.
% -------------------
%     | Q  x(k)-Xss|  >= 0               
%     | *     1    | 

LMI_Kothare = newlmi;
lmiterm([-LMI_Kothare 1 1 Q],1,1);       % Direita da LMI(-), pos (1,1), Var (Q).
lmiterm([-LMI_Kothare 1 2 0],xk);        % Direita da LMI(-), pos (1,2), Const (x(k)).
lmiterm([-LMI_Kothare 1 2 Xss],-1,1);    % Direita da LMI(-), pos (1,2), -Xss.
lmiterm([-LMI_Kothare 2 2 0],1);         % Direita da LMI(-), pos (1,2), Const '1'. 
                                         
                                     
% -------------------------------                                     
% (d) LMIs da Combinação Convexa.
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

% -------------------------                                     
% (d) LMI das "Igualdades".
% -------------------------
%     |I    (I-Aj).Xss - Bj.Uss| >= 0   
%     |*           epsilon     | 
%     para todo J = 1,...,N (=qA*qB);

for i=1:N
    LMIdasIgualdades(i) = newlmi;
    [Aj, Bj] = vertice(A,B,n,qB,i);
    Aconj = eye(size(Aj,2)) - Aj;                     % (I-Aj)
    I = eye(size(Aconj,2));
    lmiterm([-LMIdasIgualdades(i) 1 1 0],I);
    lmiterm([-LMIdasIgualdades(i) 1 2 Xss],Aconj,1);  % (I-Aj).Xss
    lmiterm([-LMIdasIgualdades(i) 1 2 Uss],Bj,-1);    % -Bj.Xss
    lmiterm([-LMIdasIgualdades(i) 2 2 0],epsilon);
end

% --------------------------                                     
% (e) LMI do "Steady State".
% --------------------------
%     | I   Xss | >= 0                 
%     | *   Eta | 

LMIss   = newlmi;
I = eye(size(A,2));              % I (nxn)
lmiterm([-LMIss 1 1 0],I);
lmiterm([-LMIss 1 2 Xss],1,1);
lmiterm([-LMIss 2 2 Eta],1,1);

% -------------------------------                                     
% (f) LMI dos limites da entrada.
% -------------------------------
%     | X  Y |  >= 0                  
%     | *  Q |

InputConst = newlmi;
lmiterm([-InputConst 1 1 X],1,1);    % Direita da LMI(-), pos (1,1), Var (X).
lmiterm([-InputConst 1 2 Y],1,1);    % Direita da LMI(-), pos (1,2), Var (Y).
lmiterm([-InputConst 2 2 Q],1,1);    % Direita da LMI(-), pos (1,2), Var (Q).

% -----------------------------------                                    
% (g) LMI dos limites da entrada (I).
% -----------------------------------
%     | 1     Uss,l  | >= 0           
%     | *  (Umax,l)^2| 
%     para todo l = 1,...,p.
%
% Essa LMI é interessante pois ela faz a ratificação de que todos os 'Us'
% do sistema, na situação de estado estacionário (SS), estejam dentro dos
% limitantes para a sua própria variável.

for i = 1:p
    LMIlimitantesEntrada(i) = newlmi; 
    e = E(:,i);                                         % Aqui pega só a base canônica 'e'.
    lmiterm([-LMIlimitantesEntrada(i) 1 1 0],1);     
    lmiterm([-LMIlimitantesEntrada(i) 1 2 Uss],e',1);   % Pega só o 'l-ésimo' termo da entrada
    lmiterm([-LMIlimitantesEntrada(i) 2 2 0],Umax(i)^2);     
end


% % ------------------------------------                                    
% % (h) LMI dos limites da entrada (II).
% % ------------------------------------
% %     | 1  (Umax,l - Uss,l)  | <= 0   
% %     | *       X,ll         | 
% %     para todo l = 1,...,p. 
% 
% for i = 1:p
%     LMI_Entrada_2(i) = newlmi;
%     e = E(:,i);                                         % Aqui pega só a base canônica 'e'.
%     lmiterm([LMI_Entrada_2(i) 1 1 0],1);     
%     lmiterm([LMI_Entrada_2(i) 1 2 0],Umax(i));          % Umax
%     lmiterm([LMI_Entrada_2(i) 1 2 Uss],e',-1);          % -Uss,l
%     lmiterm([LMI_Entrada_2(i) 2 2 X],e',e);
% end
% 
% 
% -------------------------------------                                    
% (h) LMI dos limites da entrada (III).
% -------------------------------------
%     | 1  (Umax,l + Uss,l)  | <= 0   
%     | *       X,ll         | 
%     para todo l = 1,...,p.

% for i = 1:p
%     LMI_Entrada_3(i) = newlmi;
%     e = E(:,i);                                         % Aqui pega só a base canônica 'e'.
%     lmiterm([LMI_Entrada_3(i) 1 1 0],1);     
%     lmiterm([LMI_Entrada_3(i) 1 2 0],Umax(i));          % Umax
%     lmiterm([LMI_Entrada_3(i) 1 2 Uss],e',1);           % Uss,l
%     lmiterm([-LMI_Entrada_3(i) 2 2 X],e',e);
% end

%-----------------------------
% Pega as LMI definidas acima.
%-----------------------------
SistemaLMIs = getlmis;

numvar = decnbr(SistemaLMIs); % Quantidade total de variáveis do sistema.
c = zeros(numvar,1);
c(1) = rho;                    % Cost = rho*gamma
c(2) = 1;                      % Cost = Eta

options = [0 0 0 0 1];       % Trace off
% options = [0 100 0 0 0];   % Trace on

% Usa-se o 'tic' e o 'toc' para que possamos fazer o cálculo de quanto tempo
% demora o processo de otimizaçao em cada laçoa simulação.
tic            
[Copt, Xopt] = mincx(SistemaLMIs, c, options);
toc

Ysol = dec2mat(SistemaLMIs,Xopt,Y);
Qsol = dec2mat(SistemaLMIs,Xopt,Q);

F = Ysol*inv(Qsol);

Xss_sol = Xopt(3:4)
Uss_sol = Xopt(5);

% uk = F*(xk - Xss_sol) + Uss;
uk = F*(xk - Xss_sol);

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