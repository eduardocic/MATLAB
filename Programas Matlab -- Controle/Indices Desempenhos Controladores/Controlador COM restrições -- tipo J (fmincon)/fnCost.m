function J = fnCost(x)

% Chamada da fun��o 'G(s)', definida na fun��o 'Main'.
global G

% Desembrulho as vari�veis.
Kp = x(1);
Kd = x(2);

% Fun��o de malha L(s).
L = minreal(Kp*G(1) + Kd*G(2));

% Fun��o de malha fechada.
T = minreal(L/(1 + L));

% C�lculo da sa�da e do tempo de simula��o.
[y, t, ~] = step(T,10);

% C�lculo do erro.
e     = 1 - y;

% 1. C�lculo do custos pelo padr�o ITAE (integral of time multiplied by
%    absolute error) -- p�gina 221.
mod_e = abs(e);
J     = t'*mod_e;

% 2. C�lculo do custos pelo padr�o ITSE (integral of time multiplied by
%    squared error) -- p�gina 221.
% e_2   = e.^2;
% J     = t'*e_2;

end