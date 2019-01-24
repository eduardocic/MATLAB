function [a] = fn_MargemBruta(a)

% Eduardo H. Santos
% Data: 15/03/2017
%
%   Significado
%  -------------
%
%   MARGEM BRUTA representa quanto à empresa obtém de retorno das vendas,
%   retirando os custos das mercadorias venvidas e serviços prestados. A
%   margem bruta representa quanto sobra após considerar estes custos.
%
%
%   Cálculo
%  ----------        
%
%                                 Receita Bruta
%    Margem Bruta = ---------------------------------------- x 100%
%                     Receita de Venda de Bens e/ou Serviços
%
%
%   Localização dos itens
%  -----------------------
%
% -------------------------------------------------------------------------
% |     Código    |                  Descrição                            |
% -------------------------------------------------------------------------
% | 3.01          | 'Receita de Venda de Bens e/ou Serviços'              |
% | 3.03          | 'Resultado Bruto'                                     |
% -------------------------------------------------------------------------
ResultadoBruto                       = a.DemResultados.ResultadoBruto;
ReceitaDeVendasDeBensEOUServicos     = a.DemResultados.ReceitaDeVendaDeBensEOUServicos;

% 1.: Cálculo do Índice.
a.Indicador.MargemBruta.y = 100*(ResultadoBruto./ReceitaDeVendasDeBensEOUServicos);
a.Indicador.MargemBruta.x = a.Data.TRIMESTRE;

end