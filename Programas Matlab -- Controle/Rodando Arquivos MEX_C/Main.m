clear all; close all; clc;

TAM = 100000;

tic;
for i = 1:TAM
   a(i) = timestwo([i 1], 1);
end
primeiro = toc;

tic;
for i=1:TAM
   b(i) = 2*(i + 1) + 1;
end
segundo = toc;
