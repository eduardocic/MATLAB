function [] = DentroOuForaDoDominioAtracao(V, xk0);

V1 = V(:,1);
V2 = V(:,2);

%% Determina��o se o Ponto est� ou n�o dentro do Dom�nio de Atra��o
[Dentro, Superficie] = inpolygon(xk0(1), xk0(2), V1, V2);

if (Dentro == 1)
    h = msgbox('Ponto Dentro do Dom�nio de Atra��o.');
elseif (Superficie == 1)
    h = msgbox('Ponto no Limite do Dom�nio de Atra��o.');
else
    h = msgbox('Ponto Fora do Dom�nio de Atra��o.');
end

end