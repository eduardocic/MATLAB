function [o] = fnConversor(o, varargin)
% *************************************************************************
%     A fun��o 'fnConversor' tem por finalidade ler os dados das tabelas
%  Excel e deix�-lo no formato '*.mat'.
%
%  (*) A primeira parte do programa � verificar quantos arquivos Excel
%      est�o sendo lidos/aberto de uma vez.
%
%  (*) Se houver apenas um arquivo, o primeiro ser� chamado. Caso haja 
%      mais de um, deve-se selecionar a respeito de qual arquivo 
%      est� se tratando.
% *************************************************************************
n = varargin{1};
if(o.flagArquivos == 1)
    o.file = o.Empresa{1};
else
    o.file = o.Empresa{n};
end

% *************************************************************************
%     As abas do Excel carregadas pela fun��o 'uigetfile' inserem 
%   caracteres que n�o s�o v�lidos no ambiente Matlab. No caso, eles s�o 
%   carregados como hexadecimal. De forma a corrigir estes nomes para se 
%   ter menos trabalho de identifica��o de qual arquivo estamos 
%   trabalhando, ser�o, num primeiro momento, corrigido quaisquer problemas
%   de migra��o de dados. No caso, ser�o inseridos os dados sem cedinha 
%   ou acentos.
%
% (*) Cada aba do arquivo Excel carregado apresenta uma estrutura de dados
%    (referenciada no Matlab por 'data') e uma estrutura de texto
%    (referenciada no Matlab por 'textdata');
% 
% (*) As abas carregas ser�o chamadas de 'AbaVelho' (que nada mais � do que
%     o nome original das abas do Excel rec�m carregado); e
%
% (*) O novos nomes das abas, ap�s a corre��o, ser�o chamadas de 'AbaNovo'.
% *************************************************************************
AbaVelho = fieldnames(o.file.textdata);
[NomeArquivo_Matlab, remain] = strtok(o.NomeArquivo_Excel, '.');

disp(['Convertendo o arquivo --- ' o.NomeArquivo_Excel ' ...']);

aspa = '';
Hexa2String = {'0xE7', 'c';
               '0xE3', 'a';
               '0x2E',  '';
               '0x2D',  '';
               '0xED', 'i';};
QuantAbas   = max(size(AbaVelho));
for i=1:QuantAbas
    AbaVelho{i} = strcat(aspa, AbaVelho{i});
    AbaVelho{i} = strcat(AbaVelho{i}, aspa);
    AbaNovo{i}  = AbaVelho{i};
    for j=1:max(size(Hexa2String))
        AbaNovo{i} = regexprep(AbaNovo{i}, Hexa2String{j,1}, Hexa2String{j,2});
    end
end


% *************************************************************************
% (*) Em seguida, reescreva as abas internas utilizando os nomes novos
%     obtidos em 'AbaNovo'.
%
% (*) Rescreve as abas internas de forma a deixa o sistema em 'Portugu�s',
%     ou seja, fazer 'data' se transformar em 'dado' e 'textdata' em
%     'texto' (para facilitar o meu programa no decorrer do processo).
% *************************************************************************
for i = 1:QuantAbas
    % Corrige os par�metros de 'data'.
    if (isfield(o.file.data, AbaVelho{i}))
        [o.file.data.(AbaNovo{i})] = o.file.data.(AbaVelho{i});
    end
    
    if (isfield(o.file.textdata, AbaVelho{i}))
    % Corrige os par�metros de 'textdata'.
        [o.file.textdata.(AbaNovo{i})] = o.file.textdata.(AbaVelho{i});
    end
end

%  Reescreve as abas internas da struct 'file'.
[o.file.('dado')]  = o.file.('data');
[o.file.('texto')] = o.file.('textdata');
o.file = rmfield(o.file,'data');
o.file = rmfield(o.file,'textdata');


