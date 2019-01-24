%% 1) Instante Inicial.
close all; clear; clc;


%% Carrega as páginas relativas a simulação.
MainPath = pwd;
Folders = {'Modelo_Turbina'; 'Modelo_Atmosfera'; 'Modelo_6DOF'; 'Modelo_CoeficientesAerodinamicos'};


for i = 1:numel(Folders)
    Pasta = [MainPath '/' Folders{i}];
    rmpath(Pasta);
    addpath(Pasta);
end



%% Seta as condições iniciais.
x = [500 0.5 -0.2 -1 1 -1 0.7 -0.8 0.9 1000 900 10000 90];
Parametro = 0.4;                                            % Xcg
u = [0.9 20 -15 -20 Parametro];
t = 0;

%% Resultado.
Alfa = F16_saida(x, u, t)'
