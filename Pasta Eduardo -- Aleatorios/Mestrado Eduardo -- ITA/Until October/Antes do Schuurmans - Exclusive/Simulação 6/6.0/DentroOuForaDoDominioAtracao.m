function [] = DentroOuForaDoDominioAtracao(V, xk0);

V1 = V(:,1);
V2 = V(:,2);

%% Determinação se o Ponto está ou não dentro do Domínio de Atração
[Dentro, Superficie] = inpolygon(xk0(1), xk0(2), V1, V2);

if (Dentro == 1)
    h = msgbox('Ponto Dentro do Domínio de Atração.');
elseif (Superficie == 1)
    h = msgbox('Ponto no Limite do Domínio de Atração.');
else
    h = msgbox('Ponto Fora do Domínio de Atração.');
end

end