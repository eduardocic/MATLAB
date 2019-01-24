clear all; close all; clc;

% Matrizes do sistema (vide página 424). No caso, eu irei reescrever todo o
% sistema de forma que fique transparente para mim o que é realmente de
% interesse (no caso o ângulo 'alpha' e o 'q').
%
% -- Estados 'x': 'alpha' e 'q'; e
% -- Saídas  'y': 'alpha', 'q' e 'nz'.
A = [ -1.01887    0.90506;
        0.8225   -1.07741];
B = [ -0.00215;
      -0.17555];
C = [  57.2988          0;
             0    57.2988;
         16.26    0.9788];
D = [        0;
             0;
      0.04852]; 
  
% Funções de transferência da planta.  
G = minreal(tf(ss(A,B,C,D)));

% Funções de transferências do 'Filtro' e do 'Atuador'.
Gf = tf([10],[1 10]);
Ga = tf([20.2],[1 20.2]);


% Chute inicial das variáveis (pegarei o mesmo do do Lewis -- pág 428).
x0  = [-0.1  -0.1    1    1];

% Opções da função 'fminsearch' de forma a vermos o total do custo.
options = optimset('PlotFcns',@optimplotfval);
Custo   = @(x)Custo_Exemplo(x, G, Ga, Gf);
x       = fminsearch(Custo, x0, options);

% Desembrulhando os termos a serem minimizados -- para facilitar a leitura
% do código.
Ka  = x(1);
Kq  = x(2);
Ke  = x(3);
Ki  = x(4);

% Termos componentes da função de transferência de malha fechada.
g   = tf([1],[1 0]);        % Integrador.
PHI = -Ka*Gf*G(1) - Kq*G(2) + Ke*G(3) + Ki*g*G(3);
PSI = -(Ki*g + Ke);

% Função de malha fechada do sistema -- T(s)
T   = minreal(Ga*PSI*G(3)/(1 - Ga*PHI));
figure; 
step(T); grid;

% Função de transferEncia de malha aberta.
L = -(-Ka*Gf*G(1)*Ga - Kq*G(2)*Ga + Ke*G(3)*Ga + Ki*g*G(3)*Ga);
figure;
bode(L);



