% ========================================================================= 
%
%                   ----------------------------                      
%                   | Autor: Eduardo H. Santos |
%                   | Data: 05/06/2015         |
%                   ----------------------------
%
% (*) Esta simula��o est� sendo realizada em virtude da demanda levantada
%     pelo professor Kawakami (29/05/2016). 
% 
% (*) Na cronologia de eventos, estamos no 5� encontro. 
%     (Tivemos um desencontro na sexta-feira do dia 22/05/15, de forma que
%      n�o conseguimos no reunir nesse dia). 
%
% (*) A ideia principal dessa simula��o � verificar se o aprendizado da 4�
%     semana de estudo/trabalho foi efetivo. A 4� semana de trabalho
%     occoreu a primeira verifica��o se seria poss�vel, para um ponto fora
%     do dom�nio de atra��o x(k) no instante inicial, convergir para algum
%     ponto de equil�brio  Xss. Esse Xss seria a todo instante calculado e
%     a ideia seria de tentar levar esse Xss para a origem.
% 
% (*) Importante destacar que as LMI outrora levantadas, num total de 8,
%     fazia a converg�ncia quando tir�vamos as "LMIs do controle" (as 4
%     �ltimas). Essa n�o � a nossa ideia, a priori, pois queremos encontrar
%     um est�gio intermedi�rio tal qual o x(k) v� para o Xss com um esfor�o
%     de controle dentro das limita��es levantadas. 
%
% (*) Chegou a fazer uma modifica��o nas LMIS de forma que tentar�amos
%     minimizar a diferen�a "x(k)-Xss" (Isso l� para o 'gamma'). Dentro 
%     dessa perspectiva, conseguir�amos diminuir o esfor�o de controle, mas
%     a ideia de o x(k) seguir um ponto de Steady-State ficou completamente
%     deteriorado, uma vez que essa implementa��o tentar� fazer o x(k) 
%     seguir um Xss aleat�rio. Com isso, a resposta do sistema para essa 
%     situa��o (Simula��o 2.a) ficou evidentemente mais lenta com o ganho 
%     de que as entradas de controle ficaram menos 'brutas'.
%    
% (*) Quanto as LMIs que limitavam os valores para o 'X' em termos de
%     diferen�as para o estado estacion�cio 'Ull-Uss', percebeu-se que os
%     valores de X ficariam cada vez mais reclusos, uma vez que essa
%     diferen�a como Uss faria os intervalos "Ull-Uss" e "Ull+Uss"
%     variarem e consequentemente confinaria o 'X' para escolha da pior
%     situa��o a todo o instante de tempo de maneira mais restrita. N�o
%     funcionou.
% 
% (*) A ideia desta pr�xima simula��o consistem em tentar fazer com que um
%     sistema incerto pertecente a um determinado politopo G = [A,B] e com
%     um ponto inicial xk0 n�o pertecente ao dom�nio de atra��o P(x(k))
%     convirja para um ponto de Steady State determinado pelo "espa�o nulo"
%     do seguinte sistema:
%
%         [I-Ai | -Bi ]| x1 |
%                      | x2 |
%                      | :  |
%                      | xn |
%                      | u1 | = 0
%                      | u2 |
%                      | :  | 
%                      | up |   
%
%
% (*) Esse problema acima pode ser vizualizado como:
%
%     Aeq.v = 0, tem que:
%
%     - Aeq = [I-Ai | -Bi ];
%     - v   = [Xss Uss]';
% 
% (*) Encontraremos, assim, um 'v' n�o-trivial, tal que possa ser represen-
%     tado por v = H.z, sendo:
%     - H: matriz cujo espa�o imagem seja o espa�o nulo de Aeq (H =
%     null(Aeq)).
%  
% (*) No caso, n�o consideraremos a entrada Uss, pois a mesma ser�
%     considerada nula. Assim, a primeira tentariva ser� considerar apenas
%     a rela��o considerando apenas o 'Xss'. No caso, o Xss, que est�
%     oculto pelo 'v', ser� representado por 'Xss = H.z' 
%     Esse vetor 'z' � o vetor ao qual estaremos procurando minimixar.
% 
% (*) O sistema que iremos estudar essa semana diz respeito a um sistema que
%     apresenta integrador na malha A. A matriz B permanecer� a mesma para
%     esse sistema, ou seja, determinada. O sistema pode ser resumido como:
%
%            A1 = |  0   1 |  &  A2 = |  0   1 |
%                 |-1.5 2.5|          |-0.8 1.8|
%
%            B =  |0|
%                 |1|
%
% (*) Os p�los do sistema ser�o (digitando o comando 'eig(A1)' e 'eig(A2)'):
%        A1:  1.0 e 1.5               A2:  0.8 e 1.0
% 
% (*) Perceba que existem p�los em z = +1, dessa forma temos um integrador
%     sempre existente.
%
% (*) Para o problema, a �nica restri��o diz respeito � entrada 'u'. No
%     caso, a entrada 'u' estar� limitada ao valor |ul| < Umax,l. Este
%     valor m�ximo 'Umax,l' ser� determinado no corpo do programa.
%
% (*) Na formula��o original do problema, tent�vamos encontrar uma matriz
%     F, tal que um controle da forma u = Fx, sendo F = YQ^(-1), fosse
%     efetivo. Esses fatores Y e Q, viriam da minimiza��o do custo de
%     horizonte infinito 'gamma' e assim, encontrar�amos matrizes Y e Q que
%     originariam a matriz F, sendo esta �tima para o sistema. Para
%     encontrarmos um valor conveniente para Y e Q, o sistema depende dos
%     estados 'xk' (vide a LMI do Kothare).
%     Um caso interessante para essa situa��o mora no fato de que para um
%     dado valor inicial 'xk0', se o sistema for fact�vel, ele convergir� para
%     a origem nos passos subsequentes. Esse 'xk0' pode ser interpretado 
%     tamb�m como um valor ao qual o sistema se encontre depois de 
%     transcorrer um per�odo de tempo razo�vel 'L'. Ele sendo fact�vel a 
%     partir desse valor, o sistema ser� convergente para o origem.
% 
% (*) Esse problema � interessante pois, se o seu chute inicial 'xk0' n�o
%     estiver no dom�nio de atra��o, o sistema torna-se n�o-fact�vel.
%
% (*) Para contornar esse 'pequeno' probleminha, o que tentaremos fazer
%     neste trabalho � fazer com que os estados convirjam para a regi�o do
%     dom�nio de atra��o, mesmo que no instante inicial ele esteja fora.
%
% (*) Para isso, ao inv�s de propormos a solu��o da forma u=Fx, o que
%     iremos tentar encontrar � uma solu��o da forma:
%
%                       U - Uss = F.(X - Xss)  (I)
%
%     em que 'Uss' e 'Xss' � alguma regi�o de equil�brio para o sistema 
%     (steady state).
%
% (*) No entanto as equa��es do Kothare e as subsequentes para a solu��o
%     dos problemas em LMIs, n�o leva em considera��o as vari�veis 'U -
%     Uss' mesmo 'X - Xss', mas sim 'X' e 'U'. Reescrevendo o problema de
%     outra forma, fa�amos:
%
%                           Util = F.Xtil     (II)
% 
%    , em que Util = U - Uss e Xtil = X - Xss.
%
%  (*) Assim, o problema de otimiza��o corresponder�:
%
%                           min (Eta + Rho*Gamma)
%
%     , sujeito �s seguintes LMIs:
%
%     | Q  x_til(k)|  >= 0                  (i)
%     | *     1    | 
%     em que o x_til(k) = x(k) - H.z
%    
%     | Q  0  0  (AjQ + BjY) |          
%     | *  gI 0   S^(1/2)Q   | >= 0    (ii)
%     | *  *  gI  R^(1/2)Y   |
%     | *  *  *        Q     |
%     para todo J = 1,...,N (=qA*qB);   
%
%    Esse truque tem no
%    livro do Boyd.
%
%     | X  Y |  >= 0                  (iii)    
%     | *  Q |
% 
%    PS: Essa LMI faz juz ao limitante de entrada.
% 
%     | 1   Umax,l  | <= 0              (iv)       
%     | *    X,ll   | 
%     para todo l = 1,...,p. 
%
%     | I   H.z | >= 0                 (v)
%     | *   Eta | 
%     PS: Este 'Eta' entrar� na fun��o do custo.
%
% (a) Para as 5 LMIs acima, destaca-se que os '*' dizem respeito aos termos
%     que s�o transpostos;
% (b) O vetor 'x(k)' representa o vetor de estados no instante 'k';
% (c) As matrizes 'S' e 'R' v�m da norma quadr�tica do custo. 
%     Elas t�m de ser definidas positivas, isto �, S>0 e R>0.
% (d) 'X' � uma matriz sim�trica de ordem (p x p);
% 
% =========================================================================
% =========================================================================
%   1� Parte: Determinar um ponto fora do dom�nio de atra��o. Para isso,
%             iremos utilizar a programa��o da simula��o passada primeiro.
%   2� Parte: Implementar as LMIs e a simula��o para o ponto inicial
%             definido.
% -------------------------------------------------------------------------

