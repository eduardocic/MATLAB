close all; clear all; clc;

%% 1. Caso nominal.
An = [-1.02   0.905;
       0.822  -1.08];
Bn = [ -0.0215;
       -0.175];
Cn = [    0  57.295;
      16.26  0.9787];
Dn = [     0
       -0.04852];  
   
% Função de transferência nominal.      
Gn = minreal(tf(ss(An, Bn, Cn, Dn)));
Gn.u = 'u';                         Gn.y = {'q','an'};   

% =========================================================================
%% Incertezas consideradas e obtenção da matriz 'M'.   
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

% Criação das estruturas de incertezas 'P{i}'.
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

% M final -- toolbox (veja os subscritos de m sendo 'tb');
Mn  = [An Bn; Cn Dn];
M1  = [cG cH];
M2  = [lE; lF];
M   = [Mn M2; M1 BlocoNulo];
M   = ss(M);


% =========================================================================
%% 3. Identidades estruturadas -- Matriz de incertezas.
I1 = d1*eye(r(1));
I2 = d2*eye(r(2));
I3 = d3*eye(r(3));
Delta = blkdiag(I1, I2, I3);


% =========================================================================
%% 4. Definição de Gss, em que Gss = lft(M,Delta).
Gss   = lft(M, Delta);
Gss.u = {'x1', 'x2', 'u'};           Gss.y = {'xd1', 'xd2', 'q', 'an'};


% =========================================================================
%% 5. Fechando a malha Gss nos estados do sistema para determinação de 'G'.

% Dinâmica dos integradores.
BlkIntegrador = tf([1],[1 0])*eye(2);
BlkIntegrador.u = {'xd1','xd2'};     BlkIntegrador.y = {'x1','x2'};

G = connect(Gss, BlkIntegrador, {'u'}, {'q', 'an'});


% =========================================================================
%% 6. Determina o controlador HinfStruct para o Caso Nominal (Gn).

% Pesos do sistema.
Ws = tf([0.115],[1 0.01]);               % Peso para 'S'.
Wt = tf([3.2 24 86.9],[1 52.2 110]);     % Peso para 'T'.

% Ganhos do sistema a serem determinadas.
ki = realp('ki',1);
kp = realp('kp',1);
kq = realp('kq',1);

% Controladores -- 1 proporcional-integral (PI) e um Proporcional (P).
Kq = tf(kq,1);
PI = tf([kp ki],[1 0]);

% Entradas e saídas dos blocos do sistema como um todo.
Kq.u = 'q';         Kq.y = 'out1';
PI.u = 'erro';      PI.y = 'out2';
Ws.u = 'erro';      Ws.y = 'z1';
Wt.u = 'an';        Wt.y = 'z2';
sum1 = sumblk('erro = ref - an');
sum2 = sumblk('u = out2 - out1');

% Conecta todo mundo, com o caso nominal (G.Nominal).
T0 = connect(G.Nominal, PI, Kq, Ws, Wt, sum1, sum2, {'ref'}, {'z1','z2'});

% Realiza o cálculo do Hinfstruct para o caso da planta nominal.
rng('default')
opt = hinfstructOptions('Display','final','RandomStart',5);
T   = hinfstruct(T0, opt);
showTunable(T);

% Ganhos obtidos pela função 'hinfstruct'.
Ki = T.Blocks.ki.Value;
Kp = T.Blocks.kp.Value;
Kq = T.Blocks.kq.Value;


% =========================================================================
%% 7. Determinação da estrutura 'F', em que corresponde ao caso em que eu
%     fecho a malha com o controlador obtido na planta incerta 'G'.
contKq = tf(Kq,1);                          % Controlador proporcional Kq.
contPI = tf([Kp Ki],[1 0]);                 % Controlador PI.
sum1 = sumblk('erro = ref - an');
sum2 = sumblk('u = out2 - out1');
contKq.u = 'q';      contKq.y = 'out1';
contPI.u = 'erro';   contPI.y = 'out2';

% Fecho a malha -- com os pesos do sistema inclusive.
F = connect(G, contPI, contKq, Ws, Wt, sum1, sum2, {'ref'}, {'z1','z2'});


% =========================================================================
%% 8. Determinação das Estrutura 'N-Delta'
[N, Delta, BlocoIncertezas] = lftdata(F);
nx  = size(Delta,1);
ny  = size(Delta,2);

