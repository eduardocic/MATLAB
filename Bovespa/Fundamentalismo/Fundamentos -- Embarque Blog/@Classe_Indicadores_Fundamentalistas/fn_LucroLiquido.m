function [a] = fn_LucroLiquido(a)

% Eduardo H. Santos
% Data: 15/03/2017
% 
%   Significado
%  -------------
%
%   LUCRO LÍQUIDO é relativo a todo a receita obtida pela empresa já
%   tirando todas as obrigações.
%
%
%   Cálculo
%  ----------
%
% (*) O Lucro Líquido (Ano) será tomado a partir da soma dos 4 balanços do
%     ano completo.
%
% (*) O Lucro Líquido (Trimestre) se preocupará apenas com os valores
%     referente àquele trimestre considerado.
% 
% (*) É interessante que o valor seja crescente.
%
%
%   Localização dos itens
%  -----------------------
%
% -------------------------------------------------------------------------
% |     Código    |                  Descrição                            |
% -------------------------------------------------------------------------
% | 3.11.01       | 'Atribuído a Sócios da Empresa Controladora'          |
% -------------------------------------------------------------------------

% 1.: Realiza a conta direta em relação ao referido trimestre.
LucroTrimestre           = a.DemResultados.AtribuidoASociosDaEmpresaControladora;
a.Indicador.LucroLiquido.Trimestre.x = a.Data.TRIMESTRE;
a.Indicador.LucroLiquido.Trimestre.y = LucroTrimestre;

% 2.: Faz o cálculo para o ano.
[SaidaX, SaidaY] = SomaAno(a, LucroTrimestre);
[flag, SaidaX2, SaidaY2] = SomaAcumuladaAnoIncompleto(a, LucroTrimestre);
if (flag == 1)    
    a.Indicador.LucroLiquido.Ano.x  = [SaidaX SaidaX2];
    a.Indicador.LucroLiquido.Ano.y  = [SaidaY SaidaY2];
else
    a.Indicador.LucroLiquido.Ano.x  = SaidaX;
    a.Indicador.LucroLiquido.Ano.y  = SaidaY;
end
end