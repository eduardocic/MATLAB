clear all; close all; clc;

% -------------------------------------------------------------------------
%  A função é y(t) = (1/w)*(1-cos(wt)).
%    - 1 segundo de simulação.
%    - h = 0.001;
%    - w = 20 rad/s
%
% Runge Kutta de 2nd Ordem
%
%
%  k1 = f(y_n, t_n)
%  k2 = f(y_n + h*k1,t_n + h)
%  y_n+1 = y_n + h*(k1 + k2)/2

T = 10;
h = 0.001;
w = 20;
n = T/h;           % Quantidade de passos
X{1} = [0; 0];     % Estado inicial.
for i=1:n
    k1 = f(X{i},i);
    k2 = f(X{i}+h*k1,i+h);
    X{i+1} = X{i} + h*(k1 + k2)/2;
end

for i=1:max(size(X))
    t(i)  = i;
    x1(i) = X{i}(1,1);
    x2(i) = X{i}(2,1);
end

plot(t, x1);grid;
% 
% y = (1/w)*(1-cos(w*t));
% hold on;
% plot(t,y)
