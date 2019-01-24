clear all; close all; clc;

% Caso nominal.
load('EstudoAceleracaoPaperNominal.mat');
A = An;
B = Bn; 
C = Cn;
D = Dn;

% Planta.
G = ss(A,B,C,D);
G = tf(G);
G.u = 'dElev';          G.y = {'q','an','Cstar'};

% Atuador e atraso.
[num,den] = pade(0.02,1);
Gd = tf(num,den);               % Atraso.

Ga  = tf([20.2],[1 20.2]);      % Atuador.
Gad = Ga*Gd;                    % Atuador + atraso.
Gad = tf([1],[1]);              % Sem atraso e sem atuador.
% Gad = Ga;
Gad.u = 'u';      Gad.y = 'dElev';

p = ss(Gad);
Aad = p.a;  Bad = p.b;  Cad = p.c;   Dad = p.d;

% Controlador a ser determinado.
% -------------------------------
ki = realp('ki',1);
kp = realp('kp',1);
kq = realp('kq',1);

Kq = tf(kq,1);
PI = tf([kp ki],[1 0]);

Kq.u = 'q';      Kq.y = 'out1';
PI.u = 'erro';   PI.y = 'out2';

% Blocos de soma;
sum1 = sumblk('erro = ref - an');
sum2 = sumblk('u = out2 + out1');

% Blocos de peso.
% wS = tf([0.115],[1 0.01]);
% wT = tf([3.2 24 86.9],[1 52.2 110]);
wS = tf([1],[1 0.01]);
wT = tf([8 32],[1 50]);

wS.u  = 'erro';               wS.y = 'z1';
wT.u  = 'an';                 wT.y = 'z2';

% Conecta todo mundo.
T0 = connect(G, Gad, PI, Kq, sum1, sum2, wT, wS, {'ref'}, {'z1', 'z2'});

rng('default')
opt = hinfstructOptions('Display','final','RandomStart',5);
T = hinfstruct(T0,opt);

showTunable(T);

k_i = T.Blocks.ki.Value;
k_p = T.Blocks.kp.Value;
k_q = T.Blocks.kq.Value;



% Estrutura obtida em malha fechada -- 'Closed Loop'.
Gcl = connect(G, Gad, PI, Kq, sum1, sum2, wT, wS, {'ref'}, {'z2'});
sigmaplot(Gcl);

% Segue aqui o restante do código para análise de robustez.
% opt = robopt('Display','on');
% [MargemEst, Deltas, Report, info] = robuststab(T, opt);
% figure;
% semilogx(info.MussvBnds(1,1))
% grid;

