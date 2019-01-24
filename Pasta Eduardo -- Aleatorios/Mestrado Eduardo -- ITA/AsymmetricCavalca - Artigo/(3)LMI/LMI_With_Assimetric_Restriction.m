function [sys, past_x0, str, ts] = LMI_With_Assimetric_Restriction(t, past_x, inputs, flag,...
                                                                   A, B, C, ...
                                                                   Smeio,Rmeio,...
                                                                   Umax, imax, Qsol, ...
                                                                   xref, yb, T)

global i

switch flag
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
case 0
n = size(A,2);               % Ordem das matrizes 'A';
p = size(B,2);               % Parâmetro da quantidade de entradas.
[sys,past_x0,str,ts] = mdlInitializeSizes(T, p, n); % S-function Initialization


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
case 2
sys = mdlUpdate(t, inputs);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
case {1,4,9}
sys = [];      % Flags não utilizadas.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
case 3         % Calcula a Função
   
[n, p, qA, qB, N] = ParametersSteadyState(A, B);
    
xk = inputs(1:2);   % Estado medido x(k)
E  = eye(p);       % Importante para os valores da LMI (iv).

% Condição de Chaveamento
xtil  = xk - xref{i};
if i < imax
    xtm1 = xk - xref{i+1};          % xtil(i+1)
    if xtm1'*inv(Qsol{i+1})*xtm1 < 1
        i = i+1;
    end
end

setlmis([]);

%% (2) Definição das variáveis.
[g, m1, sg] = lmivar(1,[1 0]);     % Variável a ser minimizada '(g)amma'.
[Q, m2, sQ] = lmivar(1,[n 1]);     % Q (nxn) simétrica full-block.
[Y, m3, sY] = lmivar(2,[p n]);     % Y (pxn) retangular; 
[X, m4, sX] = lmivar(1,[p 1]);     % X (pxp) simétrica full-block.


% +++++++++++++++++++++++++++++++++++++++++++
% (a) LMI do Kothare.
% -------------------
%  | Q  xtil_ss | >= 0               
%  | *      1   | 
% +++++++++++++++++++++++++++++++++++++++++++
LMI_Kothare1 = newlmi;
lmiterm([-LMI_Kothare1 1 1 Q],1,1);           % Direita da LMI(-), pos (1,1), Var (Q).
lmiterm([-LMI_Kothare1 1 2 0],xtil);          % Direita da LMI(-), pos (1,2), Const (x(k)).
lmiterm([-LMI_Kothare1 2 2 0],1);             % Direita da LMI(-), pos (1,2), Const '1' 
                                              % para representar a 'I', na dimensão apropriada

% +++++++++++++++++++++++++++++++++++++++++++                                     
% b) LMI (ii);                              +
%                                           +
%     | Q  0  0  (AjQ + BjY) |              +
%     | *  gI 0   S^(1/2)Q   | >= 0    (ii) +
%     | *  *  gI  R^(1/2)Y   |              +
%     | *  *  *       Q      |              +
%     para todo j = 1,...,N ( = qA*qB);     +
% +++++++++++++++++++++++++++++++++++++++++++  
for j=1:N
    LMI_Kothare2(j) = newlmi;
    lmiterm([-LMI_Kothare2(j) 1 1 Q],1,1);
    [Aj, Bj] = Vertice(A,B,n,qB,j);              
    lmiterm([-LMI_Kothare2(j) 1 4 Q],Aj,1);
    lmiterm([-LMI_Kothare2(j) 1 4 Y],Bj,1);
    lmiterm([-LMI_Kothare2(j) 2 2 g],1,1);
    lmiterm([-LMI_Kothare2(j) 2 4 Q],Smeio,1);
    lmiterm([-LMI_Kothare2(j) 3 3 g],1,1);
    lmiterm([-LMI_Kothare2(j) 3 4 Y],Rmeio,1);
    lmiterm([-LMI_Kothare2(j) 4 4 Q],1,1);
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
for j = 1:p
    LMI_Kothare4(j) = newlmi;
    e = E(:,j);                                % Aqui pega só a base canônica 'e'.
    lmiterm([LMI_Kothare4(j) j j X],e',e);     % Lado esquerdo da desigualdade (+).
    lmiterm([-LMI_Kothare4(j) j j 0],Umax^2);  % Lado direito da desigualdade (-).
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                        Output Assimétrico
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% if(t >= T)
% +++++++++++++++++++++++++++++++++++++++++++
% (e) LMI (v).
%
%  |       Q              *    | >= 0               
%  | Cm.(AjQ + BjY)   yb(i)^2  | 
% +++++++++++++++++++++++++++++++++++++++++++
    for j = 1:N
        LMI_Eduardo1(j) = newlmi;
    
        [Aj, Bj] = Vertice(A,B,n,qB,j);   
        Cm  = C(1,:);            % Matriz Cm (linha 'm' de C).
        CmA = Cm*Aj;             % Cm.A
        CmB = Cm*Bj;             % Cm.B
    
        lmiterm([-LMI_Eduardo1(j) 1 1 Q],1,1);
        lmiterm([-LMI_Eduardo1(j) 2 1 Q],CmA,1);
        lmiterm([-LMI_Eduardo1(j) 2 1 Y],CmB,1);
        lmiterm([-LMI_Eduardo1(j) 2 2 0],yb(i)^2);
    end
% end

%% 4) Pega as LMI definidas acima.
SistemaLMIs = getlmis;

NumVar = decnbr(SistemaLMIs);
c      = zeros(NumVar,1);
c(1)   = 1;           % Gamma.

options = [0 200 0 0 1];           
[Copt, Xopt] = mincx(SistemaLMIs, c, options);

Ysolution = dec2mat(SistemaLMIs, Xopt, Y);
Qsolution = dec2mat(SistemaLMIs, Xopt, Q);

F   = Ysolution*inv(Qsolution);
uk  = F*(xk - xref{i});

sys =  [uk yb(i)];              % S-function output (control value)
end

%=============================================================================
% mdlInitializeSizes
% Return the sizes, initial conditions, and sample times for the S-function.
%=============================================================================
%
function [sys,past_x0,str,ts] = mdlInitializeSizes(T, p, n)

%
% call simsizes for a sizes structure, fill it in and convert it to a
% sizes array.
%
%
sizes = simsizes;

sizes.NumContStates  = 0;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = p + 1; % u
sizes.NumInputs      = n; % xk
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