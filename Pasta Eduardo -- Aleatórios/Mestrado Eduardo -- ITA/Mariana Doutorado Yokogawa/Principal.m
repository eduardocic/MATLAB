clear; close all; clc;

% % 0) Inclui as pastas com as funções.
% raiz    = pwd;
% subRaiz = {'Funções'; 'LMIs'};
% 
% nMax = max(size(subRaiz));
% for i = 1:nMax
%     rmpath([raiz '\' subRaiz{i,:}]);
%     addpath([raiz '\' subRaiz{i,:}]); 
% end

% 1) Carrega os dados originais da planta: 
PreLoad;

% 2) Construção do Politopo - APENAS ATRASO.
[Ad, Bd, Cd] = InsereAtrasos(A, B, C, tao); 

% 3) Construção do Politopo - ATRASO + INTEGRADOR.
N = size(Ad,2);
for i=1:N
    [AdI{i}, BdI{i}] = InsereIntegrador(Ad{i}, Bd{i}, Cd);
end
f   = size(Cd,1);
g0  = linspace(0,0,f)';
CdI = [Cd g0];


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 4) Passo 1 ao 3 do 1º Algoritmo da Cavalca
n   = size(AdI{1},2) - 1;
% n   = size(Ad{1},2) - 1;

xk0 = [hk zeros(1,n)]';

[Ref, Xref, Eps, yb] = ReferencesCavalca(Ylimites, CdI, xk0);
% [Ref, Xref, Eps, yb] = ReferencesCavalca(Ylimites, Cd, xk0);

% 5) Passo 4 do 1º Algoritmo da Cavalca.
Imax  = max(size(Ref));       % Quantidade de Chaveamentos.
for j = 1:Imax
    [Qsol{j}, Ysol{j}] = LMI_Cavalca(Eps{j}, AdI, BdI, CdI, S, Smeio, R, Rmeio, Umax, yb(j));
%     [Qsol{j}, Ysol{j}] = LMI_Cavalca(Eps{j}, Ad, Bd, Cd, S, Smeio, R, Rmeio, Umax, yb(j));
end