function objeto = fnConverteMAT2(ticker)

% (*) Uma vez em que eu pego as 'structs' pelo 'ticker' eu farei uma fun��o
%     que calcula todos os �ndices bizurrados. 
% (*) Primeiramente eu farei a convers�o dos dados brutos das empresas em
%     dados palp�veis. O nome da empresa vem seguido de BRUTO. Pegarei o
%     nome da empresa sem bruto e farei a convers�o desse nome para um nome
%     sem da empresa.

% 1) ROE.
[ROE_T, ROE_A] = fnROE(ticker);
objeto.ROE_T = ROE_T;
objeto.ROE_A = ROE_A;

% 2) ROA.
[ROA_T, ROA_A] = fnROA(ticker);
objeto.ROA_T = ROA_T;
objeto.ROA_A = ROA_A;

% 3. �ndice de Solvencia de Caixa
[Indice_de_Solvencia_de_Caixa_T] = fnIndiceSolvenciaCaixa(ticker);
objeto.Indice_de_Solvencia_de_Caixa_T = Indice_de_Solvencia_de_Caixa_T;

% 4. �ndice de Liquidez Seca
[IndiceLiquidezSeca] = fnIndiceLiquidezSeca(ticker);
objeto.Indice_de_Liquidez_Seca_T = IndiceLiquidezSeca;


end

