function [o] = fnLucroLiquido(o)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Eduardo H. Santos
% Data: 03/03/2017
%
% (*) Na planilha do Fundamentos:
%
% -------------------------------------------------------------------------
% |        �ndice       |       Planilha        | Equival�ncia |  Posi��o |
% -------------------------------------------------------------------------
% |   Lucro L�quido     |    'DEMONSTRATIVO'    |      T2      | Linha 26 |
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


% 1.: Pega os valores disponibilizados 'Trimestre a Trimestre' na tabela do
%     Fundamentos.
LucroTrimestre           = o.Tabela2.LucroPeriodo;
o.Indicador.LucroLiquido.Trimestre.x = o.Data.TRIMESTRE;
o.Indicador.LucroLiquido.Trimestre.y = LucroTrimestre;


% 2.: Encontrar quem que � o Primeiro Trimestres o �ltimo Trimestre para o
%     fechamento de anos inteiros.
Meses = o.Data.Mes;
for i=1:4
   if (Meses(i) == 3)
      pT = i;       % Primeiro trimestre.
   end
end

n = max(size(Meses));
for i=n:-1:(n-3)
   if (Meses(i) == 12)
      uT = i;        % �ltimo trimestre.
      break
   end
end
LucroTrimestre = LucroTrimestre(pT:uT);
Ano            = o.Data.Ano(pT:uT);


% 3.: C�lculo da soma do Lucro L�quido para o ano
contador = 0;
soma = 0;
for i=1:max(size(LucroTrimestre))
   soma = soma + LucroTrimestre(i);
   if (mod(i,4) == 0)
       contador = contador + 1;
       o.Indicador.LucroLiquido.Ano.x(contador) = Ano(i);
       o.Indicador.LucroLiquido.Ano.y(contador) = soma;
       soma = 0;
   end
end

end