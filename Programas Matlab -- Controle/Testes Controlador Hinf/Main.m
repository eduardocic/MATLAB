%% Início de tudo.
clear all; close all; clc;
    
SISTEMA = 'SYS';
x{1}    = zeros(4,1);
xc{1}   = x{1};

% Ganhos controlador
kp = -29.6319;
kd = -10.0600;

h = 0.01;

% Inicializando a variável de controle.
uc(1) = 0;

% Sistema sem controle.
for i = 1:2000
    
    % Entrada 'doublet'
    if (i < 100)
        u(i) = 0;
    elseif (i < 200);
        u(i) = 1;
    elseif (i < 300) 
        u(i) = -1;
    else
        u(i) = 0;
    end
    
    % Simulação do sistema linear
    t(i)     = h*i;
    x{i+1}   = RK4(SISTEMA, 0, h, x{i}, u(i));
    
    % Saída do sistema -- Sem Controle.
    theta(i) = [0 0 57.296 0]*x{i+1};
    q(i)     = [0 0 0 57.296]*x{i+1};
    
    
    % Sistema Com Controle.
    xc{i+1}    = RK4(SISTEMA, 0, h, xc{i}, uc(i));
    theta_c(i) = [0 0 57.296 0]*xc{i+1};
    q_c(i)     = [0 0 0 57.296]*xc{i+1};
    uc(i+1)    = (u(i)-theta_c(i))*kp - kd*q_c(i);
end
uc = uc(1:end-1);

% Acompanhamento da referência.
figure
plot(t, theta_c); hold on;
plot(t, u, 'r');
title('Com Controle');
legend('\theta', '\theta_{ref}');
axis([0 20 -2 2]);
xlabel('Tempo (s)');
ylabel('Medida de \theta');

% Valor do control
figure;
plot(t, uc);
axis([0 20 -2 2]);
title('Esforço de controle u(t)');
xlabel('Tempo (s)');
ylabel('Em graus.');

% Segunda parte: análise no domínio da frequência.
A = [-1.9311e-02  8.8157e+00  -3.2170e+01  -5.7499e-01;
     -2.5389e-04 -1.0189e+00   0.0000e+00   9.0506e-01;
      0.0000e+00  0.0000e+00   0.0000e+00   1.0000e+00;
      2.9465e-12  8.2225e-01   0.0000e+00  -1.0774e+00];

% u = [elevator]
B = [ 1.7370e-01;
     -2.1499e-03;
      0.0000e+00;
     -1.7555e-01];
 
% C = [0 0 180/pi 0;
%      0 0 0 180/pi];
% D = [0; 0];

C1 = [0 0 180/pi 0];
C2 = [0 0 0 180/pi];
D  = [0];

[num1, den1] = ss2tf(A,B,C1,D);
[num2, den2] = ss2tf(A,B,C2,D);
G(1) = tf(num1, den1);
G(2) = tf(num2, den2);
G = minreal(G);


% L(s) malha aberta na entrada do atuador.
y  = -kp*G(1)-kd*G(2);
Ls = -y;                % L(s) = -y/u
Ls = minreal(Ls);
[magnitude, phase] = bode(Ls, {10^-3,10^3});

% Reposta de Nichols.
for i=1:max(size(magnitude))
   mag(i)  = magnitude(:,:,i);
   fase(i) = phase(:,:,i);
end
plot(fase, 20*log10(mag), 'LineWidth', 2); 
grid; hold on; 
plotaNicholsLimites(6);
legend('Sistema Compensado', 'Região a evitar -- 6dB');

