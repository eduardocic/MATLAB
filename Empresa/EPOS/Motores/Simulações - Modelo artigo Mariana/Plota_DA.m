function [] = Plota_DA(V)

% (*) Plota Regi�o do Dom�nio de Atra��o.
% ---------------------------------------


V1  = V(1:end,1);
V2  = V(1:end,2);

%% �rea do Dom�nio de Atra��o
area(V1, V2, 'FaceColor', 'w');  % na cor branca.
grid;
end




