function [o] = fnROE(o)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Eduardo H. Santos
% Data: 03/03/2017
% 
%                           DEFINIÇÃO 'EMPIRICUS'
%                          -----------------------
% 
% link: http://www.empiricus.com.br/termo/roe/?xpromo=XE-ME-WSE-X-X-X-OS-X-X
%
% O ROE mede a rentabilidade da empresa para os acionistas. ROE = return on
% equity (na sigle em inglês) = lucro líquido/patrimônio líquido.
%
% O numerador normalmente é o lucro acumulado nos últimos 12 meses. E o 
% denominador pode ser extraído do último balanço ou calculado como uma 
% média dos últimos 12 meses.
% 
% O ROE mede o retorno sobre o capital investido na empresa (para empresas 
% sem dívidas). O ROE mede a eficiência dos lucros para os acionistas das 
% empresas.
%
% O ROE mede a qualidade dos investimentos da companhia para gerar 
% crescimento de lucros futuros. O ROE mede a eficiência da alocação de 
% capital.
%
% Não se deve utilizar o ROE sem entender o que acontece com a empresa. 
% Como todo múltiplo, por ser de simples medição, o ROE esconde muito do 
% que acontece com as companhias.
%
% -------------------------------------------------------------------------
%
% (*) Na planilha do Fundamentos:
%
% -------------------------------------------------------------------------
% |        Índice       |       Planilha        | Equivalência |  Posição |
% -------------------------------------------------------------------------
% |   Lucro Líquido     |    'DEMONSTRATIVO'    |      T2      | Linha 26 |
% | Patrimônio Líquido  |   'BAL. PATRIMONIAL'  |      T1      | Linha 48 |
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


% 1.: Pega os valores disponibilizados Trimestre a Trimestre na tabela do
%     Fundamentos.
LucroTrimestre    = o.Tabela2.LucroPeriodo;
PatrimonioLiquido = o.Tabela1.PatrimonioLiquido;
n = max(size(o.Data.Ano));

% 2.: Realiza o somatório dos últimos 4 meses do lucro líquido.
for i=n:-1:4
   soma = 0;
   for j=i:-1:i-3
      soma = soma + LucroTrimestre(j);
   end
   LucroLiquido(i-3) = soma;
end

% 3.: Atualiza o Patrimônio Líquido.
PatrimonioLiquido = PatrimonioLiquido(4:end);

% 4.: Cálculo bruto do ROE.
ROE = LucroLiquido./PatrimonioLiquido;

% 5.: Cálculo do ROE em %.
ROE = 100*ROE;

% 6.: Separa os Trimestres
Data = o.Data.TRIMESTRE(4:end);

% 7.: Salva o indicador
o.Indicador.ROE.x = Data;
o.Indicador.ROE.y = ROE;

end