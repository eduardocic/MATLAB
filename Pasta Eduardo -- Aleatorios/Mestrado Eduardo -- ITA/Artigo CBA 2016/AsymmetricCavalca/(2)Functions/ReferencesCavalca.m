%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Esta função determinará as pseudo-referências utilizadas por Cavalca

function [r, xref, Eps, yb] = ReferencesCavalca(Y, C, xk0)
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% 1. Determinação das referências em y
Ymax = Y(1,2);
Ymin = Y(1,1);

y0 = C*xk0;

r(1) = (Ymax + y0)/2;       % Primeiro Caso
i = 2;

while(abs(r(i-1)) > Ymax)
    r(i) = (Ymax + r(i-1))/2;
    i = i+1;
end
r(i) = 0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% 2. Determinação das referências em x.
for j = 1:i
    xref{j} = mldivide(C, r(j));
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% 3. Determinação das referências em x.
Eps{1} = xk0 - xref{1};
yb(1)  = Ymax - r(1);
for j = 2:i
    Eps{j} = xref{j-1} - xref{j};
    yb(j)  = Ymax - r(j);
end

end