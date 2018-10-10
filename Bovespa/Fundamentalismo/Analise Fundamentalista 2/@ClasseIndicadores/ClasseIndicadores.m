classdef ClasseIndicadores
    
    properties
        Nome
        Ticker        
        QuantAcoes
        
        Data
        Tabela1
        Tabela2
        
        Indicador
    end
    
    methods
        
        % -----------------------------------------------------------------
        %                           Construtor
        % -----------------------------------------------------------------
        function [o] = ClasseIndicadores(name)
           %%% Pega o arquivo BRUTO gerado. 
           FILE        = load(name);
           [o.Nome, ~] = strtok(name, 'BRUTO.')
           [name, ~]   = strtok(name, '.')
           Dados       = FILE.(name)
             
% -------------------------------------------------------------------------
% Código Original feito por mim.
%
%            %%% Pega o arquivo BRUTO gerado.
%            [NomeBruto, Caminho, ~] = uigetfile('*.mat', 'MultiSelect', 'on');
%            Diretorio = fullfile(Caminho, NomeBruto);
%            FILE      = load(Diretorio);       
%            
%            %%% Arquivos.
%            [o.Nome, ~] = strtok(NomeBruto, 'BRUTO.');
%            [NomeBruto, ~] = strtok(NomeBruto, '.');
%            Dados     = FILE.(NomeBruto);
% -------------------------------------------------------------------------
           o.Data       = Dados.D;
           o.Tabela1    = Dados.T1;
           o.Tabela2    = Dados.T2;
           o.QuantAcoes = Dados.QuantAcoes;
           o.Ticker     = Dados.Ticker;
           
           %%% Dados calculados.
           [o] = fnData(o);   
           [o] = fnROE(o);
%            [o] = fnROA(o);
           [o] = fnLucroLiquido(o);
           [o] = fnIndiceLiquidezCorrente(o);
           [o] = fnMargemBruta(o);
           [o] = fnMargemLiquida(o);
           [o] = fnDividaBruta(o);
           [o] = fnDividaLiquida(o);
           
           %%% Salva o objeto criado
           N = max(size(o.Nome));
           str = '';
           for i = 1:N
              str = strcat(str, o.Nome(i)); 
           end
           Empresa = lower(str);
           Empresa = strcat(Empresa, '.mat');
           NomeArquivo = [Empresa];
           save(NomeArquivo, 'o');
        end;
        
        
        % -----------------------------------------------------------------
        %                           Demais Métodos
        % -----------------------------------------------------------------
        [o] = fnData(o,varargin);
        [o] = fnROE(o);
%         [o] = fnROA(o);
        [o] = fnLucroLiquido(o);
        [o] = fnIndiceLiquidezCorrente(o);
        [o] = fnMargemBruta(o);
        [o] = fnMargemLiquida(o);
        [o] = fnDividaBruta(o);
        [o] = fnDividaLiquida(o);
        []  = plotaIndicador(o,varargin);
%         [h] = plotaIndicador(o,varargin);
    end
    
end

