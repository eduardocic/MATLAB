clear all; close all; clc;

% Eduardo H. Santos
% 21/03/2017
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
Vm  = 3000;                  % Velocidade total do m�ssil.
Pmx = 0;                     % Posi��o em x do m�ssil.
Pmy = 10000;                 % Posi��o em y do m�ssil.
HEemGraus = 0;               % 'Heading Error' em graus.
HE  = HEemGraus/57.3;        % em radiano.
N   = 5;                     % Par�metro de projeto.

%%% Caracter�sticas iniciais do alvo (target).
Vt   = 1000;            % Velocidade total do alvo.
Ptx  = 40000;           % Posi��o em x do alvo.
Pty  = 10000;           % Posi��o em y do alvo.
beta = 0;               % �ngulo do alvo com a horizontal.
nt   = 96.6;               % Acelera��o perpendicular do alvo.
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

lambda  = atan2(dy, dx);
L       = asin(Vt*sin(beta + lambda)/Vm);
X(1,2)  = Vm*cos(L + lambda + HE);
X(1,4)  = Vm*sin(L + lambda + HE);

% C�lculo da velocidade relativa entre o m�ssil e o alvo.
vx = Y(1,2) - X(1,2);
vy = Y(1,4) - X(1,4);

% C�lculo de aproxima��o entre os alvos.
Vc  = -(dx*vx + dy*vy)/d;

% C�lculo iterativo.
i    = 1;
t(1) = 0 ;
while(Vc >=0)
    if (d < 1000)
        h = 0.00002;            % Em segundos
    else
        h = 0.01;               % Em segundos
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
    
    % C�lculo do 'nc' e beta;
    nc(i) = N*Vc*lambdaD;
    betaD = nt/Vt;
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
xlim([0 10;])
