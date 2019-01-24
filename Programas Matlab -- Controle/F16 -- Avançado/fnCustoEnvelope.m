function J = fnCustoEnvelope(x, A, B, C, D)

% Desembrulho as variáveis.
kp = x(1);
kd = x(2);

K = [ 0  0  kp  kd];
Acl = A - B*K;
Bcl = B*kp;
Ccl = C(3,1:end);
Dcl = D(3,1:end);

sys = ss(Acl, Bcl, Ccl, Dcl);
[y, t, ~] = step(sys, 0:0.01:10);


% Função de referência.
% eta = 0.7;
% wn  = 1.5;
% theta = tf([wn^2],[1 2*eta*wn wn^2]);
% [yref, t, ~]  = step(theta, 0:0.01:10);

e = 1- y;

% 1. Cálculo do custos pelo padrão ITAE (integral of time multiplied by
%    absolute error) -- página 221.
mod_e = abs(e);
J     = t'*mod_e

% 2. Cálculo do custos pelo padrão ITSE (integral of time multiplied by
%    squared error) -- página 221.
e_2   = e.^2;
J     = t'*e_2;
end