function [sys, past_x0, str, ts] = LMI_Schuurmans(t, past_x, inputs, flag, A, B, Umax, T)

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

global K    
    
[n, p, qA, qB, N] = ParametersSteadyState(A, B);

xk = inputs;       % Estado medido x(k)


   

%% ------------------------------------------------------------------------ 
%                           (1) Inicializa LMIs.
% -------------------------------------------------------------------------
% Essas matrizes v�m da f�rmula do custo quadr�tico: J = Sum(x'Qx +u'Ru)
Q  = eye(n);   Qsqrt = sqrt(Q);    % Q^(-1/2)
R  = eye(p);   Rsqrt = sqrt(R);    % R^(-1/2)
I  = eye(n);   % Matriz identidade.
E  = eye(p);

setlmis([]);


%% ------------------------------------------------------------------------
%                       (2) Defini��o das vari�veis.
% -------------------------------------------------------------------------
% *)   Como o nc = 1, o custo tem um somat�rio que varia de 0 at� nc. Dessa
%    forma o que se tem s�o duas vari�veis de otimiza��o (nc+1).
% *)   X = P^(-1)*g_nc. Como o P � de ordem nxn => X = nxn.
% *)   K = Y*X^(-1). Como K � de ordem pxn => Y = pxn.
% *)   Como h� 'nc' vari�veis de otimiza��o, mostra que teremos que
%    escolher necessariamente 'nc' vari�veis de otimiza��o para o 'c' que
%    minimiza a entrada 'u'. E o 'c' tem a mesma ordem do 'u' (px1).
[g0, m0, sg0] = lmivar(1,[1 0]);     % '(g)amma0'.
[g1, m1, sg1] = lmivar(1,[1 0]);     % '(g)amma1'.
[X, m2, sX]   = lmivar(1,[n 1]);     % X (nxn) sim�trica full-block.
[Y, m3, sY]   = lmivar(2,[p n]);     % Y (pxn) retangular; 
[U, m4, sU]   = lmivar(1,[p 1]);       % U (pxp) retangular;
[c0, m5, sc0] = lmivar(2,[p 1]);     % c (px1) retangular; 


%% ------------------------------------------------------------------------
%                      (3) Determina��o das LMI.
% -------------------------------------------------------------------------
% +++++++++++++++++++++++++++++++++++++++++++++++++++++
%  | I    Q^(1/2)xk             0             |       +
%  | *       g0      c0'R^(1/2) + xk'K'R^(1/2)| >= 0  +             
%  | *       *                   I            |       +
% +++++++++++++++++++++++++++++++++++++++++++++++++++++
LMI_1 = newlmi;
multi1 = Qsqrt*xk;
multi2 = xk'*K'*Rsqrt;
lmiterm([-LMI_1 1 1 0],1);          % I
lmiterm([-LMI_1 1 2 0],multi1);     % Q^(1/2)xk
lmiterm([-LMI_1 2 2 g0],1,1);       % g0.
lmiterm([-LMI_1 2 3 -c0],1,Rsqrt);  % c0'R^(1/2).
lmiterm([-LMI_1 2 3 0],multi2);     % xk'K'R^(1/2).
lmiterm([-LMI_1 3 3 0],1);          % I.


