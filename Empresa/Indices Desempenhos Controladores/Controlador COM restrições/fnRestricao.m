function [c, ceq] = fnRestricao(x)

global G;

% Desembrulho as vari�veis.
K = x(1);
a = x(2);

% Constroi o controlador C(s).
C = K*tf([1 a],[1 1]);

% Fun��o de malha L(s).
L = minreal(C*G);

% Obten��o das margens do projeto.
[~, ~, Wgm, ~] = margin(L);

% c(1)   = Wgm - 40;
c(2)   = -Wgm + 0.01;
ceq = [];

end