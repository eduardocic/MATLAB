function [a] = fn_DespesasPorLucroBruto(a)

% Eduardo H. Santos
% Data: 18/03/2017
% 
%   Significado
%  -------------
%
%   DESPERAS POR LUCRO BRUTO serve para se ter uma noção se há ou não 
%   muitos gastos operacionais com o negócio em si. Segundo o livro do 
%   pessoal do Buffet, é interessante que tal índice seja baixo. Acima de 
%   80% é horrível. Considerado excelente é abaixo de 30%.
%
%
%   Cálculo
%  ----------
%
%   Despesas totais  = Despesas com venda + gerais e administrativas
%
%
%   Localização dos itens
%  -----------------------
%
% -------------------------------------------------------------------------
% |     Código    |                  Descrição                            |
% -------------------------------------------------------------------------
% |    3.04.01    | 'Despesas com Vendas'                                 |
% |    3.04.02    | 'Despesas Gerais e Administrativas'                   |
% |    3.03       | 'Resultado Bruto'                                     |
% -------------------------------------------------------------------------
DespesasComVendas              = a.DemResultados.DespesasComVendas;
DespesasGeraisEAdministrativas = a.DemResultados.DespesasGeraisEAdministrativas;
ResultadoBruto                 = a.DemResultados.ResultadoBruto;

% Cálculo da despesas
Despesas = DespesasComVendas + DespesasGeraisEAdministrativas; 

% Indicador relativo à despesas.
a.Indicador.Despesas.y = Despesas;
a.Indicador.Despesas.x = a.Data.TRIMESTRE;

% Irei multiplicar por -1 para ter um valor padronizado.
a.Indicador.DespesasPorLucroBruto.y = (-1)*Despesas./ResultadoBruto;
a.Indicador.DespesasPorLucroBruto.x = a.Data.TRIMESTRE;


end