clear; close all; clc;


% Assim funciona. ALELUIA.
X = load('petrobras.mat');

B = fieldnames(X)
C = fieldnames(X.(B{1}))
D = fieldnames(X.(B{1}).(C{2}))
