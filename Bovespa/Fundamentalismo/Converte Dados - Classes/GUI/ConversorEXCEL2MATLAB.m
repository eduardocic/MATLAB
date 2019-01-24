% clear all; close all; clc

% -------------------------------------------------------------------------
% raiz    = pwd;
subRaiz = {'Funções'};

nMax = max(size(subRaiz));
for i = 1:nMax
    rmpath([raiz '\' subRaiz{i,:}]);
    addpath([raiz '\' subRaiz{i,:}]); 
end
% -------------------------------------------------------------------------


% -------------------------------------------------------------------------
% 1.: Seleciona todos os arquivos '.xls' os quais eu gostaria de ler para
%     uma determinada empresa.
Jota = 'Selecione os arquivos .xls references aos balanços trimestrais da empresa obtidos do programa Empresa.net';
[NomeArquivo_Excel, CaminhoArquivo, ~] = uigetfile(fullfile(raiz, '*.xls'), 'MultiSelect', 'on', Jota);
rmpath([CaminhoArquivo]);
addpath([CaminhoArquivo]); 


% -------------------------------------------------------------------------
% 2.: Ler os referidos arquivos e gera o seu respectivo arquivo '.mat'.
NomeArquivo_Excel = cellstr(NomeArquivo_Excel);
n = max(size(NomeArquivo_Excel));

if (n == 1)
    theta  = waitbar(0, sprintf('Gerando o balanço trimestral...', n));
    Empresa{1} = importdata(NomeArquivo_Excel{1});
    Arquivo{1} = fnExcel2Matlab(Empresa{1}, NomeArquivo_Excel{1}, CaminhoArquivo);
    waitbar(1); 
else
    theta  = waitbar(0, sprintf('Gerando os balanços trimestrais...', n));
    for i=1:n
        Empresa{i} = importdata(NomeArquivo_Excel{i});
        Arquivo{i} = fnExcel2Matlab(Empresa{i}, NomeArquivo_Excel{i}, CaminhoArquivo);
        waitbar(i/n); 
    end
end
close(theta);