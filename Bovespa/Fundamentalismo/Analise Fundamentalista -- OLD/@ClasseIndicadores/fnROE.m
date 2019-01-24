function [o] = fnROE(o)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Eduardo H. Santos
% Data: 03/03/2017
% 
%                           DEFINI��O 'EMPIRICUS'
%                          -----------------------
% 
% link: http://www.empiricus.com.br/termo/roe/?xpromo=XE-ME-WSE-X-X-X-OS-X-X
%
% O ROE mede a rentabilidade da empresa para os acionistas. ROE = return on
% equity (na sigle em ingl�s) = lucro l�quido/patrim�nio l�quido.
%
% O numerador normalmente � o lucro acumulado nos �ltimos 12 meses. E o 
% denominador pode ser extra�do do �ltimo balan�o ou calculado como uma 
% m�dia dos �ltimos 12 meses.
% 
% O ROE mede o retorno sobre o capital investido na empresa (para empresas 
% sem d�vidas). O ROE mede a efici�ncia dos lucros para os acionistas das 
% empresas.
%
% O ROE mede a qualidade dos investimentos da companhia para gerar 
% crescimento de lucros futuros. O ROE mede a efici�ncia da aloca��o de 
% capital.
%
% N�o se deve utilizar o ROE sem entender o que acontece com a empresa. 
% Como todo m�ltiplo, por ser de simples medi��o, o ROE esconde muito do 
% que acontece com as companhias.
%
% -------------------------------------------------------------------------
%
% (*) Na planilha do Fundamentos:
%
% -------------------------------------------------------------------------
% |        �ndice       |       Planilha        | Equival�ncia |  Posi��o |
% -------------------------------------------------------------------------
% |   Lucro L�quido     |    'DEMONSTRATIVO'    |      T2      | Linha 26 |
% | Patrim�nio L�quido  |   'BAL. PATRIMONIAL'  |      T1      | Linha 48 |
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


% 1.: Pega os valores disponibilizados Trimestre a Trimestre na tabela do
%     Fundamentos.
LucroTrimestre    = o.Tabela2.LucroPeriodo;
PatrimonioLiquido = o.Tabela1.PatrimonioLiquido;
n = max(size(o.Data.Ano));

% 2.: Realiza o somat�rio dos �ltimos 4 meses do lucro l�quido.
for i=n:-1:4
   soma = 0;
   for j=i:-1:i-3
      soma = soma + LucroTrimestre(j);
   end
   LucroLiquido(i-3) = soma;
end

% 3.: Atualiza o Patrim�nio L�quido.
PatrimonioLiquido = PatrimonioLiquido(4:end);

% 4.: C�lculo bruto do ROE.
ROE = LucroLiquido./PatrimonioLiquido;

% 5.: C�lculo do ROE em %.
ROE = 100*ROE;

% 6.: Separa os Trimestres
Data = o.Data.TRIMESTRE(4:end);

% 7.: Salva o indicador
o.Indicador.ROE.x = Data;
o.Indicador.ROE.y = ROE;

end