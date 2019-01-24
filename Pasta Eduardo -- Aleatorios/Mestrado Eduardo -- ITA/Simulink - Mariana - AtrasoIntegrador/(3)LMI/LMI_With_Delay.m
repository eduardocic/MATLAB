function [sys, past_wu0, str, ts] = LMI_With_Assimetric_Restriction(t, past_uw, inputs, flag,... 
                                                                    Ad, Bd, Cd,...
                                                                    tao, Smeio,...
                                                                    Rmeio, Umax, T)
switch flag
        
case 0
n = size(Ad{1},1);    % (n+tao) x (n+tao) [z(k) u(k-1) ... u(k-tao)].
p = size(Bd{1},2);    % nº de variáveis de controle u(k).
n_real = (n-tao);     % nº estados z(k).
[sys, past_wu0, str, ts] = mdlInitializeSizes(T, p, n, n_real, tao); % Inicialização.


case 2
% n = size(Aa{1},1);    % (n+tao) x (n+tao)
% p = size(Ba{1},2);    % nº de variáveis de controle
sys = mdlUpdate(t, past_uw, tao);


case {1,4,9}
sys = [];      % Flags não utilizadas.


case 3         % Calcula a Função    
% -------------------------------------------------------------------------
%                                 PREÂNBULO
%
% -------------------------------------------------------------------------
global uk
global wk

N = max(size(Ad));     % Quantidade de Vértices do Politopo.
n = size(Ad{1},1);     % x(k) = [z(k) u(k-1) ... u(k-tao)] -- SEM INTEGRADOR
p = size(Bd{1},2);     % Quantidade de entradas u(k)'s.
n_real = (n-tao);      % Vetores de Estados z(k)
    
zk = inputs;   % Estado medido.
E  = eye(p);           % Importante para os valores da LMI (iv). 

%%% Formação das matrizes com delay e integrador.
for i=1:N
   [Aj{i}, Bj{i}] = InsereIntegrador(Ad{i}, Bd{i}, Cd);
end

% Reconstrução do estado aumentado para x(k).
Omegak = [zk past_uw']';     %[z(k) past_u past_w]   -- (n+1) do INTEGRADOR.
setlmis([]);

[g, m1, sg] = lmivar(1,[1 0]);          % Variável a ser minimizada '(g)amma'.
[Q, m2, sQ] = lmivar(1,[(n+1) 1]);      % Q (nxn) simétrica full-block -- JÁ LEVANDO EM CONTA O INTEGRADOR
[Y, m3, sY] = lmivar(2,[p (n+1)]);      % Y (pxn) retangular -- JÁ LEVANDO EM CONTA O INTEGRADOR 
[X, m4, sX] = lmivar(1,[p 1]);          % X (pxp) simétrica full-block.





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
lmiterm([-LMI_Kothare1 1 1 Q],1,1);     % Direita da LMI(-), pos (1,1), Var (Q).
lmiterm([-LMI_Kothare1 1 2 0],Omegak);  % Direita da LMI(-), pos (1,2), Const (x(k)).
lmiterm([-LMI_Kothare1 2 2 0],1);       % Direita da LMI(-), pos (1,2), Const '1' 


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
    lmiterm([-LMI_Kothare2(i) 1 4 Q],Aj{i},1);
    lmiterm([-LMI_Kothare2(i) 1 4 Y],Bj{i},1);
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
uk = F*Omegak

xk = Omegak(1:(end-1));      % Pegar [z(k) u(k-1) ... u(k-tao)]
wk = past_uw(end) - Cd*xk;    % w(k+1) = w(k) - C*xk.

sys =  uk; 
end


function [sys, past_uw0, str, ts] = mdlInitializeSizes(T, p, n, n_real, tao)

% n      -- [z(k) u(k-1) ... u(k-tao)].
% n_real -- z(k)
% tao    -- delay
sizes = simsizes;
QuantEstadosDiscretos = (tao + 1);             % [u(k-1) ... u(k-tao) w(k)]

sizes.NumContStates  = 0;
sizes.NumDiscStates  = QuantEstadosDiscretos;  % [u(k-1) ... u(k-tao) w(k)]
sizes.NumOutputs     = p;                      % uk
sizes.NumInputs      = n_real;                 % z(k).
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1;   % Just one sample time

sys = simsizes(sizes);

% initialize the initial conditions
past_uw0  = zeros(tao + 1,1);     %[u(k-1) ... u(k-tao) w(k)]

% str is always an empty matrix
str = [];

% initialize the array of sample times
ts  = [T 0];

function sys = mdlUpdate(t, past_uw, tao)

global uk
global wk

% Housekeeping

past_uw = [uk; past_uw(1:tao-1); wk];
% past_uw = [uk; past_uw(1:tao-1); 0];
    
sys = past_uw;
