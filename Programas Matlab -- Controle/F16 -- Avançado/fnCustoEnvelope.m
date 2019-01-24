function J = fnCustoEnvelope(x, A, B, C, D)

% Desembrulho as vari�veis.
kp = x(1);
kd = x(2);

K = [ 0  0  kp  kd];
Acl = A - B*K;
Bcl = B*kp;
Ccl = C(3,1:end);
Dcl = D(3,1:end);

sys = ss(Acl, Bcl, Ccl, Dcl);
[y, t, ~] = step(sys, 0:0.01:10);


% Fun��o de refer�ncia.
% eta = 0.7;
% wn  = 1.5;
% theta = tf([wn^2],[1 2*eta*wn wn^2]);
% [yref, t, ~]  = step(theta, 0:0.01:10);

e = 1- y;

% 1. C�lculo do custos pelo padr�o ITAE (integral of time multiplied by
%    absolute error) -- p�gina 221.
mod_e = abs(e);
J     = t'*mod_e

% 2. C�lculo do custos pelo padr�o ITSE (integral of time multiplied by
%    squared error) -- p�gina 221.
e_2   = e.^2;
J     = t'*e_2;
end