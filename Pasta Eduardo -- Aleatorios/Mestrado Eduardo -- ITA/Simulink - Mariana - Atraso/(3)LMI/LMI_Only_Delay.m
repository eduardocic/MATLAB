function [sys, past_wu0, str, ts] = LMI_With_Assimetric_Restriction(t, past_u, inputs, flag,... 
                                                                    Ad, Bd, Cd,...
                                                                    tao, Smeio,...
                                                                    Rmeio, Umax, T)
switch flag
        
case 0
n = size(Ad{1},1);    % (n+tao) x (n+tao) [z(k) u(k-1) ... u(k-tao)].
p = size(Bd{1},2);    % nº de variáveis de controle u(k).
[sys, past_wu0, str, ts] = mdlInitializeSizes(T, p, n, tao); % Inicialização.


case 2
% n = size(Aa{1},1);    % (n+tao) x (n+tao)
% p = size(Ba{1},2);    % nº de variáveis de controle
sys = mdlUpdate(t, past_u, tao);


case {1,4,9}
sys = [];      % Flags não utilizadas.


case 3         % Calcula a Função    
% -------------------------------------------------------------------------
%                                 PREÂNBULO
%
% -------------------------------------------------------------------------
global uk

N = max(size(Ad));     % Quantidade de Vértices do Politopo.
n = size(Ad{1},1);     % x(k) = [z(k) u(k-1) ... u(k-tao)] -- SEM INTEGRADOR
p = size(Bd{1},2);     % Quantidade de entradas u(k)'s.
    
zk = inputs;           % Estado medido.
E  = eye(p);           % Importante para os valores da LMI (iv). 

% Reconstrução do estado aumentado para x(k).
xk = [zk past_u']';     %[z(k) past_u] -- n
setlmis([]);

[g, m1, sg] = lmivar(1,[1 0]);      % Variável a ser minimizada '(g)amma'.
[Q, m2, sQ] = lmivar(1,[n 1]);      % Q (nxn) simétrica full-block
[Y, m3, sY] = lmivar(2,[p n]);      % Y (pxn) retangular.
[X, m4, sX] = lmivar(1,[p 1]);      % X (pxp) simétrica full-block.





% -------------------------------------------------------------------------
%                            FORMAÇÃO LMI's
%
% -------------------------------------------------------------------------

% +++++++++++++++++++++++++++++++++++++++++++
% (a) LMI do Kothare.
% -------------------
%  | Q  x(k)| >= 0               
%  | *   1  | 
% +++++++++++++++++++++++++++++++++++++++++++
LMI_Kothare1 = newlmi;
lmiterm([-LMI_Kothare1 1 1 Q],1,1); % Direita da LMI(-), pos (1,1), Var (Q).
lmiterm([-LMI_Kothare1 1 2 0],xk);  % Direita da LMI(-), pos (1,2), Const (x(k)).
lmiterm([-LMI_Kothare1 2 2 0],1);   % Direita da LMI(-), pos (1,2), Const '1' 


% +++++++++++++++++++++++++++++++++++++++++++                                     
% b) LMI (ii);                              +
%                                           +
%     | Q  0  0  (AjQ + BjY) |              +
%     | *  gI 0   S^(1/2)Q   | >= 0    (ii) +
%     | *  *  gI  R^(1/2)Y   |              +
%     | *  *  *       Q      |              +
%     para todo j = 1,...,N ( = qA*qB);     +
% +++++++++++++++++++++++++++++++++++++++++++  
for i=1:N
    LMI_Kothare2(i) = newlmi;
    lmiterm([-LMI_Kothare2(i) 1 1 Q],1,1);
    sQ
    Ad{i}
    sY
    Bd{i}
    lmiterm([-LMI_Kothare2(i) 1 4 Q],Ad{i},1);
    lmiterm([-LMI_Kothare2(i) 1 4 Y],Bd{i},1);
    lmiterm([-LMI_Kothare2(i) 2 2 g],1,1);
    lmiterm([-LMI_Kothare2(i) 2 4 Q],Smeio,1);
    lmiterm([-LMI_Kothare2(i) 3 3 g],1,1);
    lmiterm([-LMI_Kothare2(i) 3 4 Y],Rmeio,1);
    lmiterm([-LMI_Kothare2(i) 4 4 Q],1,1);
end


% +++++++++++++++++++++++++++++++++++++++++++                                     
% c) LMI (iii);                             +
%                                           +
%     | X  Y |  >= 0                  (iii) +   
%     | *  Q |                              +
% +++++++++++++++++++++++++++++++++++++++++++              
LMI_Kothare3 = newlmi;
lmiterm([-LMI_Kothare3 1 1 X],1,1);    % Direita da LMI(-), pos (1,1), Var (X).
lmiterm([-LMI_Kothare3 1 2 Y],1,1);    % Direita da LMI(-), pos (1,2), Var (Y).
lmiterm([-LMI_Kothare3 2 2 Q],1,1);    % Direita da LMI(-), pos (1,2), Var (Q).


% +++++++++++++++++++++++++++++++++++++++++++++++++                                     
% d) LMI (iv);                                    +
%                                                 +
%  Essa LMI faz juz ao limitante de entrada.      +
%                                                 +
%     | 1   Umax,l  | <= 0              (iv)      + 
%     | *    X,ll   |                             +
%     para todo l = 1,...,p.                      +
% +++++++++++++++++++++++++++++++++++++++++++++++++
for i = 1:p
    LMI_Kothare4(i) = newlmi;
    e = E(:,i);                                % Aqui pega só a base canônica 'e'.
    lmiterm([LMI_Kothare4(i) i i X],e',e);     % Lado esquerdo da desigualdade (+).
    lmiterm([-LMI_Kothare4(i) i i 0],Umax^2);  % Lado direito da desigualdade (-).
end


% -------------------------------------------------------------------------
%                            EXTRAI RESULTADOS
%
% -------------------------------------------------------------------------

%%% 1. Cálculo do Custo.
SistemaLMIs = getlmis;
NumVar = decnbr(SistemaLMIs);
c    = zeros(NumVar,1);
c(1) = 1;   % Gamma.

%%% 2. Pega os resultados.
options = [0 200 0 0 1];             
[Copt, Xopt] = mincx(SistemaLMIs, c, options);  
Ysol = dec2mat(SistemaLMIs, Xopt, Y);
Qsol = dec2mat(SistemaLMIs, Xopt, Q);
F   = Ysol*inv(Qsol);

%%% 3. Saída.
uk = F*xk;
sys =  uk; 
end


function [sys, past_u0, str, ts] = mdlInitializeSizes(T, p, n, tao)

% -------------------------------------------------------------------------
% n      -- [z(k) u(k-1) ... u(k-tao)].
% tao    -- delay
sizes = simsizes;

sizes.NumContStates  = 0;
sizes.NumDiscStates  = tao;         % [u(k-1) ... u(k-tao)]
sizes.NumOutputs     = p;           % uk
sizes.NumInputs      = (n-tao);     % z(k).
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1;           % Apenas 1 tempo de amostragem

sys = simsizes(sizes);
past_u0  = zeros(tao,1);     %[u(k-1) ... u(k-tao)]
% -------------------------------------------------------------------------

% 'str' sempre uma matriz vazia.
str = [];
% initialize the array of sample times
ts  = [T 0];

function sys = mdlUpdate(t, past_u, tao)

global uk

% Housekeeping
past_u = [uk; past_u(1:tao-1)];
    
sys = past_u;
