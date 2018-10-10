%%% Matrizes de Estado - REPRESENTAM O MODELO.
A = 1;
B = 0.0865;
C = 1;

%%% Matrizes para utilização no SIMULINK
Csimulink = eye(size(A,1));       % Realimentação dos estados reais.
Dsimulink = 0*Csimulink(:,size(A,1));
