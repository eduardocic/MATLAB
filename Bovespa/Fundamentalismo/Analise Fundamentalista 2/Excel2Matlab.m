clear; close all; clc;

% -------------------------------------------------------------------------
%                          Inclusão das Funções
% -------------------------------------------------------------------------
raiz    = pwd;
subRaiz = {'Funções'; 'Excel'};

nMax = max(size(subRaiz));
for i = 1:nMax
    rmpath([raiz '\' subRaiz{i,:}]);
    addpath([raiz '\' subRaiz{i,:}]); 
end
clc;
% -------------------------------------------------------------------------
%                       Inclusão das Planilhas .xls
% -------------------------------------------------------------------------

nomearquivo = uigetfile('.xls');
file = importdata(nomearquivo);

% Lendo os arquivos.
% ------------------
DadosT1   = file.data.Bal0x2EPatrim0x2E;          % Primeira Tabela.
DadosT2   = file.data.Dem0x2EResult0x2E;          % Segunda Tabela.
Textos    = file.textdata.Bal0x2EPatrim0x2E;      % Todos os textos.
cellDatas = Textos(2,2:end);                      % Datas.

% Quantos balanços trimestrais eu tenho?
% --------------------------------------
n1 = size(DadosT1,1);        % Variáveis totais Tabela-1.      
n2 = size(DadosT2,1);        % Variáveis totais Tabela-2.      
m  = size(DadosT1,2);        % Balanços.

% Deixando os balanços em ordem crescente de data.
% ------------------------------------------------
% Tabela 1.
for i=1:n1
    for j=1:m
        Tab1(i,j) = DadosT1(i,m-j+1);
    end
end
% Tabela 2.
for i=1:n2
    for j=1:m
        Tab2(i,j) = DadosT2(i,m-j+1);
    end
end
% Convertendo datas.
for i=1:m
    numData(i) = datenum(cellDatas{i}, 'dd/mm/yyyy');
end
% Invertendo datas.
for i=1:m
    Data(i) = numData(1,m-i+1);
end

% Convertendo 'células de datas' em 'datas de string' para leitura.
% -----------------------------------------------------------------
% Converte em datas comumente utilizadas.
[Ano, Mes, Dia, Hora, Minuto, Segundo] = datevec(Data);

% Trimestre Inicial - Pela Tabela.
trimestreInicial = Mes(1);

% Lógica relativa ao Primeiro Trimestre de Interesse.
if trimestreInicial ~= 3
    cont = 0;
    for i=1:4
        if Mes(i) ~= 3
            cont = cont + 1;
        else 
            cont = cont + 1;
            break;
        end
    end
else
    cont = 1;    
end


% -------------------------------------------------------------------------
%                           Dados Tabela 1
%
% -------------------------------------------------------------------------
Tabela1.AtivoTotal                       = Tab1(1,cont:end);
Tabela1.AtivoCirculante                  = Tab1(2,cont:end);
Tabela1.CxEquiCx                         = Tab1(3,cont:end);
Tabela1.ApliFinanceira                   = Tab1(4,cont:end);
Tabela1.ContasReceber                    = Tab1(5,cont:end);
Tabela1.Estoques1                        = Tab1(6,cont:end);
Tabela1.AtivosBiologicos1                = Tab1(7,cont:end);
Tabela1.TributosRecuperar                = Tab1(8,cont:end);
Tabela1.DespesasAntecipadas              = Tab1(9,cont:end);
Tabela1.OutrosAtivosCirc                 = Tab1(10,cont:end);
Tabela1.AtivoRealizavelLongoPrazo        = Tab1(11,cont:end);
Tabela1.AplicFinanceiraValorJusto        = Tab1(12,cont:end);
Tabela1.AplicFinanceiraCustoAmort        = Tab1(13,cont:end);
Tabela1.ContasReceber                    = Tab1(14,cont:end);
Tabela1.Estoques2                        = Tab1(15,cont:end);
Tabela1.AtivosBiologicos2                = Tab1(16,cont:end);
Tabela1.TributosDiferidos1               = Tab1(17,cont:end);
Tabela1.DespesasAntecipadas              = Tab1(18,cont:end);
Tabela1.CreditoPartesRelacionadas        = Tab1(19,cont:end);
Tabela1.OutrosAtivosNaoCirculantes       = Tab1(20,cont:end);
Tabela1.Investimentos                    = Tab1(21,cont:end);
Tabela1.Imobilizado                      = Tab1(22,cont:end);
Tabela1.Intangivel                       = Tab1(23,cont:end);
Tabela1.Diferido                         = Tab1(24,cont:end);
Tabela1.PassivoTotal                     = Tab1(25,cont:end);
Tabela1.PassivoCirculante                = Tab1(26,cont:end);
Tabela1.ObrigacoesSociaisTrabalhitas     = Tab1(27,cont:end);
Tabela1.Fornecedores                     = Tab1(28,cont:end);
Tabela1.ObrigacoesFiscais                = Tab1(29,cont:end);
Tabela1.EmprestimosFinanciamentos1       = Tab1(30,cont:end);
Tabela1.PassivosPartesRelacionadas1      = Tab1(31,cont:end);
Tabela1.Dividendos                       = Tab1(32,cont:end);
Tabela1.Outros1                          = Tab1(33,cont:end);
Tabela1.Provisoes                        = Tab1(34,cont:end);
Tabela1.PassivosSobreAtivosNaoCor1       = Tab1(35,cont:end);
Tabela1.PassivoNaoCirculante             = Tab1(36,cont:end);
Tabela1.EmprestimosFinanciamentos2       = Tab1(37,cont:end);
Tabela1.PassivosPartesRelacionadas2      = Tab1(38,cont:end);
Tabela1.Outros2                          = Tab1(39,cont:end);
Tabela1.TributosDeferidos2               = Tab1(40,cont:end);
Tabela1.AdiantamentoFuturoAumentCap1     = Tab1(41,cont:end);
Tabela1.Provisoes                        = Tab1(42,cont:end);
Tabela1.PassivosSobreAtivosNaoCor2       = Tab1(43,cont:end);
Tabela1.LucrosRecietasApropriar          = Tab1(44,cont:end);
Tabela1.ParticipacaoAcionistasNaoCont    = Tab1(45,cont:end);
Tabela1.PatrimonioLiquido                = Tab1(46,cont:end);
Tabela1.CapitalSocialRealizado           = Tab1(47,cont:end);
Tabela1.ReservaCapital                   = Tab1(48,cont:end);
Tabela1.ReservaReavalizacao              = Tab1(49,cont:end);
Tabela1.ReservasLucros                   = Tab1(50,cont:end);
Tabela1.LucroPrejuizoAcumulado           = Tab1(51,cont:end);
Tabela1.AjusteAvaliacaoPatrimonial       = Tab1(52,cont:end);
Tabela1.AjusteAcumuladoConversao         = Tab1(53,cont:end);
Tabela1.ResultadosAbrangentes            = Tab1(54,cont:end);
Tabela1.AdiantamentoFuturoAumentCap2     = Tab1(55,cont:end);

% -------------------------------------------------------------------------
%                           Dados Tabela 2
%
% -------------------------------------------------------------------------
Tabela2.ReceitaBrutaVendasServicos       = Tab2(1,cont:end);
Tabela2.DeducoesReceitaBruta             = Tab2(2,cont:end);
Tabela2.ReceitaLiquidaVendasServicos     = Tab2(3,cont:end);
Tabela2.CustoBensServicosVendidos        = Tab2(4,cont:end);
Tabela2.ResultadoBruto                   = Tab2(5,cont:end);
Tabela2.DespesasComVendas                = Tab2(6,cont:end);
Tabela2.DespesasGeraisAdministrativas    = Tab2(7,cont:end);
Tabela2.PerdasNaoRecuperabAtivos         = Tab2(8,cont:end);
Tabela2.OutrasReceitasOperacionais       = Tab2(9,cont:end);
Tabela2.OutrasDespesasOperacionais       = Tab2(10,cont:end);
Tabela2.ResultadoEquivalenciaPatrimonial = Tab2(11,cont:end);
Tabela2.Financeiras                      = Tab2(12,cont:end);
Tabela2.ReceitasFinanceiras              = Tab2(13,cont:end);
Tabela2.DespesasFinanceiras              = Tab2(14,cont:end);
Tabela2.ResultadoNaoOperacional          = Tab2(15,cont:end);
Tabela2.Receitas                         = Tab2(16,cont:end);
Tabela2.Despesas                         = Tab2(17,cont:end);
Tabela2.ResultadosAntesTribPartic        = Tab2(18,cont:end);
Tabela2.ProvisaoIR                       = Tab2(19,cont:end);
Tabela2.IRDiferido                       = Tab2(20,cont:end);
Tabela2.ParticipacoesEstaturarias        = Tab2(21,cont:end);
Tabela2.ReversaoJurosCapitalProprio      = Tab2(22,cont:end);
Tabela2.PartAcionistaNaoControladores    = Tab2(23,cont:end);
Tabela2.LucroPeriodo                     = Tab2(24,cont:end);

% -------------------------------------------------------------------------
%                       Salvando os Dados da Empresa.
% -------------------------------------------------------------------------
% 1) Nome da Empresa.
% --------------------
StringCompleta = strsplit(Textos{1,2});             % Pela Tabela Fundamentos.
StringCompleta = num2str(cell2mat(StringCompleta));
N = max(size(StringCompleta));
for i=1:N
   if (StringCompleta(i) == '-')
       PosicaoNome = i+1;
   end
end

% Concatena nome da Empresa.
string1 = '';
for i = PosicaoNome:N
   string1 = strcat(string1, StringCompleta(i)); 
end
Empresa      = lower(string1);
EmpresaBRUTO = strcat(Empresa, 'BRUTO');

% Datas dos balanços.
Data = Data(cont:end);
Ticker     = input('Digite o Ticker da ação: ', 's');
QuantAcoes = input('Digite a quantidade de ações emitidas: ')
estrutura  = struct('D', Data, 'Ticker', Ticker, 'QuantAcoes', QuantAcoes, 'T1', Tabela1, 'T2', Tabela2);
eval([EmpresaBRUTO '=estrutura;']);
FileNameSaveBRUTO = strcat(EmpresaBRUTO, '.mat');
save(FileNameSaveBRUTO, EmpresaBRUTO);

% Faz um ajuste fino dos dados.
clc;
a = ClasseIndicadores(FileNameSaveBRUTO);
clear all; close all; clc;

