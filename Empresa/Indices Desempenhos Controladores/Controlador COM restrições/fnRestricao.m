function [c, ceq] = fnRestricao(x)

global G;

% Desembrulho as variáveis.
K = x(1);
a = x(2);

% Constroi o controlador C(s).
C = K*tf([1 a],[1 1]);

% Função de malha L(s).
L = minreal(C*G);

% Obtenção das margens do projeto.
[~, ~, Wgm, ~] = margin(L);

% c(1)   = Wgm - 40;
c(2)   = -Wgm + 0.01;
ceq = [];

end