% Bloco de incertezas e o bloco nominal do sistema 'N-Delta'.
N11 = N(1:ny, 1:nx);
N22 = N((ny+1):end, (nx+1):end);


% =========================================================================
%% 9. Determinação de DESEMPENHO NOMINAL.
% Bloco nominal de um Upper LTF entre Delta e N -- página 300.
w   = logspace(-3,2,601);
NormaN22 = norm(N22, inf);
if(NormaN22 < 1)
    X = ['O sistema apresenta Performance Nominal com norma |H|_{inf} = ' mat2str(NormaN22)];
    disp(X);
else
    X = ['O sistema NÃO apresenta Performance Nominal, pois apresenta |H|_{inf} = ' mat2str(NormaN22)];
    disp(X);
end

% =========================================================================
%% 10. Determinação de ESTABILIDADE ROBUSTA
% Range de frequência para análise.
w   = logspace(-3,2,601);
N11frd = frd(N11, w);
mu_EstabilidadeRobusta = mussv(N11frd, BlocoIncertezas, 's');

% Plota o resultado obtido.
semilogx(mu_EstabilidadeRobusta);
title('Valor singular estruturado para ESTABILIDADE ROBUSTA');
xlabel('\omega (rad/s)');
ylabel('\mu');


% =========================================================================
%% 11. Análise de PERFORMANCE ROBUSTA.
% Obtenção do sistema como um todo fechado na incerteza não estruturada,
% ou seja, um sistema da forma 'N -- Delta Chapéu'.
% No caso, o sistema encontra um Upper LTF entre Delta-N
DeltaP = ultidyn('DeltaP', [1 2]);
Ffinal = lft(DeltaP,F);

[Nf, DeltaChapeu, BlocoIncertezasFinal] = lftdata(Ffinal);
Nf_frd = frd(Nf, w);
mu_DesempenhoRobusto = mussv(Nf_frd, BlocoIncertezasFinal, 's');

% Plota o resultado obtido.
semilogx(mu_DesempenhoRobusto);
title('Valor singular estruturado para DESEMPENHO ROBUSTO');
xlabel('\omega (rad/s)');
ylabel('\mu');


%% Resultados clássicos do sistema em malha fechada após a conclusão do 
%  projeto.
% Fecho a malha -- com os pesos do sistema inclusive.
SensitividadeComplementar = connect(G, contPI, contKq, sum1, sum2, ...
                                   {'ref'}, {'an'});
Sensitividade = 1-SensitividadeComplementar;

% Análise da Sensitividade e Sensitividade Complementar.
subplot(2,1,1);
bodemag(Sensitividade, 1/Ws);
legend('S', '1/W_s');
xlabel('\omega (rad/s)');
ylabel('Magnitude');

subplot(2,1,2);
bodemag(SensitividadeComplementar, 1/Wt);
legend('T', '1/W_t');
xlabel('\omega (rad/s)');   ylabel('Magnitude');

% Domínio do tempo.
figure;
step(SensitividadeComplementar.NominalValue, 'r', 8);  grid; hold on;
step(SensitividadeComplementar, 8); 
step(SensitividadeComplementar.NominalValue, 'r', 8);  
legend('Caso nominal', 'Demais casos incertos');
xlabel('Tempo (s)');     ylabel('a_n');



%% Diagrama de Nichols.
Gq = connect(G, {'u'}, {'q'});
Gqn = connect(G, {'u'}, {'an'});
L = minreal(PI*Gqn + contKq*Gq);            % Função de malha L(s).

% Amostragem de 'kappa' vezes em L(s).
kappa = 25;
phi = usample(L, kappa);

subplot(2,1,1);
for i = 1:kappa
    OpenLoop{i} = minreal(tf(phi(:,:,i)));
    [mag{i}, phase{i}] = nichols(OpenLoop{i});
    
    for j = 1:max(size(mag{i}))
        Magnitude(j) = mag{i}(:,:,j);
        Phase(j)     = phase{i}(:,:,j);
    end
    
    plot(Phase - 360, 20*log10(Magnitude)); hold on;
end
plotaNicholsLimites(6);

% plota resultado.
subplot(2,1,2);
nichols(phi); 


