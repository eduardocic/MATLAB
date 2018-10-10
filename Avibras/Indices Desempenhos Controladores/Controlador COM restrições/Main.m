close all; clear all; clc;

global G

% Sistema a ser minimizado -- defini 'G' como global pois a mesma será
% utilizada na funçãod de custo.
G   = tf([1],[1 5 6 0]);

% O controlador do sistema estará na malha direta com a planta e será algo
% da forma:
%
%                             (s + a)
%                 C   =    K ---------
%                             (s + 1)
%
% sendo 'K' e 'a' variáveis a serem determinadas para a obtenção do
% controlador.

% Como eu desejo minimizar as variáveis 'K' e 'a' o que eu faço é
% inicializar as mesmas em um vetor x0, sendo K = x(1), a = x(2) e        
% w = x(3).
% x0  = [0.2 1 5];
x0  = [0.2 1];

% Opções da função 'fmincon' de forma a vermos o total do custo.
% options = optimset('PlotFcns',@optimplotfval);
A   = [];
b   = [];
Aeq = [];
beq = [];
% lb  = [0.1, 0.01, 1];
% ub  = [Inf, Inf, Inf];
lb  = [0.1, 0.01];
ub  = [Inf, Inf];
nonlcon = @fnRestricao;

options = optimoptions('fmincon','Display','iter','Algorithm','sqp');
x       = fmincon(@fnCost,x0,A,b,Aeq,beq,lb,ub,nonlcon, options);

% O vetor 'x' traz as respostas da minimização obtida. Dessa forma eu
% construo efetivamente o controlador obtido.
C   = x(1)*tf([1 x(2)],[1 1]);

% Defino a função de malha aberta 'L(s)'.
L = minreal(C*G); 
figure;
bode(L); grid;

% E a função de malha fechada.
T   = minreal(L/(1 + L));
figure; 
step(T); grid;
