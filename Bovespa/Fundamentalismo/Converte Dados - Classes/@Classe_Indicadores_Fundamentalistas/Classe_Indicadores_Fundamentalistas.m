classdef Classe_Indicadores_Fundamentalistas
    
    properties
        Nome
        Data
        QuantAcoes
        AcoesTesouraria
        
        Ativos
        Passivos
        DemResultados
        
        Indicador
    end
    
    
    
    methods
        % *****************************************************************
        %
        %                           Construtor
        %
        % *****************************************************************
        function [a] = Classe_Indicadores_Fundamentalistas()
           
            % *************************************************************
            % 1. Chama o arquivo com os balanços condensados.
            % *************************************************************
            raiz    = pwd;
            Titulo = 'Selecione o arquivo "*.mat" references ao balanço CONDENSADO da empresa';
            [Arquivo_Matlab, CaminhoArquivo, ~] = uigetfile(fullfile(raiz, '*.mat'), ...
                                                                    'MultiSelect', 'on', Titulo);
            rmpath([CaminhoArquivo]);
            addpath([CaminhoArquivo]);
            
            load(Arquivo_Matlab);
            
            % *************************************************************
            % 2. Pega o nome da empresa.
            % 
            % (*) Dados da primeira tabela.
            % *************************************************************
            Intermed = strsplit(Arquivo_Matlab, '_');
            
            a.Nome            = Intermed{1};
            a.Data            = o.T1.data;
            a.QuantAcoes      = o.T1.totalAcoes;
            a.AcoesTesouraria = o.T1.totalAcoesEmTesouraria;
            
            a.Ativos          = o.T2;
            a.Passivos        = o.T3;
            a.DemResultados   = o.T4;
            
            % *************************************************************
            %  3. Indicadores
            % *************************************************************
            [a] = fn_Data(a);   
            [a] = fn_ROE(a);
            [a] = fn_IndiceLiquidezCorrente(a);
            [a] = fn_VPA(a);
            [a] = fn_LucroLiquido(a);
            [a] = fn_MargemLiquida(a);
            [a] = fn_MargemBruta(a);
            [a] = fn_MargemEBIT(a);
            [a] = fn_Dividendos(a);
            [a] = fn_DespesasPorLucroBruto(a);
            [a] = fn_LucroAntesDosImpostos(a);
            [a] = fn_ResultadoDeVendas(a);
            [a] = fn_DividaBruta(a);
            [a] = fn_DividaLiquida(a);

        end;        
      
        % -----------------------------------------------------------------
        %                           Demais Métodos
        % -----------------------------------------------------------------
         [a] = fn_Data(a,varargin);
         [a] = fn_ROE(a);
         [a] = fn_IndiceLiquidezCorrente(a);
         [a] = fn_VPA(a);
         [a] = fn_LucroLiquido(a);
         [a] = fn_MargemBruta(a); 
         [a] = fn_MargemEBIT(a);
         [a] = fn_Dividendos(a);
         [a] = fn_DespesasPorLucroBruto(a);
         [a] = fn_LucroAntesDosImpostos(a);
         [a] = fn_ResultadoDeVendas(a);
         [a] = fn_DividaBruta(a);
         [a] = fn_DividaLiquida(a);

    end
    
end

