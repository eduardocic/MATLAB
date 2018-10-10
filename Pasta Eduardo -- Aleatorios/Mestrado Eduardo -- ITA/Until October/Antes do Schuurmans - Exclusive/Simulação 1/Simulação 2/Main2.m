%% ========================================================================
%                            2º Parte.
% =========================================================================
 
%--------------------------------------------------------------------------
% 1) Determinação de algum ponto de equilíbrio.

% Só executado para tentar encontrar uma solução não trivial.
% 
% A1_linha = eye(size(A1,2)) - A1;
% A2_linha = eye(size(A2,2)) - A2;
% A = [A1_linha; A2_linha];
% B = [B;B];
% SisIndeterminado = [A -B];
% rref(SisIndeterminado);
% b = linspace(0,0,4)';
% 
% x = SisIndeterminado\b;         % Solução para 'Ax = b' 
%--------------------------------------------------------------------------
close all; clear; clc;

%% ------------------------------------------------------------------------
%               (1) Definição das matrizes incertas.
% -------------------------------------------------------------------------

A1 = [   0   1;
      -1.5 2.5];
  
A2 = [   0   1;
      -0.8 1.8];  

B = [0;
     1];
 
%% ------------------------------------------------------------------------
%                   (2) Determinação do Cone G.
% -------------------------------------------------------------------------
 
n = size(A1,2);     % Ordem das matrizes 'A' (n x n). Pego o valor de 'n';
p = size(B,2);      % Parâmetro de entradas de B (n x p). Pego o valor de 'p';

% Concatena as matrizes de incertezas A e B.
A = [A1;
     A2];
B = [B];

alfa = size(A,1);
beta = size(B,1);
qA = alfa/n;                 % # da matrizes 'A' (A1 e A2);
qB = beta/n;                 % # da matrizes 'B' (B);
N  = qA*qB;                  % # Vértices Politopo ('2' de A e '1' de B);


% =========================================================================
%        Determinação dos pesos e variáveis que entrarão no sistema.
% =========================================================================

% ---------------------------------------
% (a) Constantes e Valores Iniciais LMIs.
% ---------------------------------------

rho     = 1;        % Peso dado a variável 'gamma'.
epsilon = 0.0005;  % Vem lá da LMI oriunda da igualdade do sistema (arquivo 'Main').

S  = eye(n);   Ssqrt = sqrt(S);    % S^(-1/2)
R  = eye(p);   Rsqrt = sqrt(R);    % R^(-1/2)
E  = eye(p);    % Importante para os valores da LMI (iv). 

xk = [5;1];     % Deu não factível para xk = [5; 1];

Umax = 1;      % Pois no caso, o -1 <= U <= 1.


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
%     lmiterm([LMI_Entrada_3(i) 2 2 X],e',e);
% end

%-----------------------------
% Pega as LMI definidas acima.
%-----------------------------
SistemaLMIs = getlmis;

numvar = decnbr(SistemaLMIs); % Quantidade total de variáveis do sistema.
c = zeros(numvar,1);
c(1) = rho;                    % Cost = rho*gamma
c(2) = 1;                      % Cost = Eta

% options = [0 0 0 0 1];       % Trace off
options = [0 100 0 0 0];   % Trace on

% Usa-se o 'tic' e o 'toc' para que possamos fazer o cálculo de quanto tempo
% demora o processo de otimizaçao em cada laçoa simulação.
tic            
[Copt, Xopt] = mincx(SistemaLMIs, c, options);
toc

Ysol = dec2mat(SistemaLMIs,Xopt,Y);
Qsol = dec2mat(SistemaLMIs,Xopt,Q);

F = Ysol*inv(Qsol);
Xss_sol = Xopt(3:4);
Uss_sol = Xopt(5);
u = F*(xk - Xss_sol) + Uss
