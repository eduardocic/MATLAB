function [o] = fnDividaBruta(o)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Eduardo H. Santos
% Data: 03/03/2017
%
% (*) Na planilha do Fundamentos:
%
%
%        Dívida Bruta = Div. Longo Prazo + Div. Curto Prazo 
%
% -------------------------------------------------------------------------
% |        Índice       |       Planilha        | Equivalência |  Posição |
% -------------------------------------------------------------------------
% | Empr. e Finan (CP)  |   'Bal. Patrimonial'  |      T1      | Linha 32 |
% | Empr. e Finan (LP)  |   'Bal. Patrimonial'  |      T1      | Linha 39 |
% -------------------------------------------------------------------------
%
% (*) No caso do presente programa, o que cálculo será tomado utilizando-se
%     os últimos 12 meses do ano, calculados a cada trimestre. Ou seja, em
%     cada trimestre, eu irei olhar os resultados do trimestre atual e dos
%     últimos 3 para fechar o balanço.
%
% (*) A dívida de 'curto prazo' é aquela com provisão de pagamento no
%     horizonte de até um ano.
% 
% (*) A dívida de 'longo prazo' é aquela com provisão de pagamento no
%     horizonte de mais de um ano.
%
% (*) Após a obtenção do valor, multiplica-se o mesmo por 100% para obter o
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