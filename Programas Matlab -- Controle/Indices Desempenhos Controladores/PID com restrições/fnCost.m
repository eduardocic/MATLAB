function J = fnCost(x)

% Chamada da função 'G(s)', definida na função 'Main'.
global G

% Desembrulho as variáveis.
K = x(1);
z = x(2);
p = x(3);

% Controlador.
C = tf([1 x(2)],[1 x(3)]);

% Função de malha L(s).
L = minreal(x(1)*C*G);

% Função de malha fechada.
T = minreal(L/(1 + L));

% Cálculo da saída e do tempo de simulação.
[y, t, ~] = step(T, 20);

% Cálculo do erro.
e     = 1 - y;

% 1. Cálculo do custos pelo padrão ITAE (integral of time multiplied by
%    absolute error) -- página 221.
mod_e = abs(e);
J     = t'*mod_e;

% 2. Cálculo do custos pelo padrão ITSE (integral of time multiplied by
%    squared error) -- página 221.
% e_2   = e.^2;
% J     = t'*e_2;

end