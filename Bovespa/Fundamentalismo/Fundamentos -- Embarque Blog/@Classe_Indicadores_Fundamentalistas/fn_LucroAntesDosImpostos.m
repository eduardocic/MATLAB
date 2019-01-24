function [a] = fn_LucroAntesDosImpostos(a)

% Eduardo H. Santos
% Data: 18/03/2017
% 
%   Significado
%  -------------
%
%    LUCRO ANTES DOS IMPOSTOS é a situação que mostra o lucro bruto antes
%    de serem pagos os impostos (lembre-se: "IMPOSTO È ROUBO!!!").
%
%
%   Cálculo
%  ----------
%
%
%   Localização dos itens
%  -----------------------
%
% -------------------------------------------------------------------------
% |     Código    |                  Descrição                            |
% -------------------------------------------------------------------------
% |    3.07       | 'Resultado Antes dos Tributos sobre o Lucro'          |
% -------------------------------------------------------------------------
LucroAntesDosImpostos = a.DemResultados.ResultadoAntesDosTributosSobreOLucro;

a.Indicador.LucroAntesDosImpostos.y = LucroAntesDosImpostos;
a.Indicador.LucroAntesDosImpostos.x = a.Data.TRIMESTRE;

end