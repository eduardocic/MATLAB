% Restri��es e entradas para o controle.

rho  = 100;            % Peso para o Controle.
Umax = 1;            % Restri��o de Entrada.
T    = 1;            % Passo de Simula��o.

H = MatrizH(A);      % do Estado de Xss.
Hlinha = orth(H);