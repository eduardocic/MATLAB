clear; close all; clc;

% 1. Carrega Matrizes.
Matrizes;

% 2. Vari�veis importantes para o processamento global da fun��o.
[n, p, qA, qB, N] = ProcessamentoMatrizes(A, B);
Umax = 2;
xk_0;





% % 3. Rela��o entre as vari�veis.
% %
% % * nc -- Tamanho do horizonte recendente;
% % * K  -- Ser� um vetor de dimens�o (n*p)x(nc);
% % * c  -- Ser�o os vetores a ser minimizados.
% 
% %   Para o caso desse exemplo, o que farei diz respeito direto ao uso de
% %   apenas um passo de predi��o. Dessa forma o valor de nc=1. Escolhi fazer
% %   para o caso mais simples at� para entender o funcionamento da ideia
% %   central do algoritmo.
% 
% 
% 
% %% ------------------------------------------------------------------------ 
% %                           (1) Inicializa LMIs.
% % -------------------------------------------------------------------------
% % Essas matrizes v�m da f�rmula do custo quadr�tico: J = Sum(x'Qx +u'Ru)
% Q  = eye(n);   Qsqrt = sqrt(Q);    % Q^(-1/2)
% R  = eye(p);   Rsqrt = sqrt(R);    % R^(-1/2)
% I  = eye(n);   % Matriz identidade.
% 
% xk = [1; 1];
% K  = [0  0];
% 
% % 1.c) Inicializar um conjunto de LMIs.
% setlmis([]);
% 
% %% ------------------------------------------------------------------------
% %                       (2) Defini��o das vari�veis.
% % -------------------------------------------------------------------------
% % *)   Como o nc = 1, o custo tem um somat�rio que varia de 0 at� nc. Dessa
% %    forma o que se tem s�o duas vari�veis de otimiza��o (nc+1).
% % *)   X = P^(-1)*g_nc. Como o P � de ordem nxn => X = nxn.
% % *)   K = Y*X^(-1). Como K � de ordem pxn => Y = pxn.
% % *)   Como h� 'nc' vari�veis de otimiza��o, mostra que teremos que
% %    escolher necessariamente 'nc' vari�veis de otimiza��o para o 'c' que
% %    minimiza a entrada 'u'. E o 'c' tem a mesma ordem do 'u' (px1).
% [g0, m0, sg0] = lmivar(1,[1 0]);     % '(g)amma0'.
% [g1, m1, sg1] = lmivar(1,[1 0]);     % '(g)amma1'.
% [X, m2, sX]   = lmivar(1,[n 1]);     % X (nxn) sim�trica full-block.
% [Y, m3, sY]   = lmivar(2,[p n]);     % Y (pxn) retangular; 
% [c0, m4, sc0] = lmivar(2,[p 1]);     % c (px1) retangular; 
% 
% 
% %% ------------------------------------------------------------------------
% %                      (3) Determina��o das LMI.
% % -------------------------------------------------------------------------
% % +++++++++++++++++++++++++++++++++++++++++++++++++++++
% %  | I    Q^(1/2)xk             0             |       +
% %  | *       g0      c0'R^(1/2) + xk'K'R^(1/2)| >= 0  +             
% %  | *       *                   I            |       +
% % +++++++++++++++++++++++++++++++++++++++++++++++++++++
% LMI_1 = newlmi;
% multi1 = Qsqrt*xk;
% multi2 = xk'*K'*Rsqrt;
% lmiterm([-LMI_1 1 1 0],1);          % I
% lmiterm([-LMI_1 1 2 0],multi1);     % Q^(1/2)xk
% lmiterm([-LMI_1 2 2 g0],1,1);         % g0.
% lmiterm([-LMI_1 2 3 -c0],1,Rsqrt);  % c0'R^(1/2).
% lmiterm([-LMI_1 2 3 0],multi2);     % xk'K'R^(1/2).
% lmiterm([-LMI_1 3 3 0],1);          % I.
% 
% 
% % +++++++++++++++++++++++++++++++++++++++++++++++++++                                     
% % 3.b) LMI das incertezas                           +
% %     |         1            *  | >= 0    (ii)      +
% %     | Theta_l*xk + B_l*c0  X  |                   +
% % +++++++++++++++++++++++++++++++++++++++++++++++++++
% for i=1:N
%     ConjLMICombConvex(i) = newlmi;
%     lmiterm([-ConjLMICombConvex(i) 1 1 0],1);
%     [Aj, Bj] = Vertice(A,B,n,qB,i);
%     Theta = Aj + Bj*K;
%     Theta = Theta*xk;
%     lmiterm([-ConjLMICombConvex(i) 2 1 0],Theta);
%     lmiterm([-ConjLMICombConvex(i) 2 1 c0],Bj,1);
%     lmiterm([-ConjLMICombConvex(i) 2 2 X],1,1);
% end
% 
% % +++++++++++++++++++++++++++++++++++++++++++++++++++++++++                                     
% % 3.c) LMI das incertezas                                 +
% %                                                         +
% %     |     X         *           *         *  |             +
% %     | Aj.X + Bj.Y   X           *         *  | >= 0  (ii)  +
% %     | Qsqrt.X       0           g1        *  |             +
% %     | Rsqrt.Y       0           0         g1 |             +
% %     para todo j = 1,...,N ( = qA*qB);                   +
% % +++++++++++++++++++++++++++++++++++++++++++++++++++++++++                                     
% for i=1:N
%     ConjLMICombConvex(i) = newlmi;
%     lmiterm([-ConjLMICombConvex(i) 1 1 X],1,1);
%     [Aj, Bj] = Vertice(A,B,n,qB,i);  
%     lmiterm([-ConjLMICombConvex(i) 2 1 X],Aj,1);
%     lmiterm([-ConjLMICombConvex(i) 2 1 Y],Bj,1);
%     lmiterm([-ConjLMICombConvex(i) 2 2 X],1,1);
%     lmiterm([-ConjLMICombConvex(i) 3 1 X],Qsqrt,1);
%     lmiterm([-ConjLMICombConvex(i) 3 3 g1],1,1);
%     lmiterm([-ConjLMICombConvex(i) 4 1 Y],Rsqrt,1);
%     lmiterm([-ConjLMICombConvex(i) 4 4 g1],1,1);
% end
% 
% %% ------------------------------------------------------------------------
% %                      (4) Pega as LMI definidas acima.
% % -------------------------------------------------------------------------
% 
% SistemaLMIs = getlmis;
% 
% 
% %% ------------------------------------------------------------------------
% %      (5) Calcula a quantidade de vari�veis a serem encontradas.
% % -------------------------------------------------------------------------
% 
% NumVar = decnbr(SistemaLMIs);  % Quantidade total de vari�veis do sistema.
% c = zeros(NumVar,1);           %   Vetor de zeros.
% 
% %++ ------ Custo ------ +++
% %   J = g1 + g0           +
% % -------------------------
% c(1) = 1;     % 1*g0
% c(1) = 1;     % 1*g1
% 
% % +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++                                     
% % 5.b) Usa-se o 'tic' e o 'toc' para que possamos fazer o c�lculo +
% %      de quanto tempo demora o processo de OTIMIZA��O em cada    +
% %      la�o da simula��o.                                         +
% options = [0 200 0 0 1];      % Trace off                         +
% % tic                                                            
% [Copt, Xopt] = mincx(SistemaLMIs, c, options);                   
% % toc                                                            
% % +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% 
% Ysol  = dec2mat(SistemaLMIs, Xopt, Y);
% Xsol  = dec2mat(SistemaLMIs, Xopt, X);
% g1sol = dec2mat(SistemaLMIs, Xopt, g1);
% c0sol = dec2mat(SistemaLMIs, Xopt, c0);
% 
% 
% %% Determina��o da Matriz F, tal que: u*(k) = F.x(k)
% Kfut = Ysol*inv(Xsol);
% 
% %% Sa�da de Controle.
% uk = K*xk + c0sol; 
% 
% sys =  uk; 
% 
% 
% 
