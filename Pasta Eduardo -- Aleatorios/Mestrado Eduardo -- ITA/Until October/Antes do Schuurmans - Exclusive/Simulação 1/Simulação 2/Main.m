% ========================================================================= 
%
%                   ----------------------------                      
%                   | Autor: Eduardo H. Santos |
%                   | Data: 17/05/2015         |
%                   ----------------------------
%
% (*) Esta simula��o est� sendo realizada em virtude da demanda levantada
%     pelo professor Kawakami (15/05/2016). 
% 
% (*) Na cronologia de eventos, estamos no 4� encontro. 
%
% (*) A ideia principal dessa simula��o � verificar se o aprendizado da 3�
%     semana de estudo/trabalho foi efetivo. A 3� semana de trabalho foi
%     pautada na implementa��o de uma simula��o de sistema incerto
%     pertecente a um politopo, e verificar a converg�ncia do sistema para
%     essa situa��o. Tal simula��o pode ser facilmente encontrar na pasta
%     "Simula��o 1" dentro da pasta do mestrado.
% 
% (*) A ideia desta pr�xima simula��o consistem em tentar fazer com que um
%     sistema incerto pertecente a um determinado politopo G = [A,B] e com
%     um ponto inicial xk0 n�o pertecente ao dom�nio de atra��o P(x(k))
%     convirja para um ponto do dom�nio de atra��o e a�, sim, convergir
%     para a origem (situa��o de regula��o).
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
% (*) Percebe-se, assim, que as matrizes definem uma regi�o no espa�o que
%     que pode ser interpretada como um "cone". Seria politopo se consegu�s
%     semos determinar um pol�gono no espa�o.
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
%     em que o x_til(k) = x(k) - x_ss
%    
%     | Q  0  0  (AjQ + BjY) |          
%     | *  gI 0   S^(1/2)Q   | >= 0    (ii)
%     | *  *  gI  R^(1/2)Y   |
%     | *  *  *        Q     |
%     para todo J = 1,...,N (=qA*qB);
%
%     |I    (I-Ai)Xss - BiUss| >= 0   (iii)
%     |*         epsilon     | 
%     para todo J = 1,...,N (=qA*qB);
%
%    PS: essa LMI (iii) vem do fato de que o sistema tem de ser fact�vel no
%    equil�brio para todas as incertezas.  Assim, no equil�brio, o x(k+1) =
%    x(k) = Xss. Dessa forma, Xss = Ai.Xss + Bi.Uss => (I-Ai)Xss = BiUss. No
%    entanto, para colocar essa igualdade na forma de LMI, a gente sup�e a
%    exist�ncia de um 'E' "pequeno" o quanto quisermos. Esse truque tem no
%    livro do Boyd.
%
%     | X  Y |  >= 0                  (iv)    
%     | *  Q |
% 
%    PS: Essa LMI faz juz ao limitante de entrada.
% 
%     | 1  (Umax,l - Uss,l)  | <= 0    (v)       
%     | *       X,ll         | 
%     para todo l = 1,...,p. 
%  
%     | 1  (Umax,l + Uss,l)  | <= 0    (vi)      
%     | *       X,ll         | 
%     para todo l = 1,...,p.
%
%     | I   Xss | >= 0                 (vii)
%     | *   Eta | 
%     PS: Este 'Eta' entrar� na fun��o do custo.
%
%     | 1     Uss,l  | >= 0           (viii)
%     | *  (Umax,l)^2| 
%     para todo l = 1,...,p.
%
% (a) Para as 8 LMIs acima, destaca-se que os '*' dizem respeito aos termos
%     que s�o transpostos;
% (b) O vetor 'x(k)' representa o vetor de estados no instante 'k';
% (c) As matrizes 'S' e 'R' v�m da norma quadr�tica do custo. 
%     Elas t�m de ser definidas positivas, isto �, S>0 e R>0.
% (d) 'X' � uma matriz sim�trica de ordem (p x p);
% 
% (*) O grande problema mora no fato de termos de encontrar um ponto de
%     estado estacionario (Xss e Uss). Para tanto, temos de ter uma fam�lia
%     de pontos tais que haja infinitas solu��es diferentas da trivial. Uma
%     solu��o proposta pelo professor Kawakami � a seguinte:
%  
%    (1)- Rearrajamos o problema para que fique da seguinte forma:
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
%     (2)- Tentaremos verificar a solu��o n�o trivial. Dessa forma,
%          pegaremos uma solu��o para o estado. No caso, vamos pegar uma
%          solu��o n�o-trivial na qual o limite da entrada 'U,l' seja 
%          limitada.
%     (3)- Essa "solu��o" de estado estacion�rio ser� utilizada na LMI.
%     (4)- Para que seja n�o trivial, temos de ter um sistema
%          indeterminado.
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

xk = [5; 1]; % fact�vel.
% xk = [5; 1];   % n�o-fact�vel.

Umax = 1;      % Pois no caso, o -1 <= U <= 1.

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


