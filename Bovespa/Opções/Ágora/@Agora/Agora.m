classdef Agora
    % Essa Classe faz todo o c�lculo necess�rio para o tratamento com a��es
    % e o��es utilizando a plataforma da XP Investimentos.
    
    properties
        ISS               % (I)mposto (S)obre (S)ervi�o.
        PIS               % (P)rograma de (I)ntegra��o (S)ocial.
        COFINS            % (CO)ntribui��o para o (F)inanciamento de 
                          % (S)eguridade (S)ocial.
                          
        EmolAcao          % Para A��o.
        EmolOpcao         % Para Op��o.        
        LiqAcao           % Taxa de Liquida��o para A��o.
        LiqAcaoEx         % Taxa de Liquida��o para A��o -- Caso Exercido.

        LiqOpcao          % Taxa de Liquida��o para Op��o -- Venda Op��o.
        RegOpcao          % Taxa de Registro para Op��o.
        
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
        %               MERCADO � VISTA -- APENAS A��ES.
        [totCompra] = CustoCompraAcao(o, varargin);     
        [totVenda]  = CustoVendaAcao(o, varargin);
            
        % -----------------------------------------------------------------            
        %                      MERCADO DE OP��ES
        [totCompra] = CustoCompraOpcao(o, varargin);     
        [totVenda]  = CustoVendaOpcao(o, varargin);    

        % -----------------------------------------------------------------            
        %            MERCADO DE OP��ES - EXERCIDO EM A��ES
        [totVenda]  = Exercido(o, varargin);     
        
        
        % -----------------------------------------------------------------
        %            MERCADO DE OP��ES - PROTE��O OBTIDA.
        
    end
    
end

