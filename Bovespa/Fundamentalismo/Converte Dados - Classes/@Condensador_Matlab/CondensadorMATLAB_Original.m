%  Modificações
% --------------
%
% 1. Dia 13/03/2016
% 
%  (*) Inseri na estrutura de dados da Tabela 1, a seguinte variável:
%      -- 'T1.totalAcoesEmTesouraria' na 'Total - Em Tesouraria';
%
%  (*) Inseri na estrutura de dados da Tabela 3, a seguinte variável:
%      -- T3.DividendosEJCPAPagar na 'Dividendos e JCP a pagar';          
%
%  (*) Inseri na estrutura de dados da Tabela 3, as seguinte variáveis:
%      -- T4.DespesasComVendas na 'Despesas com Vendas';  e
%      -- T4.DespesasGeraisEAdministrativas na 'Despesas Gerais e Administrativas';  
%
%
% 2. Dia 14/03/2016
%
% (*) Inseri na estrutura de dados da Tabela 3, as seguinte variáveis:
%      -- T4.AtribuidoASóciosDaEmpresaControladora na aba
%            'Atribuído a Sócios da Empresa Controladora'; e
%      -- T4.AtribuidoASociosNãoControladora na aba 
%            'Atribuído a Sócios Não Controladora';  
%
%
% 3. Dia 16/03/2016
%
% (*) Alterações das Tabelas dos resultados 'Individuais' para os
%     'Consolidados'
% -------------------------------------------------------------------------
% (*) A primeira parte do programa selecionará A PASTA a qual tem os
%     arquivos '*.mat'.
% raiz    = pwd;

Jota = 'Selecione os arquivos *.mat references aos balanços trimestrais da empresa';
[NomeArquivo, CaminhoArquivo, ~] = uigetfile(fullfile(raiz, '*.mat'), 'MultiSelect', 'on', Jota);
rmpath([CaminhoArquivo]);
addpath([CaminhoArquivo]); 


% -------------------------------------------------------------------------
% (*) Abre um monte de arquivo '*.mat'
% (*) Para facilitar eu irei salver todas as variáveis em um vetor chamado
%     TRI, em referência à trimestre.
TRI = cellstr(NomeArquivo);
n   = max(size(TRI));
if (n == 1)
    TRI{1} = load(TRI{1});
else
    for i=1:n
        TRI{i} = load(TRI{i});
    end
end


% -------------------------------------------------------------------------
% (*) Ordenas as datas em ordem DECRESCENTE.
DATAS = [];
for i=1:n
   Data(i,:)    = TRI{i}.o.T1.data;
   DataYYYYMMDD = fnYYYYMMDD(Data(i,:));
   DATAS = [DATAS; DataYYYYMMDD];
end
DOrdenada = fnOrdenaDatas(DATAS);     % Datas ordenadas (no formato bruto)
DOrdenada = fnYYYYMMDD2String(DOrdenada);


% -------------------------------------------------------------------------
% (*) Comparativo entre as STRINGS de 'DOrdenada' com as STRINGS dos
%     trimestres
for i=1:n
    str1 = DOrdenada(i,:);
    for j=1:n
       if(strcmp(str1, TRI{j}.o.T1.data))
           disp(TRI{j}.o.T1.data);
       end
    end
end

% -------------------------------------------------------------------------
% 5.: Monta um arquivo '*.mat' com o balanço da empresa recém analisada
CampoTabela1 = fields(TRI{1}.o.T1);
CampoTabela2 = fields(TRI{1}.o.T2);
CampoTabela3 = fields(TRI{1}.o.T3);
CampoTabela4 = fields(TRI{1}.o.T4);
CampoTabela5 = fields(TRI{1}.o.T5);
n = max(size(TRI));

theta  = waitbar(0, sprintf('Condensando os balanços trimestrais da empresa...', n));
%  Pré-Load
% ----------
% Tabela 1
T1.(CampoTabela1{1}) = TRI{1}.o.T1.texto;

% Tabela 2
T2.(CampoTabela2{1}) = TRI{1}.o.T2.texto;
T2.(CampoTabela2{2}) = TRI{1}.o.T2.numero;


% Tabela 3
T3.(CampoTabela3{1}) = TRI{1}.o.T3.texto;
T3.(CampoTabela3{2}) = TRI{1}.o.T3.numero;

