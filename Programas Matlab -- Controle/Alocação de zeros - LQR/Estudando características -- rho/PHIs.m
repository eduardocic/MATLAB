function [M] = PHIs(A, B)

syms s

n          = max(size(A));       % Ordem do sistema.
poliCar    = charpoly(A);        % Polinômio característico de A.
phi        = (s*eye(n) - A)^-1;  % Matriz 'phi'.
[num, den] = numden(phi);        % Num. e den. da matriz 'phi'.

for i = 1:n
    for j = 1:n
    % Seleciona a parcela que falta no denominador dos elementos de 'phi'
    % para que consigamos multiplicar esse fator pelo numerador e assim
    % obter a matriz N(s) completa (em função dos termos de ordem completa
    % do sistema).
    coefDen    = sym2poly(den(i,j));
    TermoFalta = deconv(poliCar,coefDen);
    
    % Coeficientes do numerador.
    coefNum     = sym2poly(num(i,j));
    NumCompleto = conv(TermoFalta,coefNum);
    NumeradorPHI(i,j) = poly2sym(NumCompleto);
    end
end

% Pegando apenas a matriz de coeficientes.
Ns = NumeradorPHI*B;
for i = 1:n
      cont  = 0;
      t     = sym2poly(Ns(i));
      ordem = size(t,2); 
      
      for j = 1:n
         if (ordem < n)
             for k = 1:(n-ordem)
                o(k) = 0; 
             end
                M(i,:) = [o t];
         else
             M(i,j) = t(j);
         end
      end
end

end