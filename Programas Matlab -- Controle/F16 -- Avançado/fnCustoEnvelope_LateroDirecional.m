function J = fnCustoEnvelope_LateroDirecional(x, A, B, C, D)

% Desembrulho as variáveis.
K1  = x(1);
K2  = x(2);
K3  = x(3);
tao = x(4);


% Ajuste das matrizes de estado (A, B, C e D).
A   = [     A      zeros(4,1);
       [0 0 0 1/tao]  -1/tao  ];
B   = [B; zeros(1,2)];
C   = [0 1 0 0 0;
       0 0 0 1 0];
D   = [0 0; 0 0];


% Matrizes de ganho do controlador -- 'K' e 'L'.
K = [ 0     K2    K1     0    0;
      0      0     0     0    K3];
L = [ K2  0;
       0  1];
   

Acl = A - B*K;
Bcl = B*L;
Ccl = C;
Dcl = D;

TempoSim = 1:0.02:20;
G = minreal(tf(ss(Acl, Bcl, Ccl, Dcl)));
g11 = G(1,1);
g12 = G(1,2);
g21 = G(2,1);
g22 = G(2,2);

y11 = step(g11,TempoSim);
y12 = step(g12,TempoSim);
y21 = step(g21,TempoSim);
y22 = step(g22,TempoSim);

% Função de referência.
eta = 0.7;
wn  = 0.5;
theta = tf([wn^2],[1 2*eta*wn wn^2]);
yref  = step(theta, TempoSim);

% Erro de desacoplamento.
e1 = yref - y11;
e2 = y12;
e3 = y21;
e4 = yref - y22;

% 1. Cálculo do custos pelo padrão ITAE (integral of time multiplied by
%    absolute error) -- página 221.
% mod_e1 = abs(e1);
% mod_e2 = abs(e2);
% mod_e3 = abs(e3);
% mod_e4 = abs(e4);
% 
% 
% f(1)   = t'*mod_e1;
% f(2)   = t'*mod_e2;
% f(3)   = t'*mod_e3;
% f(4)   = t'*mod_e4;

% 2. Cálculo do custos pelo padrão ITSE (integral of time multiplied by
%    squared error) -- página 221.
% e_2   = e.^2;
J     =  e4'*e4 %+ (e2'*e2 + e3'*e3)
% J = sum(f);
end