% 3. Dia 16/03/2016
%
% (*) Alterações das Tabelas dos resultados 'Individuais' para os
%     'Consolidados'
% -------------------------------------------------------------------------

% raiz = pwd;

Jota = 'Selecione os arquivos *.mat references aos balanços condensado da empresa';
[NomeArquivo, CaminhoArquivo, ~] = uigetfile(fullfile(raiz, '*.mat'), Jota);
rmpath([CaminhoArquivo]);
addpath([CaminhoArquivo]); 

load(NomeArquivo);
[principal, remain] = strtok(NomeArquivo,'_');
NomeArquivo = strcat(principal,'.xls');


% -------------------------------------------------------------------------
%                       MONTANDO A PRIMEIRA TABELA
%
% -------------------------------------------------------------------------
Tabela1_Total;
waitbar(1/10);


% -------------------------------------------------------------------------
%                       MONTANDO A SEGUNDA TABELA
%
% -------------------------------------------------------------------------
Tabela2_Total;
waitbar((2)/10);



% -------------------------------------------------------------------------
%                       MONTANDO A TERCEIRA TABELA
%
% -------------------------------------------------------------------------
Tabela3_Total;
waitbar(4/10);


% -------------------------------------------------------------------------
%                       MONTANDO A QUARTA TABELA
%
% -------------------------------------------------------------------------
Tabela4_Total;
waitbar(5/10);

% -------------------------------------------------------------------------
%                       MONTANDO A QUINTA TABELA
%
% -------------------------------------------------------------------------
Tabela5_Total;
waitbar(6/10);

% -------------------------------------------------------------------------
%                        Cria um arquivo Excel
%
% -------------------------------------------------------------------------
waitbar(7/10);
xlswrite(NomeArquivo, A, 1, 'A1');
waitbar(7.5/10);
xlswrite(NomeArquivo, A2, 2, 'A1');
waitbar(8/10);
xlswrite(NomeArquivo, A3, 3, 'A1');
waitbar(8.5/10);
xlswrite(NomeArquivo, A4, 4, 'A1');
waitbar(9/10);
xlswrite(NomeArquivo, A5, 5, 'A1');
waitbar(9.5/10);
clc;


% -------------------------------------------------------------------------
% (*) Alterando os nomes das abas do arquivo '.xls' recém gerado.
nomeDiretorio = strcat(CaminhoArquivo,'\');
Total = strcat(nomeDiretorio, NomeArquivo);
xlswrite(NomeArquivo,1);

waitbar(9.6/10);
e   = actxserver('Excel.Application');
ewb = e.Workbooks.Open(Total);
ewb.Worksheets.Item(1).Name = 'Composição de Capital';
waitbar(9.7/10);
ewb.Worksheets.Item(2).Name = 'Ativos';
waitbar(9.8/10);
ewb.Worksheets.Item(3).Name = 'Passivos';
waitbar(9.9/10);
ewb.Worksheets.Item(4).Name = 'Dem. Resultados';
ewb.Save;
ewb.Worksheets.Item(5).Name = 'Fluxo de Caixa';
ewb.Save;
ewb.Close(false);
e.Quit
waitbar(10/10);
NomeArquivo_Excel = NomeArquivo;
close(theta);
% A