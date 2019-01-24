clear all; close all; clc;

% Carrega as matrizes do sistema linearizado.
load('Matrizes.mat');
syms k1 k2 k3 k4;
syms s;

% Matrizes de ganho de realimentação.
K  = [k1 0 k3 0;
      k2 0 k4 0];
J  = [k1 k3;
      k2 k4];  
Acl = A- B*K;
Bcl = B*J;

sys = simplifyFraction(C*((eye(4)*s - Acl)^-1)*Bcl + D);
sys = vpa(sys);
[symNum, symDen] = numden(sys);
TFnum = sym2poly(symNum);    %Convert Symbolic num to polynomial
TFden = sym2poly(symDen);    %Convert Symbolic den to polynomial
