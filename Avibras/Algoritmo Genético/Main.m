close all; clear all; clc;

% -------------------------------------------------------------------------
% No caso, eu criei uma fun��o externa, chamada 'GA' a qual tem a fun��o a
% ser minimizada. Para que o algoritmo identificador a chama � necess�rio
% que eu escreva dentro do algoritmo '@GA', conforme escrito abaixo.
%
% Eduardo H. Santos.
% 10/07/2017
% -------------------------------------------------------------------------

% n_var_a_encontrar = 3;    % N�mero de vari�veis as quais desejo encontrar.
n_var_a_encontrar = 1;    % N�mero de vari�veis as quais desejo encontrar.
A   = [];                 % Da inequa��o A.x <= b
b   = [];                 % Da inequa��o A.x <= b
Aeq = [];                 % Da equa��o Aeq.x = Beq
Beq = [];                 % Da equa��o Aeq.x = Beq
LB  = [];                 % Lower Bound
UB  = [];                 % Upper Bound
nonlcon = [];             % Non-Linearity Constraints.
 
% options = optimoptions(@ga, 'Display', 'iter');
% options = optimoptions(@ga,'MutationFcn',@mutationadaptfeasible);
options = gaoptimset('PlotFcn',{@gaplotbestf,@gaplotmaxconstr},'Display','iter');
x = ga(@GA, n_var_a_encontrar, A, b, Aeq, Beq, LB, UB, nonlcon, options);

