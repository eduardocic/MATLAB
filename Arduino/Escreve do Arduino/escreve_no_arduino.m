clear all; close all; clc;
instrreset;

% Apresenta a porta do arduino disponível para comunicação serial.
PORTA = seriallist;

% Criando um objeto serial.
Arduino = serial(PORTA);

% Abre o objeto.
fopen(Arduino);

% Manda escrever no Arduino.
fwrite(Arduino, 1);

% No caso, se eu quiser enviar mais algum parâmetro ao Arduino, eu não
% preciso fechar a porta em si. Ou seja, no caso eu simplesmente comento as
% linhas abaixo.
fclose(Arduino);
delete(Arduino);