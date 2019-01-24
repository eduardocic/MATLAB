function [c, ceq] = fnRestricao(x)

global G;

% Desembrulho as vari�veis.
Kp = x(1);
Kd = x(2);

% Fun��o de malha L(s).
L = minreal(Kp*G(1) + Kd*G(2));
T = minreal(L/(1+L));

% Obten��o das margens do projeto.
[Gm, Pm, Wgm, Wpm] = margin(L);

% c(1) = Wpm - 40;
% c(2) = -Wpm + 5;
% c(3) = norm(T,inf) -1.1;
c   = [];
ceq = [];

end