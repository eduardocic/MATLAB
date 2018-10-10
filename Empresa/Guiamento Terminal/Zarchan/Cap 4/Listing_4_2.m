clear all; close all; clc;

%  Eduardo H. Santos
%  23/03/2017
% 
%  Para varificar a distribuição das variáveis aleatórias que são criadas a
%  partir da distribuição uniforma, será utilizada a seguinte ideia.
%
%  -- a partir das variáveis uniformemente distribuídas, tem-se que o
%     'pior' valor ao qual se pode obter em se somando 12 variáveis as 
%     quais variam de valor no intervalor [0, 1] é 0 (todas as variáveis 
%     são 0) e o 'melhor' valor é 12 (todas as variáveis são 1).
%
%  -- com isto posto, após subtrair um valor média = 6, ficamos com os
%     possíveis valores oscilando entre -6 (ou seja 0-6) e 6 (ou seja
%     12-0).
%
%  -- com isso, será realizada uma contagem dos valores que estão no
%     intervalo [-6, 6], fazendo com precisão de ao sabor do cliente.
%     no caso eu irei uniformizar este intervalor (de comprimento 12) em um
%     intervalo que varia de 0 até 1.
%
%  -- no caso, o cálculo o algoritmo a ser implementado é o seguinte:
%
%     1. gera os valores Gaussianos (a primeira parte do código pode ser
%     copiada diretamente do exemplo 'Listing_4_1.m').
% 
%     2. subtrai o valor obtido do mínimo valor possível da soma (no caso
%     um valor igual a -6).
%
%     3. verifico ONDE este valor se encontra no espectro de comprimento
%     12. Isto será feito a partir da divisão do resultado obtido no passo
%     2 por 12 (ou seja, frac(i) = (y(i) - (-6))/12). O valor de frac(i),
%     obviamente estará no intervalo [0, 1], pois ele foi uniformizado para
%     isto. Eu multiplicarei o valor de frac(i) por 100 (pois eu desejo
%     fazer uma contagem de 0,01 em 0,01) e verificarei se o número após a
%     vírgula é maior ou menor do que 0,5. Caso seja maior, entrará na
%     conta do número inteiro acima. Caso seja menor, entrará na conta do
%     número inteiro abaixo.


% Primeira parte (igual ao exemplo 'Listing_4_1.m').
% --------------------------------------------------
N = 1000;            % Número de variáveis as quais eu desejo criar
for i = 1:N
    soma = 0;
    for j = 1:12
        % Cria um número uniformemente distribuído.
        randomico = rand(1);   
        soma      = soma + randomico;
    end;
    x = soma - 6;   % subtração para obtenção de média = 0.
    t(i) = i;
    y(i) = x;
end;
figure
plot(t, y); grid;
xlabel('Posição da variáveil');
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

% Normalização do 'cont' (variável contadora). No caso, eu tenho que
% dividir a quantidade de eventos ocorridos em cada contador e dividir pela
% quantidade total de amostras do sistema. 
cont = (cont/N)*(divisao/range);    % ?????
t    = linspace(Vmin, Vmax, divisao);

% Geração do valor esperado (o teórico, por meio da equação de distribuição
% de probabilidade).
inter = linspace(Vmin, Vmax, N);
n     = max(size(inter));
for i=1:n
   p(i) = exp(-(inter(i)^2)/2) /sqrt(2*pi);
end

plot(t, cont, 'LineWidth', 2); hold on;
plot(inter, p, 'r', 'LineWidth', 2);
xlabel('x');
ylabel('Função densidade de probabilidade');

