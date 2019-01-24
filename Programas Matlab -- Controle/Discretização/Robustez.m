clear all; close all;  clc;

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

% Ganhos do LQR do livro -- página 594.
% -------------------------------------
Ki = 1.361;
Ka = -0.0807;
Kq = -0.475;

% Controladores do sistema.
% -------------------------
Gi = tf(Ki, [1 0]);
Ga = tf(10*Ka, [1 10]);
Gq = tf(Kq, [1]);

% Função de loop de malha aberta.
% -------------------------------
L = -((Gi-Gq)*G(2)-Ga*G(1));
[mag, phase] = bode(L);
for i = 1:max(size(mag))
    MAG(i)   = mag(:,:,i);
    PHASE(i) = phase(:,:,i);
end
plot(PHASE, 20*log10(MAG)); grid;

