close all; clear; clc;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
MainPath = 'C:\Users\Eduardo\Documents\MATLAB\Mestrado\Simulações\Kothare Schuurmans Diversos';
Modulos = {'(1)Inicialization';'(2)Functions';'(3)LMI'};

Tamanho = max(size(Modulos));

for i=1:Tamanho
    rmpath([MainPath '\' Modulos{i,:}]);
    addpath([MainPath '\' Modulos{i,:}]);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% 1) Matrizes de Estado
SteadyStateMatrix;

%% 2) Carrega Variveis Diversas e xk0
Constraints;



N = 150000;

x{1} = xk0;

for i=1:N
   uk = Matlab_Xss_Com_Restricao(x{i}, A, B, H, Umax, rho);
   u{i} = uk;
   x{i+1}  = A1*x{i} + B1*u{i};
   
   % Colocar um marcador para saber quando falta aqui.
   
end

X  = cell2mat(x);
U  = cell2mat(u);
x1 = X(1,1:end);
stairs(x1);