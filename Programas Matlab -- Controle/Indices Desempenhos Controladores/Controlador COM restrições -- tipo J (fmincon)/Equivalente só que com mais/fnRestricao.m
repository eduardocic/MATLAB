function [c, ceq] = fnRestricao(x, G)

% Desembrulho as variáveis.
Kp = x(1);
Kd = x(2);

% Função de malha L(s).
L = minreal(Kp*G(1) + Kd*G(2));
T = minreal(L/(1+L));

% Obtenção das margens do projeto.
[Gm, Pm, Wgm, Wpm] = margin(L);

c(1) = Wpm - 5;
c(2) = -Wpm + 4.9;
c(3) = 20*log(norm(T,inf)) - 2;
% c   = [];
ceq = [];

end