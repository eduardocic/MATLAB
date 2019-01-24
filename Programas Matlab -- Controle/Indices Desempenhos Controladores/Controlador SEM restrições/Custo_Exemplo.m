function J = Custo_Exemplo(x, G, Ga, Gf)

% Desembrulhando os termos a serem minimizados -- para facilitar a leitura
% do c�digo.
Ka  = x(1);
Kq  = x(2);
Ke  = x(3);
Ki  = x(4);

g   = tf([1],[1 0]);        % Integrador.
PHI = -Ka*Gf*G(1) - Kq*G(2) + Ke*G(3) + Ki*g*G(3);
PSI = -(Ki*g + Ke);

% Fun��o de malha fechada do sistema -- T(s)
T   = minreal(Ga*PSI*G(3)/(1 - Ga*PHI));

% C�lculo da sa�da e do tempo de simula��o.
[nz, t, ~] = step(T,30);

% C�lculo do erro entre a refer�ncia e a sa�da.

e     = 1 - nz;
% 1. C�lculo do custos pelo padr�o ITAE (integral of time multiplied by
%    absolute error) -- p�gina 221.
mod_e = abs(e);
J     = t'*mod_e;

end