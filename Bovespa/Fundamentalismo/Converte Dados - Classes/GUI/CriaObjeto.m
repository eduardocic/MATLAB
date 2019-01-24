clear all; close all; clc;

% -------------------------------------------------------------------------
%                          Inclusão das Funções
% -------------------------------------------------------------------------
raiz    = pwd;
subRaiz = {'Funções'};

nMax = max(size(subRaiz));
for i = 1:nMax
    rmpath([raiz '\' subRaiz{i,:}]);
    addpath([raiz '\' subRaiz{i,:}]); 
end
clc;
% -------------------------------------------------------------------------
%                       Inclusão das Planilhas .xls
% -------------------------------------------------------------------------
TEXTO = 'Selecione os arquivos .xls com o balanço condensado da empresa';
[NomeArquivo_Excel, CaminhoArquivo, ~] = uigetfile(fullfile(raiz, '*.xls'), TEXTO);
rmpath([CaminhoArquivo]);
addpath([CaminhoArquivo]); 

NomeArquivo = NomeArquivo_Excel;
file = importdata(NomeArquivo);

AbaVelho = fieldnames(file.textdata);
[NomeArquivo_Matlab, remain] = strtok(NomeArquivo_Excel,'.');
% 3.: As abas do Excel carregadas pela função 'uigetfile' inserem caracteres
%     que não são válidos no ambiente Matlab. No caso, eles são carregados
%     como hexadecimal. De forma a corrigir estes nomes de forma a ter menos
%     trabalho de identificação de qual arquivo estamos trabalhando, serão,
%     num primeiro momento, corrigido quaisquer problemas de migração de
%     dados. No caso, serão inseridos os dados sem cedinha ou acentos.
aspa = '';
Hexa2String = {'0xE7', 'c';
               '0xE3', 'a';
               '0x2E',  '';
               '0x2D',  '';
               '0xED', 'i';};
QuantAbas   = max(size(AbaVelho));
for i=1:QuantAbas
    AbaVelho{i} = strcat(aspa, AbaVelho{i});
    AbaVelho{i} = strcat(AbaVelho{i}, aspa);
    AbaNovo{i}  = AbaVelho{i};
    for j=1:max(size(Hexa2String))
        AbaNovo{i} = regexprep(AbaNovo{i}, Hexa2String{j,1}, Hexa2String{j,2});
    end
end

% 4.: Reescreve as abas internas da substruct 'data' quanto de 'textdata' 
%     do arquivo 'file'.
for i=1:QuantAbas
    % 4.1.: Corrige os parâmetros de 'data'.
    if (isfield(file.data, AbaVelho{i}))
        [file.data.(AbaNovo{i})] = file.data.(AbaVelho{i});
    end
    
    if (isfield(file.textdata, AbaVelho{i}))
    % 4.2.: Corrige os parâmetros de 'textdata'.
        [file.textdata.(AbaNovo{i})] = file.textdata.(AbaVelho{i});
    end
end


% Lendo os arquivos.
% ------------------
cellDatas           = file.textdata.ComposicaoDeCapital(1,2:end);
ComposicaoDeCapital = file.data.ComposicaoDeCapital;  
Ativos              = file.data.Ativos;
Passivos            = file.data.Passivos;
DemResultados       = file.data.DemResultados;
% Corta apenas os valores positivos.
Ativos   = Ativos(:,3:end);
Passivos = Passivos(:,3:end);

% Quantos balanços trimestrais eu tenho?
% --------------------------------------
n1 = size(ComposicaoDeCapital,1);        % Variáveis totais Tabela-1.      
n2 = size(Ativos,1);                     % Variáveis totais Tabela-2.      
n3 = size(Passivos,1);                   % Variáveis totais Tabela-3.      
n4 = size(DemResultados,1);              % Variáveis totais Tabela-4.      
m  = size(cellDatas,2);                  % Quantos balanços trimestrais existem?

% Deixando os balanços em ordem crescente de data.
% ------------------------------------------------
% Tabela 1.
for i=2:n1
    Temp = ComposicaoDeCapital(i,2:end);
    Temp = wrev(Temp);
    if (i == 2)
        for j=1:m
            QuantAcoes(1,j)             = Temp(1,j);
        end
    end
    if(i == 3)
        for j=1:m
            totalAcoesEmTesouraria(1,j) = Temp(1,j);
        end
    end
end

% Tabela 2.
for i=1:n2
    Temp = Ativos(i,1:end);
    Temp = wrev(Temp);
    for j=1:m
        Ativos(i,j) = Temp(1,j);
    end
end

% Tabela 3.
for i=1:n3
    Temp = Passivos(i,1:end);
    Temp = wrev(Temp);
    for j=1:m
        Passivos(i,j) = Temp(1,j);
    end
end

% Tabela 4.
for i=1:n4
    Temp = DemResultados(i,1:end);
    Temp = wrev(Temp);
    for j=1:m
        DemonstracaoResultado(i,j) = Temp(1,j);
    end
end


% Convertendo datas.
for i=1:m
    numData(i) = datenum(cellDatas{i}, 'dd/mm/yyyy');
end
Data = wrev(numData); 

% -------------------------------------------------------------------------
%                           Dados Tabela 2
%
% -------------------------------------------------------------------------
Tabela1.AtivoTotal                       = Ativos(1,1:end);
Tabela1.AtivoCirculante                  = Ativos(2,1:end);
Tabela1.CaixaEEquivalenteDeCaixa         = Ativos(3,1:end);
Tabela1.AplicacoesFinanceiras            = Ativos(4,1:end);
Tabela1.ContasAReceber                   = Ativos(5,1:end);
Tabela1.Estoques                         = Ativos(6,1:end);
Tabela1.AtivosBiologicos                 = Ativos(7,1:end);
Tabela1.TributosARecuperar               = Ativos(8,1:end);
Tabela1.DespesasAntecipadas              = Ativos(9,1:end);
Tabela1.OutrosAtivosCirculantes          = Ativos(10,1:end);
Tabela1.AtivoNaoCirculantes              = Ativos(11,1:end);
Tabela1.AtivoRealizavelALongoPrazo       = Ativos(12,1:end);
Tabela1.Investimentos                    = Ativos(13,1:end);
Tabela1.Imobilizado                      = Ativos(14,1:end);
Tabela1.Intangivel                       = Ativos(15,1:end);
Tabela1.Diferido                         = Ativos(15,1:end);


% -------------------------------------------------------------------------
%                           Dados Tabela 3
%
% -------------------------------------------------------------------------
Tabela2.PassivoTotal                     = Passivos(1,1:end);
Tabela2.PassivoCirculante                = Passivos(2,1:end);
Tabela2.ObrigacoesSociaisETrabalhitas    = Passivos(3,1:end);
Tabela2.Fornecedores                     = Passivos(4,1:end);
Tabela2.ObrigacoesFiscais                = Passivos(5,1:end);
Tabela2.EmprestimosEFinanciamentos       = Passivos(6,1:end);
Tabela2.OutrasObrigacoes                 = Passivos(7,1:end);
Tabela2.DividendosEJCPAPagar             = Passivos(8,1:end);
Tabela2.Provisoes                        = Passivos(9,1:end);
Tabela2.PassivosSobreAtivosNaoCorrentesAVendaEDescontinuados = Passivos(10,1:end);
Tabela2.PassivoNaoCirculante             = Passivos(11,1:end);
Tabela2.EmprestimosEFinanciamentos2      = Passivos(12,1:end);
Tabela2.OutrasObrigacoes2                = Passivos(13,1:end);
Tabela2.TributosDiferidos                = Passivos(14,1:end);
Tabela2.Provisoes2                       = Passivos(15,1:end);
Tabela2.PassivosSobreAtivosNaoCorrentesAVendaEDescontinuados2 = Passivos(16,1:end);
Tabela2.LucroEReceitasAApropriar         = Passivos(17,1:end);
Tabela2.PatrimonioLiquido                = Passivos(18,1:end);
Tabela2.CapitalSocialRealizado           = Passivos(19,1:end);
Tabela2.ReservasDeCapital                = Passivos(20,1:end);
Tabela2.ReservasDeReavaliacao            = Passivos(21,1:end);
Tabela2.ReservasDeLucros                 = Passivos(22,1:end);
Tabela2.LucrosPrejuizosAcumulados        = Passivos(23,1:end);
Tabela2.AjustesDeAvaliacaoPatrimonial    = Passivos(24,1:end);
Tabela2.AjustesAcumuladosDeConversao     = Passivos(25,1:end);
Tabela2.OutrosResultadosAbrangentes      = Passivos(26,1:end);

% -------------------------------------------------------------------------
%                           Dados Tabela 4
%
% -------------------------------------------------------------------------
Tabela3.ReceitaDeVendaDeBensEOUServicos                        = DemonstracaoResultado(1,1:end);
Tabela3.CustoDosBensEOUServicosVendidos                        = DemonstracaoResultado(2,1:end);
Tabela3.ResultadoBruto                                         = DemonstracaoResultado(3,1:end);
Tabela3.DespesasReceitasOperacionais                           = DemonstracaoResultado(4,1:end);
Tabela3.DespesasComVendas                                      = DemonstracaoResultado(5,1:end);
Tabela3.DespesasGeraisEAdministrativas                         = DemonstracaoResultado(6,1:end);
Tabela3.ResultadoAntesDoResultadoFinanceiroEDOSTributos        = DemonstracaoResultado(7,1:end);
Tabela3.ResultadoFinanceiro                                    = DemonstracaoResultado(8,1:end);
Tabela3.ResultadoAntesDosTributosSobreOLucro                   = DemonstracaoResultado(9,1:end);
Tabela3.ImpostoDeRendaEContribuicaoSocialSobreOLucro           = DemonstracaoResultado(10,1:end);
Tabela3.ResultadoLiquidoDasOperacoesContinuadas                = DemonstracaoResultado(11,1:end);
Tabela3.ResultadoLiquidoDeOperacoesDescontinuadas              = DemonstracaoResultado(12,1:end);
Tabela3.LucroPrejuizoDoPeriodo                                 = DemonstracaoResultado(13,1:end);
Tabela3.AtribuidoASociosDaEmpresaControladora                  = DemonstracaoResultado(14,1:end);
Tabela3.AtribuidoASociosNaoControladora                        = DemonstracaoResultado(15,1:end);

% -------------------------------------------------------------------------
%                 NomeArquivo_Excel      Salvando os Dados da Empresa.
% -------------------------------------------------------------------------
% Concatena nome da Empresa.
Empresa = strtok(NomeArquivo_Excel,'.');
Empresa = upper(Empresa);
EmpresaBRUTO = strcat(Empresa, '_BRUTO');

% Datas dos balanços.
estrutura  = struct('Data', Data, 'QuantAcoes', QuantAcoes,...
                    'AcoesTesouraria',totalAcoesEmTesouraria,...
                    'T1', Tabela1, 'T2', Tabela2, 'T3', Tabela3,...
                    'Empresa', Empresa);
eval([EmpresaBRUTO '=estrutura;']);
FileNameSaveBRUTO = strcat(EmpresaBRUTO, '.mat');
% save(FileNameSaveBRUTO, EmpresaBRUTO);

o        = ClasseInd(estrutura);
FileName = strcat(Empresa,'.mat');
save(FileName,'o');








