close all; clear all; clc;

% % -------------------------------------------------------------------------
% % (*) A primeira parte do programa selecionar� A PASTA a qual tem os
% %     arquivos '*.mat'.
% DiretorioRaiz = uigetdir();
% 
% % -------------------------------------------------------------------------
% % (*) A segunda parte selecionar� os arquivos '*.mat' dentro da pasta
% %     selecionada. Essa sele��o pode ser m�ltipla, bastando apenas segurar
% %     o bot�o CTRL enquanto seleciona os arquivos.
% [Empresa,~,~] = uigetfile(fullfile(DiretorioRaiz, '*.mat'), 'MultiSelect', 'on');
% addpath(DiretorioRaiz); 
% clear DiretorioRaiz;
% 
% % -------------------------------------------------------------------------
% % (*) Defini��o do sistemas de Cores
% Cor = {'b','g','r','c','m','y','k','b-.','g-.','r-.','c-.','m-.','y-.',...
%        'k-.'};
% 
% % -------------------------------------------------------------------------
% % (*) Verifica a quantidade m�xima de empresas selecionadas e j� abre o GUI
% %     para a sele��o do 'Indicador' desejado e do per�odo levado em conta.
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


