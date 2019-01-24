%%% Passo de Simulação.
T = 5;            

%%% Atraso de Transporte.
tao   = 6;
tao_p = 6;

%%% Referências.
h_ref = 30;     % 30%
u_ref = 65;     % 65%

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
