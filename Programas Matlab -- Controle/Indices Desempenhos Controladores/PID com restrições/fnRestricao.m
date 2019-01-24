function [c, ceq] = fnRestricao(x)

% Chamada da fun��o 'G(s)', definida na fun��o 'Main'.
global G

% Desembrulho as vari�veis.
K = x(1);
z = x(2);
p = x(3);

% Controlador.
C = tf([1 x(2)],[1 x(3)]);

% Fun��o de malha L(s).
L = minreal(x(1)*C*G);

% Fun��o de malha fechada.
T = minreal(L/(1 + L));

% C�lculo da sa�da e do tempo de simula��o.
[y, t, ~] = step(T, 20);

% C�lculo do erro.
e     = 1 - y;
e_max = min(e);     % Erro m�ximo.

% Obten��o das margens do projeto.
[Gm, Pm, Wgm, Wpm] = margin(L);

% Encontrando o vetor de zero.
for i=1:max(size(t))
    flag = 0;
    if ((t(i) > 4) && flag == 0)
       flag = 1;
       Izao = i-1; 
    end
end



c(1) = e_max - 0.35;
c(2) = Wpm - 2.2222;
% c(3) = -Wpm + 5.5;
ceq = [];

end