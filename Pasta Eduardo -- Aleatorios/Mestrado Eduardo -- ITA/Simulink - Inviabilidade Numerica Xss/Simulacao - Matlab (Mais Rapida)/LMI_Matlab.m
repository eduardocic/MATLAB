function uk = LMI_Matlab(xk, A, B, S, R, Smeio, Rmeio, H, Umax, rho)
                                
n = size(A{1},1);
p = size(B{1},2);
L = max(size(A))*max(size(B));   % Cardinalidade do sistema.
E = eye(p);                      % Matriz utilizada na restrição de controle.

setlmis([]);

[g, m1, sg]     = lmivar(1,[1 0]);         % Variável a ser minimizada '(g)amma'.
[Q, m2, sQ]     = lmivar(1,[n 1]);         % Q (nxn) simétrica full-block.
[Y, m3, sY]     = lmivar(2,[p n]);         % Y (pxn) retangular; 
[X, m4, sX]     = lmivar(1,[p 1]);         % X (pxp) simétrica full-block.
[z, m5, sz]     = lmivar(1,[1 0]);         % z (nx1)- Variável que gostaremos de minimizar.
[Eta, m6, sEta] = lmivar(1,[1 0]);         % Variável a ser minimizada 'Eta' no Custo.


% -------------------
% (b) LMI do Kothare.
% -------------------
%  | Q  x(k)-H.z | >= 0               
%  | *      1    | 
LMI_Kothare1 = newlmi;
lmiterm([-LMI_Kothare1 1 1 Q],1,1);    % Direita da LMI(-), pos (1,1), Var (Q).
lmiterm([-LMI_Kothare1 1 2 0],xk);     % Direita da LMI(-), pos (1,2), Const (x(k)).
lmiterm([-LMI_Kothare1 1 2 z],H,-1);   % Direita da LMI(-), pos (1,2), -H.z.
lmiterm([-LMI_Kothare1 2 2 0],1);      % Direita da LMI(-), pos (1,2), Const '1'
                                     
% -------------------------------                                     
% (c) LMIs da Combinação Convexa.
% -------------------------------
%     | Q  0  0  (AjQ + BjY) |          
%     | *  gI 0   S^(1/2)Q   | >= 0    
%     | *  *  gI  R^(1/2)Y   |
%     | *  *  *        Q     |
%     para todo J = 1,...,N (=qA*qB);
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


% ++++++++++++++++++++++++++++                                                                         
% e) LMI  (v)                +
%                            +
%     | I   H.z | >= 0       +          
%     | *   Eta |            +
% ++++++++++++++++++++++++++++
LMI_Eduardo1   = newlmi;
lmiterm([-LMI_Eduardo1 1 1 0],1);
lmiterm([-LMI_Eduardo1 1 2 z],H,1);     % Direita da LMI(-), pos (1,2), -Hz.
lmiterm([-LMI_Eduardo1 2 2 Eta],1,1);   


SistemaLMIs = getlmis;
numvar = decnbr(SistemaLMIs);    % Quantidade total de variáveis do sistema.

%%%  min 'c'.x
c      = zeros(numvar,1);
c(1)   = rho;                    % Cost = rho*gamma
c(end) = 1;                      % Cost = Eta

%%% Opções do Otimizador.
options = [0 1000 0 0 1];        % Trace off
[Copt, Xopt] = mincx(SistemaLMIs, c, options);

%%% Solução.
Ysol    = dec2mat(SistemaLMIs, Xopt, Y);
Qsol    = dec2mat(SistemaLMIs, Xopt, Q);
zsol    = dec2mat(SistemaLMIs, Xopt, z);
Etasol  = dec2mat(SistemaLMIs, Xopt, Eta);

F   = Ysol*inv(Qsol);
Xss = H*zsol;

uk  = F*(xk - Xss);
end