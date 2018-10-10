function [o] = fnNomeEmpresa(o)

StringCompleta = cell2mat(o.Textos(1,2));
N = max(size(StringCompleta));
for i=1:N
   if (StringCompleta(i) == '-')
       PosicaoNome = i+1;
   end
end

% Concatena nome da Empresa.
string1 = '';
for i = PosicaoNome:N
   string1 = strcat(string1, StringCompleta(i)); 
end

o.NomeEmpresa      = upper(string1);

end

