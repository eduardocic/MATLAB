function [o] = fnSalva(o)

% Criando um delimitador para o arquivo a ser salvo com o nome da empresa.
File = strcat(o.NomeEmpresa, '.mat');

% Estruturas de dados a serem salvas.
estrutura = struct('Empresa', o.NomeEmpresa,...
                   'DatasTexto', o.DatasTexto,...
                   'Ativos', o.Ativos,...
                   'Passivos', o.Passivos,...
                   'DemResultados', o.DemResultados, ...
                   'Data', o.Data, ...
                   'Indicador', o.Indicador);
eval(['o' '=estrutura;']);
% Salva o arquivo.
save(File, 'o');

end