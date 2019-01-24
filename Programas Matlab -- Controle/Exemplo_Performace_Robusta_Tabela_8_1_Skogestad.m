clear all; close all; clc;

% Planta nominal.
m  = [   87.8 -86.4;
       108.2 -109.6];
Gn = tf([1],[75 1])*m;  

% Controlador.
K = tf([0.7],[1 0])*inv(Gn);

% Peso de incerteza.
wi = tf([1 0.2],[0.5 1]);
Wi = eye(2)*wi;
% Peso para performance.
wp = tf([0.5 0.05],[1 0]);
Wp = eye(2)*wp;

% Alocando a incerteza para a planta completa.
Delta1 = ultidyn('Delta1', [1 1]);
Delta2 = ultidyn('Delta2', [1 1]);
delta  = blkdiag(Delta1, Delta2);
G = Gn*(eye(2) + Wi*delta);

% Identificando entradas e saídas dos sistemas.
G.u = {'u1','u2'};              G.y = {'y1','y2'};
K.u = {'e1','e2'};              K.y = {'u1','u2'};
Wp.u = {'p1', 'p2'};            Wp.y = {'z1','z2'};
sum1 = sumblk('p1 = y1 + w1');
sum2 = sumblk('p2 = y2 + w2');
sum3 = sumblk('e1 = - p1');
sum4 = sumblk('e2 = - p2');

% Sistema em malha fechada.
T = connect(G, K, Wp, sum1, sum2, sum3, sum4, {'w1','w2'},{'z1','z2'});

% Separando as incertezas do sistema.
[N, Delta, BlkStruct] = lftdata(T);

% Análise de estabilidade robusta e performance nominal.
nx = size(Delta, 1);
ny = size(Delta, 2);
N11 = N(1:ny, 1:nx);
N22 = N((ny+1):end, (nx+1):end);

w   = logspace(-3,3,61);
N11_frd = frd(N11, w);
N22_frd = frd(N22, w);

mu_DesempenhoNominal = mussv(N22_frd, BlkStruct, 's');
mu_EstabilidadeRobusta = mussv(N11_frd, BlkStruct, 's');

% Análise do desempenho robusto.
x = size(T,1);
y = size(T,2);
DeltaP = ultidyn('DeltaP', [y x]);
Ffinal = lft(T, DeltaP);

[Nf, DeltaChapeu, BlkStructFinal] = lftdata(Ffinal);
Nf_frd = frd(Nf, w);
mu_DesempenhoRobusto = mussv(Nf_frd, BlkStructFinal, 's');

% Plota o resultado.
semilogx(mu_DesempenhoNominal(:,1), mu_EstabilidadeRobusta(:,1), ...
         mu_DesempenhoRobusto(:,1));
xlabel('Frequência (rad/s)');
ylabel('Valor Singular Estruturado');
legend('Desempenho Nominal', 'Estabilidade Robusta', 'Desempenho Robusto');

% Obtenção das normas.
mu_NP1 = mu_DesempenhoNominal(:,1);
mu_NP2 = mu_DesempenhoNominal(:,2);
mu_RS1 = mu_EstabilidadeRobusta(:,1);
mu_RS2 = mu_EstabilidadeRobusta(:,2);
mu_RP1 = mu_DesempenhoRobusto(:,1);
mu_RP2 = mu_DesempenhoRobusto(:,2);

norm(mu_NP1, inf)
norm(mu_NP2, inf)
norm(mu_RS1, inf)
norm(mu_RS2, inf)
norm(mu_RP1, inf)
norm(mu_RP2, inf)


