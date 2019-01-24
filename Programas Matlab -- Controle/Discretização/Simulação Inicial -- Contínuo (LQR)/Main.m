close all; clear all; clc;

% Matrizes do sistema.
% --------------------
A = [-1.01887   0.90506   -0.00215;
      0.82225  -1.07741   -0.17555;
            0         0      -20.2];
        
B = [0  0  20.2]';        
C = [57.2958      0    0;
           0  57.2958  0;];
D = [0 0]';  

sys = ss(A,B,C,D);
G   = tf(sys);


% Tempos os quais podem ser utilizados na discretização.
% ------------------------------------------------------
% dt = 0.25;
% dt = 0.1;
dt = 0.025;

% Ganhos do LQR do livro -- página 594.
% -------------------------------------
Ki = 1.361;
Ka = -0.0807;
Kq = -0.475;

% Após a discretização.
% ---------------------
k1 = Ki*dt/2;
PI = (1-10*dt/2)/(1+10*dt/2);
k2 = 10*Ka*dt/(10*dt+2);
k3 = Kq;

% Controladores do sistema a serem discretizados.
K1 = tf(Ki, [1 0]);
K2 = tf(10*Ka, [1 10]);
K3 = tf(Kq, [1]);

% Possíveis tempos de discretização.
K1d = c2d(K1, dt, 'tustin');   % Controlador K1 discretizado.
K2d = c2d(K2, dt, 'tustin');   % Controlador K2 discretizado.
K3d = c2d(K3, dt, 'tustin');   % Controlador K3 discretizado.

