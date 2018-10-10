%%erl - A ideia base desse arquivo é fazer como que encontremos o domínio de
% atração do sistema no espaço 2D;

% - Para tal, o que faremos aqui é correr um vetor da forma:
%   
%    xk0 = [cos(theta);
%           sin(theta)];

% - Determinaremos, assim, a região do domínio de atraçao.

close all; clear; clc;

%% 1.: Matrizes de Estados Incertas.
MatrizesDeEstados;

Linha = linspace(0,180,181)';
V = 0*[Linha Linha];

Umax = 1;

for i = 1:181
   theta = i-1; 
   Epsilon = [cos(theta*pi/180);
              sin(theta*pi/180)]; 
    
   ConsMultiVetor = LMI_DominioDeAtracao(A, B, Epsilon, Umax);
   Vetor = ConsMultiVetor*Epsilon';
   V(i,:) = Vetor;
end   
V = [-V; V];

PlotaRegiao;
