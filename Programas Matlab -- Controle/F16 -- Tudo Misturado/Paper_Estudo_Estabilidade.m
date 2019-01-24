clear all; close all; clc;

% Carrega as matrizes.
load('MatrizesDeEstado.mat');
vetor = [2 8];       % alpha e q.
    
% Desacopla din�mica de acelera��o.
for i = 1:max(size(vetor))
x    = vetor(i);
cont = 0;
    for j = 1:max(size(vetor))
        cont = cont + 1;
        y    = vetor(j);
        An(i,cont) = A(x, y);
        Cn(i, j) = C(i, y);
    end 
Bn(i) = B(x, 2);        % Elevator.
Dn(i) = D(i, 2);
end

% Inser��o da �ltima linha C*.
Cn(3, 1) = C(3,2);
Cn(3, 2) = C(3,8);
Dn(3)    = Dn(2);

Bn = Bn';
Dn = Dn';

save('EstudoAceleracaoPaperNominal.mat', 'An','Bn','Cn','Dn');
    
  