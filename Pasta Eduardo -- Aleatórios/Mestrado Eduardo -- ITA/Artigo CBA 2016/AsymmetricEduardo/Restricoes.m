%%% Restrições sobre entrada e saída.
Umax = 5;
Ymin = -10;
Ymax = 0.1;
Y    = [Ymin Ymax];  

%%% Direção do vetor Xss.
H    = MatrixH(A);   

%%% Ponto Tangente.
at    = min(abs(Ymax), abs(Ymin));  % at: 'a' que do ponto tangente.

