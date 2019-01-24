function [TotalVenda]  = Exercido(o, varargin)  
      Quant  = varargin{1};
      Preco  = varargin{2};
            
      % 1º Parte -- RESUMO DOS NEGÓCIOS
      FinVenda    = Quant*Preco;


      Corretagem  = 19.90;
%       if (FinVenda <= 135.07)
%           Corretagem = 2.7;
%       elseif (FinVenda >= 135.08 && FinVenda <= 498.62) 
%           Corretagem = 0.02*FinVenda;
%       elseif (FinVenda >= 498.63 && FinVenda <= 1514.69) 
%           Corretagem = 2.49 + 0.015*FinVenda;
%       elseif (FinVenda >= 1514.70 && FinVenda <= 3029.38) 
%           Corretagem = 10.06 + 0.01*FinVenda;
%       else
%           Corretagem = 25.21 + 0.005*FinVenda;
%       end

            
      % 2. Parte -- CBLC
      Imposto      = Corretagem*(o.ISS + o.PIS + o.COFINS)/100;
      Emolumentos  = FinVenda*o.EmolAcao/100;
      Liquidacao   = FinVenda*o.LiqAcaoEx/100;
            
      TotalVenda   = FinVenda - Corretagem - Imposto - ...
                     Emolumentos - Liquidacao - o.OutrosBovespa*Corretagem/100;
end