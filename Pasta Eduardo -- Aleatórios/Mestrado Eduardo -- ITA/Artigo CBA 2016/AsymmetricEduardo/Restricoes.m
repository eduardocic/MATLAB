%%% Restri��es sobre entrada e sa�da.
Umax = 5;
Ymin = -10;
Ymax = 0.1;
Y    = [Ymin Ymax];  

%%% Dire��o do vetor Xss.
H    = MatrixH(A);   

%%% Ponto Tangente.
at    = min(abs(Ymax), abs(Ymin));  % at: 'a' que do ponto tangente.

