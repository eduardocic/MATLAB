clear all; close all; clc;

% Pontos do grid.
x = [10 15];        % Temperatura.
y = [10 11];        % '%' de etanol.

% Concentração de hidroxilas (OH-) para os pontos do grid.
Q = [0.98393 0.98267;
     0.98304 0.98171];

% Ponto de interesse.
X = 12;
Y = 10.5;

% Cálculo das inversas.
invY = [y(1) 1;
        y(2) 1]^-1;
invX = [x(1) 1;
        x(2) 1]^-1;    
    
% Resultado final.
Qxy  = [Y 1]*invY*Q'*invX'*[X 1]';

    

