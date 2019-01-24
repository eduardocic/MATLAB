close all; clear all; clc;

% Função de transferência do sistema nominal -- Gnom(s).
g11 = tf([6], conv([0.9 1],[0.1 1]));
g12 = tf([-0.05], [0.1 1]);
g21 = tf([0.07], [0.3 1]);
g22 = tf([5], conv([1.8 -1],[0.06 1]));
Gnom = [ g11  g12;
         g21  g22];    
sigma(Gnom); grid; legend('\sigma(G)');     

% Cálculo do RGA     
omega = logspace(-5,2,61);          % range de 10^-5 a 10^2 Hz.
for i=1:length(omega)
   Gf = freqresp(Gnom, omega(i));
   RGAw{i} = Gf.*inv(Gf).';
   a11(i)  = real(RGAw{i}(1,1));
   a12(i)  = real(RGAw{i}(1,2));
   a21(i)  = real(RGAw{i}(2,1));
   a22(i)  = real(RGAw{i}(2,2));
end

% Plota os elementos da matriz RGA.
figure;
subplot(2,2,1)
semilogx(omega, a11, 'LineWidth', 2);   grid;
xlim([min(omega) max(omega)]);          ylim([-0.5 1.5]);
xlabel('Frequência (rad/s)');           ylabel('real(\lambda_{11})');

subplot(2,2,2)
semilogx(omega, a12, 'LineWidth', 2);   grid;
xlim([min(omega) max(omega)]);          ylim([-0.5 1.5]);
xlabel('Frequência (rad/s)');           ylabel('real(\lambda_{12})');

subplot(2,2,3)
semilogx(omega, a21, 'LineWidth', 2);   grid;
xlim([min(omega) max(omega)]);          ylim([-0.5 1.5]);
xlabel('Frequência (rad/s)');           ylabel('real(\lambda_{21})');

subplot(2,2,4)          
semilogx(omega, a22, 'LineWidth', 2);   grid;
xlim([min(omega) max(omega)]);          ylim([-0.5 1.5]);
xlabel('Frequência (rad/s)');           ylabel('real(\lambda_{22})');

% Erro nas entradas do sistema.
W1 = makeweight(0.20, 35, 10);
W2 = makeweight(0.25, 40, 10);

% Incerteza multiplicativa 
Delta1 = ultidyn('Delta1',[1 1]);   % Incerteza na entrada 1.
Delta2 = ultidyn('Delta2',[1 1]);   % Incerteza na entrada 2.
W      = blkdiag(W1,W2);            % Bloco diagonal de incertezas.
Delta  = blkdiag(Delta1,Delta2);    % Bloco diagonal de erros.
G      = Gnom*(eye(2) + Delta*W);   % Planta do sistema incerto.

% Controlador para teste -- 'K'.
k11 = tf(2*[1 1],[1 0]);
k12 = tf(-1*[1 0],[3 1]);
k21 = tf(-5*[1 1],[0.8 1]);
k22 = tf(4*[0.7 1],[1 0]);
K   = [ k11  k12;
        k21  k22];

% Fechando o loop.
G.u = {'u1', 'u2'};          G.y = {'y1','y2'};
K.u = {'erro1','erro2'};     K.y = {'u1','u2'};
sum1 = sumblk('erro1 = ref1 - y1');
sum2 = sumblk('erro2 = ref2 - y2');
ClosedLoop = connect(G, K, sum1, sum2, {'ref1', 'ref2'},{'y1','y2'});

% Análise de margem de estabilidade.
opt = robopt('Display','on');
[MargemEst, DeltasDesestabilizantes, Report, info] = robuststab(ClosedLoop, opt);

% Análise do valor singular estruturado.
figure;
semilogx(info.MussvBnds(1,1),'r-',info.MussvBnds(1,2),'b--')
grid;
title('Robust stability')
xlabel('Frequency (rad/s)')
ylabel('\mu')
legend('\mu-upper bound','\mu-lower bound',2)

% Resposta do sistema em malha ao controlador escolhido.
figure;
step(ClosedLoop);
grid;

% =========================================================================
% Análise pelo valor singular estruturado.
% ----------------------------------------
[N, Delta, BlkStruct] = lftdata(ClosedLoop);

% Pegando o termo M = N11.
tamDelta = size(Delta);
nx = tamDelta(1);
ny = tamDelta(2);
M  = N(1:ny, 1:nx);

% Calcula a respota em frequência de M = N11.
omega = logspace(-1,2,50);
M_g = frd(M, omega);

% Computa os limites Máximos e Mínimos do Valor Singular Estruturado da
% estrutura generalizadas 'M' com incertezas descritas por 'BlcStruct'.
muLimites = mussv(M_g, BlkStruct, 's');

% Plota o resultado do sistema.
opt = bodeoptions;
opt.PhaseVisible = 'off'; opt.XLim = [1e-1 1e2]; opt.MagUnits = 'abs';
bodeplot(muLimites(1,1), muLimites(1,2), opt);
xlabel('Frequência (rad/sec)');
ylabel('Mu upper/lower bounds');
title('Mu plot of robust stability margins (inverted scale)');

% Analisando as margens de estabilidade.
[pkl,wPeakLow] = getPeakGain(muLimites(1,2));
[pku]          = getPeakGain(muLimites(1,1));
SMfromMU.LowerBound = 1/pku;
SMfromMU.UpperBound = 1/pkl;
SMfromMU.CriticalFrequency = wPeakLow;
SMfromMU


sigma(M); 
xlabel('Frequência (rad/s)');
ylabel('\sigma(M)');
title('Valores singulares da estrutura ''M''');
grid;
