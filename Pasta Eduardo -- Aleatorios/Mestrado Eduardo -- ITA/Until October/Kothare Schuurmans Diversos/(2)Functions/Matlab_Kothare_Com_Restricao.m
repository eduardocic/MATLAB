function sys = Matlab_Kothare_Com_Restricao(xk, A, B, Umax)


[n, p, qA, qB, N] = ParametersSteadyState(A, B);


%% ------------------------------------------------------------------------ 
%                           (1) Inicializa LMIs.
% -------------------------------------------------------------------------

S  = eye(n);   Ssqrt = sqrt(S);    % S^(-1/2)
R  = eye(p);   Rsqrt = sqrt(R);    % R^(-1/2)
E  = eye(p);   % Importante para os valores da LMI (iv). 


% 1.c) Inicializar um conjunto de LMIs.
setlmis([]);

%% ------------------------------------------------------------------------
%                       (2) Defini��o das vari�veis.
% -------------------------------------------------------------------------
[g, m1, sg] = lmivar(1,[1 0]);     % '(g)amma'.
[Q, m2, sQ] = lmivar(1,[n 1]);     % Q (nxn) sim�trica full-block.
[Y, m3, sY] = lmivar(2,[p n]);     % Y (pxn) retangular; 

[X, m4, sX] = lmivar(1,[p 1]);     % X (pxp) sim�trica full-block.

%% ------------------------------------------------------------------------
%                      (3) Determina��o das LMI.
% -------------------------------------------------------------------------
% ++++++++++++++++++++++++
% 3.a) LMI do Kothare.   +
%                        +
%  | Q  x(k) | >= 0  +             
%  | *   1   |       +
% ++++++++++++++++++++++++
LMI_Kothare = newlmi;
lmiterm([-LMI_Kothare 1 1 Q],1,1);    % Direita da LMI(-), pos (1,1), Var (Q).
lmiterm([-LMI_Kothare 1 2 0],xk);     % Direita da LMI(-), pos (1,2), Const (x(k)).
lmiterm([-LMI_Kothare 2 2 0],1);      % Direita da LMI(-), pos (1,2), Const '1'

% +++++++++++++++++++++++++++++++++++++++++++                                     
% 3.b) LMI das incertezas                   +
%                                           +
%     | Q  0  0  (AjQ + BjY) |              +
%     | *  gI 0   S^(1/2)Q   | >= 0    (ii) +
%     | *  *  gI  R^(1/2)Y   |              +
%     | *  *  *       Q      |              +
%     para todo j = 1,...,N ( = qA*qB);     +
% +++++++++++++++++++++++++++++++++++++++++++                                     
for i=1:N
    ConjLMICombConvex(i) = newlmi;
    lmiterm([-ConjLMICombConvex(i) 1 1 Q],1,1);
    [Aj, Bj] = Vertice(A,B,n,qB,i);            
    lmiterm([-ConjLMICombConvex(i) 1 4 Q],Aj,1);
    lmiterm([-ConjLMICombConvex(i) 1 4 Y],Bj,1);
    lmiterm([-ConjLMICombConvex(i) 2 2 g],1,1);
    lmiterm([-ConjLMICombConvex(i) 2 4 Q],Ssqrt,1);
    lmiterm([-ConjLMICombConvex(i) 3 3 g],1,1);
    lmiterm([-ConjLMICombConvex(i) 3 4 Y],Rsqrt,1);
    lmiterm([-ConjLMICombConvex(i) 4 4 Q],1,1);
end

% +++++++++++++++++++++++++++++++++++++++++++                                     
% 3.d) LMI (iii);                           +
%                                           +
%     | X  Y |  >= 0                  (iii) +   
%     | *  Q |                              +
% +++++++++++++++++++++++++++++++++++++++++++              
InputConstraint = newlmi;
lmiterm([-InputConstraint 1 1 X],1,1);    % Direita da LMI(-), pos (1,1), Var (X).
lmiterm([-InputConstraint 1 2 Y],1,1);    % Direita da LMI(-), pos (1,2), Var (Y).
lmiterm([-InputConstraint 2 2 Q],1,1);    % Direita da LMI(-), pos (1,2), Var (Q).

% +++++++++++++++++++++++++++++++++++++++++++++++++                                     
% 3.e) LMI (iv);                                  +
%                                                 +
%  Essa LMI faz juz ao limitante de entrada.      +
%                                                 +
%     | 1   Umax,l  | <= 0              (iv)      + 
%     | *    X,ll   |                             +
%     para todo l = 1,...,p.                      +
% +++++++++++++++++++++++++++++++++++++++++++++++++
for i = 1:p
    RestX(i) = newlmi;
    e = E(:,i);                         % Aqui pega s� a base can�nica 'e'.
    lmiterm([RestX(i) i i X],e',e);     % Lado esquerdo da desigualdade (+).
    lmiterm([-RestX(i) i i 0],Umax^2);  % Lado direito da desigualdade (-).
end




%% ------------------------------------------------------------------------
%                      (4) Pega as LMI definidas acima.
% -------------------------------------------------------------------------

SistemaLMIs = getlmis;

%% ------------------------------------------------------------------------
%      (5) Calcula a quantidade de vari�veis a serem encontradas.
% -------------------------------------------------------------------------

NumVar = decnbr(SistemaLMIs);  % Quantidade total de vari�veis do sistema.
c = zeros(NumVar,1);           %   Vetor de zeros.

%++ ------ Custo ------ +++
%   J = Eta + rho*gamma   +
% -------------------------
c(1) = 1;     % rho*gamma

% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++                                     
% 5.b) Usa-se o 'tic' e o 'toc' para que possamos fazer o c�lculo +
%      de quanto tempo demora o processo de OTIMIZA��O em cada    +
%      la�o da simula��o.                                         +
options = [0 200 -1 0 1];      % Trace off                         +
% tic                                                             % +
[Copt, Xopt] = mincx(SistemaLMIs, c, options);                  % +               
% toc                                                             % +
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

Ysol = dec2mat(SistemaLMIs, Xopt, Y);
Qsol = dec2mat(SistemaLMIs, Xopt, Q);

%% Determina��o da Matriz F, tal que: u*(k) = F.x(k)
F = Ysol*inv(Qsol);

%% Sa�da de Controle.
uk = F*xk;

% Colocarei na Sa�da os seguite vetor [u' F]
sys =  uk;

end


