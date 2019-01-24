% =========================================================================
%
% Autor: Eduardo.
% Codigo escrito em 05/10/2017.
%
% =========================================================================
close all; clear; clc;


MainPath = pwd;
Folders = {'Turbina'; 'Atmosfera'; 'Modelo'; 'CoeficientesAerodinamicos'};

for k = 1:numel(Folders)
    Pasta = [MainPath '/' Folders{k}];
    rmpath(Pasta);
    addpath(Pasta);
end

DOF6      = 'F16_saida';              % Função 6-DOF.
load('TrimadosRetoNivelado.mat');     % Valores trimados de equilíbrio para x e u.

tSimulacao = 10;                      % Tempo de simulação.
h = 0.01;                             % Passo da simulação.


cont = max(size(X));

for i = 1:cont
    
    u{1} = U{i};                       
    x{1} = X{i};
    
    for k = 1:(tSimulacao/h)
        % Entrada 'doublet' no elevator.
        if (k < (1/h))
            u{k} = u{1};
        elseif (k < (1.5/h));
            u{k}      = u{1};
            u{k}(1,2) = u{1}(1,2) + 1;
        elseif (k < (2/h)) 
            u{k}      = u{1};
            u{k}(1,2) = u{1}(1,2) - 1;
        else
            u{k}      = u{1};
        end

        % Simulação do sistema não-linear
        t_nl(k)   = h*(k-1);
        x{k+1}    = RK4(DOF6, t_nl(k), x{k}, u{k}, h); 
        [~, y{k}] = F16_saida(x{k}, u{k}, t_nl(k));
    end
    
    X_nl{i} = x;
    U_nl{i} = u;
    Y_nl{i} = y;
    
    disp(['Realizou a simulação no sistema ', num2str(i)]);
end

save('SimulacaoNaoLinearEnvelope_RetoNilevado.mat', 't_nl', 'X_nl', 'U_nl', 'Y_nl');
                               