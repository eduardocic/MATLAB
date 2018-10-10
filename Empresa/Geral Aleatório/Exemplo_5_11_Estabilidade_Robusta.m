clear all; close all; clc;

% De performance.
wP = tf([0.25 0.1],[1 0]);
% De incerteza.
wU = 0.5*tf([1 0],[1 1]);
% Planta 1.
GK1 = tf([0.5],[1 0]);

% Criando a malha fechada do sistema.
Delta = ultidyn('Delta',[1 1]);
G = GK1 + wU*Delta;         % Incerteza do tipo aditiva.

G.u   = 'erro';      G.y   = 'phi';
wP.u  = 'out';       wP.y  = 'y_hat';

sum1 = sumblk('erro = - out');
sum2 = sumblk('out = d + phi');

ClosedLoop = connect(G, wP, sum1, sum2, {'d'},{'y_hat'});

% Isolando as incertezas do sistema em uma estrutura N-Delta.
[N, Delta BlkStruct] = lftdata(ClosedLoop);
M = N(1:1,1:1);

omega = logspace(-1,2,50);
M_g   = frd(M,omega);

muLimites = mussv(M_g, BlkStruct,'s');
bodeplot(muLimites);

% [Pmarg1, Pmargunc1, Report1] = robustperf(ClosedLoop)
