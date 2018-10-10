function Saida = PontoXss(A, B, H, xk)

[n, p, qA, qB, N] = ProcessamentoMatrizesEstado(A, B);

%% ------------------------------------------------------------------------ 
%                           (1) Inicializa LMIs.
% -------------------------------------------------------------------------

S  = eye(n);   Ssqrt = sqrt(S);    % S^(-1/2)
R  = eye(p);   Rsqrt = sqrt(R);    % R^(-1/2)
E  = eye(p);   % Importante para os valores da LMI (iv). 

setlmis([]);


%% ------------------------------------------------------------------------
%                       (2) Definição das variáveis.
% -------------------------------------------------------------------------
[g, m1, sg]     = lmivar(1,[1 0]);     % '(g)amma'.
[Q, m2, sQ]     = lmivar(1,[n 1]);     % Q (nxn) simétrica full-block.
[Y, m3, sY]     = lmivar(2,[p n]);     % Y (pxn) retangular; 

[Eta, m4, sEta] = lmivar(1,[1 0]);         % Variável a ser minimizada 'Eta' no Custo.
[z, m5, sz]     = lmivar(1,[1 0]);         % z (nx1)- Variável que gostaremos de minimizar.

%% ------------------------------------------------------------------------
%                      (3) Determinação das LMI.
% -------------------------------------------------------------------------


% +++++++++++++++++++++++++++++++++++++++++++
% (b) LMI do Kothare.
% -------------------
%  | Q  x(k)-H.z | >= 0               
%  | *      1    | 
% +++++++++++++++++++++++++++++++++++++++++++ 
LMI_Kothare = newlmi;
lmiterm([-LMI_Kothare 1 1 Q],1,1);    % Direita da LMI(-), pos (1,1), Var (Q).
lmiterm([-LMI_Kothare 1 2 0],xk);     % Direita da LMI(-), pos (1,2), Const (x(k)).
lmiterm([-LMI_Kothare 1 2 z],H,-1);   % Direita da LMI(-), pos (1,2), -H.z.
lmiterm([-LMI_Kothare 2 2 0],1);      % Direita da LMI(-), pos (1,2), Const '1'
                                                   
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
% 3.c) LMI do "Steady State".
% --------------------------
%     | I   H.z | >= 0                 
%     | *   Eta | 
LMIss   = newlmi;
I = eye(size(A,2));              % I (nxn)
lmiterm([-LMIss 1 1 0],I);
lmiterm([-LMIss 1 2 z],H,1);     % Direita da LMI(-), pos (1,2), -Hz.
lmiterm([-LMIss 2 2 Eta],1,1);

%% ------------------------------------------------------------------------
%                      (4) Pega as LMI definidas acima.
% -------------------------------------------------------------------------

SistemaLMIs = getlmis;


%% ------------------------------------------------------------------------
%      (5) Calcula a quantidade de variáveis a serem encontradas.
% -------------------------------------------------------------------------

NumVar = decnbr(SistemaLMIs);  % Quantidade total de variáveis do sistema.
c = zeros(NumVar,1);           %   Vetor de zeros.
c(end) = 1;                    %   Apenas o primeiro elemento do vetor como 1,
                               % pois o mesmo será multiplicado por 'Beta'.

% +++++++++++++++++++++++++++++++++++++++++++++++++                                     
% 5.a) Opções para vizualização dos resultados.   +
%                                                 +
options = [0 200 0 0 0];      % Trace off         
% +++++++++++++++++++++++++++++++++++++++++++++++++                                     

% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++                                     
% 5.b) Usa-se o 'tic' e o 'toc' para que possamos fazer o cálculo +
%      de quanto tempo demora o processo de OTIMIZAÇÃO em cada    +
%      laço da simulação.                                         +
%                                                                 +
% tic                                                             % +
[Copt, Xopt] = mincx(SistemaLMIs, c, options);                  % +               
% toc                                                             % +
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

Ysol = dec2mat(SistemaLMIs, Xopt, Y);
Qsol = dec2mat(SistemaLMIs, Xopt, Q);
z   = dec2mat(SistemaLMIs,Xopt,z);
Eta = dec2mat(SistemaLMIs,Xopt,Eta);

%% Determinação da Matriz F, tal que: u*(k) = F.x(k)
F = Ysol*inv(Qsol);

%% Saída de Controle.
xss = z*H;

u = F*(xk - xss)
Saida = xss;
end
