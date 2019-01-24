close all; clear all; clc;

% =========================================================================
%
%                           Casos considerados
%
% ========================================================================= 
% Caso nominal.
An = [-1.02   0.905;
       0.822  -1.08];
Bn = [ -0.0215;
       -0.175];
Cn = [    0  57.295;
      16.26  0.9787];
Dn = [     0
       -0.04852];  
      
% Incerteza 1.
Ap1 = [    0    0.0002;
        3.3214  0.3088];
Bp1 = [    0;
        0.0069];
Cp1 = [   0       0;
        1.5485  0.1405];
Dp1 = [     0
        0.0032];  
        
% Incerteza 2.
Ap2 = [  0    0;
         0  -0.2694];
Bp2 = [    0;
        0.0028];
Cp2 = [   0     0;
          0  -0.1256];
Dp2 = [ 0
        0];  
      
% Incerteza 3.
Ap3 = [  0  0;
         0  0];
Bp3 = [ -0.0005;
        -0.0439];
Cp3 = [ 0   0;
        0   0];
Dp3 = [    0
        -0.0121];        
    
% =========================================================================
%
%                       Definição do sistema incerto.
%
% ========================================================================= 
d1 = ultidyn('d1',[1 1]);
d2 = ultidyn('d2',[1 1]);
d3 = ultidyn('d3',[1 1]);

Gn = minreal(tf(ss(An, Bn, Cn, Dn)));
G1 = minreal(tf(ss(Ap1, Bp1, Cp1, Dp1)));
G2 = minreal(tf(ss(Ap2, Bp2, Cp2, Dp2)));
G3 = minreal(tf(ss(Ap3, Bp3, Cp3, Dp3)));

A = An + d1*Ap1 + d2*Ap2 + d3*Ap3;
B = Bn + d1*Bp1 + d2*Bp2 + d3*Bp3;
C = Cn + d1*Cp1 + d2*Cp2 + d3*Cp3;
D = Dn + d1*Dp1 + d2*Dp2 + d3*Dp3;


% =========================================================================
%
%                       Definição do sistema incerto.
%
% ========================================================================= 
% Criação das estruturas de incertezas.
P{1} = [Ap1 Bp1;
        Cp1 Dp1];
P{2} = [Ap2 Bp2;
        Cp2 Dp2];    
P{3} = [Ap3 Bp3;
        Cp3 Dp3];    

% Posto das matrizes 'P'.
for i = 1:max(size(P))
    r(i) = rank(P{i});
end
    
% Determinação dos outros condicionantes do sistema.
n  = size(An,1);        % Ordem do sistema
ny = size(Cn,1);        % Quantidade de saídas.
nu = size(Bn,2);        % Quantidade de entradas.

% Valores singulares do sistema.
for i = 1:max(size(P))
    [U{i}, S{i}, V{i}] = svd(P{i});
    
    % Matrizes totais.
    P1{i} = U{i}*S{i};
    P2{i} = V{i}';
    
    % Separação das matrizes.
    E{i} = P1{i}(1:n, 1:r(i));
    F{i} = P1{i}((n+1):(n+ny), 1:r(i));
    G{i} = P2{i}(1:r(i),1:n);
    H{i} = P2{i}(1:r(i),(n+1):(n+nu));
    
    % Apenas para análise.
    T1{i} = [E{i}; F{i}];
    T2{i} = [G{i} H{i}];
end

% % Resultado obtido.
% T1{1}*T2{1} - P{1};
% T1{2}*T2{2} - P{2};
% T1{3}*T2{3} - P{3};

% Construção da matriz 'M'.
% -------------------------
quant = max(size(E));
cG = [];              % Coluna de 'G'
cH = [];              % Coluna de 'H'  
lE = [];              % Linha de 'E'
lF = [];              % Linha de 'F'
for i=1:quant
    cG = [cG; G{1}];
    cH = [cH; H{1}];
    lE = [lE E{1}];
    lF = [lF F{1}];
end

% Total de linhas e colunas de 'M'.
BlocoNulo = zeros(size(cG,1),size(lE,2));

% M final.
M = [An lE Bn];
M = [M; cG BlocoNulo cH];
M = [M; Cn lF Dn];

% =========================================================================
%
%                  Reproduzindo os controladores da tese.
%
% ========================================================================= 
% (*) A primeira parte diz respeito ao controlador 'Hinf', sem considerar
% incertezas, dinâmica do atuador e atraso.
Ws = tf([1],[1 0.01]);          % Peso para a sensitividade.
Wt = tf([8 32],[1 50]);         % Peso para a função de sensitividade complementar.
G = minreal(tf(ss(An,Bn,Cn,Dn)));
G = G(2);       % Pego apenas a variável 'an'.

% Planta generalizada.
P = augw(G, Ws, [], Wt);

% Obtenção do controlador.
[K, CL, GAM] = hinfsyn(P); 
[K2, CL2, GAM2] = h2syn(P); 

L = G*K; 
S = inv(1+L); 
T = 1-S; 

% Resposta em frequência.
subplot(2,1,1);
sigma(S, 1/Ws, 'r', {10^-2,10^2});
legend('S', '1/W_s');
title('Controlador H_{\infty} sem atraso e sem incertezas');

