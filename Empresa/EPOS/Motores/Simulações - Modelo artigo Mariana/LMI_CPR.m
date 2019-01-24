function [uk] = LMI_CPR(xk, A, B, C, S, R, Umax, imax, Qsol, xref, yb)

global j

n = size(A{1},1);       % Tamanho do estado.
p = size(B{1},2);       % Quantidade de entradas u(k)'s.
N = max(size(A));       % Vértices total politopo.   
E = eye(p);             % Importante para Restrições sobre o Controle u(k).

Smeio = sqrt(S);        % S^(-1/2)
Rmeio = sqrt(R);        % R^(-1/2)

% Condição de Chaveamento.
% ------------------------
xtil  = xk - xref{j};
if j < imax
    xtm1 = xk - xref{j+1};          
    if xtm1'*inv(Qsol{j+1})*xtm1 < 1
        j = j+1;
    end
end

setlmis([]);

%% (2) Definição das variáveis.
[g, m1, sg] = lmivar(1,[1 0]);     % Variável a ser minimizada '(g)amma'.
[Q, m2, sQ] = lmivar(1,[n 1]);     % Q (nxn) simétrica full-block.
[Y, m3, sY] = lmivar(2,[p n]);     % Y (pxn) retangular; 
[X, m4, sX] = lmivar(1,[p 1]);     % X (pxp) simétrica full-block.


% +++++++++++++++++++++++++++++++++++++++++++
% (a) LMI do Kothare.
% -------------------
%  | Q  xtil_ss | >= 0               
%  | *      1   | 
% +++++++++++++++++++++++++++++++++++++++++++
LMI_Kothare1 = newlmi;
lmiterm([-LMI_Kothare1 1 1 Q],1,1);           % Direita da LMI(-), pos (1,1), Var (Q).
lmiterm([-LMI_Kothare1 1 2 0],xtil);          % Direita da LMI(-), pos (1,2), Const (x(k)).
lmiterm([-LMI_Kothare1 2 2 0],1);             % Direita da LMI(-), pos (1,2), Const '1' 
                                              % para representar a 'I', na dimensão apropriada

% +++++++++++++++++++++++++++++++++++++++++++                                     
% b) LMI (ii);                              +
%                                           +
%     | Q  0  0  (AjQ + BjY) |              +
%     | *  gI 0   S^(1/2)Q   | >= 0    (ii) +
%     | *  *  gI  R^(1/2)Y   |              +
%     | *  *  *       Q      |              +
%     para todo j = 1,...,N ( = qA*qB);     +
% +++++++++++++++++++++++++++++++++++++++++++  
for i=1:N
    LMI_Kothare2(i) = newlmi;
    lmiterm([-LMI_Kothare2(i) 1 1 Q],1,1);
    lmiterm([-LMI_Kothare2(i) 1 4 Q],A{i},1);
    lmiterm([-LMI_Kothare2(i) 1 4 Y],B{i},1);
    lmiterm([-LMI_Kothare2(i) 2 2 g],1,1);
    lmiterm([-LMI_Kothare2(i) 2 4 Q],Smeio,1);
    lmiterm([-LMI_Kothare2(i) 3 3 g],1,1);
    lmiterm([-LMI_Kothare2(i) 3 4 Y],Rmeio,1);
    lmiterm([-LMI_Kothare2(i) 4 4 Q],1,1);
end

% +++++++++++++++++++++++++++++++++++++++++++                                     
% c) LMI (iii);                             +
%                                           +
%     | X  Y |  >= 0                  (iii) +   
%     | *  Q |                              +
% +++++++++++++++++++++++++++++++++++++++++++              
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
for i = 1:p
    LMI_Kothare4(i) = newlmi;
    e = E(:,i);                                % Aqui pega só a base canônica 'e'.
    lmiterm([LMI_Kothare4(i) i i X],e',e);     % Lado esquerdo da desigualdade (+).
    lmiterm([-LMI_Kothare4(i) i i 0],Umax^2);  % Lado direito da desigualdade (-).
end

% +++++++++++++++++++++++++++++++++++++++++++
% (e) LMI (v).
%
%  |       Q              *    | >= 0               
%  | Cm.(AjQ + BjY)   yb(i)^2  | 
% +++++++++++++++++++++++++++++++++++++++++++
for i = 1:N
    LMI_Eduardo1(i) = newlmi;
    
    CA = C*A{i};             % C.A
    CB = C*B{i};             % C.B
    
    lmiterm([-LMI_Eduardo1(i) 1 1 Q],1,1);
    lmiterm([-LMI_Eduardo1(i) 2 1 Q],CA,1);
    lmiterm([-LMI_Eduardo1(i) 2 1 Y],CB,1);
    lmiterm([-LMI_Eduardo1(i) 2 2 0],yb(j)^2);
end
% end

%% 4) Pega as LMI definidas acima.
SistemaLMIs = getlmis;

NumVar = decnbr(SistemaLMIs);
c      = zeros(NumVar,1);
c(1)   = 1;           % Gamma.

options = [0 200 0 0 1];           
[Copt, Xopt] = mincx(SistemaLMIs, c, options);

Ysolution = dec2mat(SistemaLMIs, Xopt, Y);
Qsolution = dec2mat(SistemaLMIs, Xopt, Q);

F   = Ysolution*inv(Qsolution);
uk  = F*(xk - xref{j});

% sys =  [uk yb(i)];              % S-function output (control value)
end

