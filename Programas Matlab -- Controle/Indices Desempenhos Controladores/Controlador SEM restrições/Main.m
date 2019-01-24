close all; clear all; clc;

global G

% Sistema a ser minimizado -- defini 'G' como global pois a mesma ser�
% utilizada na fun��od de custo.
G   = tf([1],[1 5 6 0]);

% O controlador do sistema estar� na malha direta com a planta e ser� algo
% da forma:
%
%                             (s + a)
%                 C   =    K ---------
%                             (s + 1)
%
% sendo 'K' e 'a' vari�veis a serem determinadas para a obten��o do
% controlador.

% Como eu desejo minimizar as vari�veis 'K' e 'a' o que eu fa�o �
% inicializar as mesmas em um vetor x0, sendo K = x(1) e a = x(2).
x0  = [0.2 5];

% Op��es da fun��o 'fminsearch' de forma a vermos o total do custo.
options = optimset('PlotFcns',@optimplotfval);
x       = fminsearch(@fnCost, x0, options);

% O vetor 'x' traz as respostas da minimiza��o obtida. Dessa forma eu
% construo efetivamente o controlador obtido.
C   = x(1)*tf([1 x(2)],[1 1]);

% Defino a fun��o de malha aberta 'L(s)'.
L = minreal(C*G); 
figure;
bode(L); grid;

% E a fun��o de malha fechada.
T   = minreal(L/(1 + L));
figure; 
step(T); grid;
