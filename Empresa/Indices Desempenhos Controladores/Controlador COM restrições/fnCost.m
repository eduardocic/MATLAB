function J = fnCost(x)

% Chamada da função 'G(s)', definida na função 'Main'.
global G

% Construção do controlador C(s) com as variáveis que necessitam ser
% otimizadas.
C = x(1)*tf([1 x(2)],[1 1]);

% Determinação da função de malha aberta.
L = C*G;

% Função de malha fechada.
T = minreal(L/(1 + L));

% Cálculo da saída e do tempo de simulação.
[y, t, ~] = step(T,10);

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