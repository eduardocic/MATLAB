function [o] = fnMargemBruta(o)

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
%                              Lucro Bruto
%            Margem Bruta  = ----------------- x 100%
%                             Receita L�quida
%
%
% (*) Na planilha do Fundamentos:
%
% -------------------------------------------------------------------------
% |        �ndice       |       Planilha        | Equival�ncia |  Posi��o |
% -------------------------------------------------------------------------
% |     Lucro Bruto     |    'DEMONSTRATIVO'    |      T2      | Linha 7  |
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
LucroBruto     = o.Tabela2.ResultadoBruto;
ReceitaLiquida = o.Tabela2.ReceitaLiquidaVendasServicos;

% 1.: C�lculo do �ndice.
o.Indicador.MargemBruta.y = 100*(LucroBruto./ReceitaLiquida);
o.Indicador.MargemBruta.x = o.Data.TRIMESTRE;

end