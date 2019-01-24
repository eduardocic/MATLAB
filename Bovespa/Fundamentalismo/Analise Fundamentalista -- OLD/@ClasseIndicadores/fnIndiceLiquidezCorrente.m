function [o] = fnIndiceLiquidezCorrente(o)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Eduardo H. Santos
% Data: 03/03/2017
%
%                         DEFINIÇÃO 'Ynvestimentos'
%                        ---------------------------
% 
% link: http://ynvestimentos.com.br/2014/01/indices-e-indicadores-financeiros/
%
% O índice de liquidez corrente é o melhor indicador de solvência de curto 
% prazo, pois revela a proteção dos credores em curto prazo por ativos, 
% onde há uma expectativa que estes possam ser convertidos em dinheiro 
% rapidamente. A fórmula para se calcular o índice de liquidez corrente é a 
% seguinte:
% 
%                              Ativo Circulante  
%   IndiceLiquidezCorrente = --------------------
%                             Passivo Circulante
% 
% Como podemos notar através da fórmula, seu cálculo é feito a partir dos 
% direitos de curto prazo da empresa, como caixa, estoques, contas a 
% receber e as dívidas de curto prazo, como empréstimos e financiamentos. 
% Se o resultado do índice de liquidez corrente for > 1, significa que a 
% empresa possui meios de honrar com suas obrigações de curto prazo, 
% demonstrando uma folga no disponível. Se o resultado for = 1, significa 
% que os direitos e obrigações de curto prazo são iguais. Já se o resultado
% for < 1, a empresa poderá apresentar problemas, pois suas 
% disponibilidades são insuficientes para honrar com suas obrigações de 
% curto prazo.
% 
% Entretanto, apresentar um alto índice de liquidez corrente pode não ser 
% tão bom assim, pois poderá significar que a empresa possui muito dinheiro 
% atrelado a ativos não produtivos, como estoques que não estão sendo 
% vendidos e se tornando obsoletos. O correto sempre é analisar os índices 
% do setor, achando uma média para o índice de liquidez corrente. Se 
% estiver acima da média, poderá ser uma boa notícia, mas se estiver muito 
% abaixo da média, pode ser que a empresa esteja passando por dificuldades
% financeiras.
% -------------------------------------------------------------------------
%
% (*) Na planilha do Fundamentos:
%
% -------------------------------------------------------------------------
% |        Índice       |       Planilha        | Equivalência |  Posição |
% -------------------------------------------------------------------------
% |  Ativo Circulante   |   'BAL. PATRIMONIAL'  |      T1      | Linha 4  |
% | Passivo Circulante  |   'BAL. PATRIMONIAL'  |      T1      | Linha 28 |
% -------------------------------------------------------------------------
%
% (*) No caso do presente programa, o que cálculo será tomado utilizando-se
%     os últimos 12 meses do ano, calculados a cada trimestre. Ou seja, em
%     cada trimestre, eu irei olhar os resultados do trimestre atual e dos
%     últimos 3 para fechar o balanço.
%
% (*) O Patrimônio líquido será tomado a partir do último balanço
%     disponibilizado.
%
% (*) O Lucro Líquido será tomado a partir da média dos 4 últimos balanços
%     disponibilizados.
%
% (*) Após a obtenção do valor, multiplica-se o mesmo por 100% para obter o
%     o seu valor em '%'.
% 
% (*) Comentar a  respeito de maior, menor ou igual a 1.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
AtivoCirculante   = o.Tabela1.AtivoCirculante;
PassivoCirculante = o.Tabela1.PassivoCirculante;

% 1.: Cálculo do Índice.
o.Indicador.IndiceLiquidezCorrente.y = AtivoCirculante./PassivoCirculante;
o.Indicador.IndiceLiquidezCorrente.x = o.Data.TRIMESTRE;

end