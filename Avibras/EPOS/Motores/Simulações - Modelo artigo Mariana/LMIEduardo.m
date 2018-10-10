function [uk, Qsol, Xss] = LMIEduardo(xk, A, B, C, H, S, R, Umax, Ylimites, at, rho)

n = size(A{1},1);       % Tamanho do estado.
p = size(B{1},2);       % Quantidade de entradas u(k)'s.
N = max(size(A));       % Vértices total politopo.   
E = eye(p);             % Importante para Restrições sobre o Controle u(k).

Rmeio = sqrt(R);
Smeio = sqrt(S);

E     = eye(p);                   % Importante para os valores da LMI (iv).
Ymin  = Ylimites(1);              % Limitante Inferior para Saída.
Ymax  = Ylimites(2);              % Limitante Superior para Saída.

% LMIs
setlmis([]);

[g, m1, sg]     = lmivar(1,[1 0]);   % Variável a ser minimizada '(g)amma'.
[Q, m2, sQ]     = lmivar(1,[n 1]);   % Q (nxn) simétrica full-block.
[Y, m3, sY]     = lmivar(2,[p n]);   % Y (pxn) retangular; 
[X, m4, sX]     = lmivar(1,[p 1]);   % X (pxp) simétrica full-block.
 % Variáveis adicionais para Saída Assimétrica.
[z, m5, sz]     = lmivar(1,[1 0]);   % Variável z. 
[a, m6, sAlfa]  = lmivar(1,[1 0]);   % Variável 'a'.
[b, m6, sBeta]  = lmivar(1,[1 0]);   % Variável 'b'. 
[Eta, m7, sEta] = lmivar(1,[1 0]);   % Variável Eta.


% +++++++++++++++++++++++++++++++++++++++++++
% (a) LMI do Kothare.
% -------------------
%  | Q  x(k)-H.z| >= 0               
%  | *      1   | 
% +++++++++++++++++++++++++++++++++++++++++++

LMI_Kothare1 = newlmi;
lmiterm([-LMI_Kothare1 1 1 Q],1,1);   % Direita da LMI(-), pos (1,1), Var (Q).
lmiterm([-LMI_Kothare1 1 2 0],xk);    % Direita da LMI(-), pos (1,2), Const (x(k)).
lmiterm([-LMI_Kothare1 1 2 z],H,-1);  % Direita da LMI(-), Xss = H*z. 
lmiterm([-LMI_Kothare1 2 2 0],1);     % Direita da LMI(-), pos (1,2), Const '1' 


% +++++++++++++++++++++++++++++++++++++++++++                                     
% b) LMI (ii);                              +
%                                           +
%     | Q  0  0  (AjQ + BjY) |              +
%     | *  gI 0   S^(1/2)Q   | >= 0    (ii) +
%     | *  *  gI  R^(1/2)Y   |              +
%     | *  *  *       Q      |              +
%     para todo j = 1,...,L ( = qA*qB);     +
% +++++++++++++++++++++++++++++++++++++++++++  
for j=1:N
    LMI_Kothare2(j) = newlmi;
    lmiterm([-LMI_Kothare2(j) 1 1 Q],1,1);
    lmiterm([-LMI_Kothare2(j) 1 4 Q],A{j},1);
    lmiterm([-LMI_Kothare2(j) 1 4 Y],B{j},1);
    lmiterm([-LMI_Kothare2(j) 2 2 g],1,1);
    lmiterm([-LMI_Kothare2(j) 2 4 Q],Smeio,1);
    lmiterm([-LMI_Kothare2(j) 3 3 g],1,1);
    lmiterm([-LMI_Kothare2(j) 3 4 Y],Rmeio,1);
    lmiterm([-LMI_Kothare2(j) 4 4 Q],1,1);
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
for j = 1:p
    LMI_Kothare4(j) = newlmi;
    e = E(:,j);                                % Aqui pega só a base canônica 'e'.
    lmiterm([LMI_Kothare4(j) j j X],e',e);     % Lado esquerdo da desigualdade (+).
    lmiterm([-LMI_Kothare4(j) j j 0],Umax^2);  % Lado direito da desigualdade (-).
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                        Output Assimétrico
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% +++++++++++++++++++++++++++++++++++++++++++
% (e) LMI (v).
%
%  |       Q          *  | >= 0               
%  | C.(AjQ + BjY)    b  | 
% +++++++++++++++++++++++++++++++++++++++++++
for j = 1:N
    LMI_Eduardo1(j) = newlmi;
   
    CA = C*A{j};             % C.A
    CB = C*B{j};             % C.B
    
    lmiterm([-LMI_Eduardo1(j) 1 1 Q],1,1);
    lmiterm([-LMI_Eduardo1(j) 2 1 Q],CA,1);
    lmiterm([-LMI_Eduardo1(j) 2 1 Y],CB,1);
    lmiterm([-LMI_Eduardo1(j) 2 2 b],1,1);
end

% ++++++++++++++++++++++++++++                                                                         
% f) LMI  (vi)               +
%                            +
%     | I   H.z | >= 0       +          
%     | *   Eta |            +
% ++++++++++++++++++++++++++++
LMI_Eduardo2   = newlmi;

