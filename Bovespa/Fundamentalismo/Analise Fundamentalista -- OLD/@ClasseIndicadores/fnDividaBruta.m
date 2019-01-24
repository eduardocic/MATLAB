function [o] = fnDividaBruta(o)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Eduardo H. Santos
% Data: 03/03/2017
%
% (*) Na planilha do Fundamentos:
%
%
%        D�vida Bruta = Div. Longo Prazo + Div. Curto Prazo 
%
% -------------------------------------------------------------------------
% |        �ndice       |       Planilha        | Equival�ncia |  Posi��o |
% -------------------------------------------------------------------------
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
CurtoPrazo           = o.Tabela1.EmprestimosFinanciamentos1;
LongoPrazo           = o.Tabela1.EmprestimosFinanciamentos2;

% 2.: Agrupa o resultado
o.Indicador.DividaBruta.x = o.Data.TRIMESTRE;
o.Indicador.DividaBruta.y = CurtoPrazo + LongoPrazo;

end