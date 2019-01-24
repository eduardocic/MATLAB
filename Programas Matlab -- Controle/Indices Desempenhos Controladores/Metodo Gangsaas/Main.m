close all; clear all; clc;

%% Sistema a ser minimizado
A   = [-1.9311e-02  8.8157e+00  -3.2170e+01  -5.7499e-01;
       -2.5389e-04 -1.0189e+00   0.0000e+00   9.0506e-01;
        0.0000e+00  0.0000e+00   0.0000e+00   1.0000e+00;
        2.9465e-12  8.2225e-01   0.0000e+00  -1.0774e+00];
B   = [ 1.7370e-01;
       -2.1499e-03;
        0.0000e+00;
       -1.7555e-01];
C   = [0 0 180/pi 0;
       0 0 0 180/pi];
D   = [0; 0];

sys = ss(A, B, C, D);
G   = minreal(tf(sys));


% Requisitos "Hard Constraints" -- [Good | Bad].
% ----------------------------------------------
% 1. Autovalores no lado esquerdo do plano complexo;
% 2. Margem de fase mínima (em graus); 
% 3. Margem de ganho mínima (em dB); e
% 4. Frequência de corte (em rad/s).
Hard.Eigenvalues.Good   = -3;   Hard.Eigenvalues.Bad   = -2;   
Hard.GainMargin.Good    = 6;    Hard.GainMargin.Bad    = 6;
Hard.PhaseMargin.Good   = 60;   Hard.PhaseMargin.Bad   = 45;
Hard.FreqCrossover.Good    = 5;    H.FreqCrossover.Bad = 1;


% % Requisitos "Soft Constraints" -- [Good | Bad].
% % ----------------------------------------------
% Soft.HinfClosedLoop = [0.2 1];
% Soft.FreqCrossover  = [5 4.5];
% 
Aa   = [];
bb   = [];
Aeq  = [];
beq  = [];
lb   = [];
ub   = [];

% Chute inicial.
x0   = [-1   -1];

hard  = @(x)HardConstraints(x, G, Hard);
% soft  = @(x)SoftConstraints(x, G, Hard, Soft);
% fun   = @(x)fnCost(x, G);
options = optimoptions('fminimax', 'Display', 'iter', 'PlotFcns', @optimplotfval);
% % x     = fminsearch(fun, x0);
x     = fminimax(hard, x0, Aa, bb, Aeq, beq, lb, ub, [], options);
% x     = fminimax(soft, x, Aa, bb, Aeq, beq, lb, ub, [], options);
% 
% Defino a função de malha aberta 'L(s)'.
L = minreal(x(1)*G(1) + x(2)*G(2));
figure;
bode(L); grid;

% % E a função de malha fechada.
T   = minreal(L/(1 + L));
figure; 
step(T); grid;
