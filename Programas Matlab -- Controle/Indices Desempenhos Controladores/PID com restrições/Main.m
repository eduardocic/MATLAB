close all; clear all; clc;

global G

% Sistema a ser minimizado -- defini 'G' como global pois a mesma ser�
% utilizada na fun��o de custo.
G   = minreal(tf([1],[1 0 0]));

% Inicia��o da vari�vel de controle do nosso sistema.
% x(1) = K, x(2) = z e x(3) = p.
x0  = [8 2 1];

% Op��es da fun��o 'fmincon' de forma a vermos o total do custo.
% options = optimset('PlotFcns',@optimplotfval);
A   = [];
b   = [];
Aeq = [];
beq = [];
lb  = [ 0.1, 0.1, 0.1];
ub  = [ 10, 10, 10];
nonlcon = @fnRestricao;

options = optimoptions('fmincon','Display','iter');
x       = fmincon(@fnCost,x0,A,b,Aeq,beq, lb, ub, nonlcon, options);

% Defino o controlador.
C = tf([1 x(2)],[1 x(3)]);

% Defino a fun��o de malha aberta 'L(s)'.
L = minreal(x(1)*C*G);
figure;
bode(L); grid;

% % E a fun��o de malha fechada.
T   = minreal(L/(1 + L));
figure; 
step(T); grid;
