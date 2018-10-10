function [o] = fnLucroLiquido(o)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Eduardo H. Santos
% Data: 03/03/2017
%
% (*) Na planilha do Fundamentos:
%
% -------------------------------------------------------------------------
% |        Índice       |       Planilha        | Equivalência |  Posição |
% -------------------------------------------------------------------------
% |   Lucro Líquido     |    'DEMONSTRATIVO'    |      T2      | Linha 26 |
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


% 1.: Pega os valores disponibilizados 'Trimestre a Trimestre' na tabela do
%     Fundamentos.
LucroTrimestre           = o.Tabela2.LucroPeriodo;
o.Indicador.LucroLiquido.Trimestre.x = o.Data.TRIMESTRE;
o.Indicador.LucroLiquido.Trimestre.y = LucroTrimestre;


% 2.: Encontrar quem que é o Primeiro Trimestres o último Trimestre para o
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
      uT = i;        % Último trimestre.
      break
   end
end
LucroTrimestre = LucroTrimestre(pT:uT);
Ano            = o.Data.Ano(pT:uT);


% 3.: Cálculo da soma do Lucro Líquido para o ano
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