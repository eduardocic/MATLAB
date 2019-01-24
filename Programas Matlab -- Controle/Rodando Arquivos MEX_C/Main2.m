clear all; close all; clc;

% O outro deu 0,0126
TAM = 1000;

tic
for i=1:TAM
   b(i) = 2*(i + 1) + 1;
end
segundo = toc;