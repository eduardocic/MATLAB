clear all; close all; clc;

% Caso perturbado.
load('EstudoAceleracaoPaperXG_03.mat');
A = An;
B = Bn;
C = Cn;
D = Dn;

% Caso nominal.
load('EstudoAceleracaoPaperNominal.mat');

% Diferenças entre as matrizes para determinação de Ap.
Ap = An - A;
Bp = Bn - B;
Cp = Cn - C;