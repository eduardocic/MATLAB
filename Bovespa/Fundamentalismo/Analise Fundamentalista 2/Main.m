close all; clear all; clc;

% % -------------------------------------------------------------------------
% % (*) A primeira parte do programa selecionará A PASTA a qual tem os
% %     arquivos '*.mat'.
% DiretorioRaiz = uigetdir();
% 
% % -------------------------------------------------------------------------
% % (*) A segunda parte selecionará os arquivos '*.mat' dentro da pasta
% %     selecionada. Essa seleção pode ser múltipla, bastando apenas segurar
% %     o botão CTRL enquanto seleciona os arquivos.
% [Empresa,~,~] = uigetfile(fullfile(DiretorioRaiz, '*.mat'), 'MultiSelect', 'on');
% addpath(DiretorioRaiz); 
% clear DiretorioRaiz;
% 
% % -------------------------------------------------------------------------
% % (*) Definição do sistemas de Cores
% Cor = {'b','g','r','c','m','y','k','b-.','g-.','r-.','c-.','m-.','y-.',...
%        'k-.'};
% 
% % -------------------------------------------------------------------------
% % (*) Verifica a quantidade máxima de empresas selecionadas e já abre o GUI
% %     para a seleção do 'Indicador' desejado e do período levado em conta.
% Empresa = cellstr(Empresa);
% n = max(size(Empresa));
% if (n == 1)
%     Empresa{1} = load(Empresa{1});
% else
%     for i=1:n
%         Empresa{i} = load(Empresa{i});
%     end
% end
% % -------------------------------------------------------------------------
% % (*) Vamos apenas plotar um Indicador
% Legenda = {};
% for i=1:n
%     Empresa{i}.o.plotaIndicador('ROE',Cor{i},'Trimestre');
%     hold on;
%     Legenda{i} = Empresa{i}.o.Nome;
% end
% legend(Legenda);
% clear i;
% 
% % -------------------------------------------------------------------------
% % (*) Lista de Indicadores
% Indicadores = fieldnames(Empresa{1}.o.Indicador);

Compara;


