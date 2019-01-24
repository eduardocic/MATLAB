classdef Agora
    % Essa Classe faz todo o cálculo necessário para o tratamento com ações
    % e oções utilizando a plataforma da XP Investimentos.
    
    properties
        ISS               % (I)mposto (S)obre (S)erviço.
        PIS               % (P)rograma de (I)ntegração (S)ocial.
        COFINS            % (CO)ntribuição para o (F)inanciamento de 
                          % (S)eguridade (S)ocial.
                          
        EmolAcao          % Para Ação.
        EmolOpcao         % Para Opção.        
        LiqAcao           % Taxa de Liquidação para Ação.
        LiqAcaoEx         % Taxa de Liquidação para Ação -- Caso Exercido.

        LiqOpcao          % Taxa de Liquidação para Opção -- Venda Opção.
        RegOpcao          % Taxa de Registro para Opção.
        
        CorretagemXPi     % Taxa de corretagem da XPi.
        OutrosBovespa     % Existe esse termo aqui na XPi.
        
        IRRF              % (I)mposto de (R)enda (R)etido na (F)onte.
    end
    
    methods
        %%% Construtor
        function [o] = Agora(o)
            o.ISS           = 5;         % Em porcentagem
            o.PIS           = 0.65;      % Em porcentagem  
            o.COFINS        = 4;         % Em porcentagem      
            
            o.EmolAcao      = 0.005;     % Em porcentagem      
            o.EmolOpcao     = 0.037;     % Em porcentagem    
            
            o.LiqAcao       = 0.0275;    % Em porcentagem       
            o.LiqOpcao      = 0.0275;    % Em porcentagem       
            o.LiqAcaoEx     = 0.02       % Em porcentagem
            o.RegOpcao      = 0.0695;    % Em porcentagem  
            
            o.CorretagemXPi = 19.90;     % Taxa de Corretagem da XPi, em Reais.
            o.OutrosBovespa = 3.9;       % Em porcentagem, em cima da CorretagemXPi.
            
            o.IRRF          = 0.005;     % Em porcentagem
        end;
        
        % -----------------------------------------------------------------
        %               MERCADO À VISTA -- APENAS AÇÕES.
        [totCompra] = CustoCompraAcao(o, varargin);     
        [totVenda]  = CustoVendaAcao(o, varargin);
            
        % -----------------------------------------------------------------            
        %                      MERCADO DE OPÇÕES
        [totCompra] = CustoCompraOpcao(o, varargin);     
        [totVenda]  = CustoVendaOpcao(o, varargin);    

        % -----------------------------------------------------------------            
        %            MERCADO DE OPÇÕES - EXERCIDO EM AÇÕES
        [totVenda]  = Exercido(o, varargin);     
        
        
        % -----------------------------------------------------------------
        %            MERCADO DE OPÇÕES - PROTEÇÃO OBTIDA.
        
    end
    
end

