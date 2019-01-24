function [a] = fn_DividaLiquida(a)

% Eduardo H. Santos
% Data: 16/03/2017
% 
%   Significado
%  -------------
%
%   DÍVIDA LÍQUIDA é o valor total da dívida da empresa em determinado
%   momento da história retirando algum possível dinheiro que a empresa
%   tenha em Caixa e em Aplicações Financeiroas. Ou seja, o que sobra da
%   dívida da empresa depois de se pagar com o dinheiro de alta liquidez
%   disponível.
%
%
%   Cálculo
%  ----------
%
%     Dívida Líquida = Dívida Bruta - Caixa e Equivalente de Caixa -
%                      Aplicações Financeiras
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
% |'1.01.01'        | 'Caixa e Equivalente de Caixa'                     |
% |'1.01.02'        | 'Aplicações Financeiras'                            |
% -------------------------------------------------------------------------

% 1.: Pega os valores disponibilizados 'Trimestre a Trimestre' na tabela do
%     Fundamentos.
CurtoPrazo               = a.Passivos.EmprestimosEFinanciamentos;
LongoPrazo               = a.Passivos.EmprestimosEFinanciamentos2;
CaixaEEquivalenteDeCaixa = a.Ativos.CaixaEEquivalenteDeCaixa; 
AplicacoesFinanceiras    = a.Ativos.AplicacoesFinanceiras;

% 2.: Agrupa o resultado
a.Indicador.DividaLiquida.x = a.Data.TRIMESTRE;
a.Indicador.DividaLiquida.y = CurtoPrazo + LongoPrazo - ...
                              CaixaEEquivalenteDeCaixa - AplicacoesFinanceiras;

end