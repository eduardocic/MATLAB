function [o] = fnMargemLiquida(o)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Eduardo H. Santos
% Data: 03/03/2017
%
%                         DEFINI��O 'Ynvestimentos'
%                        ---------------------------
% 
% link: https://endeavor.org.br/margem-bruta/
%
%
%                               Lucro Liquido
%            Margem L�quida = ----------------- x 100%
%                              Receita L�quida
%
%
% (*) Na planilha do Fundamentos:
%
% -------------------------------------------------------------------------
% |        �ndice       |       Planilha        | Equival�ncia |  Posi��o |
% -------------------------------------------------------------------------
% |     Lucro L�quido   |    'DEMONSTRATIVO'    |      T2      | Linha 26  |
% |    Receita L�quida  |    'DEMONSTRATIVO'    |      T2      | Linha 5  |
% -------------------------------------------------------------------------
%
% (*) Tomando como base o documento da Cyrela, o qual eu baixei no site
%     deles, eles fazem o c�lculo trimestre a trimestre (diferentemente do
%     site do Fundamentos, o qual faz o c�lculo tomando os �ltimos 12
%     meses). Eu seguirei o c�lculo da Cyrela, ou seja, de trimestre a
%     trimestre.
%
% (*) O seu valor � dado em '%'.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
LucroLiquido   = o.Tabela2.LucroPeriodo;
ReceitaLiquida = o.Tabela2.ReceitaLiquidaVendasServicos;

% 1.: C�lculo do �ndice.
o.Indicador.MargemLiquida.y = 100*(LucroLiquido./ReceitaLiquida);
o.Indicador.MargemLiquida.x = o.Data.TRIMESTRE;

end