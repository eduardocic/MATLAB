close all; clear all; clc;

% Parâmetros incertos do sistema Massa-Mola.
m = ureal('m', 3, 'Percentage', [-40, 40]);
c = ureal('c', 1, 'Range', [0.8, 1.2]);
k = ureal('k', 2, 'PlusMinus', [-0.6, 0.6]);


% Criação do sistema via ESPAÇO DE ESTADOS e por FUNÇÂO DE TRANSFERÊNCIA.
% -----------------------------------------------------------------------
A = [     0    1
        -k/m  -c/m];
B = [0   1/m]';
C = [1 0];
D = 0;

uss1 = ss(A,B,C,D);             % Sistema incerto -- 1.
% uss2 = tf(1,[m c k]);           % Sistema incerto -- 2.
% 
% 
% % Comando 'usample'.
% uss = usample(uss1, 20);
% 
% % Ajuste de frequência com plot de Bode.
% w = logspace(-1,1,200);
% figure(1);
% bode(uss, w);
% title('Bode plot of uncertain system');
% grid;
% % plot de resposta temporal.
% figure(2);
% step(uss), grid;
% % plot de resposta em Nyquist.
% figure(3);
% nyquist(uss), grid;
% 

% Decomposição de objetos incertos -- representação LFT.
% ------------------------------------------------------
[Gnom, Delta, Blkstruct, Normunc] = lftdata(uss1);


% % Criando interconecções incertas.
% % --------------------------------
% u    = icsignal(1);
% x    = icsignal(1);
% xdot = icsignal(1);
% 
% SYS  = iconnect;
% SYS.Input  = u;
% SYS.Output = x;
% SYS.Equation{1} = equate(x, tf(1,[1,0])*xdot);
% SYS.Equation{2} = equate(xdot, tf(1,[m,0])*(u-k*x-c*xdot));
% get(SYS);

% Planta perturbada.
% ------------------
G = lft(Gnom, Delta);
G = minreal(tf(uss1.NominalValue));

% Peso para performance.
wP     = tf(0.95*[1 1.8 10],[1 8 0.01]);
% Peso para o controle.
wU     = tf(10^-2,1);

% Criando a estrutura generalizada.
systemnames = 'G wP wU';
inputvar    = '[r(1); d(1); u(1)]';
input_to_G  = '[u]';
input_to_wP = '[G + d]';
input_to_wU = '[u]';
outputvar   = '[wP; -wU; r-G-d]';
sysoutname  = 'P';
cleanupsysic = 'yes';
sysic;


% Achando um controlador H-infinito
nmeas  = 1;     % número de variáveis medidas.
ncon   = 1;     % número de variáveis de controle.
gmin   = 1;
gmax   = 10;
tol    = 0.001;
hin_ic = sel(P, 1:2, 1:2);
% [K_hin, clp] = hinfsyn(hin_ic, nmeas, ncon, 'GMIN', gmin, 'GMAX', gmax, 'TOLGAM', tol, 'DISPLAY', 'on')
[K_hin, clp] = hinfsyn(P, nmeas, ncon,'GMIN', gmin, 'GMAX', gmax, 'TOLGAM', tol, 'DISPLAY', 'on')


% systemnames = 'G';
% inputvar    = '[d(1); r(1); n(1); u(1)]';
% input_to_G  = '[u]';
% outputvar   = '[G+d-r; r-G-d-n]';
% sysoutname  = 'P';
% sysic;