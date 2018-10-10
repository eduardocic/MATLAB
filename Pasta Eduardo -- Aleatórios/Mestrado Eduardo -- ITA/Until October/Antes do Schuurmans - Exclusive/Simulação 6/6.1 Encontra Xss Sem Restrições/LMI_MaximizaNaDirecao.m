function [Saida] = LMI_MaximizaNaDirecao(A, B, VetDif, Umax)
%erl 
% - A: Matriz de Estado Completa A;
% - B: Matriz de Estado Completa B;
% - Epsilon: Vetor com a direção a ser minimizado.


% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%
%                         RESOLUÇÃO DAS LMIs
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

[n, p, qA, qB, N] = ProcessamentoMatrizesEstado(A, B);

%% ------------------------------------------------------------------------ 
%                           (1) Inicializa LMIs.
% -------------------------------------------------------------------------

S  = eye(n);   Ssqrt = sqrt(S);    % S^(-1/2)
R  = eye(p);   Rsqrt = sqrt(R);    % R^(-1/2)
E  = eye(p);   % Importante para os valores da LMI (iv). 

% 1.c) Inicializar um conjunto de LMIs.
setlmis([]);


%% ------------------------------------------------------------------------
%                       (2) Definição das variáveis.
% -------------------------------------------------------------------------

[g, m1, sg] = lmivar(1,[1 0]);         % '(g)amma'.
[Q, m2, sQ] = lmivar(1,[n 1]);         % Q (nxn) simétrica full-block.
[Y, m3, sY] = lmivar(2,[p n]);         % Y (pxn) retangular; 
[X, m4, sX] = lmivar(1,[p 1]);         % X (pxp) simétrica full-block.


%% ------------------------------------------------------------------------
%                      (3) Determinação das LMI.
% -------------------------------------------------------------------------

% +++++++++++++++++++++++++++++++++++++++++++
% 3.a) LMI (i)                              +
%                                           +    
%     | Q    VetDif |  >= 0             (i) +
%     | *      1    |                       +
% +++++++++++++++++++++++++++++++++++++++++++
LMI_Kothare = newlmi;
lmiterm([-LMI_Kothare 1 1 Q],1,1);           % Direita da LMI(-), P(1,1), Var (Q).
lmiterm([-LMI_Kothare 1 2 0],VetDif);        % Direita da LMI(-), P(1,2).
lmiterm([-LMI_Kothare 2 2 0],1);             % Direita da LMI(-), pos (1,2), '1' 
                                             % Representar 'I', na dim. apropriada.
                                                   
% +++++++++++++++++++++++++++++++++++++++++++                                     
% 3.b) LMI (ii);                            +
%                                           +
%     | Q  0  0  (AjQ + BjY) |              +
%     | *  gI 0   S^(1/2)Q   | >= 0    (ii) +
%     | *  *  gI  R^(1/2)Y   |              +
%     | *  *  *        Q     |              +
%     para todo j = 1,...,N ( = qA*qB);     +
% +++++++++++++++++++++++++++++++++++++++++++                                     
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

% +++++++++++++++++++++++++++++++++++++++++++                                     
% 3.c) LMI (iii);                           +
%                                           +
%     | X  Y |  >= 0                  (iii) +   
%     | *  Q |                              +
% +++++++++++++++++++++++++++++++++++++++++++                                     
InputConst = newlmi;
lmiterm([-InputConst 1 1 X],1,1);    % Direita da LMI(-), pos (1,1), Var (X).
lmiterm([-InputConst 1 2 Y],1,1);    % Direita da LMI(-), pos (1,2), Var (Y).
lmiterm([-InputConst 2 2 Q],1,1);    % Direita da LMI(-), pos (1,2), Var (Q).

% +++++++++++++++++++++++++++++++++++++++++++++++++                                     
% 3.d) LMI (iv);                                  +
%                                                 +
%  Essa LMI faz juz ao limitante de entrada.      +
%                                                 +
%     | 1   Umax,l  | <= 0              (iv)      + 
%     | *    X,ll   |                             +
%     para todo l = 1,...,p.                      +
% +++++++++++++++++++++++++++++++++++++++++++++++++
RestX = newlmi;                      % Restrições em X.
for i = 1:p
    e = E(:,i);                      % Aqui pega só a base canônica 'e'.
    lmiterm([RestX i i X],e',e);     % Lado esquerdo da desigualdade (+).
    lmiterm([-RestX i i 0],Umax^2);  % Lado direito da desigualdade (-).
end



%% ------------------------------------------------------------------------
%                      (4) Pega as LMI definidas acima.
% -------------------------------------------------------------------------

SistemaLMIs2 = getlmis;


%% ------------------------------------------------------------------------
%      (5) Calcula a quantidade de variáveis a serem encontradas.
% -------------------------------------------------------------------------

NumVar = decnbr(SistemaLMIs2); %   Quantidade total de variáveis do sistema.
c = zeros(NumVar,1);           %   Vetor de zeros.
c(1) = 1;                      %   Apenas o primeiro elemento do vetor como 1,
                               % pois o mesmo será multiplicado por 'gamma'.

% +++++++++++++++++++++++++++++++++++++++++++++++++                                     
% 5.a) Opções para vizualização dos resultados.   +
%                                                 +
options = [0 200 0 0 1];      % Trace off         
% options = [0 200 0 0 0];      % Trace on        
% +++++++++++++++++++++++++++++++++++++++++++++++++                                     

% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++                                     
% 5.b) Usa-se o 'tic' e o 'toc' para que possamos fazer o cálculo +
%      de quanto tempo demora o processo de OTIMIZAÇÃO em cada    +
%      laço da simulação.                                         +
%                                                                 +
% tic                                                             % +
[Copt, Xopt] = mincx(SistemaLMIs2, c, options);                  % +               
% toc                                                             % +
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

Ysol = dec2mat(SistemaLMIs2, Xopt, Y);
Qsol = dec2mat(SistemaLMIs2, Xopt, Q);

%% Determinação da Matriz F, tal que: u*(k) = F.x(k)
F = Ysol*inv(Qsol);


%% Saída do sistema.
Saida = F;

end