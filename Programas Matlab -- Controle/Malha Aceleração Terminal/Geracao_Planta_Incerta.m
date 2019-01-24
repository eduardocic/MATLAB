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
save('PlantaIncerta', 'G');