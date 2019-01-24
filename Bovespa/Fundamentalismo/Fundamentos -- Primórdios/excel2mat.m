classdef excel2mat   
    
    properties
        Nome                  % Nome da empresa
        D                     % Data
        T1                    % Tabela 1
        T2                    % Tabela 2
    end
    
    methods
        function [o] = excel2mat(o)
            % -------------------------------------------------------------------------
            %                          Inclus�o das Fun��es
            % -------------------------------------------------------------------------
            raiz    = pwd;
            subRaiz = {'Fun��es'; 'Excel'};

            nMax = max(size(subRaiz));
            for i = 1:nMax
                rmpath([raiz '\' subRaiz{i,:}]);
                addpath([raiz '\' subRaiz{i,:}]); 
            end

            % -------------------------------------------------------------------------
            %                       Inclus�o das Planilhas .xls
            % -------------------------------------------------------------------------

            nomearquivo = uigetfile();
            file = importdata(nomearquivo);

            % Lendo os arquivos.
            % ------------------
            DadosT1   = file.data.Bal0x2EPatrim0x2E;          % Primeira Tabela.
            DadosT2   = file.data.Dem0x2EResult0x2E;          % Segunda Tabela.
            Textos    = file.textdata.Bal0x2EPatrim0x2E;      % Todos os textos.
            cellDatas = Textos(2,2:end);                      % Datas.

            % Quantos balan�os trimestrais eu tenho?
            % --------------------------------------
            n1 = size(DadosT1,1);        % Vari�veis totais Tabela-1.      
            n2 = size(DadosT2,1);        % Vari�veis totais Tabela-2.      
            m  = size(DadosT1,2);        % Balan�os.

            % Deixando os balan�os em ordem crescente de data.
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

            % Convertendo 'c�lulas de datas' em 'datas de string' para leitura.
            % -----------------------------------------------------------------
            % Converte em datas comumente utilizadas.
            [Ano, Mes, Dia, Hora, Minuto, Segundo] = datevec(Data);

            % Trimestre Inicial - Pela Tabela.
            trimestreInicial = Mes(1);

            % L�gica relativa ao Primeiro Trimestre de Interesse.
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
            o.T1.AtivoTotal                       = Tab1(1,cont:end);
            o.T1.AtivoCirculante                  = Tab1(2,cont:end);
            o.T1.CxEquiCx                         = Tab1(3,cont:end);
            o.T1.ApliFinanceira                   = Tab1(4,cont:end);
            o.T1.ContasReceber                    = Tab1(5,cont:end);
            o.T1.Estoques1                        = Tab1(6,cont:end);
            o.T1.AtivosBiologicos1                = Tab1(7,cont:end);
            o.T1.TributosRecuperar                = Tab1(8,cont:end);
            o.T1.DespesasAntecipadas              = Tab1(9,cont:end);
            o.T1.OutrosAtivosCirc                 = Tab1(10,cont:end);
            o.T1.AtivoRealizavelLongoPrazo        = Tab1(11,cont:end);
            o.T1.AplicFinanceiraValorJusto        = Tab1(12,cont:end);
            o.T1.AplicFinanceiraCustoAmort        = Tab1(13,cont:end);
            o.T1.ContasReceber                    = Tab1(14,cont:end);
            o.T1.Estoques2                        = Tab1(15,cont:end);
            o.T1.AtivosBiologicos2                = Tab1(16,cont:end);
            o.T1.TributosDiferidos1               = Tab1(17,cont:end);
            o.T1.DespesasAntecipadas              = Tab1(18,cont:end);
            o.T1.CreditoPartesRelacionadas        = Tab1(19,cont:end);
            o.T1.OutrosAtivosNaoCirculantes       = Tab1(20,cont:end);
            o.T1.Investimentos                    = Tab1(21,cont:end);
            o.T1.Imobilizado                      = Tab1(22,cont:end);
            o.T1.Intangivel                       = Tab1(23,cont:end);
            o.T1.Diferido                         = Tab1(24,cont:end);
            o.T1.PassivoTotal                     = Tab1(25,cont:end);
            o.T1.PassivoCirculante                = Tab1(26,cont:end);
            o.T1.ObrigacoesSociaisTrabalhitas     = Tab1(27,cont:end);
            o.T1.Fornecedores                     = Tab1(28,cont:end);
            o.T1.ObrigacoesFiscais                = Tab1(29,cont:end);
            o.T1.EmprestimosFinanciamentos1       = Tab1(30,cont:end);
            o.T1.PassivosPartesRelacionadas1      = Tab1(31,cont:end);
            o.T1.Dividendos                       = Tab1(32,cont:end);
            o.T1.Outros1                          = Tab1(33,cont:end);
            o.T1.Provisoes                        = Tab1(34,cont:end);
            o.T1.PassivosSobreAtivosNaoCor1       = Tab1(35,cont:end);
            o.T1.PassivoNaoCirculante             = Tab1(36,cont:end);
            o.T1.EmprestimosFinanciamentos2       = Tab1(37,cont:end);
            o.T1.PassivosPartesRelacionadas2      = Tab1(38,cont:end);
            o.T1.Outros2                          = Tab1(39,cont:end);
            o.T1.TributosDeferidos2               = Tab1(40,cont:end);
            o.T1.AdiantamentoFuturoAumentCap1     = Tab1(41,cont:end);
            o.T1.Provisoes                        = Tab1(42,cont:end);
            o.T1.PassivosSobreAtivosNaoCor2       = Tab1(43,cont:end);
            o.T1.LucrosRecietasApropriar          = Tab1(44,cont:end);
            o.T1.ParticipacaoAcionistasNaoCont    = Tab1(45,cont:end);
            o.T1.PatrimonioLiquido                = Tab1(46,cont:end);
            o.T1.CapitalSocialRealizado           = Tab1(47,cont:end);
            o.T1.ReservaCapital                   = Tab1(48,cont:end);
            o.T1.ReservaReavalizacao              = Tab1(49,cont:end);
            o.T1.ReservasLucros                   = Tab1(50,cont:end);
            o.T1.LucroPrejuizoAcumulado           = Tab1(51,cont:end);
            o.T1.AjusteAvaliacaoPatrimonial       = Tab1(52,cont:end);
            o.T1.AjusteAcumuladoConversao         = Tab1(53,cont:end);
            o.T1.ResultadosAbrangentes            = Tab1(54,cont:end);
            o.T1.AdiantamentoFuturoAumentCap2     = Tab1(55,cont:end);

            % -------------------------------------------------------------------------
            %                           Dados Tabela 2
            %
            % -------------------------------------------------------------------------
            o.T2.ReceitaBrutaVendasServicos       = Tab2(1,cont:end);
            o.T2.DeducoesReceitaBruta             = Tab2(2,cont:end);
            o.T2.ReceitaLiquidaVendasServicos     = Tab2(3,cont:end);
            o.T2.CustoBensServicosVendidos        = Tab2(4,cont:end);
            o.T2.ResultadoBruto                   = Tab2(5,cont:end);
            o.T2.DespesasComVendas                = Tab2(6,cont:end);
            o.T2.DespesasGeraisAdministrativas    = Tab2(7,cont:end);
            o.T2.PerdasNaoRecuperabAtivos         = Tab2(8,cont:end);
            o.T2.OutrasReceitasOperacionais       = Tab2(9,cont:end);
            o.T2.OutrasDespesasOperacionais       = Tab2(10,cont:end);
            o.T2.ResultadoEquivalenciaPatrimonial = Tab2(11,cont:end);
            o.T2.Financeiras                      = Tab2(12,cont:end);
            o.T2.ReceitasFinanceiras              = Tab2(13,cont:end);
            o.T2.DespesasFinanceiras              = Tab2(14,cont:end);
            o.T2.ResultadoNaoOperacional          = Tab2(15,cont:end);
            o.T2.Receitas                         = Tab2(16,cont:end);
            o.T2.Despesas                         = Tab2(17,cont:end);
            o.T2.ResultadosAntesTribPartic        = Tab2(18,cont:end);
            o.T2.ProvisaoIR                       = Tab2(19,cont:end);
            o.T2.IRDiferido                       = Tab2(20,cont:end);
            o.T2.ParticipacoesEstaturarias        = Tab2(21,cont:end);
            o.T2.ReversaoJurosCapitalProprio      = Tab2(22,cont:end);
            o.T2.PartAcionistaNaoControladores    = Tab2(23,cont:end);
            o.T2.LucroPeriodo                     = Tab2(24,cont:end);

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
            o.Nome       = Empresa;

            % Datas dos balan�os.
            Data = Data(cont:end);
            o.D  = Data;

            estrutura = struct('D', Data, 'T1', T1, 'T2', T2);
            eval([EmpresaBRUTO '=estrutura;']);
            FileNameSaveBRUTO = strcat(EmpresaBRUTO, '.mat');
            save(FileNameSaveBRUTO, EmpresaBRUTO);
        end
    end
    
end

