% =========================================================================
%
% Autor: Eduardo.
% Codigo escrito em 17/03/2015.
% -------------------------------------------------------------------------
% A ideia primordial desse programa é fazer a programação inicial que será
% utilizada no decorrer nas simulações que nao funcionam em tempo real. O
% presente exemplo considera a caracteristica de uma SIMULAÇÃO NÃO LINEAR
% para que se entenda o que realmente ocorre e como fazer as simulações
% subsequentes.
%
% Atualização do código escrito no dia 20/09/2017.
%
% No presente código, existe a aplicação do doublet no instante igual a 1s
% até 2s para a entrada de controle 'ELEVATOR'.
% =========================================================================
close all; clear; clc;


MainPath = pwd;
Folders = {'Turbina'; 'Atmosfera'; 'Modelo'; 'CoeficientesAerodinamicos'};

for i = 1:numel(Folders)
    Pasta = [MainPath '/' Folders{i}];
    rmpath(Pasta);
    addpath(Pasta);
end

DOF6      = 'F16_saida';        % Função 6-DOF.
load('Trimados.mat');           % Valores trimados de equilíbrio para x e u.

tSimulacao = 50;                % Tempo de simulação.
h = 0.01;                       % Passo da simulação.

U{1} = u;                       % Referência inicial para o controle.
X{1} = x;

% Sistema sem controle.
for i = 1:(tSimulacao/h)
    % Entrada 'doublet' no elevator.
    if (i < (1/h))
        U{i} = U{1};
    elseif (i < (1.5/h));
        U{i}      = U{1};
        U{i}(1,2) = U{1}(1,2) + 1;
    elseif (i < (2/h)) 
        U{i}      = U{1};
        U{i}(1,2) = U{1}(1,2) - 1;
    else
        U{i}      = U{1};
    end
    
    % Simulação do sistema linear
    T(i)      = h*i;
    X{i+1}    = RK4(DOF6, T(i), X{i}, U{i}, h); 
    [~, Y{i}] = F16_saida(X{i}, U{i}, T(i));
end

for i = 1:(max(size(X))-1)
   % Estados.
   Vt(i)      = X{i}(1,1);
   alpha(i)   = X{i}(1,2);
   beta(i)    = X{i}(1,3);
   phi(i)     = X{i}(1,4);
   theta(i)   = X{i}(1,5);
   psi(i)     = X{i}(1,6);
   P(i)       = X{i}(1,7);  
   Q(i)       = X{i}(1,8);
   R(i)       = X{i}(1,9);
   Pn(i)      = X{i}(1,10);
   Pe(i)      = X{i}(1,11);
   Pd(i)      = X{i}(1,12);
   
   % Saída.
   an(i)       = Y{i}(1,1);
   al(i)       = Y{i}(1,2);
   
   % Controle.
   manete(i)   = U{i}(1,1);
   elevator(i) = U{i}(1,2);
   aileron(i)  = U{i}(1,3);
   rudder(i)   = U{i}(1,4);
end

save('SimulacaoNaoLinear.mat', 'Vt', 'alpha', 'beta', 'phi', 'theta', 'psi',...
                               'P', 'Q', 'R', 'Pn', 'Pe', 'Pd', ...
                               'an', 'al', ...
                               'manete', 'elevator', 'aileron', 'rudder',...
                               'T');

subplot(5,2,1); 
% Plota o resultado.
plot(T, Vt); grid;
xlabel('Tempo (s)');
ylabel('V_t (m/s)');

subplot(5,2,2); 
plot(T, alpha); grid;
xlabel('Tempo (s)');
ylabel('\alpha (rad)');

subplot(5,2,3); 
plot(T, beta); grid;
xlabel('Tempo (s)');
ylabel('\beta (rad)');

subplot(5,2,4);
plot(T, phi); grid;
xlabel('Tempo (s)');
ylabel('\phi (rad)');

subplot(5,2,5);
plot(T, theta); grid;
xlabel('Tempo (s)');
ylabel('\theta (rad)');

subplot(5,2,6);
plot(T, psi); grid;
xlabel('Tempo (s)');
ylabel('\psi (rad)');

subplot(5,2,7);
plot(T, P); grid;
xlabel('Tempo (s)');
ylabel('P (rad/s)');

subplot(5,2,8);
plot(T, Q); grid;
xlabel('Tempo (s)');
ylabel('Q (rad/s)');

subplot(5,2,9);
plot(T, R); grid;
xlabel('Tempo (s)');
ylabel('R (rad/s)');

% Plota o controle.
figure;
subplot(2,2,1);
plot(T, manete); grid;
xlabel('Tempo (s)');
ylabel('Manete');

subplot(2,2,2);
plot(T, elevator); grid;
xlabel('Tempo (s)');
ylabel('Elevator');

subplot(2,2,3);
plot(T, manete); grid;
xlabel('Tempo (s)');
ylabel('Aileron');

subplot(2,2,4);
plot(T, manete); grid;
xlabel('Tempo (s)');
ylabel('Rudder');


