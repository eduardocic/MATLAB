clear all; close all; clc;

% Constantes do meu sistema.
m1 = 1;
m2 = 1;
k  = 1;

% Função de transferência, matrizes de estado, de controlabilidade e
% observabilidade.
G = tf([(k/(m1*m2))],[1 0 ((1/m1) + (1/m2))*k 0 0]);
[A, B, C, D] = tf2ss(G.num{1}, G.den{1});
Co = ctrb(A,B);
Ob = obsv(A,C);

% Obtenção das matrizes para determinação de numerador Nx(s) = P.S
P = PHIs(A, B);

% Comportamento dos zeros do meu sistema desejado. Para este caso em
% específico, é de interesse que os zeros alvos do sistema sejam tais que a
% função de transferência do numerador final é dada por:
% 
%   n(s) = (s+0.2)(s+0.05+0.7*j)(s+0.05-0.7*j) 
%        = s^3 + 0.3s^2 +0.5125s + 0.0985
%        = [1 0.3 0.5125 0.0985]*[s^3 s^2 s^1 s^0]'.
% 
% Com isso, Pdes = [1 0.3 0.5125 0.0985]
Pdes = [1 0.3 0.5125 0.0985];
H    = Pdes*inv(P);         % Obtenção de H = Pdes*inv(P).
Q    = H'*H;                % Matriz de ganhos.

% Peso do controle.
i   = 4;
rho = 100/(5*10^i);

% Determinação da matriz K de realimentação.
F = are(A, B*(rho^-1)*B',Q);
K = (rho^-1)*B'*F;

% Malha aberta do sistema com a matriz H e com a matriz K no ramo direto
% (como se a matriz C fosse). Apenas para verificação do comportamento do
% nosso sistema (se realmente o parâmetro de tunning 'rho' está fazendo o
% comportamento de malha aberta de Gk se aproximar do comportamento
% desejado de Gh.
Gk = ss(A, B, K, D);
Gh = ss(A, B, H, D);
p  = (1/25.1);
Gk_comp = ss(A, p*B, K, D);      % Compensado em ganho.

% Diagrama de Bode do sistema (Controlador K + Planta).
w = {0.1, 10};
bode(Gh,w); hold on; 
bode(Gk,w);
legend('Loop alvo', 'Com K');

% Diagrama de Bode do sistema (Controlador K compensado em ganho + Planta).
figure;
bode(Gh,w); hold on; 
bode(Gk_comp,w);
legend('Loop alvo', 'Com K (e compensação de ganho)');

% Para erro nulo quando seguindo referência.
Kdc = -1/(C*((A-B*K)^-1)*B);

% -------------------------------------------------------------------------
% Simulando os sistemas para verificação dos esforços de controle.
%
% -------------------------------------------------------------------------
% Sistema de equações que descrevem o sistema a ser simulado.
SISTEMA = 'SYS';

% Início das variáveis de estado.
x{1} = zeros(4,1);       

% Passo de integração (h), de amostragem (dt) e tempo total de sim.(T)
h  = 0.001;  
Tt = 100+h;                

for k = 1:(Tt/h)    
    % Entrada tipo 'Degrau Unitário'.
    if (k < (1/h))
        ref(k) = 0;
    else (k < (2/h))
        ref(k) = 1;
    end

    % Tempo discreto -- iniciando do zero.
    t(k)  = h*(k-1);
 
    % Controle do sistema.
    u(k)  = Kdc*ref(k) - K*x{k};
     
    % Simulação do sistema linear.
    x{k+1} = RK4(SISTEMA, t(k), h, x{k}, u(k));
end
X = x;
U = u;

figure;
tam = 2;
plot(t, U, 'LineWidth',tam); grid;
xlabel('Tempo (s)');
ylabel('Controle u(k)');

figure;
for j = 1:(max(size(X))-1)
    xx    = cell2mat(X(1,j));
    y1(j) = [1 0 0 0]*xx; 
    y2(j) = [0 1 0 0]*xx; 
    y3(j) = [0 0 1 0]*xx; 
    y4(j) = [0 0 0 1]*xx; 
end

plot(t, y1,'LineWidth',tam); hold on;
plot(t, y2, 'r','LineWidth',tam); 
plot(t, y3, 'c','LineWidth',tam); 
plot(t, y4, 'g','LineWidth',tam); grid;
xlabel('Tempo (s)');
ylabel('Estados');
legend('x_1(t)', 'x_2(t)', 'x_3(t)', 'x_4(t)');