% Tabela 4
T4.(CampoTabela4{1}) = TRI{1}.o.T4.texto;
T4.(CampoTabela4{2}) = TRI{1}.o.T4.numero;

% Tabela 5
T5.(CampoTabela5{1}) = TRI{1}.o.T5.texto;
T5.(CampoTabela5{2}) = TRI{1}.o.T5.numero;
for i=1:n
    str1 = DOrdenada(i,:);
    for j=1:n
       if(strcmp(str1, TRI{j}.o.T1.data))
           
           Tabela1;
           waitbar(1/10); 
           
           Tabela2;
           waitbar(2/10);
           
           Tabela3;   
           waitbar(4/10);
           
           Tabela4;
           waitbar(6/10);
           
           Tabela5;
           waitbar(7/10);
       end
    end
end


% Flipa para a Tabela 1.
T1.totalAcoes = fliplr(T1.totalAcoes);
T1.totalAcoesEmTesouraria     = fliplr(T1.totalAcoesEmTesouraria);      % 13/03/2016

% Flipa para a Tabela 2.
T2.AtivoTotal                 = fliplr(T2.AtivoTotal);
T2.AtivoCirculante            = fliplr(T2.AtivoCirculante);
T2.CaixaEEquivalenteDeCaixa   = fliplr(T2.CaixaEEquivalenteDeCaixa);
T2.AplicacoesFinanceiras      = fliplr(T2.AplicacoesFinanceiras);
T2.ContasAReceber             = fliplr(T2.ContasAReceber);
T2.Estoques                   = fliplr(T2.Estoques);
T2.AtivosBiologicos           = fliplr(T2.AtivosBiologicos);
T2.TributosARecuperar         = fliplr(T2.TributosARecuperar);
T2.DespesasAntecipadas        = fliplr(T2.DespesasAntecipadas);
T2.OutrosAtivosCirculantes    = fliplr(T2.OutrosAtivosCirculantes);
T2.AtivoNaoCirculante         = fliplr(T2.AtivoNaoCirculante);
T2.AtivoRealizavelALongoPrazo = fliplr(T2.AtivoRealizavelALongoPrazo);
T2.Investimentos              = fliplr(T2.Investimentos);
T2.Imobilizado                = fliplr(T2.Imobilizado);
T2.Intangivel                 = fliplr(T2.Intangivel);


% Flipa para a Tabela 3.
T3.PassivoTotal                                          = fliplr(T3.PassivoTotal);
T3.PassivoCirculante                                     = fliplr(T3.PassivoCirculante);
T3.ObrigacoesSociaisETrabalhistas                        = fliplr(T3.ObrigacoesSociaisETrabalhistas);
T3.Fornecedores                                          = fliplr(T3.Fornecedores);
T3.ObrigacoesFiscais                                     = fliplr(T3.ObrigacoesFiscais);
T3.EmprestimosEFinanciamentos                            = fliplr(T3.EmprestimosEFinanciamentos);
T3.OutrasObrigacoes                                      = fliplr(T3.OutrasObrigacoes);
T3.DividendosEJCPAPagar                                  = fliplr(T3.DividendosEJCPAPagar);   % 13/03/2017
T3.Provisoes                                             = fliplr(T3.Provisoes);
T3.PassivoSobreAtivosNaoCorrentesAVendaEDescontinuados   = fliplr(T3.PassivoSobreAtivosNaoCorrentesAVendaEDescontinuados);
T3.PassivoNaoCirculante                                  = fliplr(T3.PassivoNaoCirculante);
T3.EmprestimosEFinanciamentos2                           = fliplr(T3.EmprestimosEFinanciamentos2);
T3.OutrasObrigacoes2                                     = fliplr(T3.OutrasObrigacoes2);
T3.TributosDiferidos                                     = fliplr(T3.TributosDiferidos);
T3.Provisoes2                                            = fliplr(T3.Provisoes2);
T3.PassivosSobreAtivosNaoCorrentesAVendaEDescontinuados2 = fliplr(T3.PassivosSobreAtivosNaoCorrentesAVendaEDescontinuados2);
T3.LucrosEReceitasAApropriar                             = fliplr(T3.LucrosEReceitasAApropriar);
T3.PatrimonioLiquido                                     = fliplr(T3.PatrimonioLiquido);
T3.CapitalSocialRealizado                                = fliplr(T3.CapitalSocialRealizado);
T3.ReservaDeCapital                                      = fliplr(T3.ReservaDeCapital);
T3.ReservasDeReavaliacao                                 = fliplr(T3.ReservasDeReavaliacao);
T3.ReservasDeLucros                                      = fliplr(T3.ReservasDeLucros);
T3.LucrosPrejuizosAcumulados                             = fliplr(T3.LucrosPrejuizosAcumulados);
T3.AjustesDeAvalicaoPatrimonial                          = fliplr(T3.AjustesDeAvalicaoPatrimonial);
T3.AjustesAcumuladosDeConversao                          = fliplr(T3.AjustesAcumuladosDeConversao);
T3.OutrosResultadosAbrangentes                           = fliplr(T3.OutrosResultadosAbrangentes);
waitbar(9/10);

