clear all; close all; clc;

% Constantes do meu sistema.
m1 = 1;
m2 = 1;
k  = 1;

% Fun��o de transfer�ncia, matrizes de estado, de controlabilidade e
% observabilidade.
G = tf([(k/(m1*m2))],[1 0 ((1/m1) + (1/m2))*k 0 0]);
[A, B, C, D] = tf2ss(G.num{1}, G.den{1});
Co = ctrb(A,B);
Ob = obsv(A,C);

% Obten��o das matrizes para determina��o de numerador Nx(s) = P.S
P = PHIs(A, B);

% Comportamento dos zeros do meu sistema desejado. Para este caso em
% espec�fico, � de interesse que os zeros alvos do sistema sejam tais que a
% fun��o de transfer�ncia do numerador final � dada por:
% 
%   n(s) = (s+0.2)(s+0.05+0.7*j)(s+0.05-0.7*j) 
%        = s^3 + 0.3s^2 +0.5125s + 0.0985
%        = [1 0.3 0.5125 0.0985]*[s^3 s^2 s^1 s^0]'.
% 
% Com isso, Pdes = [1 0.3 0.5125 0.0985]
Pdes = [1 0.3 0.5125 0.0985];
H    = Pdes*inv(P);         % Obten��o de H = Pdes*inv(P).
Q    = H'*H;                % Matriz de ganhos.

% Peso do controle -- do maior para o menor.
rho = linspace(0.1,0.0001,1000);

for i=1:max(size(rho))
    
    % Determina��o da matriz K de realimenta��o.
    F{i}  = are(A, B*(rho(i)^-1)*B',Q);
    K{i}  = (rho(i)^-1)*B'*F{i};

    % Matriz obtida por realimenta��o.
    Gk(i)  = minreal(tf(ss(A, B, K{i}, D)));
    Kdc(i) = -1/(C*((A-B*K{i})^-1)*B);

    % Malha fechada.
    T(i)     = Gk(i)/(1+Gk(i));
    Time{i}  = stepinfo(T(i));
    Freq{i}  = allmargin(Gk(i));
    
    % Par�metros para plot.
    w(i)     = Freq{i}.PMFrequency(1);
end
