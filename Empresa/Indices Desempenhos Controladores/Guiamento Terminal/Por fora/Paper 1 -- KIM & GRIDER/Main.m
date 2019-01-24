clear all; close all; clc;

% Posição inicial do Míssil no início do GUIAMENTO.
Pmx = 0;
Pmy = 10000;
Vtm = 100;                      % Velocidade total do míssil.
Theta0 = 0;                     % Ângulo inicial, em graus.
Vmx = Vtm*sin(Theta0*pi/180);
Vmy = Vtm*cos(Theta0*pi/180);

% Posição inicia do Alvo no início do GUIAMENTO.
Ptx = 10000;
Pty = 0;
Vtx = 10;
Vty = 0;

% O símbolo X, maiúsculo, representará o vetor de estados do Míssil, e o Y,
% também maiúsculo, representará os estados do Alvo.
X(1,1) = Pmx;
X(1,2) = Vmx;
X(1,3) = Pmy;
X(1,4) = Vmy;
X(1,5) = Theta0;

Y(1,1) = Ptx;
Y(1,2) = Vtx;
Y(1,3) = Pty;
Y(1,4) = Vty;

% Definição dos termos iniciais, como a distância na vertical, na
% horizontal entre o míssil e o alvo, bem como a linha de visada (LOS)
% entre os dois corpos.
dx = Y(1,1) - X(1,1);
dy = Y(1,3) - X(1,3);
lambda = atan2(abs(dx),abs(dy));    % Ângulo em relação ao eixo y.

K0 = 1;
K  = 1;

C1 = K0*cos(lambda)^2*(-Vmy)/Pmy^2;
C2 = K0*cos(lambda)^2/Pmy;
C3 = K;




