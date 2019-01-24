clear all; close all; clc;

% Eduardo H. Santos
% 12/12/2017
% 
% 
% (*) Eu não entendi muito bem o código do Zarchan. Limitação minha. Sendo
%     assim, eu decidi então refazer todo o cálculo do livro por meio de
%     equações no espaço de estados (acredito que fica mais fácil para
%     mim).
%
% (*) As características do míssil foram colocadas em um vetor 'X' e as 
%     características do alvo (target) foram colocadas em um vetor 'Y'.
%
% (*) No caso, primei por ordenar nos vetores 'X' e 'Y' os parâmetros que
%     dizem respeito à, na ordem:
%
%       1 - posição em x
%       2 - velocidade em x
%       3 - posição em y
%       4 - velocidade em y
%
% (*) O resto to código está bem explicativo, inclusive com a alocação das
%     variáveis que são constantemente alteradas (vide funções 'f_missil' e
%     'f_target').
 

%%% Características iniciais do míssil.
Vm  = 500;                  % Velocidade total do míssil.
Pmx = 0;                    % Posição em x do míssil.
Pmy = 0;                    % Posição em y do míssil.

N       = 4;
gammaF  = -60/57.3;
gammaIC = -30/57.3;           % Ângulo inicial em relação à horizontal.

%%% Características iniciais do alvo (target).
Vt   = 0;               % Velocidade total do alvo.
Ptx  = 20000;           % Posição em x do alvo.
Pty  = 0;           % Posição em y do alvo.
beta = 0;               % Ângulo do alvo com a horizontal.
nt   = 0;               % Aceleração perpendicular do alvo.
Vtx  = -Vt*cos(beta);   % Velocidade em x do alvo.
Vty  = Vt*sin(beta);    % Velocidade em y do alvo.


% -------------------------------------------------------------------------
% Com essas informações, é necessário então calcular qual seria a
% velocidade do míssil em cada um dos eixos. No caso, sabe-se a distância
% entre o míssil e o alvo. Com isso, será determinada a linha de visada
% (LOS).
% -------------------------------------------------------------------------

% Vetor de estados do míssil.
X(1,1) = Pmx;
X(1,3) = Pmy;

% Vetor de estados do alvo.
Y(1,1) = Ptx;
Y(1,2) = Vtx;
Y(1,3) = Pty;
Y(1,4) = Vty;

% Cálculo da velociade do míssil.
dx = Y(1,1) - X(1,1);
dy = Y(1,3) - X(1,3);
d  = sqrt(dx^2 + dy^2);

% Obtenção do lambda.
lambda  = atan2(dy, dx);
X(1,2)  = Vm*cos(gammaIC);
X(1,4)  = Vm*sin(gammaIC);

% Cálculo da velocidade relativa entre o míssil e o alvo.
vx = Y(1,2) - X(1,2);
vy = Y(1,4) - X(1,4);

% Cálculo de aproximação entre os alvos.
Vc  = -(dx*vx + dy*vy)/d;

% Cálculo iterativo.
i    = 1;
t(1) = 0;

% Determinação do BIAS.
deltaT = 30;
bias = (-gammaF*(N-1) + N*lambda - gammaIC)/deltaT;

while(Vc >= 0)
    if (d < 2000)
        h = 0.0002;            % Em segundos
    else
        h = 0.1;               % Em segundos
    end
    
    % Distância relativa.
    % -------------------
    dx = Y(i,1) - X(i,1);
    dy = Y(i,3) - X(i,3);
    d  = sqrt(dx^2 + dy^2);     % Distância Míssil-Alvo.
   
    % Velocidade relativa.
    % --------------------
    vx = Y(i,2) - X(i,2);
    vy = Y(i,4) - X(i,4);
    
    % Lambda, derivada de lambda e velocidade de aproximação (Vc).
    % ------------------------------------------------------------
    lambda  = atan2(dy, dx);
    lambdaD = (dx*vy - dy*vx)/d^2;    
    Vc      = -(dx*vx + dy*vy)/d;
    
    % Cálculo do 'nc' e beta.
    % -----------------------
    gammaD = N*lambdaD + bias;
%     nc(i)  = Vm*gammaD;
%     nc(i) = N*Vc*lambdaD;
    nc(i) = 4*Vc*lambdaD + 2*Vc*(lambda - gammaF)/(d/abs(Vc));
    if (Vt == 0)
        betaD = 0;
    else
        betaD = nt/Vt;
    end
    beta  = beta + h*betaD;
    
    % Cálculo do Runge Kutta de 2nd Ordem para atualização dos estados.
    % -----------------------------------------------------------------
    % a) Míssil.
    k1     = f_missil(X(i,:), i, nc(i), lambda);             % k1
    k2     = f_missil(X(i,:) + h*k1, i + h, nc(i), lambda);  % k2
    X(i+1,:) = X(i,:) + h*(k1 + k2)/2;                   
    
    % b) Alvo.
    k1  = f_target(Y(i,:), i, nt, beta);                     % k1
    k2  = f_target(Y(i,:) + h*k1, i + h, nt, beta);          % k2
    Y(i+1,:) = Y(i,:) + h*(k2 + k2)/2;                       % Y(i+1)
    i = i+1;
    t(i) = t(i-1) + h;
end

% Pegando apenas os dados de posição já calculados.
alfa = 1000;   % conversão para 'Kft'.
for j=1:i
   xm(j) = X(j,1)/alfa; 
   ym(j) = X(j,3)/alfa;
   
   xt(j) = Y(j,1)/alfa; 
   yt(j) = Y(j,3)/alfa;
end

plot(xm, ym); hold on;
plot(xt, yt, 'r'); grid;
xlabel('Downrange (Kft)');
ylabel('Crossrange(Kft)');

figure;
t = t(1,1:end-1);
plot(t, nc/32.2000); grid;
xlabel('Tempo (s)');
ylabel('Aceleração em G');
xlim([0 10;]);
