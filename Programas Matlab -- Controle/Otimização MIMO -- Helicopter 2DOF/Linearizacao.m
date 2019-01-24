clear all; close all; clc;

% Variáveis simbólicas.
syms Vmp Vmy                  % Variáveis de CONTROLE.
syms theta phi theta_p phi_p  % Variáveis de ESTADO.
syms Kpp Kyy Kyp Kpy          % Constante de Força dos Motores.
syms Beq_p Beq_y              % Atrito Viscoso dos Motores.
syms M rcm g                  % Propriedades do Helicoptero e gravidade.
syms Jeq_p Jeq_y              % Momento de Inércia.

% Em termos de equações de estados, tem-se, de maneira LITERAL que:
Jp = Jeq_p + M*rcm^2;
Jy = Jeq_y + M*rcm^2*cos(theta)^2;
theta_pp = (1/Jp)*(Kpp*Vmp + Kpy*Vmy - M*rcm^2*sin(theta)*cos(theta)*phi_p^2 - ...
                   M*g*rcm*cos(theta) - Beq_p*theta_p);
phi_pp   = (1/Jy)*(Kyp*Vmp + Kyy*Vmy - M*rcm^2*sin(2*theta)*theta_p*phi_p - ...
                   Beq_y*phi_p);

x   = [theta;  theta_p; phi; phi_p];
x_p = [theta_p;  theta_pp; phi_p; phi_pp];

% Em termos de variáveis de controle, tem-se:
u = [Vmp; Vmy];

% Tenho a intenção de fazer a minha variável 'y' ser definida em termos
% de 'theta' e 'phi' (realimentação dos ângulos apenas).
y = [theta phi];

% Determinação da linearização de equações.
A = jacobian(x_p, x);
B = jacobian(x_p, u);
C = jacobian(y, x);
D = jacobian(y, u);

% Determinação das constantes do sistema.
Kpp   = 0.204;          % em N.m/V
Kyy   = 0.072;          % em N.m/V
Kpy   = 0.0068;         % em N.m/V
Kyp   = 0.0219;         % em N.m/V
Beq_p = 0.8;            % em N/V
Beq_y = 0.318;          % em N/V
M     = 1.3872;         % em kg
rcm   = 0.186;          % em m
Jeq_y = 0.0384;         % em kg.m^2
Jeq_p = 0.0432;         % em kg.m^2
g     = 9.81;           % em m/s^2

% Ponto de equilíbrio considerado - ESTADOS obtidos pela função 'Trimmer'
theta   = 0;
theta_p = 0;
phi     = 0;
phi_p   = 0;

% Ponto de equilíbrio considerado - CONTROLES obtidos pela função 'Trimmer'
Vmp     = 12.5348;
Vmy     = -3.81266;

A = double(subs(A));
B = double(subs(B));
C = double(subs(C));
D = double(subs(D));

sys = ss(A,B,C,D);
G   = minreal(tf(sys));

save('Matrizes.mat', 'A', 'B', 'C', 'D');
