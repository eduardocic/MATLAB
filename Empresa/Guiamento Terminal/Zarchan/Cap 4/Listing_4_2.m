clear all; close all; clc;

%  Eduardo H. Santos
%  23/03/2017
% 
%  Para varificar a distribui��o das vari�veis aleat�rias que s�o criadas a
%  partir da distribui��o uniforma, ser� utilizada a seguinte ideia.
%
%  -- a partir das vari�veis uniformemente distribu�das, tem-se que o
%     'pior' valor ao qual se pode obter em se somando 12 vari�veis as 
%     quais variam de valor no intervalor [0, 1] � 0 (todas as vari�veis 
%     s�o 0) e o 'melhor' valor � 12 (todas as vari�veis s�o 1).
%
%  -- com isto posto, ap�s subtrair um valor m�dia = 6, ficamos com os
%     poss�veis valores oscilando entre -6 (ou seja 0-6) e 6 (ou seja
%     12-0).
%
%  -- com isso, ser� realizada uma contagem dos valores que est�o no
%     intervalo [-6, 6], fazendo com precis�o de ao sabor do cliente.
%     no caso eu irei uniformizar este intervalor (de comprimento 12) em um
%     intervalo que varia de 0 at� 1.
%
%  -- no caso, o c�lculo o algoritmo a ser implementado � o seguinte:
%
%     1. gera os valores Gaussianos (a primeira parte do c�digo pode ser
%     copiada diretamente do exemplo 'Listing_4_1.m').
% 
%     2. subtrai o valor obtido do m�nimo valor poss�vel da soma (no caso
%     um valor igual a -6).
%
%     3. verifico ONDE este valor se encontra no espectro de comprimento
%     12. Isto ser� feito a partir da divis�o do resultado obtido no passo
%     2 por 12 (ou seja, frac(i) = (y(i) - (-6))/12). O valor de frac(i),
%     obviamente estar� no intervalo [0, 1], pois ele foi uniformizado para
%     isto. Eu multiplicarei o valor de frac(i) por 100 (pois eu desejo
%     fazer uma contagem de 0,01 em 0,01) e verificarei se o n�mero ap�s a
%     v�rgula � maior ou menor do que 0,5. Caso seja maior, entrar� na
%     conta do n�mero inteiro acima. Caso seja menor, entrar� na conta do
%     n�mero inteiro abaixo.


% Primeira parte (igual ao exemplo 'Listing_4_1.m').
% --------------------------------------------------
N = 1000;            % N�mero de vari�veis as quais eu desejo criar
for i = 1:N
    soma = 0;
    for j = 1:12
        % Cria um n�mero uniformemente distribu�do.
        randomico = rand(1);   
        soma      = soma + randomico;
    end;
    x = soma - 6;   % subtra��o para obten��o de m�dia = 0.
    t(i) = i;
    y(i) = x;
end;
figure
plot(t, y); grid;
xlabel('Posi��o da vari�veil');
ylabel('Valor');



% Segunda parte (contador).
% -------------------------
Vmax     = 6;
Vmin     = -6;
range    = Vmax - Vmin;
divisao  = 100;             % Quero dividir o comprimento 1 em 100 partes.

for i = 1:divisao 
    cont(i) = 0; 
end

for i = 1:N
    frac(i)  = (y(i) - Vmin)/range;
    frac(i)  = frac(i)*divisao;
    pInteira = fix(frac(i));            % pego parte inteira.
    resto    = frac(i) - pInteira;      % quero verifica o resto.
    
    % Se for maior do que 0,5 eu conto o valor para cima, se for menor eu
    % conto o valor correspondente.
    if (resto >= 0.5)
        k = pInteira + 1;
    else
        k = pInteira;
    end
    cont(k) = cont(k) + 1;
end

% Normaliza��o do 'cont' (vari�vel contadora). No caso, eu tenho que
% dividir a quantidade de eventos ocorridos em cada contador e dividir pela
% quantidade total de amostras do sistema. 
cont = (cont/N)*(divisao/range);    % ?????
t    = linspace(Vmin, Vmax, divisao);

% Gera��o do valor esperado (o te�rico, por meio da equa��o de distribui��o
% de probabilidade).
inter = linspace(Vmin, Vmax, N);
n     = max(size(inter));
for i=1:n
   p(i) = exp(-(inter(i)^2)/2) /sqrt(2*pi);
end

plot(t, cont, 'LineWidth', 2); hold on;
plot(inter, p, 'r', 'LineWidth', 2);
xlabel('x');
ylabel('Fun��o densidade de probabilidade');

