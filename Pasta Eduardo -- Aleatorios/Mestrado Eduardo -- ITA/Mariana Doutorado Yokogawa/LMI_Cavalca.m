function [Qsol, Ysol] = LMI_Cavalca(Eps, A, B, C, S, Smeio, R, Rmeio, Umax, yb)



n = size(A{1},1);       % xtil(k) = [h(k) | u(k-1) ... u(k-tao) | w(k)] 
p = size(B{1},2);       % Quantidade de entradas u(k)'s.
N = max(size(A));       % Vértices total politopo.   
E = eye(p);             % Importante para Restrições sobre o Controle u(k). 

setlmis([]);

%% (2) Definição das variáveis.
[g, m1, sg] = lmivar(1,[1 0]);     % Variável a ser minimizada '(g)amma'.
[Q, m2, sQ] = lmivar(1,[n 1]);     % Q (nxn) simétrica full-block.
[Y, m3, sY] = lmivar(2,[p n]);     % Y (pxn) retangular; 
[X, m4, sX] = lmivar(1,[p 1]);     % X (pxp) simétrica full-block.


% +++++++++++++++++++++++++++++++++++++++++++
% (a) LMI do Kothare.
% -------------------
%  | Q  Epsilon(i) | >= 0               
%  | *      1      | 
% +++++++++++++++++++++++++++++++++++++++++++
LMI_Kothare1 = newlmi;
lmiterm([-LMI_Kothare1 1 1 Q],1,1);   % Direita da LMI(-), pos (1,1), Var (Q).
lmiterm([-LMI_Kothare1 1 2 0],Eps);   % Direita da LMI(-), pos (1,2), Const (x(k)).
lmiterm([-LMI_Kothare1 2 2 0],1);     % Direita da LMI(-), pos (1,2), Const '1' 
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
%  |       Q             *    | >= 0               
%  | Cm.(AjQ + BjY)   yb(i)^2 | 
% +++++++++++++++++++++++++++++++++++++++++++
for i = 1:N
    LMI_Eduardo1(i) = newlmi;
    
    CA = C*A{i};             % C.A
    CB = C*B{i};             % C.B
    
    lmiterm([-LMI_Eduardo1(i) 1 1 Q],1,1);
    lmiterm([-LMI_Eduardo1(i) 2 1 Q],CA,1);
    lmiterm([-LMI_Eduardo1(i) 2 1 Y],CB,1);
    lmiterm([-LMI_Eduardo1(i) 2 2 0],yb^2);
end

%% 4) Pega as LMI definidas acima.
SistemaLMIs = getlmis;

NumVar = decnbr(SistemaLMIs);
c      = zeros(NumVar,1);
c(1)   = 1;

options = [0 1000 -1 0 0];           
[Copt, Xopt] = mincx(SistemaLMIs, c, options);

Ysol = dec2mat(SistemaLMIs, Xopt, Y);
Qsol = dec2mat(SistemaLMIs, Xopt, Q);

end