close all; clear; clc;

%% ------------------------------------------------------------------------
%               (1) Defini��o das matrizes incertas.
% -------------------------------------------------------------------------


A1 = [   0   1;
      -1.5 2.5];
  
A2 = [   0   1;
      -0.8 1.8];  

B = [0;
     1];
 
%% ------------------------------------------------------------------------
%                   (2) Determina��o do Cone G.
% -------------------------------------------------------------------------
 
n = size(A1,2);     % Ordem das matrizes 'A' (n x n). Pego o valor de 'n';
p = size(B,2);      % Par�metro de entradas de B (n x p). Pego o valor de 'p';

% Concatena as matrizes de incertezas A e B.
A = [A1;
     A2];
B = [B];

alfa = size(A,1);
beta = size(B,1);
qA = alfa/n;                 % # da matrizes 'A' (A1 e A2);
qB = beta/n;                 % # da matrizes 'B' (B);
N  = qA*qB;                  % # V�rtices Politopo ('2' de A e '1' de B);

%% ------------------------------------------------------------------------
%                              1� Parte.
% -------------------------------------------------------------------------
% (1) Inicializa LMIs.
% --------------------

S  = eye(n);   Ssqrt = sqrt(S);    % S^(-1/2)
R  = eye(p);   Rsqrt = sqrt(R);    % R^(-1/2)
E  = eye(p);   % Importante para os valores da LMI (iv). 

