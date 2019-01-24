clear all; close all; clc;

% Carrega as matrizes do sistema linearizado.
load('Matrizes.mat');
G   = minreal(tf(ss(A,B,C,D)));
% Os parâmetros a serem minimizados dizem respeito aos 4 ganhos do sistema,
% a saber: k1, k2 k3 e k4.
% O nosso vetor será inicializado como sendo algo da forma:
fun = @(x)Custo(x, A, B, C, D);
% fun = @(x)CustoHinf(x, G);

x0  = 1*[-1   -1   -1  -1];
Aa  = [];
bb  = [];
Aeq = [];
beq = [];
lb  = 100*[-1 -1 -1 -1];
ub  = 100*[1 1 1 1];
% lb  = [];
% ub  = [];
nonlcon = [];

% Realiza a minimização do sistema.
options = optimset('Display', 'iter', 'MaxFunEvals', 5000, 'PlotFcns', @optimplotfval);
% x   = fminimax(fun, x0, Aa, bb, Aeq, beq, lb, ub, nonlcon, options);
x   = fminsearch(fun, x0, options);



% Destrinchando o vetor a ser minimizado.
k1 = x(1);
k2 = x(2);
k3 = x(3);
k4 = x(4);

% Matrizes de ganho de realimentação.
K  = [k1 k3;
      k2 k4];  
Acl = A - B*K*C;
Bcl = B*K;

sys = ss(Acl, Bcl, C, D);

step(sys); grid;
save('Ganhos.mat', 'k1', 'k2', 'k3', 'k4');

figure;
L = K*G;
sigma(L); grid;

% %% Minimizando a norma H infinito da estrutura recém definida.
% fun = @(x)CustoHinf(x, G);
% % options = optimoptions('fmincon','Display','iter','Algorithm','sqp');
% % x = fmincon(fun, x, Aa, bb, Aeq, beq, lb, ub, nonlcon, options);
%  options = gaoptimset('MutationFcn',@mutationadaptfeasible);
% [x,fval,exitflag] = ga(fun, 4, Aa, bb, Aeq, beq, lb, ub, nonlcon,  options);
% 
% % Destrinchando o vetor a ser minimizado.
% k1 = x(1);
% k2 = x(2);
% k3 = x(3);
% k4 = x(4);
% 
% % Matrizes de ganho de realimentação.
% K  = [k1 k3;
%       k2 k4];  
%   
% figure;
% L = K*G;
% sigma(L); grid;  
% 
% Acl = A - B*K*C;
% Bcl = B*K;
% 
% sys2 = ss(Acl, Bcl, C, D);
% figure;
% 
% step(sys2); grid;


% % Abrindo o loop em u1.
% % ---------------------
% P = (-k4*G(1,1) - k2*G(2,1))/(1 + k4*G(1,2) + k2*G(2,2));
% l = k1*G(1,1) + k1*G(1,2)*P + k3*G(2,1) + k3*G(2,2)*P;
% 
% figure;
% nichols(l);


