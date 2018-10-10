close all; clear all; clc;

% -------------------------------------------------------------------------
% No caso, eu criei uma função externa, chamada 'GA' a qual tem a função a
% ser minimizada. Para que o algoritmo identificador a chama é necessário
% que eu escreva dentro do algoritmo '@GA', conforme escrito abaixo.
%
% Eduardo H. Santos.
% 10/07/2017
% -------------------------------------------------------------------------

% n_var_a_encontrar = 3;    % Número de variáveis as quais desejo encontrar.
n_var_a_encontrar = 1;    % Número de variáveis as quais desejo encontrar.
A   = [];                 % Da inequação A.x <= b
b   = [];                 % Da inequação A.x <= b
Aeq = [];                 % Da equação Aeq.x = Beq
Beq = [];                 % Da equação Aeq.x = Beq
LB  = [];                 % Lower Bound
UB  = [];                 % Upper Bound
nonlcon = [];             % Non-Linearity Constraints.
 
% options = optimoptions(@ga, 'Display', 'iter');
% options = optimoptions(@ga,'MutationFcn',@mutationadaptfeasible);
options = gaoptimset('PlotFcn',{@gaplotbestf,@gaplotmaxconstr},'Display','iter');
x = ga(@GA, n_var_a_encontrar, A, b, Aeq, Beq, LB, UB, nonlcon, options);

