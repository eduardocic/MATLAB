clear all; close all; clc;


load('OpenLoop_Simulink.mat');
load('SimulacaoNaoLinear.mat');

tS        = ans(1,1:end);
VtS       = ans(2,1:end);
alphaS    = ans(3,1:end);
betaS     = ans(4,1:end);
phiS      = ans(5,1:end);
thetaS    = ans(6,1:end);
psiS      = ans(7,1:end);
PS        = ans(8,1:end);
QS        = ans(9,1:end);
RS        = ans(10,1:end);


subplot(5,2,1);
plot(tS, VtS, T, Vt, 'r'); 
xlabel('Tempo (s)');
ylabel('V_t');
legend('Simulink', 'Matlab'); grid;

subplot(5,2,2);
plot(tS, alphaS, T, alpha, 'r'); 
xlabel('Tempo (s)');
ylabel('\alpha');
grid;

subplot(5,2,3);
plot(tS, betaS, T, beta, 'r'); 
xlabel('Tempo (s)');
ylabel('\beta');
grid;

subplot(5,2,4);
plot(tS, phiS, T, phi, 'r'); 
xlabel('Tempo (s)');
ylabel('\phi');
grid;

subplot(5,2,5);
plot(tS, thetaS, T, theta, 'r'); 
xlabel('Tempo (s)');
ylabel('\theta');
grid;

subplot(5,2,6);
plot(tS, psiS, T, psi, 'r');
xlabel('Tempo (s)');
ylabel('\psi');
grid;

subplot(5,2,7);
plot(tS, PS, T, P, 'r'); 
xlabel('Tempo (s)');
ylabel('P');
grid;

subplot(5,2,8);
plot(tS, QS, T, Q, 'r'); 
xlabel('Tempo (s)');
ylabel('Q');
grid;

subplot(5,2,9);
plot(tS, RS, T, R, 'r'); 
xlabel('Tempo (s)');
ylabel('R');
grid;
