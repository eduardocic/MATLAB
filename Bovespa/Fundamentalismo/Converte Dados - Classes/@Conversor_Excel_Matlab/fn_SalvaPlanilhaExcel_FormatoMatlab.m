function [] = fn_SalvaPlanilhaExcel_FormatoMatlab(o, varargin)


% 'Trimestre' e 'ano' do dado.
i = varargin{1};
if (iscell(o.NomeArquivo_Excel))
    tituloTrimestre = strsplit(o.NomeArquivo_Excel{i},'.');
    NomeArquivo = tituloTrimestre{1};
else
    tituloTrimestre = strsplit(o.NomeArquivo_Excel,'.');
    NomeArquivo = tituloTrimestre{1};
end


% Criando um delimitador para o arquivo a ser salvo com o nome da empresa.
File = strcat(o.NomeDaEmpresa, '_');
File = strcat(File, NomeArquivo);
File = strcat(File, '.mat');

% Estruturas de dados a serem salvas.
% estrutura = struct('T1', o.T1, 'T2', o.T2, 'T3', o.T3, 'T4', o.T4, 'T5', o.T5);
estrutura = struct('T1', o.T1, 'T2', o.T2, 'T3', o.T3, 'T4', o.T4);
eval(['o' '=estrutura;']);

% Salva o arquivo.
save(File, 'o');
disp(['Convertendo o arquivo --- ' NomeArquivo ' --- CONVERTIDO!']);

end