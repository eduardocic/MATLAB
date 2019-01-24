clear all; close all; clc;

% Carrega as matrizes linearizadas.
% ---------------------------------
load('MatrizesDeEstado.mat');

% Dinâmica longitudinal.
% ----------------------
long = [1 2 5 8];          % Vt, alpha, theta e q.
for i=1:max(size(long))
    x = long(i);
    cont = 0;
    for j=1:max(size(long))
        cont = cont + 1;
        y = long(j);
        Along(i,cont) = A(x, y);
    end
end

% Dinâmica lateral.
% -----------------
lat  = [3 4 7 9];    % beta, phi, p e r.
for i=1:max(size(lat))
    x = lat(i);
    cont = 0;
    for j=1:max(size(lat))
        cont = cont + 1;
        y = lat(j);
        Alat(i,cont) = A(x, y);
    end
end