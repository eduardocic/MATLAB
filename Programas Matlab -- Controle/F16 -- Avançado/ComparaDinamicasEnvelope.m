% close all; clear all; clc;
% 
% % Carrega simula��o n�o-linear e linear.
% load('SimulacaoNaoLinearEnvelope_RetoNilevado.mat');
% load('SimulacaoLinearEnvelope_RetoNivelado.mat');
% load('TrimadosRetoNivelado.mat');

% for i = 99:99
    figure;
    flag = 2;
    PlotaComparativo;
    title(['Desempenho da aeronave na trimagem n�mero: ', num2str(flag)]);
% end