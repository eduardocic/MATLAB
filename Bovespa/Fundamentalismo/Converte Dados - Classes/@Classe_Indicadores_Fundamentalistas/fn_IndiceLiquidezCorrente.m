function [a] = fn_IndiceLiquidezCorrente(a)

% Eduardo H. Santos
% Data: 15/03/2017
%
%   Significado
%  -------------
%
%   ÍNDICE DE LIQUIDEZ CORRENTE toma a relação entre as receitas de curto
%   prazo da empresa (contas de caixa + bancos + estoques + clientes a
%   receber) e as dívidas de curto prazo (empréstimos, financiamentos,
%   impostos e fornecedores a pagar).
%
%
%   Cálculo
%  ----------        
% 
%                                  Ativo Circulante  
%     Indice Liquidez Corrente = --------------------
%                                 Passivo Circulante
%  
% (*) O Ativo Circulante será tomado trimestre a trimestre (pois ao
%     fechamento do balanço, o ativo circulante é tomado no prazo
%     olhando-se um ano à frente).
%
% (*) Mesma consideração deverá ser realizada para o Passivo Circulante
%
% (*) É interessante que este valor seja superior a 1.
% 
% (*) Estou utilizando a referência do site FUNDAMENTUS.
%
%
%   Localização dos itens
%  -----------------------
%
% -------------------------------------------------------------------------
% |     Código    |                  Descrição                            |
% -------------------------------------------------------------------------
% | 1.01          | 'Ativo Circulante'                                    |
% | 2.01          | 'Passivo Circulante'                                  |
% -------------------------------------------------------------------------

AtivoCirculante   = a.Ativos.AtivoCirculante;
PassivoCirculante = a.Passivos.PassivoCirculante;

% 1.: Cálculo do Índice.
a.Indicador.IndiceLiquidezCorrente.y = AtivoCirculante./PassivoCirculante;
a.Indicador.IndiceLiquidezCorrente.x = a.Data.TRIMESTRE;

end