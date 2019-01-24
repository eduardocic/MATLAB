% function [SaidaX, SaidaY] = SomaUltimosQuatroTrimestres(o, y)
clear all; close all; clc;
load('TAESA.mat');

% 1.: Verifica a quantidade de anos.
% -----------------------------------
Ano       = o.Data.Ano;
Mes       = o.Data.Mes;
Trimestre = o.Data.TRIMESTRE; 
n         = max(size(Ano));         % Quantos Trimestres disponíveis?


% Cálculo da quantidade de trimestres disponíveis no ano.
% -------------------------------------------------------
AnoInicial = min(Ano);
AnoFinal   = max(Ano);
Indice     = 0;
for i = AnoInicial:AnoFinal
    Indice = Indice + 1;
    QuantidadeTrimestresNoAno(Indice) = sum(Ano(:) == i);
end



% % 2.: Realiza o somatório dos quatro últimos trimestres.
% % ------------------------------------------------------
% contador = 0;
% if (n >= 4)
%     for i = 4:n
%         soma     = 0;
%         contador = contador + 1;
%         for j = i:-1:(i-3)
%             soma = soma + y(j);
%         end
%         SaidaX(contador) = Trimestre(i);
%         SaidaY(contador) = soma;
%     end
% else
%     SaidaX = Trimestre;
%     SaidaY = y;
% end
% % end