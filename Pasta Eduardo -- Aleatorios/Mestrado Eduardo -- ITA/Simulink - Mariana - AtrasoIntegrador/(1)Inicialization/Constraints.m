%%% Estado Inicial
zk0  = (12.5/100)*70;       % 12.5% de 70cm.

%%% Passo de Simulação.
T = 5;            

%%% Atraso de Transporte.
tao = 6;

%%% Restrições sobre entrada e saída.
Umax = (10/100)*3450;       % 10% de 3450rpm

%%%  Matrizes de Peso.
rho_h = 1;
rho_u = 0.1;
rho_w = 0.01;

% Construção da Matriz S
S = eye(size(A) + tao + 1);
S(1,1) = rho_h;
for i = 1:(tao)
    S(i+1,i+1) = rho_u/(tao+1);
end
S(end, end) = rho_w;
R = rho_u/(tao+1);

Smeio = sqrt(S);
Rmeio = sqrt(R);
