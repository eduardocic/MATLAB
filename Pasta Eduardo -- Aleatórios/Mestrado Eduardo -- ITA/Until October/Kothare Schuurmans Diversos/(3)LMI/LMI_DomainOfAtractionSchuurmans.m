function [Saida] = LMI_DomainOfAtractionSchuurmans(A, B, K, Epsilon, Umax)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                           1. Inicialização.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[n, p, qA, qB, N] = ParametersSteadyState(A, B);

Q     = eye(n);    
Qsqrt = sqrt(Q);   % Q^(-1/2)
R     = eye(p);   
Rsqrt = sqrt(R);   % R^(-1/2)
I     = eye(n);    % Matriz identidade (nxn);
E     = eye(p);    % Matriz identidade (pxp);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                       (2) Definição das variáveis.
%
% -------------------------------------------------------------------------
%
%  a) Como o nc = 1, o custo tem um somatório que varia de 0 até nc. Dessa
%     forma o que se tem são duas variáveis de otimização (nc+1);
%  b) X = P^(-1)*g_nc. Como o P é de ordem (nxn) => X = nxn;
%  c) K = Y*X^(-1). Como K é de ordem (pxn) => Y = pxn;
%  d) Como há 'nc' variáveis de otimização, mostra que teremos que
%     escolher necessariamente 'nc' variáveis de otimização para o 'c' que
%     minimiza a entrada 'u'. E o 'c' tem a mesma ordem do 'u' (px1).
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
setlmis([]);

[Z,  m0, sZ]   = lmivar(1,[1 0]);     % Z, variável a ser minimizada.
[g0, m1, sg0]  = lmivar(1,[1 0]);     % '(g)amma0'.
[g1, m2, sg1]  = lmivar(1,[1 0]);     % '(g)amma1'.
[X,  m3, sX]   = lmivar(1,[n 1]);     % X (nxn) simétrica full-block.
[Y,  m4, sY]   = lmivar(2,[p n]);     % Y (pxn) retangular; 
[U,  m5, sU]   = lmivar(1,[p 1]);     % U (pxp) retangular;
[c,  m6, sc]   = lmivar(2,[p 1]);     % c (px1) retangular; 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                      (3) Determinação das LMI.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%  | I    Q^(1/2)*Z*Epsilon             0            |              +
%  | *           g0                 c'R^(1/2)        | >= 0  +             
%  | *           *                      I            |                +
% ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
LMI_1 = newlmi;
lmiterm([-LMI_1 1 1 0],1);                % I
lmiterm([-LMI_1 1 2 Z],Qsqrt,Epsilon);    % Q^(1/2)xk
lmiterm([-LMI_1 2 2 g0],1,1);             % g0.
lmiterm([-LMI_1 2 3 -c],1,Rsqrt);         % c'R^(1/2).
lmiterm([-LMI_1 3 3 0],1);                % I.


% +++++++++++++++++++++++++++++++++++++++++++++++++++                                     
% 3.b) LMI das incertezas                           +
%     |   1  Z*(Epsilon'*Aj') + c'Bj') | >= 0 (ii)  +
%     |   *              X              |            +
% +++++++++++++++++++++++++++++++++++++++++++++++++++
for i=1:N
    ConjLMICombConvex(i) = newlmi;
    lmiterm([-ConjLMICombConvex(i) 1 1 0],1);
    [Aj, Bj] = Vertice(A,B,n,qB,i);
    lmiterm([-ConjLMICombConvex(i) 1 2 -Z],1,Epsilon'*Aj');
    lmiterm([-ConjLMICombConvex(i) 1 2 -c],1,Bj');
    lmiterm([-ConjLMICombConvex(i) 2 2 X],1,1);
end

% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++                                     
% 3.c) LMI das incertezas                                 +
%                                                         +
%     |     X         *           *         *  |             +
%     | Aj.X + Bj.Y   X           *         *  | >= 0  (ii)  +
%     |   Qsqrt.X     0           g1        *  |             +
%     |   Rsqrt.Y     0           0         g1 |             +
%     para todo j = 1,...,N ( = qA*qB);                   +
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++                                     
for i=1:N
    ConjLMICombConvex2(i) = newlmi;
    lmiterm([-ConjLMICombConvex2(i) 1 1 X],1,1);
    [Aj, Bj] = Vertice(A,B,n,qB,i);  
    lmiterm([-ConjLMICombConvex2(i) 2 1 X],Aj,1);
    lmiterm([-ConjLMICombConvex2(i) 2 1 Y],Bj,1);
    lmiterm([-ConjLMICombConvex2(i) 2 2 X],1,1);
    lmiterm([-ConjLMICombConvex2(i) 3 1 X],Qsqrt,1);
    lmiterm([-ConjLMICombConvex2(i) 3 3 g1],1,1);
    lmiterm([-ConjLMICombConvex2(i) 4 1 Y],Rsqrt,1);
    lmiterm([-ConjLMICombConvex2(i) 4 4 g1],1,1);
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                              Restrições
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% a) Restrição de i = 0 até nc-1.
LMI_2 = newlmi;
Umax2 = Umax^2;
lmiterm([-LMI_2 1 1 0],1);          % I
lmiterm([-LMI_2 1 2 c],1,1);        % c.
lmiterm([-LMI_2 2 2 0],Umax2);      % Umax^2.


% b) Restrição de i = nc até inf
LMI_3 = newlmi;
lmiterm([-LMI_3 1 1 U],1,1);          % U
lmiterm([-LMI_3 1 2 Y],1,1);          % Y
lmiterm([-LMI_3 2 2 X],1,1);          % X

for i = 1:p
    RestU(i) = newlmi;
    e = E(:,i);                         % Aqui pega só a base canônica 'e'.
    lmiterm([RestU(i) i i U],e',e);     % Lado esquerdo da desigualdade (+).
    lmiterm([-RestU(i) i i 0],Umax2);   % Lado direito da desigualdade (-).
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
SistemaLMIs = getlmis;

NumVar = decnbr(SistemaLMIs);  % Quantidade total de variáveis do sistema.
d = zeros(NumVar,1);           % Vetor de zeros.

%++ ------ Custo ------ +++
%   J = g1 + g0           +
% -------------------------
d(1)   = 1;     % 1*Beta
d(2)   = 0;       % 0*g0
d(3)   = 0;       % 0*g1
d(end) = 0;



% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++                                     
% 5.b) Usa-se o 'tic' e o 'toc' para que possamos fazer o cálculo +
%      de quanto tempo demora o processo de OTIMIZAÇÃO em cada    +
%      laço da simulação.                                         +
options = [0 1000 0 0 1];      % Trace off                         +
% tic                                                            
[Copt, Xopt] = mincx(SistemaLMIs, d, options);                   
% toc                                                            

Zsol = dec2mat(SistemaLMIs, Xopt, Z);    % Solução para o velor de 'B'eta.

Saida = Zsol; 