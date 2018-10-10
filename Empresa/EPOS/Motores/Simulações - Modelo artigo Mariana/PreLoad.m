% Matrizes de estado
% ------------------
T = 0.5;
A{1} = [ 1  0.5;
         0   1];
A{2} = A{1};
  
B{1} = 0.9*[(T^2)/2;
             T];
      
B{2} = 1.1*[(T^2)/2;
             T];

C = [1 0.2];


% Posi��o Inicial
% ---------------
xk0  = [-10; 0];


% Restri��es
% -----------
Umax   = 5;              % Restri��o de Entrada.
Ymin   = -10;            
Ymax   = 0.1;
Ylimites = [Ymin Ymax];  % Restri��es Assim�trica.
at       = min(abs(Ymax), abs(Ymin));  % Utilizado apenas em 'Eduardo'.


% Matriz H.
% ---------
H      = MatrizH(A);      
Hlinha = orth(H);
rho    = 10^-4;


% Pesos.
% ------
S = [100     0;     
       0  0.01];   
R = 100;