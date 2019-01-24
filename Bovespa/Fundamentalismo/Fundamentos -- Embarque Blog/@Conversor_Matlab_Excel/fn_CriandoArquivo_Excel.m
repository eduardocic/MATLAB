function [o] = fn_CriandoArquivo_Excel(o)

% 1. Cria um arquivo Excel.
% -------------------------
xlswrite(o.NomeArquivoExcel_Final, o.Aba_1, 1, 'A1');
xlswrite(o.NomeArquivoExcel_Final, o.Aba_2, 2, 'A1');
xlswrite(o.NomeArquivoExcel_Final, o.Aba_3, 3, 'A1');
xlswrite(o.NomeArquivoExcel_Final, o.Aba_4, 4, 'A1');
% xlswrite(o.NomeArquivoExcel_Final, o.Aba_5, 5, 'A1');


% 2. Alterando os nomes das abas do arquivo '.xls' recém gerado.
% --------------------------------------------------------------

% 2.a) Encontrando diretório do arquivo em Excel criado.
nomeDiretorio = strcat(o.raiz,'\');
Total         = strcat(nomeDiretorio, o.NomeArquivoExcel_Final);
xlswrite(o.NomeArquivoExcel_Final,1);

% 2.b) Realizando a efetiva alteração de nomes.
e   = actxserver('Excel.Application');
ewb = e.Workbooks.Open(Total);
ewb.Worksheets.Item(1).Name = 'Composição de Capital';
ewb.Worksheets.Item(2).Name = 'Ativos';
ewb.Worksheets.Item(3).Name = 'Passivos';
ewb.Worksheets.Item(4).Name = 'Dem. Resultados';
% ewb.Worksheets.Item(5).Name = 'Fluxo de Caixa';
ewb.Save;
ewb.Close(false);
e.Quit

end