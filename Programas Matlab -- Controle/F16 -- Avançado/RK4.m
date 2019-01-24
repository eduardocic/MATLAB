function [xnew] = RK4(f, time, xx, u, dt)

% =========================================================================
% Esta funçao diz respeito ao calculo por Runge Kuta de 4º ordem.
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
% No caso, o que se tem �:
% 
%   k0 = f(x, t);
%   k1 = f(x + 0.5*k1, t + 0.5.T);
%   k2 = f(x + 0.5*k2, t + 0.5.T);
%   k3 = f(x + k2, t + T);

% =========================================================================
F1 = feval(f, xx, u, time);                          % f(x, t);
k1 = dt*F1;

F2 = feval(f, (xx + 0.5*k1), u, (time + 0.5*dt));    % f(x + b1.k1, t + a1.T);    
k2 = dt*F2;

F3 = feval(f, (xx + 0.5*k2), u,  (time + 0.5*dt));    % f(x + b2.k1 + b3.k2, t + a2.T);
k3 = dt*F3;

F4 = feval(f, (xx + 1*k3), u, (time + 1*dt));         % f(x + b4.k1 + b5.k2 + b6*k3, t + a3.T);
k4 = dt*F4;

xnew = xx + (k1 + 2*k2 + 2*k3 + k4)/6;

end