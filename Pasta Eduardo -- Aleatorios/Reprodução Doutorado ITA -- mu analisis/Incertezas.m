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
    
% Incertezas.    
d1 = ultidyn('d1',[1 1]);
d2 = ultidyn('d2',[1 1]);
d3 = ultidyn('d3',[1 1]);

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
    cG = [cG; G{i}];
    cH = [cH; H{i}];
    lE = [lE E{i}];
    lF = [lF F{i}];
end

% Total de linhas e colunas de 'M'.
BlocoNulo = zeros(size(cG,1),size(lE,2));

% M final -- Paper.
M = [An lE Bn];
M = [M; cG BlocoNulo cH];
M = [M; Cn lF Dn];

% M final -- toolbox (veja os subscritos de m sendo 'tb');
Mn   = [An Bn; Cn Dn];
M1   = [cG cH];
M2   = [lE; lF];
Mtb  = [Mn M2; M1 BlocoNulo];
Mtb  = ss(Mtb);

% Identidades estruturadas -- Matriz de incertezas.
I1 = d1*eye(r(1));
I2 = d2*eye(r(2));
I3 = d3*eye(r(3));
Delta = blkdiag(I1, I2, I3);

% Definindo entradas e saídas da minha planta incerta e a nominal.
Gss = lft(Mtb, Delta);
Gss.u = {'x1', 'x2', 'u'};           Gss.y = {'xd1', 'xd2', 'q', 'an'};

Gn = minreal(tf(ss(An, Bn, Cn, Dn)));
Gn.u = 'u';                  Gn.y = {'q','an'};

% Determinando as entradas e saídas.
% Pesos do sistema.
% Ws = tf([1],[1 0.01]);            % Peso para a sensitividade.
% Wt = tf([8 32],[1 50]);           % Peso para a função de sensitividade complementar.
Ws = tf([0.115],[1 0.01]);          % Peso para a sensitividade.
Wt = tf([3.2 24 86.9],[1 52.2 110]);         % Peso para a função de sensitividade complementar.

% Constante determinadas -- valores dos papers.
ki = realp('ki',1);
kp = realp('kp',1);
kq = realp('kq',1);

% Controladores.
Kq = tf(kq,1);
PI = tf([kp ki],[1 0]);

% Entradas e saídas dos controladores.
Kq.u = 'q';      Kq.y = 'out1';
PI.u = 'erro';   PI.y = 'out2';

sum1 = sumblk('erro = ref - an');
sum2 = sumblk('u = out2 - out1');

Ws.u = 'erro';             Ws.y = 'z1';
Wt.u = 'an';               Wt.y = 'z2';

F = connect(Gn, PI, Kq, Ws, Wt, sum1, sum2, {'ref'}, {'z1','z2'});

rng('default')
opt = hinfstructOptions('Display','final','RandomStart',5);
T   = hinfstruct(F, opt);

showTunable(T);

% Resultado final do H_infty.
% ---------------------------
k_i = T.Blocks.ki.Value;
k_p = T.Blocks.kp.Value;
k_q = T.Blocks.kq.Value;


%% Análise em malha fechada do sistema incerto.
% --------------------------------------------
% Valores dos papers.
Kq_aposHinfStructNominal = tf(k_q,1);
PI_aposHinfStructNominal = tf([k_p k_i],[1 0]);

Kq_aposHinfStructNominal.u = 'q';      Kq_aposHinfStructNominal.y = 'out1';
PI_aposHinfStructNominal.u = 'erro';   PI_aposHinfStructNominal.y = 'out2';

% Acoplando integradores no sistema para fechar a malha em Gss.
int1 = tf([1],[1 0]);
int2 = tf([1],[1 0]);

int1.u = 'xd1';                         int1.y = 'x1';
int2.u = 'xd2';                         int2.y = 'x2';
Gss_fechado = connect(Gss, int1, int2, {'u'}, {'q', 'an'});

ClosedLoopIncerto = connect(Gss_fechado, PI_aposHinfStructNominal, Kq_aposHinfStructNominal,...
                            sum1, sum2, {'ref'}, {'an'});

