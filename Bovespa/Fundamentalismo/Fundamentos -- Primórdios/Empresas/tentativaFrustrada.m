clear; close all; clc;


% Assim funciona. ALELUIA.
X = load('petrobras.mat');
% X{2} = load('eztec.mat');

B = fieldnames(X)
C = fieldnames(X.(B{1}))
% D = fieldnames(X.(B{1}).(C{2}))

alfa = X.(B{1}).ROE_T

beta = 'oi';

switch beta
    case 'agua'
        disp('Fela da mãe');
    case 'oi'
        disp('Maravilha');
end
    