xk = [5; 20];    % fact�vel.
% xk = [5; 1];   % n�o-fact�vel.

Umax = 7;      % Pois no caso, o -1 <= U <= 1.

setlmis([]);

% ----------------------------
% (2) Defini��o das vari�veis.
% ----------------------------
[g, m1, sg] = lmivar(1,[1 0]);     % Vari�vel a ser minimizada '(g)amma'.
[Q, m2, sQ] = lmivar(1,[n 1]);     % Q (nxn) sim�trica full-block.
[Y, m3, sY] = lmivar(2,[p n]);     % Y (pxn) retangular; 
[X, m4, sX] = lmivar(1,[p 1]);     % X (pxp) sim�trica full-block.

% -------------------------
% (3) Determina��o das LMI.
% -------------------------
% (a) LMI (i)
LMI_Kothare = newlmi;
lmiterm([-LMI_Kothare 1 1 Q],1,1);   % Direita da LMI(-), pos (1,1), Var (Q).
lmiterm([-LMI_Kothare 1 2 0],xk);    % Direita da LMI(-), pos (1,2), Const (x(k)).
lmiterm([-LMI_Kothare 2 2 0],1);     % Direita da LMI(-), pos (1,2), Const '1' 
                                     % para representar a 'I', na dimens�o apropriada.

% (b) LMI (ii);
for i=1:N
    ConjLMICombConvex(i) = newlmi;
    lmiterm([-ConjLMICombConvex(i) 1 1 Q],1,1);
    [Aj, Bj] = vertice(A,B,n,qB,i);            
    lmiterm([-ConjLMICombConvex(i) 1 4 Q],Aj,1);
    lmiterm([-ConjLMICombConvex(i) 1 4 Y],Bj,1);
    lmiterm([-ConjLMICombConvex(i) 2 2 g],1,1);
    lmiterm([-ConjLMICombConvex(i) 2 4 Q],Ssqrt,1);
    lmiterm([-ConjLMICombConvex(i) 3 3 g],1,1);
    lmiterm([-ConjLMICombConvex(i) 3 4 Y],Rsqrt,1);
    lmiterm([-ConjLMICombConvex(i) 4 4 Q],1,1);
end

% (c) LMI (iii);
InputConst = newlmi;
lmiterm([-InputConst 1 1 X],1,1);    % Direita da LMI(-), pos (1,1), Var (X).
lmiterm([-InputConst 1 2 Y],1,1);    % Direita da LMI(-), pos (1,2), Var (Y).
lmiterm([-InputConst 2 2 Q],1,1);    % Direita da LMI(-), pos (1,2), Var (Q).

% (d) LMI (iv);
RestX = newlmi;                      % Restri��es em X.
for i = 1:p
    e = E(:,i);                      % Aqui pega s� a base can�nica 'e'.
    lmiterm([RestX i i X],e',e);     % Lado esquerdo da desigualdade (+).
    lmiterm([-RestX i i 0],Umax^2);  % Lado direito da desigualdade (-).
end

% 4) Pega as LMI definidas acima.
SistemaLMIs = getlmis;

% 5) Calcula a quantidade de vari�veis a serem encontradas;
% Perceba que do jeito que aqui est� escrito, o que temos diz respeito a
% minimiza��o do valor do '(g)amma'. Uma vez que o '(g)amma' foi determinado
% como a 'PRIMEIRA lmivar', o seu valor ser� multiplicado pelo vetor de
% estados x(k) para que se minimize a fun��o [c'x] sujeito as LMIs 
% programadas logo acima (SistemaLMIs).

numvar = m4;                % Quantidade total de vari�veis do sistema.
c = zeros(numvar,1);
c(1) = 1;                   % Cost = 1*gamma

% options = [0 0 0 0 1];      % Trace off
options = [0 200 0 0 0];   % Trace on

% Usa-se o 'tic' e o 'toc' para que possamos fazer o c�lculo de quanto tempo
% demora o processo de otimiza�ao em cada la�o da simula��o.

tic            
[Copt, Xopt] = mincx(SistemaLMIs, c, options)
toc

Ysol = dec2mat(SistemaLMIs,Xopt,Y);
Qsol = dec2mat(SistemaLMIs,Xopt,Q);


