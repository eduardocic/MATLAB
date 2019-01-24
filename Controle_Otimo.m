clear all; close all; clc;

% Equações de estado.
% -------------------
syms x1 x2 u;

dx1 = x2;
dx2 = -x2 + u;


% Integrando.
% ----------
syms g;

g = 0.5*u^2;

% Hamiltoniano.
% -------------
syms H lambda1 lambda2;

H = g + lambda1*dx1 + lambda2*dx2;


% Equações de coestado.
% ---------------------
dlambda1 = -diff(H, x1);
dlambda2 = -diff(H, x2);

% Resolve para 'u'.
% -----------------
du    = diff(H, u);
sol_u = solve(du, 'u');

% Resolve para a equação de estados.
% ----------------------------------
dx1 = subs(dx1, u, sol_u);
dx2 = subs(dx2, u, sol_u);

eq = [diff(x1,t) == x2, diff(x2,t) == - lambda2 - x2, diff(lambda1,t) == 0, diff(lambda2,t) == lambda2 - lambda1];
dsolve(eq)
