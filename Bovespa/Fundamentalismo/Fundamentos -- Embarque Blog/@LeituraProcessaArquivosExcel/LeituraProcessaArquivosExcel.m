classdef LeituraProcessaArquivosExcel
    
    properties
        Empresa
        
        % Dados ainda brutos.
        % -------------------
        Tabela1
        Tabela2
        Textos
        DatasTexto

        % Dados já alinhados e separados (prontos p/ gerar arquivos Excel).
        % -----------------------------------------------------------------
        NomeEmpresa
        Ativos
        Passivos
        DemResultados
       
        % Indicadores Fundamentalistas.
        % -----------------------------
        Data
        Indicador
    end
       
    methods 
        % =================================================================
        %                           CONSTRUTOR
        %
        % =================================================================
        function [o] = LeituraProcessaArquivosExcel(varargin)
           NomeArquivo_Excel = varargin{1};
           o.Empresa = importdata(NomeArquivo_Excel);  % Importa.
           o = o.fnExcel2Matlab;
           o = o.fnAtivos;
           o = o.fnPassivos;
           o = o.fnDemResultados;
           o = o.fnNomeEmpresa;
                
           o = o.fn_Data;
           o = o.fn_ROE;
           o = o.fn_IndiceLiquidezCorrente;
           o = o.fn_LucroLiquido;           
           o = o.fn_MargemLiquida;
           o = o.fn_MargemBruta;
%            o = o.fn_MargemEBIT;
%            o = o.fn_Dividendos;
%            o = o.fn_DespesasPorLucroBruto;
%            o = o.fn_LucroAntesDosImpostos;
%            o = o.fn_ResultadoDeVendas;
%            o = o.fn_DividaBruta;
%            o = o.fn_DividaLiquida;
%            o = o.fn_VPA;
%            fnSalva(o);
        end
        
        
        % =================================================================
        %                       DEMAIS MÉTODOS
        %
        % =================================================================
        [o] = fnNomeEmpresa(o);
        [o] = fnExcel2Matlab(o);
        [o] = fnAtivos(o);
        [o] = fnPassivos(o);
        [o] = fnDemResultados(o);
        
        % Métodos para análise fundamentalista.
        [o] = fn_Data(o, varargin);
        [o] = fn_ROE(o, varargin);
        [o] = fn_IndiceLiquidezCorrente(o);
        [o] = fn_VPA(o);
        [o] = fn_LucroLiquido(o);
        [o] = fn_MargemBruta(o); 
        [o] = fn_MargemEBIT(o);
        [o] = fn_Dividendos(o);
        [o] = fn_DespesasPorLucroBruto(o);
        [o] = fn_LucroAntesDosImpostos(o);
        [o] = fn_ResultadoDeVendas(o);
        [o] = fn_DividaBruta(o);
        [o] = fn_DividaLiquida(o);
        
        [o] = fnSalva(o);
        []  = plotaIndicador(o,varargin);
    end
    
end

