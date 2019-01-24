close all; clear all; clc;

% global G

% Sistema a ser minimizado -- defini 'G' como global pois a mesma será
% utilizada na função de custo.
A = [-1.9311e-02  8.8157e+00  -3.2170e+01  -5.7499e-01;
     -2.5389e-04 -1.0189e+00   0.0000e+00   9.0506e-01;
      0.0000e+00  0.0000e+00   0.0000e+00   1.0000e+00;
      2.9465e-12  8.2225e-01   0.0000e+00  -1.0774e+00];
B = [ 1.7370e-01;
     -2.1499e-03;
      0.0000e+00;
     -1.7555e-01];
C = [0 0 180/pi 0;
     0 0 0 180/pi];
D = [0; 0];
sys = ss(A, B, C, D);
G   = minreal(tf(sys));

% Iniciação da variável de controle do nosso sistema.
x0  = [-1.2965   -0.4482];

% Opções da função 'fmincon' de forma a vermos o total do custo.
% options = optimset('PlotFcns',@optimplotfval);
Aa   = [];
bb   = [];
Aeq  = [];
beq  = [];
lb   = [];
ub   = [];

% Custo a ser minimizado e restrições não lineares.
custo   = @(x)fnCost(x,G);
nonlcon = @(x)fnRestricao(x,G);

options = optimoptions('fmincon','Display','iter');
x       = fmincon(custo, x0,...
                  Aa, bb, Aeq, beq, lb, ub,...
                  nonlcon, options);

% Defino a função de malha aberta 'L(s)'.
L = minreal(x(1)*G(1) + x(2)*G(2));
figure;
bode(L); grid;

% % E a função de malha fechada.
T   = minreal(L/(1 + L));
figure; 
step(T); grid;
