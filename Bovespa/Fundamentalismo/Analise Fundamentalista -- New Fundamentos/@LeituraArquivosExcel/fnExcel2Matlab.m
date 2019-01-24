function [o] = fnExcel2Matlab(o, varargin)

i = varargin{1};

o.Tabela1   = o.Empresa{i}.data.Bal0x2EPatrim0x2E;          % Primeira Tabela.
o.Tabela2   = o.Empresa{i}.data.Dem0x2EResult0x2E;          % Segunda Tabela.
o.Textos    = o.Empresa{i}.textdata.Bal0x2EPatrim0x2E;      % Todos os textos. 
o.Datas     = o.Textos(2,2:end);                            % Todas as datas.


% Flipar os vetores.
% ------------------
n1 = size(o.Tabela1,1);        % Variáveis totais Tabela-1.      
n2 = size(o.Tabela2,1);        % Variáveis totais Tabela-2.      
m  = size(o.Tabela1,2);        % Balanços.

% 1. Tabela 1.
for i = 1:n1
    Intermed = o.Tabela1(i,:);
    Intermed = wrev(Intermed);
    o.Tabela1(i,:) = Intermed;
end

for i = 1:n2
    Intermed = o.Tabela2(i,:);
    Intermed = wrev(Intermed);
    o.Tabela1(i,:) = Intermed;
end

o.Datas = wrev(o.Datas);


end