% +++++++++++++++++++++++++++++++++++++++++++++++++++                                     
% 3.b) LMI das incertezas                           +
%     |  1  (xk'*Theta_l' + c0'*B_l)  | >= 0 (ii)   +
%     |  *                X           |             +
% +++++++++++++++++++++++++++++++++++++++++++++++++++
for i=1:N
    ConjLMICombConvex(i) = newlmi;
    lmiterm([-ConjLMICombConvex(i) 1 1 0],1);
    [Aj, Bj] = Vertice(A,B,n,qB,i);
    Theta = Aj + Bj*K;
    ThetaX = xk'*Theta';
    Bjt = Bj';
    lmiterm([-ConjLMICombConvex(i) 1 2 0],ThetaX);
    lmiterm([-ConjLMICombConvex(i) 1 2 -c0],1,Bjt);
    lmiterm([-ConjLMICombConvex(i) 2 2 X],1,1);
end

% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++                                     
% 3.c) LMI das incertezas                                 +
%                                                         +
%  |     X         *           *         *  |             +
%  | Aj.X + Bj.Y   X           *         *  | >= 0  (ii)  +
%  |   Qsqrt.X     0           g1        *  |             +
%  |   Rsqrt.Y     0           0         g1 |             +
%  para todo j = 1,...,N ( = qA*qB);                      +
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++                                     
for i=1:N
    ConjLMICombConvex(i) = newlmi;
    lmiterm([-ConjLMICombConvex(i) 1 1 X],1,1);
    [Aj, Bj] = Vertice(A,B,n,qB,i);  
    lmiterm([-ConjLMICombConvex(i) 2 1 X],Aj,1);
    lmiterm([-ConjLMICombConvex(i) 2 1 Y],Bj,1);
    lmiterm([-ConjLMICombConvex(i) 2 2 X],1,1);
    lmiterm([-ConjLMICombConvex(i) 3 1 X],Qsqrt,1);
    lmiterm([-ConjLMICombConvex(i) 3 3 g1],1,1);
    lmiterm([-ConjLMICombConvex(i) 4 1 Y],Rsqrt,1);
    lmiterm([-ConjLMICombConvex(i) 4 4 g1],1,1);
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                              Restri��es
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% a) Restri��o de i = 0 at� nc-1.
LMI_2 = newlmi;
Q1 = K*xk;
Umax2 = Umax^2;
lmiterm([-LMI_2 1 1 0],1);          % I
lmiterm([-LMI_2 1 2 0],Q1);         % K*x(k)
lmiterm([-LMI_2 1 2 c0],1,1);       % c.
lmiterm([-LMI_2 2 2 0],Umax2);      % Umax^2.


% b) Restri��o de i = nc at� inf
LMI_3 = newlmi;
lmiterm([-LMI_3 1 1 U],1,1);        % U
lmiterm([-LMI_3 1 2 Y],1,1);        % Y
lmiterm([-LMI_3 2 2 X],1,1);        % X

for i = 1:p
    RestU(i) = newlmi;
    e = E(:,i);                         % Aqui pega s� a base can�nica 'e'.
    lmiterm([RestU(i) i i U],e',e);     % Lado esquerdo da desigualdade (+).
    lmiterm([-RestU(i) i i 0],Umax2);   % Lado direito da desigualdade (-).
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
SistemaLMIs = getlmis;

NumVar = decnbr(SistemaLMIs);  % Quantidade total de vari�veis do sistema.
c = zeros(NumVar,1);           %   Vetor de zeros.

%++ ------ Custo ------ +++
%   J = g1 + g0           +
% -------------------------
c(1) = 1;     % 1*g0
c(2) = 1;     % 1*g1


% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++                                     
% 5.b) Usa-se o 'tic' e o 'toc' para que possamos fazer o c�lculo +
%      de quanto tempo demora o processo de OTIMIZA��O em cada    +
%      la�o da simula��o.                                         +
options = [0 200 0 0 1];      % Trace off                         +
% tic                                                            
[Copt, Xopt] = mincx(SistemaLMIs, c, options);                   
% toc                                                            
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

Ysol  = dec2mat(SistemaLMIs, Xopt, Y);
Xsol  = dec2mat(SistemaLMIs, Xopt, X);
g1sol = dec2mat(SistemaLMIs, Xopt, g1);
c0sol = dec2mat(SistemaLMIs, Xopt, c0);




%% Sa�da de Controle.
uk = K*xk + c0sol; 

%% Determina��o da Matriz F, tal que: u*(k) = F.x(k)
% K = Ysol*inv(Xsol);

sys =  uk; 

end


%=============================================================================
% mdlInitializeSizes
% Return the sizes, initial conditions, and sample times for the S-function.
%=============================================================================
%
function [sys,past_x0,str,ts] = mdlInitializeSizes(T,p,n)

global K
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
K = [0 0];
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
