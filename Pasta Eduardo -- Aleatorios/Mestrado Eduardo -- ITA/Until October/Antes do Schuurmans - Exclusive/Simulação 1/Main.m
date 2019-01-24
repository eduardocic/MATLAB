% ========================================================================= 
%
%                   ----------------------------                      
%                   | Autor: Eduardo H. Santos |
%                   | Data: 09/05/2015         |
%                   ----------------------------
%
% (*) Esta simulação está sendo realizada em virtude da demanda levantada
%     pelo professor Kawakami (08/05/2016). 
% 
% (*) Na cronologia de eventos, estamos no 3º encontro. 
%
% (*) A ideia principal dessa simulação é verificar se o aprendizado da 2º
%     semana de estudo/trabalho foi efetivo. A 2º semana de trabalho foi
%     pautada no estudo da 'Aula 14' do curso de MPC ministrada pelo mestre
%     Kawakami.
%
% (*) A ideia base está em tentar fazer a simulação para o sistema incerto 
%     definido por tais matrizes:
%
%       A1 =  |  0  1 |          &      A2 = |  0    1 |
%             |-0.9 2 |                      |-0.8  1.5|
%
%       B1 =  | 0 |              &      B2 = | 0 |     
%             |0.5|                          | 2 |
%
%     sujeito à (s.a) restrição na entrada u, dada por:
%       
%       -1 <= u <= 1  
%
%  (*) Os pólos do sistema serão (digitando o comando 'eig(A1)' e 'eig(A2)'):
%        A1:  0,68 e 1.32               A2:  0.75+-0.4873i
%
%  (*) Percebe-se, assim, que as matrizes definem um politopo com 4 vérteces
%      dado pela combinação convexa entre elas G = {(A1,B1), (A1,B2), ...
%      (A2,B1), (A2, B2)}.
%  
%  (*) O sistema apresenta uma situação de instabilidade (A1). Vamos
%      verificar como que ele se comporta, na simualação proposta.
% =========================================================================
clear; close all; clc;

%% ------------------------------------------------------------------------
%               (1) Definição das matrizes incertas.
% -------------------------------------------------------------------------

A1 = [    0   1;
       -0.9   2];
   
A2 = [    0   1;
       -0.8 1.5];   
   
B1 = [  0;
      0.5];
   
B2 = [0;
      2];
  
%% ------------------------------------------------------------------------
%                   (2) Determinação do politopo G.
% -------------------------------------------------------------------------
 
n = size(A1,2);         % Ordem das matrizes 'A';
p = size(B1,2);         % Parâmetro da quantidade de entradas.

% Concatena as matrizes de incertezas A e B.
A = [A1;
     A2];
B = [B1;
     B2];

alfa = size(A,1);
beta = size(B,1);
qA = alfa/n;                 % # da matrizes 'A' (A1 e A2);
qB = beta/n;                 % # da matrizes 'B' (B1 e B2);
N  = qA*qB;                  % # Vértices Politopo ('2' de A e '2' de B);

%% ------------------------------------------------------------------------
%               (3) Determinação do incógnitas do Sistema.
% -------------------------------------------------------------------------
%
% (*) Para o problema, a única restrição diz respeito à entrada 'u'.
%
% (*) Dessa forma, o problema torna-se uma minimização de '(g)amma', 
%     sujeito ao seguinte conjunto de LMIs:
%
%     | Q x(k)|  > 0                  (i)
%     | *  1  | 
%    
%     | Q  0  0  (AjQ + BjY) |          
%     | *  gI 0   S^(1/2)Q   | > 0    (ii)
%     | *  *  gI  R^(1/2)Y   |
%     | *  *  *        Q     |
%     para todo J = 1,...,N (=qA*qB);
% 
%     | X  Y |  >= 0                  (iii)    
%     | *  Q |
%
% |e1'Xe1    0    ...     0  |    |Umax^2,1     0      ...     0     |
% |   0   e2'Xe2  ...     0  |    |   0     Umax^2,2   ...     0     |       
% |   .      .    .       .  | <= |   .         .      .       .     | (iv)
% |   .      .     .      .  |    |   .         .       .      .     |
% |   .      .      .     .  |    |   .         .        .     .     | 
% |   0      0    ...  ep'Xep|    |   0         0      ...  Umax^2,p |
%
%
% (a) Para as 4 LMIs acima, destaca-se que os '*' dizem respeito aos termos
%     que são transpostos;
% (b) O vetor 'x(k)' representa o vetor de estados no instante 'k';
% (c) As matrizes 'S' e 'R' vêm da norma quadrática do custo. 
%     Elas têm de ser definidas positivas, isto é, S>0 e R>0.
% (d) 'X' é uma matriz simétrica de ordem (pxp);
% (e) Os termos e1,...ep são os termos de base canônica, que visa
%     exclusivamente pegar os termos da diagonal principal da matriz 'X'.
% 
% (*) O problema consiste, portanto, em minimizar '(g)amma'(simplificado 
%     por 'g') sujeito à (s.a) g>0 e Q>0;
% -------------------------------------------------------------------------

%% (1) Inicializa LMIs.

