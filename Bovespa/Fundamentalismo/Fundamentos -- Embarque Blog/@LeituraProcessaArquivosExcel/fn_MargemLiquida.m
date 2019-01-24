function [a] = fn_MargemLiquida(a)

% Eduardo H. Santos
% Data: 15/03/2017
%
%   Significado
%  -------------
%
%   MARGEM L�QUIDA corresponde ao que sobra para os acionistas em rela��o
%   �s receitas com vendas e presta��es de servi�o da empresa. Mostra qual
%   o lucro l�quido para cada unidade de venda realizada na empresa.
%
%
%   C�lculo
%  ----------        
% 
%                     Atribu�do A S�cios da Empresa Controladora
% Margem L�quida = ----------------------------------------------- x 100%
%                        Receita de Venda de Bens e/ou Servi�os
%
%
%   Localiza��o dos itens
%  -----------------------
%
% -------------------------------------------------------------------------
% |     C�digo    |                  Descri��o                            |
% -------------------------------------------------------------------------
% | 3.01          | 'Receita de Venda de Bens e/ou Servi�os'              |
% | 3.09          | 'Resultado L�quido das Operacoes Continuadas'         |
% -------------------------------------------------------------------------
ReceitaDeVendaDeBensEOUServicos         = a.DemResultados.ReceitaDeVendaDeBensEOUServicos;
AtribuidoASociosDaEmpresaControladora   = a.DemResultados.ResultadoLiquidoDasOperacoesContinuadas;

% 1.: C�lculo do �ndice.
a.Indicador.MargemLiquida.y = 100*(AtribuidoASociosDaEmpresaControladora./ReceitaDeVendaDeBensEOUServicos);
a.Indicador.MargemLiquida.x = a.Data.TRIMESTRE;

end