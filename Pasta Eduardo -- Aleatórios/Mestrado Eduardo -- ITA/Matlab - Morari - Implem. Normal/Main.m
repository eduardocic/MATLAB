close all; clear; clc;

%%% Carrega as bases para o programa.
x0_ajustes;
Pesos;
Restricoes;

%%% Carrega as matrizes de estado.
MatrizesEstado;

Size = 300;

xk   = xk0;
X{1} = xk;
U{1} = 0;
h = waitbar(0,'');
for j=2:Size
   tic
   [uk] = LMI_Morari(xk, A, B, C, Smeio, Rmeio, Umax, Ymax);
   Tempo{j} = toc;
   xk   = A{1}*xk + B{1}*uk;
   X{j} = xk;
   U{j} = uk;
   waitbar(j/Size,h,sprintf('Calculando...'));
end
close(h);

X      = cell2mat(X);
U      = cell2mat(U);
Tempo  = cell2mat(Tempo);

file = 'Morari';
save(file,'X', 'U', 'Tempo'); 
clear; clc; 

load Morari;

x1 = X(1,1:end);
x2 = X(2,1:end);
x3 = X(3,1:end);
x4 = X(4,1:end);

stairs(x1); hold; grid;
stairs(x2, 'r');
stairs(x3, 'k');
stairs(x4, 'g');



