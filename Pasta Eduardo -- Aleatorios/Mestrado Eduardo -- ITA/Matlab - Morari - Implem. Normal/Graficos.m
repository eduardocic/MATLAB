%%% Plota Morari.
clear; clc; 

load Morari;

x1 = X(1,1:end);
x2 = X(2,1:end);
x3 = X(3,1:end);
x4 = X(4,1:end);
u  = U(1,1:end); 
t  = Tempo(1,1:end);

stairs(x1); hold; grid;
stairs(x2, 'r');
stairs(x3, 'k');
stairs(x4, 'g');
