clear all; close all; clc;

% Eduardo H. Santos
% 12/12/2017
% 
% 
% (*) Eu n�o entendi muito bem o c�digo do Zarchan. Limita��o minha. Sendo
%     assim, eu decidi ent�o refazer todo o c�lculo do livro por meio de
%     equa��es no espa�o de estados (acredito que fica mais f�cil para
%     mim).
%
% (*) As caracter�sticas do m�ssil foram colocadas em um vetor 'X' e as 
%     caracter�sticas do alvo (target) foram colocadas em um vetor 'Y'.
%
% (*) No caso, primei por ordenar nos vetores 'X' e 'Y' os par�metros que
%     dizem respeito �, na ordem:
%
%       1 - posi��o em x
%       2 - velocidade em x
%       3 - posi��o em y
%       4 - velocidade em y
%
% (*) O resto to c�digo est� bem explicativo, inclusive com a aloca��o das
%     vari�veis que s�o constantemente alteradas (vide fun��es 'f_missil' e
%     'f_target').
 

%%% Caracter�sticas iniciais do m�ssil.
Vm  = 500;                  % Velocidade total do m�ssil.
Pmx = 0;                    % Posi��o em x do m�ssil.
Pmy = 0;                    % Posi��o em y do m�ssil.

N       = 4;
gammaF  = -60/57.3;
gammaIC = -30/57.3;           % �ngulo inicial em rela��o � horizontal.

%%% Caracter�sticas iniciais do alvo (target).
Vt   = 0;               % Velocidade total do alvo.
Ptx  = 20000;           % Posi��o em x do alvo.
Pty  = 0;           % Posi��o em y do alvo.
beta = 0;               % �ngulo do alvo com a horizontal.
nt   = 0;               % Acelera��o perpendicular do alvo.
Vtx  = -Vt*cos(beta);   % Velocidade em x do alvo.
Vty  = Vt*sin(beta);    % Velocidade em y do alvo.


% -------------------------------------------------------------------------
% Com essas informa��es, � necess�rio ent�o calcular qual seria a
% velocidade do m�ssil em cada um dos eixos. No caso, sabe-se a dist�ncia
% entre o m�ssil e o alvo. Com isso, ser� determinada a linha de visada
% (LOS).
% -------------------------------------------------------------------------

% Vetor de estados do m�ssil.
X(1,1) = Pmx;
X(1,3) = Pmy;

% Vetor de estados do alvo.
Y(1,1) = Ptx;
Y(1,2) = Vtx;
Y(1,3) = Pty;
Y(1,4) = Vty;

% C�lculo da velociade do m�ssil.
dx = Y(1,1) - X(1,1);
dy = Y(1,3) - X(1,3);
d  = sqrt(dx^2 + dy^2);

% Obten��o do lambda.
lambda  = atan2(dy, dx);
X(1,2)  = Vm*cos(gammaIC);
X(1,4)  = Vm*sin(gammaIC);

% C�lculo da velocidade relativa entre o m�ssil e o alvo.
vx = Y(1,2) - X(1,2);
vy = Y(1,4) - X(1,4);

% C�lculo de aproxima��o entre os alvos.
Vc  = -(dx*vx + dy*vy)/d;

% C�lculo iterativo.
i    = 1;
t(1) = 0;

% Determina��o do BIAS.
deltaT = 30;
bias = (-gammaF*(N-1) + N*lambda - gammaIC)/deltaT;

while(Vc >= 0)
    if (d < 2000)
        h = 0.0002;            % Em segundos
    else
        h = 0.1;               % Em segundos
    end
    
    % Dist�ncia relativa.
    % -------------------
    dx = Y(i,1) - X(i,1);
    dy = Y(i,3) - X(i,3);
    d  = sqrt(dx^2 + dy^2);     % Dist�ncia M�ssil-Alvo.
   
    % Velocidade relativa.
    % --------------------
    vx = Y(i,2) - X(i,2);
    vy = Y(i,4) - X(i,4);
    
    % Lambda, derivada de lambda e velocidade de aproxima��o (Vc).
    % ------------------------------------------------------------
    lambda  = atan2(dy, dx);
    lambdaD = (dx*vy - dy*vx)/d^2;    
    Vc      = -(dx*vx + dy*vy)/d;
    
    % C�lculo do 'nc' e beta.
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
    
    % C�lculo do Runge Kutta de 2nd Ordem para atualiza��o dos estados.
    % -----------------------------------------------------------------
    % a) M�ssil.
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

% Pegando apenas os dados de posi��o j� calculados.
alfa = 1000;   % convers�o para 'Kft'.
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
ylabel('Acelera��o em G');
xlim([0 10;]);
