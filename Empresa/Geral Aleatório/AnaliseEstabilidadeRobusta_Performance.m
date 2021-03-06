close all; clear all; clc;

% An�lise de estabilidade robusta e performance
% ---------------------------------------------

% Fun��o de transfer�ncia.
g11 = tf([6], conv([0.9 1],[0.1 1]));
g12 = tf([-0.05], [0.1 1]);
g21 = tf([0.07], [0.3 1]);
g22 = tf([5], conv([1.8 -1],[0.06 1]));
Gnom = [ g11  g12;
         g21  g22];
    
% Erro nas entradas do sistema.
W1 = makeweight(0.20, 35, 10);
W2 = makeweight(0.25, 40, 10);

bodemag(W1, 'b--', W2, 'r--');
grid;
legend('W_1', 'W_2');

% Incerteza multiplicativa.
Delta1 = ultidyn('Delta1',[1 1]);
Delta2 = ultidyn('Delta2',[1 1]);
W      = blkdiag(W1,W2);            % Bloco diagonal de incertezas.
Delta  = blkdiag(Delta1,Delta2);    % Bloco diagonal de erros.
G      = Gnom*(eye(2) + Delta*W);   % Planta do sistema incerto.

% Controlador para teste -- K.
k11 = tf(2*[1 1],[1 0]);
k12 = tf(-1*[1 0],[3 1]);
k21 = tf(-5*[1 1],[0.8 1]);
k22 = tf(4*[0.7 1],[1 0]);
K   = [ k11  k12;
        k21  k22];
    
% % Para este controlador, ser� realizada a an�lise de estabilidade de malha
% % fechada do sistema.
% looptransfer = loopsens(G,K);
% Ti = looptransfer.Ti;
% [PeakNorm, freq] = norm(W*Ti.Nominal, 'inf')
% 
% % Pelo valor encontrado da normal do sistema W*Ti (um valor acima de 1),
% % sabe-se que pelo teorema do ganho pequeno o sistema N�O � robustamente
% % est�vel. No entanto, a matriz 'Delta' tem uma estrutura diagonal, o que
% % afeta e muito a robustez do sistema em malha fechada. Essa an�lise de
% % estabilidade ser� agora realizada utilizando-se a fun��o 'robuststab' com
% % um argumento de intreda incerto correspondendo � Fun��o sensitividade
% % complementar para a sa�da.
% To = looptransfer.To;
% omega = logspace(-1,2,200);
% To_g  = ufrd(To, omega);
% opt   = robopt('Display', 'on');
% [stabmarg, destabunc, report, info] = robuststab(To_g,opt)
% 
% % OBS1: Pela an�lise utilizando a fun��o 'robuststab' tem-se que o sistema
% % � est�vel. Isso confirma o fato de que se negligenciarmos a estrutura da
% % incerteza no nosso sistema, podemos chegar a conclus�es pessimistas a
% % respeito da estabilidade do sistema.
% 
% 
% semilogx(info.MussvBnds(1,1),'r-',info.MussvBnds(1,2), 'b--')
% grid
% title('Robust stability')
% xlabel('Frequency (rad/s)')
% ylabel('mu')
% legend('\mu-upper bound','\mu-lower bound',2)
% 
% 
% 
% % Consideremos agora a an�lise de estabilidade robusta do sistema
% % utilizando a fun��o 'mussv'. Para essa an�lise, tem-se que � necess�rio
% % decompor a 'To' em um bloco da forma 'M-Delta'.
% [M, Delta, BlockStructure] = lftdata(To);
% 
% % Pegando apenas o M11.
% size_Delta = size(Delta);
% M11 = M(1:size_Delta(2),1:size_Delta(1));
% omega = info.Frequency;
% 
% M11_g = frd(M11,omega);
% rbounds = mussv(M11_g, BlockStructure);
