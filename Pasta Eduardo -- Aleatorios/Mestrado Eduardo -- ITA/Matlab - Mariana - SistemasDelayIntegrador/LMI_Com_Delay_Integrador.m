function [uk, wk] = LMI_Com_Delay_Integrador(zk, AdI, BdI, Cd, Smeio, Rmeio, ...
                                             Umax, tao, Upast, Wpast)

% _________________________________________________________________________
%                  Dados para procesamento do programa.
% _________________________________________________________________________
n = size(AdI{1},1);      % xtil(k) = [z(k) u(k-1) ... u(k-tao) w(k)] 
p = size(BdI{1},2);      % Quantidade de entradas u(k)'s.
N = max(size(AdI{1}));   % Vértices total politopo.   
E = eye(p);              % Importante para Restrições sobre o Controle u(k). 


% _________________________________________________________________________
%                 Estado aumentado [z(k) + Upast + Wpast]
% _________________________________________________________________________
xtil = [zk Upast' Wpast]';    %[z(k) | u(k-1) ... u(k-tao) | w(k)]


% _________________________________________________________________________
%                    Inicializa Variáveis para as LMIs
% _________________________________________________________________________
setlmis([]);

[g, m1, sg] = lmivar(1,[1 0]);      % Variável a ser minimizada '(g)amma'.
[Q, m2, sQ] = lmivar(1,[n 1]);      % Q (nxn) simétrica full-block. 
[Y, m3, sY] = lmivar(2,[p n]);      % Y (pxn) retangular.
[X, m4, sX] = lmivar(1,[p 1]);      % X (pxp) simétrica full-block.


% _________________________________________________________________________
%                             Constrói as LMIs
% _________________________________________________________________________                            

%  | Q  x(k)| >= 0              
%  | *   1  |           
LMI_Kothare1 = newlmi;
lmiterm([-LMI_Kothare1 1 1 Q],1,1);   % Direita da LMI(-), pos (1,1), Var (Q).
lmiterm([-LMI_Kothare1 1 2 0],xtil);  % Direita da LMI(-), pos (1,2), Const (xtil(k)).
lmiterm([-LMI_Kothare1 2 2 0],1);     % Direita da LMI(-), pos (1,2), Const '1' 
                                  
%     | Q  0  0  (AjQ + BjY) |              
%     | *  gI 0   S^(1/2)Q   | >= 0    
%     | *  *  gI  R^(1/2)Y   |              
%     | *  *  *       Q      |              
%     para todo j = 1,...,N ( = qA*qB);     
for i=1:(N-1)   
    LMI_Kothare2(i) = newlmi;
    lmiterm([-LMI_Kothare2(i) 1 1 Q],1,1);
    lmiterm([-LMI_Kothare2(i) 1 4 Q],AdI{i},1);
    lmiterm([-LMI_Kothare2(i) 1 4 Y],BdI{i},1);
    lmiterm([-LMI_Kothare2(i) 2 2 g],1,1);
    lmiterm([-LMI_Kothare2(i) 2 4 Q],Smeio,1);
    lmiterm([-LMI_Kothare2(i) 3 3 g],1,1);
    lmiterm([-LMI_Kothare2(i) 3 4 Y],Rmeio,1);
    lmiterm([-LMI_Kothare2(i) 4 4 Q],1,1);
end

%     | X  Y |  >= 0              
%     | *  Q |                   
LMI_Kothare3 = newlmi;
lmiterm([-LMI_Kothare3 1 1 X],1,1);    % Direita da LMI(-), pos (1,1), Var (X).
lmiterm([-LMI_Kothare3 1 2 Y],1,1);    % Direita da LMI(-), pos (1,2), Var (Y).
lmiterm([-LMI_Kothare3 2 2 Q],1,1);    % Direita da LMI(-), pos (1,2), Var (Q).

%     | 1   Umax,l  | <= 0              
%     | *    X,ll   |                   
%     para todo l = 1,...,p.       
for i = 1:p
    LMI_Kothare4(i) = newlmi;
    e = E(:,i);                                % Aqui pega só a base canônica 'e'.
    lmiterm([LMI_Kothare4(i) i i X],e',e);     % Lado esquerdo da desigualdade (+).
    lmiterm([-LMI_Kothare4(i) i i 0],Umax^2);  % Lado direito da desigualdade (-).
end


% _________________________________________________________________________
%                          Definição do Custo 
% _________________________________________________________________________                            
SistemaLMIs = getlmis;              % Pega as LMI formadas.
NumVar      = decnbr(SistemaLMIs);  % Quantidade de variáveis do sistema.
c           = zeros(NumVar,1);      % Vetor de zeros.
c(1)        = 1;                    % Gamma.

% _________________________________________________________________________
%                    Resolve o problema de otimização. 
% _________________________________________________________________________
options = [0 200 0 0 1];                        % Opções do otimizador.
[Copt, Xopt] = mincx(SistemaLMIs, c, options);  % Resolve.

Ysol = dec2mat(SistemaLMIs, Xopt, Y);           % Resultado para Y
Qsol = dec2mat(SistemaLMIs, Xopt, Q);           % Resultado para Q
F   = Ysol*inv(Qsol);                           % Cálculo de F.

% _________________________________________________________________________
%                           Atualiza u(k) e w(k).
% _________________________________________________________________________
uk = F*xtil;

xk = xtil(1:(end-1));       % [z(k) u(k-1) ... u(k-tao)]
wk = Wpast - Cd*xk;         % w(k+1) = w(k) - C*xk.

end