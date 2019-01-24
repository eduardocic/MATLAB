function [TotalVenda] = CustoVendaOpcao(o, varargin)
      Quant  = varargin{1};
      Preco  = varargin{2};
            
      % 1º Parte -- RESUMO DOS NEGÓCIOS
      FinVenda    = Quant*Preco;
            
      % 2. Parte -- CBLC
      Imposto      = o.CorretagemXPi*(o.ISS + o.PIS + o.COFINS)/100;
      ImpostoRenda = o.IRRF*FinVenda/100;
      Emolumentos  = FinVenda*o.EmolOpcao/100;
      Liquidacao   = FinVenda*o.LiqOpcao/100;
      Registro     = FinVenda*o.RegOpcao/100;      
            
      TotalVenda   = FinVenda - o.CorretagemXPi - (Imposto + ImpostoRenda) - ...
                     Emolumentos - Liquidacao - o.OutrosBovespa*o.CorretagemXPi/100 - ...
                     Registro;
end
        