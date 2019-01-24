function [flag, SaidaX, SaidaY] = SomaAcumuladaAnoIncompleto(o, y)

% 1.: Verifica a quantidade de anos.
% -----------------------------------
Ano   = o.Data.Ano;
Mes   = o.Data.Mes;
n     = max(size(Ano));      % Quantos Trimestres disponíveis?

% 2.: Realiza o somatório dos 4 últimos trimestres.
% -------------------------------------------------
contador  = 0;
soma      = 0;

% if(n >= 3)  
if (Mes(n) ~= 12)       % Ano incompleto?  
    flag = 1;
    if (Mes(n) == 9)
        index = 2;
    elseif (Mes(n) == 6)
        index = 1;
    elseif (Mes(n) == 3)
        index = 0;
    end
    
    for j = n:-1:(n-index) 
           soma = soma + y(j);
    end
    SaidaX(1) = o.Data.TRIMESTRE(n);
    SaidaY(1) = soma; 
else
    flag = 0;
    SaidaX(1) = 0;
    SaidaY(1) = 0; 
end

end