clear all; close all; clc;

%% 1. Carrega a planta incerta.
load('PlantaIncerta.mat');

%% 2. Ganhos do sistema a serem determinadas pelo sistema.
kss = realp('kss',1);
ki  = realp('ki',1);
kt  = realp('kt',1);
kq  = realp('kq',1);

% Respectivas funções de transferência.
Kss = tf(kss,1);
Kt  = tf(kt,1);
Ki  = tf(ki,1);
Kq  = tf(kq,1);
Integrador = tf([1],[1 0]);

% Pesos do sistema.
Ws = tf([0.115],[1 0.001]);                % Peso para 'S'.
Wt = tf([3.2 24 86.9],[1 52.2 110]);      % Peso para 'T'.
% Ws = tf([1/2 10],[1 1e-5]);               % Peso para 'S'.

% Entradas e saídas dos blocos do sistema como um todo.
Kss.u = 'an_{ref}';           Kss.y  = 'out1';
Ki.u  = 'erro1';              Ki.y   = 'out2';
Kt.u  = 'q';                  Kt.y   = 'out4';
Kq.u  = 'q';                  Kq.y   = 'out5';
Integrador.u = 'erro2';       Integrador.y  = 'out3';
sum1 = sumblk('erro1 = out1 - an');
sum2 = sumblk('erro2 = out2 - out4');
sum3 = sumblk('u = out3 - out5');

% Local para ajustes.
sum4 = sumblk('erro_em_a = an_{ref} - an');
Ws.u  = 'erro_em_a';          Ws.y   = 'z1';
Wt.u  = 'an';                 Wt.y   = 'z2';

% Conecta todo mundo, com o caso nominal (G.Nominal).
T0 = connect(G.Nominal, Kss, Ki, Kt, Kq, Integrador, Ws, Wt, sum1, sum2, sum3, sum4, {'an_{ref}'}, {'z1','z2'});

% Realiza o cálculo do Hinfstruct para o caso da planta nominal.
rng('default')
opt = hinfstructOptions('Display','final','RandomStart',10);
T   = hinfstruct(T0, opt);
showTunable(T);


%% Pegando os valores das funções obtidas.
ki  = T.Blocks.ki.Value;
kq  = T.Blocks.kq.Value;
kss = T.Blocks.kss.Value;
kt  = T.Blocks.kt.Value;

Kss = tf(kss,1);
Kt  = tf(kt,1);
Ki  = tf(ki,1);
Kq  = tf(kq,1);
Integrador = tf([1],[1 0]);


Kss.u = 'an_{ref}';           Kss.y  = 'out1';
Ki.u  = 'erro1';              Ki.y   = 'out2';
Kt.u  = 'q';                  Kt.y   = 'out4';
Kq.u  = 'q';                  Kq.y   = 'out5';
Integrador.u = 'erro2';       Integrador.y  = 'out3';
sum1 = sumblk('erro1 = out1 - an');
sum2 = sumblk('erro2 = out2 - out4');
sum3 = sumblk('u = out3 - out5');

ClosedLoop = connect(G.Nominal, Kss, Ki, Kt, Kq, Integrador, sum1, sum2, sum3, {'an_{ref}'}, {'an'});
step(ClosedLoop);