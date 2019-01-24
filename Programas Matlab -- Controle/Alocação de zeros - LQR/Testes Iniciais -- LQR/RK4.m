function [xdot] = RK4(funcao, t, h, x, u)
% =========================================================================
% Esta função diz respeito ao calculo por Runge Kuta de 4º ordem.
% O processo de RK4 eh relativamente facil e se encontra presenta na pagina
% 173 do livro 'Aircraft Control and Simulation', 2nd Edition. Stevens and
% Lewis.
% -------------------------------------------------------------------------
%
% k1 = T.f(x, t);
% k2 = T.f(x + b1.k1, t + a1.T);
% k3 = T.f(x + b2.k1 + b3.k2, t + a2.T);
% .
% .
% .
% xRK(t + T) = x(t) + g1.k1 + g2.k2 + g3.k3 + ...
%
% Os coeficientes multiplicativos sao os seguintes (presentes na pagina
% 174 do referido livro):
%
%    *  a1 = a2 = b1 = b3 = 1/2;  (equivalem ao 'alfa' e 'beta');
%   **  a3 = b6 = 1;
%  ***  b2 = b4 = b5 = 0;
% ****  g1 = g4 = 1/6;       e     g2 = g3 = 1/3
%
%
% No caso, o que se tem é:
% 
%   k0 = f(x, t);
%   k1 = f(x + 0.5*k1, t + 0.5.T);
%   k2 = f(x + 0.5*k2, t + 0.5.T);
%   k3 = f(x + k2, t + T);
% =========================================================================

F1 = feval(funcao, t, x, u);                          % f(x, t);
k1 = h*F1;

F2 = feval(funcao, (t + 0.5*h), (x + 0.5*k1), u);    % f(x + b1.k1, t + a1.T);    
k2 = h*F2;

F3 = feval(funcao, (t + 0.5*h), (x + 0.5*k2), u);    % f(x + b2.k1 + b3.k2, t + a2.T);
k3 = h*F3;

F4 = feval(funcao, (t + 1*h), (x + 1*k3), u);        % f(x + b4.k1 + b5.k2 + b6*k3, t + a3.T);
k4 = h*F4;

xdot = x + (k1 + 2*k2 + 2*k3 + k4)/6;
end