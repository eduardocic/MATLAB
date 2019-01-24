function [a] = fn_MargemLiquida(a)

% Eduardo H. Santos
% Data: 15/03/2017
%
%   Significado
%  -------------
%
%   MARGEM LÍQUIDA corresponde ao que sobra para os acionistas em relação
%   às receitas com vendas e prestações de serviço da empresa. Mostra qual
%   o lucro líquido para cada unidade de venda realizada na empresa.
%
%
%   Cálculo
%  ----------        
% 
%                     Atribuído A Sócios da Empresa Controladora
% Margem Líquida = ----------------------------------------------- x 100%
%                        Receita de Venda de Bens e/ou Serviços
%
%
%   Localização dos itens
%  -----------------------
%
% -------------------------------------------------------------------------
% |     Código    |                  Descrição                            |
% -------------------------------------------------------------------------
% | 3.01          | 'Receita de Venda de Bens e/ou Serviços'              |
% | 3.11.01       | 'Atribuído A Sócios da Empresa Controladora'          |
% -------------------------------------------------------------------------

AtribuidoASociosDaEmpresaControladora   = a.DemResultados.AtribuidoASociosDaEmpresaControladora;
ReceitaDeVendaDeBensEOUServicos         = a.DemResultados.ReceitaDeVendaDeBensEOUServicos;


% 1.: Cálculo do Índice.
a.Indicador.MargemLiquida.y = 100*(AtribuidoASociosDaEmpresaControladora./ReceitaDeVendaDeBensEOUServicos);
a.Indicador.MargemLiquida.x = a.Data.TRIMESTRE;

end