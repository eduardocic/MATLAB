close all; clear all; clc;

% Carrega as matrizes de estado.
load('MatrizesDeEstadoEnvelope.mat');

% Dinâmicas longitudinal e latero-direcional.
long = [1 2 5 8];       % Vt, alpha, theta, q e h.
lat  = [3 4 7 9];       % beta, phi, p e r.

% Quantidade máxima de rodadas por intervalo.
quantMax = max(size(a));

for k = 1:quantMax
    A = a{k};
    B = b{k};
    
    % Dinâmica Logitudinal.
    for i=1:max(size(long))
    x    = long(i);
    cont = 0;
        for j=1:max(size(long))
            cont = cont + 1;
            y    = long(j);
            Along(i,cont) = A(x, y);
        end 
        
    Blong(i) = B(x, 2);        
    end
    
    % Dinâmica Lateral.
    Blat = [];
    for i=1:max(size(lat))
    x = lat(i);
    cont = 0;
        for j=1:max(size(lat))
            cont = cont + 1;
            y = lat(j);
            Alat(i,cont) = A(x, y);
        end
    Blat = [Blat; B(x, 3:4)];        
    end
    
    % Salva as respectivas.
    A_long{k} = Along;
    B_long{k} = Blong';
    C_long{k} = eye(max(size(Along)));
    D_long{k} = zeros(max(size(Along)),1);
    
    A_lat{k}  = Alat;
    B_lat{k}  = Blat;
    C_lat{k}  = eye(max(size(Alat)));
    D_lat{k}  = zeros(max(size(Alat)),1);
end


save('DinamicaLongitudinal_RetoNivelado', 'A_long', 'B_long', 'C_long', 'D_long');
save('DinamicaLateroDirecional_RetoNivelado', 'A_lat', 'B_lat', 'C_lat', 'D_lat');