clear all; close all; clc;

% Carrega as matrizes 'A' e 'B'.
% ------------------------------
load('MatrizesDeEstado.mat');
A = A(1:12,1:12);
B = B(1:12, 2:end);
C = eye(max(size(A)));      
D = zeros(12,3);

tTotal = 50;
t = linspace(0, tTotal, tTotal*100);            % 20s ao total.

% Doublet em elevator.
% --------------------
u11 = linspace(0,0,100);
u12 = linspace(1,1,50);
u13 = linspace(-1,-1,50);
u14 = linspace(0,0,max(size(t)) - 200);
u1 = [u11 u12 u13 u14];
u2 = 0*u1;
u3 = 0*u1;

% Sistema.
% --------
sys = ss(A,B,C,D);

% Simulação linear.
Y = lsim(sys, [u1' u2' u3'], t);

% Salva o Resultado.
% ------------------
save('SimulacaoLinear.mat', 'Y', 't');


subplot(5,2,1); 
% Plota o resultado.
plot(t, Y(:,1)); grid;
xlabel('tempo (s)');
ylabel('V_t (m/s)');

subplot(5,2,2); 
plot(t, Y(:,2)); grid;
xlabel('tempo (s)');
ylabel('\alpha (rad)');

subplot(5,2,3); 
plot(t, Y(:,3)); grid;
xlabel('tempo (s)');
ylabel('\beta (rad)');

subplot(5,2,4);
plot(t, Y(:,4)); grid;
xlabel('tempo (s)');
ylabel('\phi (rad)');

subplot(5,2,5);
plot(t, Y(:,5)); grid;
xlabel('tempo (s)');
ylabel('\theta (rad)');

subplot(5,2,6);
plot(t, Y(:,6)); grid;
xlabel('tempo (s)');
ylabel('\psi (rad)');

subplot(5,2,7);
plot(t, Y(:,7)); grid;
xlabel('tempo (s)');
ylabel('P (rad/s)');

subplot(5,2,8);
plot(t, Y(:,8)); grid;
xlabel('tempo (s)');
ylabel('Q (rad/s)');

subplot(5,2,9);
plot(t, Y(:,9)); grid;
xlabel('tempo (s)');
ylabel('R (rad/s)');


