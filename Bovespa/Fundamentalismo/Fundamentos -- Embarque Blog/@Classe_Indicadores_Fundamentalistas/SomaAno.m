function [SaidaX, SaidaY] = SomaAno(o, y)

% 1.: Verifica a quantidade de anos.
% -----------------------------------
Ano   = o.Data.Ano;
Mes   = o.Data.Mes;
n     = max(size(Ano));   % Quantos Trimestres disponíveis?

% 2.: Realiza o somatório dos 4 últimos trimestres.
% -------------------------------------------------
contador = 0;
if (n >= 4)     
    for i = 4:n
        if(Mes(i) == 12)
            soma     = 0;
            contador = contador + 1;
            for j = i:-1:(i-3)
                soma = soma + y(j);
            end
            SaidaX(contador) = Ano(i);
            SaidaY(contador) = soma;
        end
    end
else
    SaidaX = Ano;
    SaidaY = y;
end

end