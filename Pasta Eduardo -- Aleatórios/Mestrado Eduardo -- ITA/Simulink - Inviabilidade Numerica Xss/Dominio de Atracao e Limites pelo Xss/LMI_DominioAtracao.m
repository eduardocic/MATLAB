function [Saida] = LMI_DominioAtracao(A, B, Epsilon, Umax)
%erl 
% - A: Matriz de Estado Completa A;
% - B: Matriz de Estado Completa B;
% - Epsilon: Vetor com a direção a ser minimizado.


%%% Preambulo.
n = size(A{1},1);
p = size(B{1},2);
L = max(size(A))*max(size(B));   % Cardinalidade do sistema.

S     = eye(n);   
R     = eye(p);
Smeio = sqrt(S);    % S^(-1/2)
Rmeio = sqrt(R);    % R^(-1/2)

E  = eye(p);        % Importante para os valores da LMI do controle.


%%% LMI's.
setlmis([]);

[Beta, m0, sBeta] = lmivar(1,[1 0]);     % Beta, variável a ser minimizada.
[g, m1, sg] = lmivar(1,[1 0]);           % '(g)amma'.
[Q, m2, sQ] = lmivar(1,[n 1]);           % Q (nxn) simétrica full-block.
[Y, m3, sY] = lmivar(2,[p n]);           % Y (pxn) retangular; 
[X, m4, sX] = lmivar(1,[p 1]);           % X (pxp) simétrica full-block.

% +++++++++++++++++++++++++++++++++++++++++++
% 3.a) LMI (i)                              +
%                                           +    
%     | Q  B*epsilon|  >= 0             (i) +
%     | *      1    |                       +
% +++++++++++++++++++++++++++++++++++++++++++
LMI_Kothare1 = newlmi;
lmiterm([-LMI_Kothare1 1 1 Q],1,1);           % Direita da LMI(-), P(1,1), Var (Q).
lmiterm([-LMI_Kothare1 1 2 Beta],1,Epsilon);  % Direita da LMI(-), P(1,2).
lmiterm([-LMI_Kothare1 2 2 0],1);             % Direita da LMI(-), pos (1,2), '1' 
                                            
                                                   
% -------------------------------                                     
% (c) LMIs da Combinação Convexa.
% -------------------------------
%     | Q  0  0  (AjQ + BjY) |          
%     | *  gI 0   S^(1/2)Q   | >= 0    
%     | *  *  gI  R^(1/2)Y   |
%     | *  *  *        Q     |
%     para todo J = 1,...,L.
for j=1:L
    LMI_Kothare2(j) = newlmi;
    lmiterm([-LMI_Kothare2(j) 1 1 Q],1,1);
    [Aj, Bj] = VerticePolitopo(A, B, j);
    lmiterm([-LMI_Kothare2(j) 1 4 Q],Aj,1);
    lmiterm([-LMI_Kothare2(j) 1 4 Y],Bj,1);
    lmiterm([-LMI_Kothare2(j) 2 2 g],1,1);
    lmiterm([-LMI_Kothare2(j) 2 4 Q],Smeio,1);
    lmiterm([-LMI_Kothare2(j) 3 3 g],1,1);
    lmiterm([-LMI_Kothare2(j) 3 4 Y],Rmeio,1);
    lmiterm([-LMI_Kothare2(j) 4 4 Q],1,1);
end

% -------------------------------                                     
% (d) LMI dos limites da entrada.
% -------------------------------
%     | X  Y |  >= 0                  
%     | *  Q |
LMI_Kothare3 = newlmi;
lmiterm([-LMI_Kothare3 1 1 X],1,1);    % Direita da LMI(-), pos (1,1), Var (X).
lmiterm([-LMI_Kothare3 1 2 Y],1,1);    % Direita da LMI(-), pos (1,2), Var (Y).
lmiterm([-LMI_Kothare3 2 2 Q],1,1);    % Direita da LMI(-), pos (1,2), Var (Q).


% +++++++++++++++++++++++++++++++++++++++++++++++++                                     
% d) LMI (iv);                                    +
%                                                 +
%  Essa LMI faz juz ao limitante de entrada.      +
%                                                 +
%     | 1   Umax,l  | <= 0              (iv)      + 
%     | *    X,ll   |                             +
%     para todo l = 1,...,p.                      +
% +++++++++++++++++++++++++++++++++++++++++++++++++
for j = 1:p
    LMI_Kothare4(j) = newlmi;
    e = E(:,j);                                % Aqui pega só a base canônica 'e'.
    lmiterm([LMI_Kothare4(j) j j X],e',e);     % Lado esquerdo da desigualdade (+).
    lmiterm([-LMI_Kothare4(j) j j 0],Umax^2);  % Lado direito da desigualdade (-).
end


SistemaLMIs = getlmis;

%%%  min 'c'.x
numvar = decnbr(SistemaLMIs);    % Quantidade total de variáveis do sistema.
c      = zeros(numvar,1);        %   Vetor de zeros.
c(1)   = 1;                      %   Apenas o primeiro elemento do vetor como 1,
 
%%% Opções do Otimizador.
options = [0 200 0 0 1];      % Trace off                                          
[Copt, Xopt] = mincx(SistemaLMIs, c, options);                            

%%% Solução.
Betasol = dec2mat(SistemaLMIs, Xopt, Beta);    % Solução para o velor de 'B'eta.
Ysol    = dec2mat(SistemaLMIs, Xopt, Y);
Qsol    = dec2mat(SistemaLMIs, Xopt, Q);
F       = Ysol*inv(Qsol);

Saida = Betasol;
end