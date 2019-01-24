clear all; close all; clc;

%  Eduardo H. Santos
%  23/03/2017
% 
% Para a confec��o deste exemplo, � interessante que se tenha o
% conhecimento da fun��o 'rand' do Matlab e que esteja bem firme o conceito
% de m�dia e vari�ncia na cabe�a do caboclo. 
%
% 1.: a fun��o 'rand' cria n�meros uniformemente distribuidos no intervalo
%     especificado (d� um 'help rand'), o qual aqui ser� tratado entre [a,
%     b].
%
% 2.: para fun��es uniformemente distribuidas, tem-se que a m�dia e a
%     vari�ncia s�o:
%
%                     media =  E[x] = (b+a)/12
%
%                    sigma2 = (b-a)^2/12
%
% 3.: para a distribui��o normal, o que se tem �:
%
%                     media = E[x] = m
%
%                    sigma2 = E[x^2] - m^2
%
% 4.: com a finalidade de a partir da distribui��o uniforme, obtermos uma
%     distribui��o normal com m�dia 0 e vari�ncia 1, a ideia pode ser 
%     resumida da seguinte forma.
%
%    -- gerar um valor uniformemente distribuindo entre 0 e 1 (faz isso com
%       a fun��o 'rand'). Neste caso, tem-se que o 'a = 0' e 'b = 1'.
%       Isso faz com que sigma2 = 1/12 e a media = 1/2.
%
%    -- como eu desejo uma vari�ncia de 1, se eu somar 12 vari�veis
%       uniformemente distribuidas no intervalo [0, 1] eu terei ao final um
%       valor resultante da soma 1/12 + 1/12 + ... 1/12 = 1 ( o que j�
%       atende � vari�ncia de interesse). 
%
%    -- como a m�dia de uma vari�vel uniformemente distribu�da � 1/2, se eu
%       somar 12 vari�veis eu terei um valor de m�dia = 6. 
%
%    -- para ent�o ter uma vari�vel que apresente sempre, m�dia = 0 e 
%       sigma2 = 1, o seguinte procedimento � realizado: eu somo 12
%       variaveis uniformemente distribuidas e do valor da soma eu subtraio
%       6.
%
%    -- quanto maior for o valor de 'N', mais fidedigno � o modelo criado.

N = 100000;            % N�mero de vari�veis as quais eu desejo criar
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
clc;