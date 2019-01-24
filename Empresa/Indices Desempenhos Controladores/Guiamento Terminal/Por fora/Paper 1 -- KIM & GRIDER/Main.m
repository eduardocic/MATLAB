clear all; close all; clc;

% Posi��o inicial do M�ssil no in�cio do GUIAMENTO.
Pmx = 0;
Pmy = 10000;
Vtm = 100;                      % Velocidade total do m�ssil.
Theta0 = 0;                     % �ngulo inicial, em graus.
Vmx = Vtm*sin(Theta0*pi/180);
Vmy = Vtm*cos(Theta0*pi/180);

% Posi��o inicia do Alvo no in�cio do GUIAMENTO.
Ptx = 10000;
Pty = 0;
Vtx = 10;
Vty = 0;

% O s�mbolo X, mai�sculo, representar� o vetor de estados do M�ssil, e o Y,
% tamb�m mai�sculo, representar� os estados do Alvo.
X(1,1) = Pmx;
X(1,2) = Vmx;
X(1,3) = Pmy;
X(1,4) = Vmy;
X(1,5) = Theta0;

Y(1,1) = Ptx;
Y(1,2) = Vtx;
Y(1,3) = Pty;
Y(1,4) = Vty;

% Defini��o dos termos iniciais, como a dist�ncia na vertical, na
% horizontal entre o m�ssil e o alvo, bem como a linha de visada (LOS)
% entre os dois corpos.
dx = Y(1,1) - X(1,1);
dy = Y(1,3) - X(1,3);
lambda = atan2(abs(dx),abs(dy));    % �ngulo em rela��o ao eixo y.

K0 = 1;
K  = 1;

C1 = K0*cos(lambda)^2*(-Vmy)/Pmy^2;
C2 = K0*cos(lambda)^2/Pmy;
C3 = K;




