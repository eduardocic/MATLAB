clear all; close all; clc;

%  Eduardo H. Santos
%  23/03/2017
% 
% Para a confecção deste exemplo, é interessante que se tenha o
% conhecimento da função 'rand' do Matlab e que esteja bem firme o conceito
% de média e variância na cabeça do caboclo. 
%
% 1.: a função 'rand' cria números uniformemente distribuidos no intervalo
%     especificado (dá um 'help rand'), o qual aqui será tratado entre [a,
%     b].
%
% 2.: para funções uniformemente distribuidas, tem-se que a média e a
%     variância são:
%
%                     media =  E[x] = (b+a)/12
%
%                    sigma2 = (b-a)^2/12
%
% 3.: para a distribuição normal, o que se tem é:
%
%                     media = E[x] = m
%
%                    sigma2 = E[x^2] - m^2
%
% 4.: com a finalidade de a partir da distribuição uniforme, obtermos uma
%     distribuição normal com média 0 e variância 1, a ideia pode ser 
%     resumida da seguinte forma.
%
%    -- gerar um valor uniformemente distribuindo entre 0 e 1 (faz isso com
%       a função 'rand'). Neste caso, tem-se que o 'a = 0' e 'b = 1'.
%       Isso faz com que sigma2 = 1/12 e a media = 1/2.
%
%    -- como eu desejo uma variância de 1, se eu somar 12 variáveis
%       uniformemente distribuidas no intervalo [0, 1] eu terei ao final um
%       valor resultante da soma 1/12 + 1/12 + ... 1/12 = 1 ( o que já
%       atende à variância de interesse). 
%
%    -- como a média de uma variável uniformemente distribuída é 1/2, se eu
%       somar 12 variáveis eu terei um valor de média = 6. 
%
%    -- para então ter uma variável que apresente sempre, média = 0 e 
%       sigma2 = 1, o seguinte procedimento é realizado: eu somo 12
%       variaveis uniformemente distribuidas e do valor da soma eu subtraio
%       6.
%
%    -- quanto maior for o valor de 'N', mais fidedigno é o modelo criado.

N = 100000;            % Número de variáveis as quais eu desejo criar
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
clc;