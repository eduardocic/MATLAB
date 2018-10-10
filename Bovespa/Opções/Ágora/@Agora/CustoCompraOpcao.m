function [TotalCompra] = CustoCompraOpcao(o, varargin)
     Quant  = varargin{1};
     Preco  = varargin{2};
            
     % 1º Parte -- RESUMO DOS NEGÓCIOS
     FinCompra   = Quant*Preco;
            
     % 2. Parte -- CBLC
     Imposto     = o.CorretagemXPi*(o.ISS + o.PIS + o.COFINS)/100;
     Emolumentos = FinCompra*o.EmolOpcao/100;
     Liquidacao  = FinCompra*o.LiqOpcao/100;
     Registro    = FinCompra*o.RegOpcao/100;
            
     TotalCompra = FinCompra + o.CorretagemXPi + Imposto + Emolumentos ...
                   + Liquidacao + o.OutrosBovespa*o.CorretagemXPi/100 + ...
                   Registro;
end