%%% Estado Inicial
xk0  = [-10; 0];

%%% Passo de Simulação.
T    = 0.5;            

%%% Restrições sobre entrada e saída.
Umax = 5;
Ymin = -10;
Ymax = 0.1;
Y    = [Ymin Ymax];   

%%% Direção do vetor Xss.
H    = MatrixH(A);   

%%%  Matrizes de Peso.
S = [100     0;     
       0  0.01];   
R = 100;
Smeio = sqrt(S);
Rmeio = sqrt(R);
x0 = min(abs(Ymax), abs(Ymin));
