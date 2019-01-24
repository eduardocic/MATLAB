function [a] = fn_DividaBruta(a)

% Eduardo H. Santos
% Data: 16/03/2017
% 
%   Significado
%  -------------
%
%   DÍVIDA BRUTA é o valor total da dívida da empresa em determinado
%   momento da história. Ou seja, é o valor total devido pela empresa em um
%   determinado instante de tempo.
%
%
%   Cálculo
%  ----------
%
%     Dívida Total = Empréstimos e Financiamentos + Empréstimos e Financiamentos
%   
%
%   Localização dos itens
%  -----------------------
%
% -------------------------------------------------------------------------
% |     Código      |                  Descrição                          |
% -------------------------------------------------------------------------
% |'2.01.04'        | 'Empréstimos e Financiamentos'                      |
% |'2.02.01'        | 'Empréstimos e Financiamentos'                      |
% -------------------------------------------------------------------------


% 1.: Pega os valores disponibilizados 'Trimestre a Trimestre' na tabela do
%     Fundamentos.
CurtoPrazo           = a.Passivos.EmprestimosEFinanciamentos;
LongoPrazo           = a.Passivos.EmprestimosEFinanciamentos2;

% 2.: Agrupa o resultado
a.Indicador.DividaBruta.x = a.Data.TRIMESTRE;
a.Indicador.DividaBruta.y = CurtoPrazo + LongoPrazo;

end