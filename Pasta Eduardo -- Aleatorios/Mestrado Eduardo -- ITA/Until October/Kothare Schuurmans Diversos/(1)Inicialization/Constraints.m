H = MatrixH(A);      % Dire��o do vetor Xss.

rho  = 0.00001;      % Peso para o Controle (multiplica o gama).
Umax = 2;            % Restri��o de Entrada.
T    = 1;            % Passo de Simula��o.

xk0  = [500; 20];
K    = 0*linspace(1,1,n);  % Matriz de Inicializa��o Schuurmans.
