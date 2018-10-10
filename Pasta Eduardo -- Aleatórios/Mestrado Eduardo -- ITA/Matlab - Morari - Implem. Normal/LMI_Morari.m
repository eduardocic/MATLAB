function [uk] = LMI_Morari(xk, A, B, C, Smeio, Rmeio, Umax, Ymax)

%%% Parâmetros utilizados na otimização.
n = size(A{1},1);
p = size(B{1},2);
q = size(C, 1);

E  = eye(p);                    % Importante para os valores da LMI (iv).
L = max(size(A))*max(size(B));  % Cardinalidade do sistema.



%%% Determinação das LMIs
setlmis([]);

[g, m1, sg] = lmivar(1,[1 0]);     % Variável a ser minimizada '(g)amma'.
[G, m2, sG] = lmivar(1,[n 1]);     % G (nxn) simétrica full-block.
[Y, m3, sY] = lmivar(2,[p n]);     % Y (pxn) retangular; 
[X, m4, sX] = lmivar(1,[p 1]);     % X (pxp) simétrica full-block.
for j=1:L
    [Q{j}, m2, sQ{j}] = lmivar(1,[n 1]);     % Qj (nxn) simétrica full-block.
end
    
% +++++++++++++++++++++++++++++++++++++++++++
% (a) LMI do Kothare.
% -------------------
%  | Qj  x(k)| >= 0               
%  | *    1  |      , para todo j = 1,..., L.
% +++++++++++++++++++++++++++++++++++++++++++

for j=1:L
    LMI_Morari(j) = newlmi;
    lmiterm([-LMI_Morari(j) 1 1 Q{j}],1,1);   % Direita da LMI(-), pos (1,1), Var (Q).
    lmiterm([-LMI_Morari(j) 1 2 0],xk);       % Direita da LMI(-), pos (1,2), Const (x(k)).
    lmiterm([-LMI_Morari(j) 2 2 0],1);        % Direita da LMI(-), pos (1,2), Const '1'     
end

% +++++++++++++++++++++++++++++++++++++++++++                                     
% b) LMI (ii);                              +
%                                           +
%     | (G + G^{T} - Qj)  *   *  * |        +
%     |   (Aj.G + Bj.Y)   Qj  *  * | >= 0   +
%     |      Smeio.G      0  g.I * |        +
%     |      Rmeio.Y      0   0 g.I|        +
%               para todo j = 1,..., L      +
% +++++++++++++++++++++++++++++++++++++++++++  
for j=1:L
    LMI_Morari2(j) = newlmi;
    lmiterm([-LMI_Morari2(j) 1 1 G],1,1,'s');   % G + G^{T}
    lmiterm([-LMI_Morari2(j) 1 1 Q{j}],1,-1);
    [Aj, Bj] = VerticePolitopo(A, B, j);
    lmiterm([-LMI_Morari2(j) 2 1 G],Aj,1);
    lmiterm([-LMI_Morari2(j) 2 1 Y],Bj,1);
    lmiterm([-LMI_Morari2(j) 2 2 Q{j}],1,1);
    lmiterm([-LMI_Morari2(j) 3 1 G],Smeio,1);
    lmiterm([-LMI_Morari2(j) 3 3 g],1,1);
    lmiterm([-LMI_Morari2(j) 4 1 Y],Rmeio,1);
    lmiterm([-LMI_Morari2(j) 4 4 g],1,1);
end

% +++++++++++++++++++++++++++++++++++++++++++                                     
% c) LMI (iii);                             +
%                                           +
%     | X         Y         | >= 0    (iii) +   
%     | *  (G + G^{T} - Qj) |               +
%               para todo j = 1,..., L      +
% +++++++++++++++++++++++++++++++++++++++++++              
for j=1:L
    LMI_Morari3(j) = newlmi;
    lmiterm([-LMI_Morari3(j) 1 1 X],1,1);       % Direita da LMI(-), pos (1,1), Var (X).
    lmiterm([-LMI_Morari3(j) 1 2 Y],1,1);       % Direita da LMI(-), pos (1,2), Var (Y).
    lmiterm([-LMI_Morari3(j) 2 2 G],1,1,'s');   % G + G^{T}
    lmiterm([-LMI_Morari3(j) 2 2 Q{j}],1,-1);   % Direita da LMI(-), pos (2,2), Var (Qj).
end

% +++++++++++++++++++++++++++++++++++++++++++++++++                                     
% d) LMI (iv);                                    +
%                                                 +
%  Essa LMI faz jus ao limitante de entrada.      +
%                                                 +
%     | 1   Umax,l  | <= 0              (iv)      + 
%     | *    X,ll   |                             +
%     para todo l = 1,...,p.                      +
% +++++++++++++++++++++++++++++++++++++++++++++++++
for j = 1:p
    LMI_Morari4(j) = newlmi;
    e = E(:,j);                                % Aqui pega só a base canônica 'e'.
    lmiterm([LMI_Morari4(j) j j X],e',e);     % Lado esquerdo da desigualdade (+).
    lmiterm([-LMI_Morari4(j) j j 0],Umax^2);  % Lado direito da desigualdade (-).
end


% % +++++++++++++++++++++++++++++++++++++++++++++++++                                     
% % e) LMI (v);                                     +
% %                                                 +
% %  Essa LMI faz jus ao limitante de entrada.      +
% %                                                 +
% %     | (G + G^{T} - Qj)     *      | >= 0 (v)    + 
% %     |  C.(Aj.G + Bj.Y)   ymax^2   |             +
% %     para todo j = 1,...,L.                      +
% % +++++++++++++++++++++++++++++++++++++++++++++++++
% for j = 1:L
%     LMI_Morari5(j) = newlmi;
%     lmiterm([-LMI_Morari5(j) 1 1 G],1,1,'s');   % G + G^{T}
%     lmiterm([-LMI_Morari5(j) 1 1 Q{j}],1,-1);   % Direita da LMI(-), pos (2,2), Var (Qj).
%     [Aj, Bj] = VerticePolitopo(A, B, j);
%     CAj = C*Aj;
%     CBj = C*Bj;
%     lmiterm([-LMI_Morari5(j) 2 1 G],CAj,1);
%     lmiterm([-LMI_Morari5(j) 2 1 Y],CBj,1);
%     lmiterm([-LMI_Morari5(j) 2 2 0],Ymax^2);      % Lado esquerdo da desigualdade (+).
% end


%%% Pega as LMI definidas acima.
SistemaLMIs = getlmis;
NumVar = decnbr(SistemaLMIs);
c    = zeros(NumVar,1);
c(1) = 1;   % Gamma.

%%% Resolve o problema das LMIs.
options = [0 200 0 0 1];           
[Copt, Xopt] = mincx(SistemaLMIs, c, options);
  
%%% Pega o resultado.
Ysol = dec2mat(SistemaLMIs, Xopt, Y);
Gsol = dec2mat(SistemaLMIs, Xopt, G);
F    = Ysol*inv(Gsol);

uk = F*xk;