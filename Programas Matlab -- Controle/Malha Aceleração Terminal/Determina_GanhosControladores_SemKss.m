clear all; close all; clc;

%% 1. Carrega a planta incerta.
load('PlantaIncerta.mat');

%% 2. Ganhos do sistema a serem determinadas pelo sistema.
ki  = realp('ki',1);
kt  = realp('kt',1);
kq  = realp('kq',1);

% Respectivas funções de transferência.
Kt  = tf(kt,1);
Ki  = tf(ki,1);
Kq  = tf(kq,1);
int = tf([1],[1 0]);

% Pesos do sistema.
Ws = tf([0.115],[1 0.01]);                 % Peso para 'S'.
Wt = tf([3.2 24 86.9],[1 52.2 110]);     % Peso para 'T'.
% Wt = tf([1],[1]);
Wu = tf([1],[1]);

% Entradas e saídas dos blocos do sistema como um todo.
Ki.u  = 'erro1';            Ki.y   = 'out2';
Kt.u  = 'q';                Kt.y   = 'out4';
Kq.u  = 'q';                Kq.y   = 'out5';
int.u = 'erro2';            int.y  = 'out3';
Ws.u  = 'erro_em_a';        Ws.y  = 'z1';
Wt.u  = 'erro1';            Wt.y  = 'z2';
Wu.u  = 'u';                Wu.y  = 'z3';

sum1 = sumblk('erro1 = an_{ref} - an');
sum2 = sumblk('erro2 = out2 - out4');
sum3 = sumblk('u = out3 - out5');
sum4 = sumblk('erro_em_a = an_{ref} - an');

% Conecta todo mundo, com o caso nominal (G.Nominal).
T0 = connect(G.Nominal, Ki, Kt, Kq, int, Ws, Wt, Wu, sum1, sum2, sum3, {'an_{ref}'}, {'z1', 'z2','z3'});

% Realiza o cálculo do Hinfstruct para o caso da planta nominal.
rng('default');
opt = hinfstructOptions('Display','final','RandomStart',5);
T   = hinfstruct(T0, opt);
showTunable(T);

%% Pegando os valores das funções obtidas.
ki  = T.Blocks.ki.Value;
kq  = T.Blocks.kq.Value;
kt  = T.Blocks.kt.Value;

Kt  = tf(kt,1);
Ki  = tf(ki,1);
Kq  = tf(kq,1);
int = tf([1],[1 0]);

Ki.u  = 'erro1';            Ki.y   = 'out2';
Kt.u  = 'q';                Kt.y   = 'out4';
Kq.u  = 'q';                Kq.y   = 'out5';
int.u = 'erro2';            int.y  = 'out3';

ClosedLoop = connect(G.Nominal, Ki, Kt, Kq, int, sum1, sum2, sum3, {'an_{ref}'}, {'an'});
step(ClosedLoop);
