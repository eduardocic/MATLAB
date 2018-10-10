clear all; close all; clc;

% Equações de estado.
syms x1(t) x2(t); 
syms u(t); 
syms H(t);
syms lambda1(t) lambda2(t);
syms g(t);

% Equações de Estado.
eq1 = diff(x1) == x2;
eq2 = diff(x2) == -x2 - lambda2;

% Integrando
g = 0.5*u^2;

% Hamiltoniano
H = g + lambda1*x2 + lambda2*(-x2 + u);

% Demais equações.
eq3 = diff(lambda1) == 0;
eq4 = diff(lambda2) == -lambda1 + lambda2;

% Juntar as equações diferenciais.
odes  = [eq1; eq2; eq3; eq4]

% Condições de contorno.
cond1 = x1(0) == 0;
cond2 = x2(0) == 0;
cond3 = x1(2) == 5;
cond4 = x2(2) == 2;
cond  = [cond1; cond2; cond3; cond4];

% Resolve o problema.
S = dsolve(odes, cond);

% Separa as variáveis.
x1(t) = S.x1;
x2(t) = S.x2;
lambda1(t) = S.lambda1;
lambda2(t) = S.lambda2;

% Plota o resultado
ezplot(x1); hold on;
ezplot(x2); 
xlim([0 2]); ylim([-2 7]);
