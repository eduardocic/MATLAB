function J = Custo_Exemplo(x, G, Ga, Gf)

% Desembrulhando os termos a serem minimizados -- para facilitar a leitura
% do código.
Ka  = x(1);
Kq  = x(2);
Ke  = x(3);
Ki  = x(4);

g   = tf([1],[1 0]);        % Integrador.
PHI = -Ka*Gf*G(1) - Kq*G(2) + Ke*G(3) + Ki*g*G(3);
PSI = -(Ki*g + Ke);

% Função de malha fechada do sistema -- T(s)
T   = minreal(Ga*PSI*G(3)/(1 - Ga*PHI));

% Cálculo da saída e do tempo de simulação.
[nz, t, ~] = step(T,30);

% Cálculo do erro entre a referência e a saída.

e     = 1 - nz;
% 1. Cálculo do custos pelo padrão ITAE (integral of time multiplied by
%    absolute error) -- página 221.
mod_e = abs(e);
J     = t'*mod_e;

end