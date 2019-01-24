
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Esta função determinará as pseudo-referências utilizadas por Cavalca

function [yss, xss, Eps, yb] = ReferencesCavalca(Y, C, xk0)
    
Ymax = Y(1,2);
Ymin = Y(1,1);

y0 = C*xk0;

yss(1) = (Ymax + y0)/2;       % Primeiro Caso
i = 2;

while(abs(yss(i-1)) > Ymax)
    yss(i) = (Ymax + yss(i-1))/2;
    i = i+1;
end
yss(i) = 0;

for j = 1:i
    xss{j} = mldivide(C, yss(j));
end

Eps{1} = xk0 - xss{1};
yb(1)  = Ymax - yss(1);
for j = 2:i
    Eps{j} = xss{j-1} - xss{j};
    yb(j)  = Ymax - yss(j);
end

end