S  = eye(n);   Ssqrt = sqrt(S);    % S^(-1/2)
R  = eye(p);   Rsqrt = sqrt(R);    % R^(-1/2)
E  = eye(p);   % Importante para os valores da LMI (iv). 

xk = [1000000; 1000000]; % não-factível (testei e só parou para a 141 rodada).
% xk = [2; 1];   % factível (foi para 42º rodada).

Umax = 1;      % Pois no caso, o -1 <= U <= 1.

setlmis([]);

%% (2) Definição das variáveis.

[g, m1, sg] = lmivar(1,[1 0]);     % Variável a ser minimizada '(g)amma'.
[Q, m2, sQ] = lmivar(1,[n 1]);     % Q (nxn) simétrica full-block.
[Y, m3, sY] = lmivar(2,[p n]);     % Y (pxn) retangular; 
[X, m4, sX] = lmivar(1,[p 1]);     % X (pxp) simétrica full-block.

%% (3) Determinação das LMI.
% (a) LMI (i)
LMI_Kothare = newlmi;
lmiterm([-LMI_Kothare 1 1 Q],1,1);   % Direita da LMI(-), pos (1,1), Var (Q).
lmiterm([-LMI_Kothare 1 2 0],xk);    % Direita da LMI(-), pos (1,2), Const (x(k)).
lmiterm([-LMI_Kothare 2 2 0],1);     % Direita da LMI(-), pos (1,2), Const '1' 
                                     % para representar a 'I', na dimensão apropriada.

% (b) LMI (ii);
for i=1:N
    ConjLMICombConvex(i) = newlmi;
    lmiterm([-ConjLMICombConvex(i) 1 1 Q],1,1);
    [Aj, Bj] = vertice(A,B,n,qB,i)            
    lmiterm([-ConjLMICombConvex(i) 1 4 Q],Aj,1);
    lmiterm([-ConjLMICombConvex(i) 1 4 Y],Bj,1);
    lmiterm([-ConjLMICombConvex(i) 2 2 g],1,1);
    lmiterm([-ConjLMICombConvex(i) 2 4 Q],Ssqrt,1);
    lmiterm([-ConjLMICombConvex(i) 3 3 g],1,1);
    lmiterm([-ConjLMICombConvex(i) 3 4 Y],Rsqrt,1);
    lmiterm([-ConjLMICombConvex(i) 4 4 Q],1,1);
end

% (c) LMI (iii);
% InputConst = newlmi;
% lmiterm([-InputConst 1 1 X],1,1);    % Direita da LMI(-), pos (1,1), Var (X).
% lmiterm([-InputConst 1 2 Y],1,1);    % Direita da LMI(-), pos (1,2), Var (Y).
% lmiterm([-InputConst 2 2 Q],1,1);    % Direita da LMI(-), pos (1,2), Var (Q).
% 
% % (d) LMI (iv);
% RestX = newlmi;                      % Restrições em X.
% for i = 1:p
%     e = E(:,i);                      % Aqui pega só a base canônica 'e'.
%     lmiterm([RestX i i X],e',e);     % Lado esquerdo da desigualdade (+).
%     lmiterm([-RestX i i 0],Umax^2);  % Lado direito da desigualdade (-).
% end

%% 4) Pega as LMI definidas acima.
SistemaLMIs = getlmis;

%% 5) Calcula a quantidade de variáveis a serem encontradas;
% Perceba que do jeito que aqui está escrito, o que temos diz respeito a
% minimização do valor do 'gamma'. Uma vez que o 'gamma' foi determinado
% como a 'PRIMEIRA lmivar', o seu valor será multiplicado pelo vetor de
% estados x(k) para que se minimize a função [c'x] sujeito as LMIs 
% programadas logo acima (SistemaLMIs).

numvar = m4;                % Quantidade total de variáveis do sistema.
c = zeros(numvar,1);
c(1) = 1;                   % Cost = 1*gamma

options = [0 0 0 0 1];      % Trace off
% options = [0 200 0 0 0];   % Trace on

% Usa-se o 'tic' e o 'toc' para que possamos fazer o cálculo de quanto tempo
% demora o processo de otimizaçao em cada laçoa simulação.
tic            
[Copt, Xopt] = mincx(SistemaLMIs, c, options);
toc

% Ysol = dec2mat(SistemaLMIs,Xopt,Y);
% Qsol = dec2mat(SistemaLMIs,Xopt,Q);
% 
% K = Ysol*inv(Qsol)



%% ========================================================================
%                           Considerações finais.
% =========================================================================
% 
% (*) Neste programa 'Main', eu fiz a programação de tudo aquilo que irá
%     acontecer dentro da simualação no Simulink. De forma que o código que
%     eu irei colocar dentro das funções no Simulink será um extrato das
%     coisas que estão presentes por aqui.
% (*) Atentar para aquilo que é importante de se passar para a função do
%     controlador no Simulink.
% (*) A simulação que deveremos fazer é tentar pegar algum dos vértices do
%     politopo, considerar que ele representa de maneira "fiel" o sistema
%     ao  que está sendo simulado e submete-lo ao conjunto de LMIs dado
%     acima em cada instante de tempo 'k'.
% (*) Tente pegar a situação para um 'x(k)' "estável" e "outro instável" e
%     vamos verificar como que se comporta o sistema.