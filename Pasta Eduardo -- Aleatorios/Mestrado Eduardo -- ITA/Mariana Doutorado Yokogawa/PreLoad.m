% Matrizes de Estado - "REPRESENTAM" O MODELO.
% --------------------------------------------
A = 1;
B = 0.0865;
C = 1;

% Restri��es sobre entrada.
% -------------------------
Umax = 10;            % Equivale a 10% 
Ymin = -20;           % Meu batente m�nimo � o -17.5%.
Ymax = 2;
Ylimites = [Ymin Ymax];

% Atraso de Transporte.
% ---------------------
tao   = 1;            % Geral (planta + processamento).
tao_p = 1;            % Atraso do controlador da planta.
Ta    = 5;            % Tempo de amostragem.

% Matrizes de Peso.
% -----------------
rho_h = 1;
rho_u = 0.1;
rho_w = 0.01;

S = eye(size(A) + tao + 1);         % Com integrador
% S = eye(size(A) + tao);
S(1,1) = rho_h;
for i = 1:(tao)
    S(i+1,i+1) = rho_u/(tao+1);
end
S(end, end) = rho_w;

R = rho_u/(tao+1);
Smeio = sqrt(S);
Rmeio = sqrt(R);

% Condi��o Inicial - Altura da planta depois de atingido o equil�brio.
% --------------------------------------------------------------------
hk = -17.5;

% Refer�ncias para o sistema.
% ---------------------------
hp_ref = 12.5;          % Refer�ncia de 12.5%;
up_ref = 60;            % step de 60%.
