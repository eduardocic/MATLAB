clear all; close all; clc;

X = 40000;          % Capital inicial.
a = 2.3;            % Rentabilidade líquida (em %).
b = 1500;           % Valor investido todo mês (em R$).
n = 120;            % Quantidade de meses.

T = (1 + a/100);

% Primeira parcela
S1 = X*T^n;
% Segunda parcela.
S2 = b*(T^n-1)/(T-1);

% Resultado total.
S = S1 + S2