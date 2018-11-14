clear all; close all; clc;
instrreset;

% Apresenta a porta do arduino disponível para comunicação serial.
PORTA = seriallist;

% Criando um objeto serial.
Arduino = serial(PORTA);

% Abre o objeto.
fopen(Arduino);


i = 0;
% Lendo os dados.
while (i < 100) 
   i = i + 1;
   
   % Para eu receber uma variável do tipo 'float', eu simplesmente utilizo
   % o código acima.
   A(i) = fread(Arduino, 1 ,'single');
   A(i)
end

fclose(Arduino);
delete(Arduino);