% Flipa para a Tabela 4.
T4.ReceitaDeVendaDeBensEOUServicos                  = fliplr(T4.ReceitaDeVendaDeBensEOUServicos);
T4.CustoDosBensEOUServicosVendidos                  = fliplr(T4.CustoDosBensEOUServicosVendidos);
T4.ResultadoBruto                                   = fliplr(T4.ResultadoBruto);
T4.DespesasReceitasOperacionais                     = fliplr(T4.DespesasReceitasOperacionais);
T4.DespesasComVendas                                = fliplr(T4.DespesasComVendas);              % 13/03/2017
T4.DespesasGeraisEAdministrativas                   = fliplr(T4.DespesasGeraisEAdministrativas); % 13/03/2017
T4.ResultadoAntesDoResultadoFinanceiroEDosTributos  = fliplr(T4.ResultadoAntesDoResultadoFinanceiroEDosTributos);
T4.ResultadoFinanceiro                              = fliplr(T4.ResultadoFinanceiro);
T4.ResultadoAntesDosTributosSobreOLucro             = fliplr(T4.ResultadoAntesDosTributosSobreOLucro);
T4.ImpostoDeRendaEContribuicaoSocialSobreOLucro     = fliplr(T4.ImpostoDeRendaEContribuicaoSocialSobreOLucro);
T4.ResultadoLiquidoDasOperacoesContinuadas          = fliplr(T4.ResultadoLiquidoDasOperacoesContinuadas);
T4.ResultadoLiquidoDeOperacoesDescontinuadas        = fliplr(T4.ResultadoLiquidoDeOperacoesDescontinuadas);
T4.LucroPrejuizoDoPeriodo                           = fliplr(T4.LucroPrejuizoDoPeriodo);                % 16/03/2017
T4.AtribuidoASociosDaEmpresaControladora            = fliplr(T4.AtribuidoASociosDaEmpresaControladora); % 14/03/2017
T4.AtribuidoASociosNaoControladora                  = fliplr(T4.AtribuidoASociosNaoControladora);       % 14/03/2017



% Flipa para a Tabela 5.
T5.DepreciacaoEAmortizacao   = fliplr(T5.DepreciacaoEAmortizacao);    % 02/05/2017
close(theta);



% -------------------------------------------------------------------------
% Junta os parâmetros em uma estrutura.
o = struct('T1', T1, 'T2', T2, 'T3', T3, 'T4', T4, 'T5', T5);


% % -------------------------------------------------------------------------
% % (*) Ajuste para o 4º Tabela -- 4º Trimestre
% prompt = {'Digite 1 se os resultados são acumulados trimestre a trimestre. Caso contrário, digite 0.'};
% dlg_title = 'Input';
% num_lines = 1;
% defaultans = {'1'};
% resposta = inputdlg(prompt, dlg_title, num_lines,defaultans);
% 
% if (resposta{1} == '1')
%     AcumuladoTrimestreATrimestre;
% else
%     AcumuladoUltimoTrimestre;
% end
AcumuladoUltimoTrimestre;

% -------------------------------------------------------------------------
% Ajuste para a 5º Tabela
Ajuste5Tabela;


% -------------------------------------------------------------------------
% (*) Salvando o resultado
nomeCompanhia       = cellstr(NomeArquivo);
n                   = max(size(TRI));
if (n ==1)
    nomeCompanhia = NomeArquivo;
else
    nomeCompanhia = NomeArquivo{1};
end
[principal, remain] = strtok(nomeCompanhia,'_');
ResultadoCondensado = strcat(principal,'_CONDENSADO.mat');
% o;
save(ResultadoCondensado, 'o');