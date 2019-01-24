function [a] = fn_MargemEBIT(a)

% Eduardo H. Santos
% Data: 15/03/2017
%
%   Significado
%  -------------
%
%   MARGEM EBIT faz a medição dos lucros da empresa para cada R$ 1,00 de
%   vendas, antes de descontar as despesas financeiras e os impostos.
%
%   Cálculo
%  ----------        
%
%                   Resultado Antes do Resultado Financeiro e dos Tributos
%    Margem EBIT = -------------------------------------------------------- x 100%
%                          Receita de Vendas de Bens e/ou Serviços
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
ResultadoAntesDoResultadoFinanceiroEDosTributos    = a.DemResultados.ResultadoAntesDoResultadoFinanceiroEDosTributos;
ReceitaDeVendasDeBensEOUServicos                   = a.DemResultados.ReceitaDeVendaDeBensEOUServicos;

% 1.: Será calculado tomando-se sempre os 4 últimos trimestres.

% [Tri, ResultadoAntesDoResultadoFinanceiroEDOSTributos] = SomaUltimosQuatroTrimestres(o, ResultadoAntesDoResultadoFinanceiroEDOSTributos)
% [~, ReceitaDeVendasDeBensEOUServicos] = SomaUltimosQuatroTrimestres(o, ReceitaDeVendasDeBensEOUServicos)

% 1.: Cálculo do Índice.
a.Indicador.MargemEBIT.y = 100*(ResultadoAntesDoResultadoFinanceiroEDosTributos./ReceitaDeVendasDeBensEOUServicos);
a.Indicador.MargemEBIT.x = a.Data.TRIMESTRE;

end