lmiterm([-LMI_Eduardo2 1 1 0],1);
lmiterm([-LMI_Eduardo2 1 2 z],H,1);     % Direita da LMI(-), pos (1,2), -Hz.
lmiterm([-LMI_Eduardo2 2 2 Eta],1,1);   
    
% ++++++++++++++++++++++++++++                                                                         
% g) LMI  (vii)              +
%                            +
%      a <= C.Hz - Ymin      +
%                            +
%.:.   a - C.Hz + Ymin <= 0  +
% ++++++++++++++++++++++++++++
LMI_Eduardo3   = newlmi;
lmiterm([LMI_Eduardo3 1 1 a],1,1);
lmiterm([LMI_Eduardo3 1 1 z],C*H,-1);
lmiterm([LMI_Eduardo3 1 1 0],Ymin);  

    
% ++++++++++++++++++++++++++++                                                                         
% h) LMI  (viii)             +
%                            +
%       a <= Ymax - C.Hz     +
%                            +
%.:.  a + C.Hz - Ymax <= 0   +
% ++++++++++++++++++++++++++++
LMI_Eduardo4   = newlmi;
lmiterm([LMI_Eduardo4 1 1 a],1,1);
lmiterm([LMI_Eduardo4 1 1 z],C*H,1);
lmiterm([LMI_Eduardo4 1 1 0],-Ymax);  
    
% ++++++++++++++++++++++++++++                                                                         
% i) LMI  (IX)               +
%                            +
%        a >= 0              +          
% ++++++++++++++++++++++++++++  
LMI_Eduardo5   = newlmi;
lmiterm([-LMI_Eduardo5 1 1 a],1,1);


% ++++++++++++++++++++++++++++                                                                         
% j) LMI  (X)                +
%                            +
%        a <= a_max          + 
%                            +
%.:.   a - a_max <= 0        +
% ++++++++++++++++++++++++++++  
LMI_Eduardo6   = newlmi;
a_max = (Ymax-Ymin)/2;
lmiterm([LMI_Eduardo6 1 1 a],1,1);
lmiterm([LMI_Eduardo6 1 1 0],-a_max);


% +++++++++++++++++++++++++++++++++++++++++                                                                         
% l) LMI  (XI)                            +
%                                         +
%            b <= alpha*a + beta          +
%                                         +
%.:.      b - alpha*a - beta <=0          +
% +++++++++++++++++++++++++++++++++++++++++

LMI_Eduardo7   = newlmi;
alpha = 2*at;               % inclinação da reta.
beta  = -at^2;              % posição da ordenada que cruza o eixo 'b'.
lmiterm([LMI_Eduardo7 1 1 b],1,1);
lmiterm([LMI_Eduardo7 1 1 a],alpha,-1);
lmiterm([LMI_Eduardo7 1 1 0],-beta);



%%% 4) Pega as LMI definidas acima.
SistemaLMIs = getlmis;
NumVar = decnbr(SistemaLMIs);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% min(J) = Eta + rho*gamma
c      = zeros(NumVar,1);
c(1)   = rho;         % Gamma.
c(end) = 1;           % Eta.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
options = [0 30 0 0 0];           
[Copt, Xopt] = mincx(SistemaLMIs, c, options);
    
Ysol = dec2mat(SistemaLMIs, Xopt, Y);
Qsol = dec2mat(SistemaLMIs, Xopt, Q);
zsol = dec2mat(SistemaLMIs, Xopt, z);

F   = Ysol*inv(Qsol);

Xss = H*zsol;
yss = C*Xss;

uk  = F*(xk - Xss);
end