opt = robopt('Display', 'on');                  
[MargemEst, DeltasDesestabilizantes, Report, info] = robuststab(ClosedLoopIncerto, opt);

% figure;
semilogx(info.MussvBnds(1,1), 'r-', info.MussvBnds(1,2), 'b--');
grid;
title('Robust stability');
xlabel('Frequency (rad/s)')
ylabel('\mu');
legend('\mu-upper bound', '\mu-lower bound',2);

figure;


% Analisando as margens de robustes do sistema à malha fechada.
S = 1 - ClosedLoopIncerto;


sigmaplot(S, 1/Ws); grid;
legend('S', '1/W_s');
figure;
sigmaplot(ClosedLoopIncerto, 1/Wt); grid;


% [M_Final,Delta_F] = lftdata(ClosedLoopIncerto);
% Performance Robusta -- página 316.
norm(ClosedLoopIncerto, 'Inf')





% %% Utilização da função fminsearch para redução do valor singular estruturado.
% 
% % Valores iniciais para a mu-synthesis recursiva.
% % -----------------------------------------------
% x0 = [k_i k_p k_q];
% 
% t  = 0.25;
% lb = [(x0(1)-t*abs(x0(1))) (x0(2)-t*abs(x0(2))) (x0(3)-t*abs(x0(3)))];
% ub = [(x0(1)+t*abs(x0(1))) (x0(2)+t*abs(x0(2))) (x0(3)+t*abs(x0(3)))];
% 
% fun = @(x)Custo(x, Gss_fechado, Wt, Ws);
% % nonlcon = @(x)RestricoesNaoLineares(x, Gss_fechado, Wt, Ws);
% % x   = fminsearch(fun, x0);
% 
% % x = fmincon(fun,x0,[],[],[],[], lb,ub, nonlcon)
% x = fminimax(fun, x0, [], [], [], [], lb, ub)
% 
% ki = x(1);
% kp = x(2);
% kq = x(3);
% 
% 
% 
% 
% 
% 
% %% Reconstrução com os valores otimizados.
% Kq_aposHinfStructNominal = tf(kq,1);
% PI_aposHinfStructNominal = tf([kp ki],[1 0]);
% 
% Kq_aposHinfStructNominal.u = 'q';     Kq_aposHinfStructNominal.y = 'out1';
% PI_aposHinfStructNominal.u = 'erro';   PI_aposHinfStructNominal.y = 'out2';
% 
% % Acoplando integradores no sistema para fechar a malha em Gss.
% int1 = tf([1],[1 0]);
% int2 = tf([1],[1 0]);
% 
% int1.u = 'xd1';                         int1.y = 'x1';
% int2.u = 'xd2';                         int2.y = 'x2';
% Gss_fechado = connect(Gss, int1, int2, {'u'}, {'q', 'an'});
% 
% ClosedLoopIncerto = connect(Gss_fechado, PI_aposHinfStructNominal, Kq_aposHinfStructNominal,...
%                       sum1, sum2, {'ref'}, {'an'});
% 
% opt = robopt('Display', 'on');                  
% [MargemEst, DeltasDesestabilizantes, Report, info] = robuststab(ClosedLoopIncerto, opt);
% 
% % figure;
% semilogx(info.MussvBnds(1,1), 'r-', info.MussvBnds(1,2), 'b--');
% grid;
% title('Robust stability');
% xlabel('Frequency (rad/s)')
% ylabel('\mu');
% legend('\mu-upper bound', '\mu-lower bound',2);
% 
% figure;
% 
% 
% % Analisando as margens de robustes do sistema à malha fechada.
% S = 1-ClosedLoopIncerto;
% 
% 
% sigmaplot(S, 1/Ws); grid;
% legend('S', '1/W_s');
% figure;
% sigmaplot(ClosedLoopIncerto, 1/Wt); grid;
% 
% 
% % [M_Final,Delta_F] = lftdata(ClosedLoopIncerto);
% % Performance Robusta -- página 316.
% norm(ClosedLoopIncerto, 'Inf')
% 
