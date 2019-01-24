function [a] = fn_ResultadoDeVendas(a)

% Eduardo H. Santos
% Data: 18/03/2017
%
%   Significado
%  -------------
%
%   RESULTADO DE VENDAS BRUTAS faz a mensuração de vendas ou não da
%   empresa.
%
%
%   Cálculo
%  ----------        
%
%
%   Localização dos itens
%  -----------------------
%
% --------------------------------------------------------------------------------------
% |     Código    |                               Descrição                            |
% --------------------------------------------------------------------------------------
% |     3.01      | 'Receita de Venda de Bens e/ou Serviços'                           |
% |     3.05      | 'Resultado Resultado Antes do Resultado Financeiro e dos Tributos' |                                   |
% --------------------------------------------------------------------------------------
ReceitaDeVendasDeBensEOUServicos   = a.DemResultados.ReceitaDeVendaDeBensEOUServicos;

% 1.: Será calculado tomando-se sempre os 4 últimos trimestres.

% 2.: Cálculo do Índice.
a.Indicador.Vendas.y = ReceitaDeVendasDeBensEOUServicos;
a.Indicador.Vendas.x = a.Data.TRIMESTRE;

end