function [o] = fnDividaLiquida(o)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Eduardo H. Santos
% Data: 03/03/2017
%
% (*) Na planilha do Fundamentos:
%
%       Divida Liquida = Divida Bruta - (Cx e Equi. Cx  +  Aplic. Fin.)
%
%
%      1. D�vida Bruta = Div. Longo Prazo + Div. Curto Prazo
%
%
% -------------------------------------------------------------------------
% |        �ndice       |       Planilha        | Equival�ncia |  Posi��o |
% -------------------------------------------------------------------------
% |    Cx e Equi. Cx    |   'Bal. Patrimonial'  |      T1      | Linha 5  |
% |     Aplic. Fin.     |   'Bal. Patrimonial'  |      T1      | Linha 6  |
% | Empr. e Finan (CP)  |   'Bal. Patrimonial'  |      T1      | Linha 32 |
% | Empr. e Finan (LP)  |   'Bal. Patrimonial'  |      T1      | Linha 39 |
% -------------------------------------------------------------------------
%
% (*) No caso do presente programa, o que c�lculo ser� tomado utilizando-se
%     os �ltimos 12 meses do ano, calculados a cada trimestre. Ou seja, em
%     cada trimestre, eu irei olhar os resultados do trimestre atual e dos
%     �ltimos 3 para fechar o balan�o.
%
% (*) A d�vida de 'curto prazo' � aquela com provis�o de pagamento no
%     horizonte de at� um ano.
% 
% (*) A d�vida de 'longo prazo' � aquela com provis�o de pagamento no
%     horizonte de mais de um ano.
%
% (*) Ap�s a obten��o do valor, multiplica-se o mesmo por 100% para obter o
%     o seu valor em '%'.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% 1.: Pega os valores disponibilizados 'Trimestre a Trimestre' na tabela do
%     Fundamentos.
CurtoPrazo            = o.Tabela1.EmprestimosFinanciamentos1;
LongoPrazo            = o.Tabela1.EmprestimosFinanciamentos2;
CaixaEquivalenteCaixa = o.Tabela1.CxEquiCx;
AplicacaoFinanceira   = o.Tabela1.ApliFinanceira;

% 2.: Agrupa o resultado
o.Indicador.DividaLiquida.x = o.Data.TRIMESTRE;
o.Indicador.DividaLiquida.y = CurtoPrazo + LongoPrazo ...
                              -(CaixaEquivalenteCaixa + AplicacaoFinanceira);

end