subplot(2,1,2);
sigma(T, 1/Wt, 'r', {10^-2,10^2});
legend('T', '1/W_T')
title('Controlador H_{\infty} sem atraso e sem incertezas');


K_tf = minreal(tf(K));
num_Hinf = K_tf.num{1};
den_Hinf = K_tf.den{1};
% Comentários: O controlador obtido foi de 4º ordem, conforme também está
%              escrito na tese (página 90).
% -------------------------------------------------------------------------

%% ========================================================================
%
%             Reproduzindo os controladores da tese - Hinfstruct
%
% ========================================================================= 

% Caso nominal.
A = An;
B = Bn; 
C = Cn;
D = Dn;

% Planta.
G = ss(An,Bn,Cn,Dn);
G = tf(G);
G.u = 'dElev';          G.y = {'q','an'};

% Atuador e atraso -- no caso estamos sem.
Gad = tf([1],[1]);              
Gad.u = 'u';      Gad.y = 'dElev';
p = ss(Gad);
Aad = p.a;  Bad = p.b;  Cad = p.c;   Dad = p.d;

% Controlador a ser determinado.
ki = realp('ki',1);
kp = realp('kp',1);
kq = realp('kq',1);

Kq = tf(kq,1);
PI = tf([kp ki],[1 0]);

Kq.u = 'q';      Kq.y = 'out1';
PI.u = 'erro';   PI.y = 'out2';

% Blocos de soma;
sum1 = sumblk('erro = ref - an');
sum2 = sumblk('u = out2 + out1');

% Blocos de peso.
% wS = tf([0.115],[1 0.01]);
% wT = tf([3.2 24 86.9],[1 52.2 110]);
wS = tf([1],[1 0.01]);
wT = tf([8 32],[1 50]);

wS.u  = 'erro';               wS.y = 'z1';
wT.u  = 'an';                 wT.y = 'z2';

% Conecta todo mundo.
T0 = connect(G, Gad, PI, Kq, sum1, sum2, wT, wS, {'ref'}, {'z1', 'z2'});

rng('default')
opt = hinfstructOptions('Display','final','RandomStart',5);
T = hinfstruct(T0,opt);

showTunable(T);

Ki_Hinfstruct = T.Blocks.ki.Value;
Kp_Hinfstruct = T.Blocks.kp.Value;
Kq_Hinfstruct = T.Blocks.kq.Value;


%% ========================================================================
%
%             Reproduzindo os controladores da tese - Hinfstruct
%
% ========================================================================= 
% Com atraso dinâmica de atuadores.
% Caso nominal.
A = An;
B = Bn; 
C = Cn;
D = Dn;

% Planta.
G = ss(An,Bn,Cn,Dn);
G = tf(G);
G.u = 'dElev';          G.y = {'q','an'};

% Atuador e atraso -- no caso estamos sem.
% [num,den] = pade(0.02,1);
% Gd = tf(num,den);               % Atraso.
Gd = tf([1],[1]);
Ga  = tf([20.2],[1 20.2]);      % Atuador.
Gad = Ga*Gd;                    % Atuador + atraso.

Gad.u = 'u';      Gad.y = 'dElev';
p = ss(Gad);
Aad = p.a;  Bad = p.b;  Cad = p.c;   Dad = p.d;

% Controlador a ser determinado.
ki = realp('ki',1);
kp = realp('kp',1);
kq = realp('kq',1);

Kq = tf(kq,1);
PI = tf([kp ki],[1 0]);

Kq.u = 'q';      Kq.y = 'out1';
PI.u = 'erro';   PI.y = 'out2';

% Blocos de soma;
sum1 = sumblk('erro = ref - an');
sum2 = sumblk('u = out2 + out1');

% Blocos de peso.
% wS = tf([0.115],[1 0.01]);
% wT = tf([3.2 24 86.9],[1 52.2 110]);
wS = tf([1],[1 0.01]);
wT = tf([8 32],[1 50]);

wS.u  = 'erro';               wS.y = 'z1';
wT.u  = 'an';                 wT.y = 'z2';

% Conecta todo mundo.
T0 = connect(G, Gad, PI, Kq, sum1, sum2, wT, wS, {'ref'}, {'z1', 'z2'});

rng('default')
opt = hinfstructOptions('Display','final','RandomStart',5);
T = hinfstruct(T0,opt);

showTunable(T);

Ki_Hinfstruct = T.Blocks.ki.Value;
Kp_Hinfstruct = T.Blocks.kp.Value;
Kq_Hinfstruct = T.Blocks.kq.Value;

%% ========================================================================
%
%                        Mu sintese de ordem Completa
%
% ========================================================================= 
% An = [-1.0189   0.90506;
%       0.82225   -1.0774];
% Bn = [    0   -0.021499;
%       0.5477   -0.17555];
% Cn = [0 0.5477;
%       0 57.2957;
%       16.26 0.97877];  
% Dn = [ 0        0;
%        0        0;
%        0 -0.048523];  
% 
% G = minreal(tf(ss(An,Bn,Cn,Dn)));
% 
