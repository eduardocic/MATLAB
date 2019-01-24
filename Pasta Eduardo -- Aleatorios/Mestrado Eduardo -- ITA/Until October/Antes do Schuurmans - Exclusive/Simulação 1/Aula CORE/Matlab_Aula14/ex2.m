clear; clc; close all;

%%  Integrador duplo  (SISTEMA)
Ac = [0 1;0 0];
Bc = [0;1];
C  = [1 0];
D  = 0;
T  = 1;
[A, B] = c2dm(Ac,Bc,C,D,T,'zoh'); % Discretiza o modelo

n = size(A,1);   % Matriz quadrada (n x n)
p = size(B,2);   % Matriz retangular (n x p)
S = eye(n);      % Valido somente para S diagonal (vem da norma quadrática da função custo)
Ssqrt = sqrt(S); % Termo que será utilizado na LMI (*)
R = eye(p);      % Valido somente para R diagonal (vem da norma quadrática da função custo)
Rsqrt = sqrt(R); % Termo que será utilizado na LMI (*)
xk = [1;2];      % x(0) - Valor inicial.


% Início. 
%% 1) Definição das variáveis do sistema a ser resolvido. 
setlmis([])
g = lmivar(1,[1 0]);
Q = lmivar(1,[n,1]);
Y = lmivar(2,[p,n]);

%% 2) 1º LMI
lmiterm([-1 1 1 Q],1,1);
lmiterm([-1 1 2 0],xk);
lmiterm([-1 2 2 0],1);

%% 3) 2º LMI
% Atentar que para este caso, está se utilizando apenas a LMI do sistema.
% Numa situação de incertezas do modelo, temos de colocar todas as combinações do
% fecho convexo de (A,B) sendo Gamma = Co{(Ai, Bi)| i variando de 1 a L}.
% Dessa forma, o que teremos num feixe convexo (Convex Hull) é uma função
% "for", fazendo inicialização de todas as LMI para cada uma das
% combinações.
lmiterm([-2 1 1 Q],1,1);
lmiterm([-2 1 4 Q],A,1);
lmiterm([-2 1 4 Y],B,1);
lmiterm([-2 2 2 g],1,1);
lmiterm([-2 2 4 Q],Ssqrt,1);
lmiterm([-2 3 3 g],1,1);
lmiterm([-2 3 4 Y],Rsqrt,1);
lmiterm([-2 4 4 Q],1,1);

%% 4) Pega as LMI detalhadas nos passos 2 e 3.
lmisys = getlmis;

ndecvar = decnbr(lmisys);
c = zeros(ndecvar,1);
c(1) = 1;                         % Cost = 1*gamma

%% 5) "Resolve", minimizando o custo do sistema de LMIs.
[copt, xopt] = mincx(lmisys, c);  % c'x sujeito ao sistema de LMIs.

Ysol = dec2mat(lmisys, xopt, Y);
Qsol = dec2mat(lmisys, xopt, Q);
F = Ysol*inv(Qsol);  % Solução para o Fk. [u(k+i|k) = Fk.x(k+i|k)]



%% 6) Aqui ele vai verificar o Valor da Função Custo 
Psi = S + F'*R*F;              % Direto na função custo.   
Amf = A + B*F;                 % Malha fechada.

Psi_infty = dlyap(Amf',Psi);   % Resolve a equação de Lyapuno 
costlmi   = xk'*Psi_infty*xk;  %  Resultado do custo.


%% O professor abordou algo que eu não conheço, chamou de DLQR.
% DLQR para comparação
Kdlqr = dlqr(A,B,S,R)

Psi = S + Kdlqr'*R*Kdlqr;
Amf = A - B*Kdlqr;

Psi_infty = dlyap(Amf',Psi);
costdlqr= xk'*Psi_infty*xk;

disp(['Custo LMI : ' num2str(costlmi,8)])
disp(['Custo DLQR: ' num2str(costdlqr,8)])

