%%% Estado Inicial
xk0  = [-10; 0];

%%% Passo de Simula��o.
T    = 0.5;            

%%% Restri��es sobre entrada e sa�da.
Umax = 5;          
Ymax = 0.1;
Ymin = -10;
Y    = [Ymin Ymax]; 
[r, xref, Eps, yb] = ReferencesCavalca(Y, C, xk0);

%%% Dire��o do vetor Xss.
H    = MatrixH(A);   

%%%  Matrizes de Peso.
S = [100     0;     
       0  0.01];   
R = 100;
Smeio = sqrt(S);
Rmeio = sqrt(R);
global i
i = 1;
