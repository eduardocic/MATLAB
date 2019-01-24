% Início de tudo.
clear all; close all; clc;

% Segunda parte: análise no domínio da frequência.
A = [-1.9311e-02  8.8157e+00  -3.2170e+01  -5.7499e-01;
     -2.5389e-04 -1.0189e+00   0.0000e+00   9.0506e-01;
      0.0000e+00  0.0000e+00   0.0000e+00   1.0000e+00;
      2.9465e-12  8.2225e-01   0.0000e+00  -1.0774e+00];

% u = [elevator]
B = [ 1.7370e-01;
     -2.1499e-03;
      0.0000e+00;
     -1.7555e-01];
 
C = [0 0 180/pi 0;
     0 0 0 180/pi];
D = [0; 0];
G = minreal(tf(ss(A,B,C,D)));


% Bloco proporcional.
Kp0 = realp('kp',1);
Kp0 = tf(Kp0, [1]);
% Bloco derivativo.
Kd0 = realp('kd',1);
Kd0 = tf(Kd0,[1]);

% Especificação de quem é entrada e saída de cada bloco.
% wc = 10;  % Frequência de interesse
% s  = tf('s');
% LS = (1+0.01*s/wc)/(0.01+s/wc);
% bodemag(LS), grid, title('Target loop shape');
% LS.u  = 'y(1)';
% LS.y  = 'yp';
Kp0.u = 'e_theta';
Kp0.y = 'kp_e';
Kd0.u = 'y(2)';
Kd0.y = 'kd_e';
G.u   = 'u';
G.y   = 'y';

% Especifica as somas.
Soma1 = sumblk('e_theta = theta_ref - y(1)');
Soma2 = sumblk('u = kp_e - kd_e');

% Para o sistema como um todo temos que nos ligar em quem é a entrada e 
% quem é a saída.
T0 = connect(G, Kp0, Kd0, Soma1, Soma2, {'theta_ref'}, {'y(1)'});

rng('default')
opt = hinfstructOptions('Display','final','RandomStart',5);
[T, gamma, info] = hinfstruct(T0, opt);

clf; step(T)