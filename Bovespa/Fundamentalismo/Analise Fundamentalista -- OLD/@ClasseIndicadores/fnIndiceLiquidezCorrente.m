function [o] = fnIndiceLiquidezCorrente(o)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Eduardo H. Santos
% Data: 03/03/2017
%
%                         DEFINI��O 'Ynvestimentos'
%                        ---------------------------
% 
% link: http://ynvestimentos.com.br/2014/01/indices-e-indicadores-financeiros/
%
% O �ndice de liquidez corrente � o melhor indicador de solv�ncia de curto 
% prazo, pois revela a prote��o dos credores em curto prazo por ativos, 
% onde h� uma expectativa que estes possam ser convertidos em dinheiro 
% rapidamente. A f�rmula para se calcular o �ndice de liquidez corrente � a 
% seguinte:
% 
%                              Ativo Circulante  
%   IndiceLiquidezCorrente = --------------------
%                             Passivo Circulante
% 
% Como podemos notar atrav�s da f�rmula, seu c�lculo � feito a partir dos 
% direitos de curto prazo da empresa, como caixa, estoques, contas a 
% receber e as d�vidas de curto prazo, como empr�stimos e financiamentos. 
% Se o resultado do �ndice de liquidez corrente for > 1, significa que a 
% empresa possui meios de honrar com suas obriga��es de curto prazo, 
% demonstrando uma folga no dispon�vel. Se o resultado for = 1, significa 
% que os direitos e obriga��es de curto prazo s�o iguais. J� se o resultado
% for < 1, a empresa poder� apresentar problemas, pois suas 
% disponibilidades s�o insuficientes para honrar com suas obriga��es de 
% curto prazo.
% 
% Entretanto, apresentar um alto �ndice de liquidez corrente pode n�o ser 
% t�o bom assim, pois poder� significar que a empresa possui muito dinheiro 
% atrelado a ativos n�o produtivos, como estoques que n�o est�o sendo 
% vendidos e se tornando obsoletos. O correto sempre � analisar os �ndices 
% do setor, achando uma m�dia para o �ndice de liquidez corrente. Se 
% estiver acima da m�dia, poder� ser uma boa not�cia, mas se estiver muito 
% abaixo da m�dia, pode ser que a empresa esteja passando por dificuldades
% financeiras.
% -------------------------------------------------------------------------
%
% (*) Na planilha do Fundamentos:
%
% -------------------------------------------------------------------------
% |        �ndice       |       Planilha        | Equival�ncia |  Posi��o |
% -------------------------------------------------------------------------
% |  Ativo Circulante   |   'BAL. PATRIMONIAL'  |      T1      | Linha 4  |
% | Passivo Circulante  |   'BAL. PATRIMONIAL'  |      T1      | Linha 28 |
% -------------------------------------------------------------------------
%
% (*) No caso do presente programa, o que c�lculo ser� tomado utilizando-se
%     os �ltimos 12 meses do ano, calculados a cada trimestre. Ou seja, em
%     cada trimestre, eu irei olhar os resultados do trimestre atual e dos
%     �ltimos 3 para fechar o balan�o.
%
% (*) O Patrim�nio l�quido ser� tomado a partir do �ltimo balan�o
%     disponibilizado.
%
% (*) O Lucro L�quido ser� tomado a partir da m�dia dos 4 �ltimos balan�os
%     disponibilizados.
%
% (*) Ap�s a obten��o do valor, multiplica-se o mesmo por 100% para obter o
%     o seu valor em '%'.
% 
% (*) Comentar a  respeito de maior, menor ou igual a 1.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
AtivoCirculante   = o.Tabela1.AtivoCirculante;
PassivoCirculante = o.Tabela1.PassivoCirculante;

% 1.: C�lculo do �ndice.
o.Indicador.IndiceLiquidezCorrente.y = AtivoCirculante./PassivoCirculante;
o.Indicador.IndiceLiquidezCorrente.x = o.Data.TRIMESTRE;

end