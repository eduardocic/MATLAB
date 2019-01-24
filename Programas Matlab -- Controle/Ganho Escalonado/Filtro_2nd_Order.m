clear all; close all; clc;

% -------------------------------------------------------------------------
% * Este programa tem a finalidade de reproduzir a cria��o de plantas LTI
%   dentro de um grid de valores que varia para a mesma.
%
% * No caso, foi tomado o seguinte filtro:
%
%                   wn^2
%  F(s) = ---------------------------
%           s^2 + 2*eta*wn*s + wn^2
%
% Eduardo H. Santos.
% 28/08/2017
% -------------------------------------------------------------------------

% 1. Criando as vari�veis de ajustes com os seguintes valores de 
%    inicializa��o (estes ultimos poderiam ser quaiquer valores).
wn   = realp('wn',3);
zeta = realp('zeta',0.8);

% 2. Criando o modelo generalizado (com as vari�veis generalizadas 'wn' e
%    'zeta'.
F    = tf(wn^2,[1 2*zeta*wn wn^2]);

% 3. � interesse que a vari�vel 'wn' possa assumir 2 valores (3 e 5) e que
%    a vari�vel 'zeta' possa assumir 3 valores (0,6, 0,8 e 1,0). Sendo
%    assim, fa�amos as vari�veis 'wn' e 'zeta' variarem por esses valores.
wn_vals   = [3;5];
zeta_vals = [0.6, 0.8, 1.0];

% 4. Criando os poss�veis filtros 'F' para a combina��o dos valores
%    especificados na vari�veis 'wn_vals' e 'zeta_vals'.
Fsample = replaceBlock(F, 'wn', wn_vals, 'zeta', zeta_vals);

% 5. Este comando fornece o tamanho da fun��o de transfer�ncia
%    parametrizada para os valores de 'wn' e 'zeta' acima. Para acessa as
%    vari�veis nesse caso, tem-se uma dimens�o da forma 2x3 para o
%    'Fsample'.
size(Fsample)

% 6. Resposta ao degrau de 'Fsample'. No caso todas as respostas dos
%    poss�veis sistemas ser�o apresentadas.
step(Fsample); grid on;

% 7. Resposta em frequ�ncia (Diagrama de Bode).
figure;
bode(Fsample); grid on;

