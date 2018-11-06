clear all; close all; clc;

t = linspace(0,10,1001);
x = sin(t);
plot(t, x);

% Cortei o sinal.
% ---------------
index1 = find(t >= 1, 1, 'first');
index2 = find(t <= 5, 1, 'last');

tlinha = t(index1:index2);
xlinha = x(index1:index2);
hold on;
plot(tlinha, xlinha, 'r');