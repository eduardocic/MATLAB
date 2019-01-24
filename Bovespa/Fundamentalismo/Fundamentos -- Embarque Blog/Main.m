% clear all; close all; clc;

% Pega o local onde est� a ra�z do sistema.
% -----------------------------------------
raiz    = pwd;
clc;
TituloJanela = 'Selecione os arquivos .xls Fundamentos.';
[NomeArquivo_Excel, CaminhoArquivo_Excel, ~] = uigetfile(fullfile(raiz, '*.xls'),...
                                                         'MultiSelect', 'on', ....
                                                         TituloJanela);
                                                     
% Adiciona o caminhos dos arquivos.                                                     
% ----------------------------------
rmpath([CaminhoArquivo_Excel]);
addpath([CaminhoArquivo_Excel]); 


% Verifica se existe UM ou V�RIOS Excel sendo chamados por vez.
% -------------------------------------------------------------
BIT = iscell(NomeArquivo_Excel);
if (BIT == 1)
    flagNumeroArquivos_Excel = size(NomeArquivo_Excel, 2);
else
    flagNumeroArquivos_Excel = 1;
end


% Carrega os arquivos.
% --------------------

% C�lula de carga.
if (flagNumeroArquivos_Excel == 1)
    h = waitbar(0,'Gerando o balan�o trimestral...');
else
    h  = waitbar(0, sprintf('Gerando os balan�os trimestrais... (1 de 1)'));
end

% Realizando efetivamente a carga do arquivo.
if (flagNumeroArquivos_Excel == 1)
    o = LeituraProcessaArquivosExcel(NomeArquivo_Excel);
    waitbar(h);
else
    for i = 1:flagNumeroArquivos_Excel
        waitbar(i/flagNumeroArquivos_Excel, h, sprintf('Gerando os balan�os trimestrais... (%d de %d)', i, flagNumeroArquivos_Excel));
        o(i) = LeituraProcessaArquivosExcel(NomeArquivo_Excel{i});
    end
end
close(h);
