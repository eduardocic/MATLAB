clear; close all; clc;

%%% Tempo da Discretização.
T = 1;            

%%% Carrega as matrizes de estado.
MatrizesDeEstado;

%%% Carrega as bases para o programa.
x0;                 % Estado Inicial.
Pesos;              % Matrizes de Peso.
Restricoes;         % Restrições do Sistema, vetor H.

%%% Modelo x(k+1) = A{1}x(k) + B{1}*uk.
N     = 1000;
xk{1}  = xk0;

h  = waitbar(0, sprintf('Calculando...', n));   % Waitbox.
for i=1:N
   uk{i}  = LMI_Matlab(xk{i}, A, B, S, R, Smeio, Rmeio, H, Umax, rho); 
   xk{i+1} = A{1}*xk{i} + B{1}*uk{i};
   
   waitbar(i/(N));
end

% _________________________________________________________________________
%                          Salva o Resultado.
% _________________________________________________________________________
uk = cell2mat(uk);
xk = cell2mat(xk);

Result = struct('uk', uk, 'xk', xk);   % struct com as variáveis.
save('Resultado.mat', 'Result');

PlanoDeFases;


