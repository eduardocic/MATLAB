H = MatrixH(A);      % Direção do vetor Xss.

rho  = 100;          % Peso para o Controle (multiplica o gama).
Umax = 2;            % Restrição de Entrada.
T    = 1;            % Passo de Simulação.

xk0  = [80; 0];