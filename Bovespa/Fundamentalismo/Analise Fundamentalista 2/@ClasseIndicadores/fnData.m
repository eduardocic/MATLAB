function [o] = fnData(o,varargin)

%%% Captação das datas no formato completo, conforme linha abaixo.
[o.Data.Ano, o.Data.Mes, ~, ~, ~, ~] = datevec(o.Data);
n = max(size(o.Data.Ano));


%%% Verifica se tem informação requerida para o offset.
if (isempty(varargin))
    offsetTRIMESTRE = 0;
    offsetANO       = 0;
else
    offsetTRIMESTRE = varargin;
end


%%% Captação das datas no formato de TRIMESTRES e ANO.
contador  = 0;
for i=1:n
    o.Data.TRIMESTRE(i) = ((o.Data.Mes(i)-1.5)/12) + o.Data.Ano(i) - offsetTRIMESTRE;      
    
    if (mod(o.Data.Mes(i), 12) == 0)
        contador = contador + 1;
        o.Data.ANO(contador)  = o.Data.Ano(i) + offsetANO;   % com offset para o gráfico.
    end
end

end