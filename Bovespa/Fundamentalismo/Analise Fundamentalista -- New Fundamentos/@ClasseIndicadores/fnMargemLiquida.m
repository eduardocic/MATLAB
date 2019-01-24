function [o] = fnMargemLiquida(o)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Eduardo H. Santos
% Data: 03/03/2017
%
%                         DEFINIÇÃO 'Ynvestimentos'
%                        ---------------------------
% 
% link: https://endeavor.org.br/margem-bruta/
%
%
%                               Lucro Liquido
%            Margem Líquida = ----------------- x 100%
%                              Receita Líquida
%
%
% (*) Na planilha do Fundamentos:
%
% -------------------------------------------------------------------------
% |        Índice       |       Planilha        | Equivalência |  Posição |
% -------------------------------------------------------------------------
% |     Lucro Líquido   |    'DEMONSTRATIVO'    |      T2      | Linha 26  |
% |    Receita Líquida  |    'DEMONSTRATIVO'    |      T2      | Linha 5  |
% -------------------------------------------------------------------------
%
% (*) Tomando como base o documento da Cyrela, o qual eu baixei no site
%     deles, eles fazem o cálculo trimestre a trimestre (diferentemente do
%     site do Fundamentos, o qual faz o cálculo tomando os últimos 12
%     meses). Eu seguirei o cálculo da Cyrela, ou seja, de trimestre a
%     trimestre.
%
% (*) O seu valor é dado em '%'.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
LucroLiquido   = o.Tabela2.LucroPeriodo;
ReceitaLiquida = o.Tabela2.ReceitaLiquidaVendasServicos;

% 1.: Cálculo do Índice.
o.Indicador.MargemLiquida.y = 100*(LucroLiquido./ReceitaLiquida);
o.Indicador.MargemLiquida.x = o.Data.TRIMESTRE;

end