% *************************************************************************
%   PRIMEIRA TABELA
%  ------------------
% 
%  (*) A parte de interesse aqui diz respeito � tabela intitulada
%     'Composi��o de Capital' do arquivo baixado do programa Empresa.net
% 
%  (*) Salvarei a DATA do �ltimo dia do referido trimestre da tabela
%      importada.
% *************************************************************************
trimestre = o.file.texto.ComposicaoDoCapital{1,2};
trimestre = strsplit(trimestre);
trimestre = trimestre{end};


% *************************************************************************
%  (*) Procura em qual linha est� posicionada a vari�vel relativa �
%      quantidade de a��es da empresa.
%
% (*) Algumas empresas apresentam as QUANTIDADE DE A��ES, �s vezes, em 
%     MILHAR e, �s vezes, em UNIDADE. No caso, eu criarei uma rotina 
%     que verifica se a quantidade de a��es vem em unidades ou em milhar. 
%     Para tal, a ideia � fazer uma procura por alguma STRING 
%     caracter�stica e se existir ela, � porque existe alguma perspectiva 
%     de milhar ou n�o.
% *************************************************************************
ACOES  = o.file.texto.ComposicaoDoCapital(1,1);
ACOES  = char(ACOES);
texto1 = 'Mil';
texto2 = 'mil';
texto3 = 'Uni';
texto4 = 'uni';
k1 = strfind(texto1, ACOES);
k2 = strfind(texto2, ACOES);
k3 = strfind(texto3, ACOES);
k4 = strfind(texto4, ACOES);
if (isempty(k4) || isempty(k4))
    multi = 0.001;
elseif(isempty(k1) || isempty(k2))
    multi = 1;
else
    multi = 1;
end


% *************************************************************************
% (*) Os texos e os dados da primeira Tabela pegar�o apenas a DATA
%     (referenciado por 'trimestre', a quantidade de a��es dispon�vels no
%     mercado e tamb�m as a��es mantidas em tesouraria pela empresa.
% *************************************************************************
o.file.texto.ComposicaoDoCapital = o.file.texto.ComposicaoDoCapital(2:end,1);
n    = max(size(o.file.texto.ComposicaoDoCapital));
str2 = 'Total - Do Capital Integralizado';
str3 = 'Total - Em Tesouraria';
for i=1:n
    str1     = o.file.texto.ComposicaoDoCapital{i,1}; 
    compara  = strcmp(str1, str2);
    compara2 = strcmp(str1, str3);
    
    if (compara == 1)
        Quant = o.file.dado.ComposicaoDoCapital(i,1);
    end
    
    if (compara2 == 1)
        QuantTesouraria = o.file.dado.ComposicaoDoCapital(i,1);
    end
    
end
o.T1.texto      = {'N�mero de A��es (Mil)'; 'Total de A��es'; 'Total - Em Tesouraria'};
o.T1.data       = trimestre;
o.T1.totalAcoes = Quant*multi;
o.T1.totalAcoesEmTesouraria = QuantTesouraria;          


% *************************************************************************
% (*) Aqui � importante destacar que algumas empresas s�o apresentadas como
%     holding ou como empresas isoladas apenas;
% 
% (*) No caso de voc� ter uma holding, os seus dados v�m de forma
%     consolidada (afinal, voc� olha todo o conjunto da mesma) e no caso de
%     n�o ser, voc� chama apenas o balan�o individual.
% *************************************************************************
flag = isfield(o.file.dado,'DFConsAtivo');
if (flag == 1)
    o = o.fn_Consolidado_Tabela2;
    o = o.fn_Consolidado_Tabela3;
    o = o.fn_Consolidado_Tabela4;
%     o = o.fn_Consolidado_Tabela5;
else
    o = o.fn_Individual_Tabela2;
    o = o.fn_Individual_Tabela3;
    o = o.fn_Individual_Tabela4;
%     o = o.fn_Individual_Tabela5;
end

end