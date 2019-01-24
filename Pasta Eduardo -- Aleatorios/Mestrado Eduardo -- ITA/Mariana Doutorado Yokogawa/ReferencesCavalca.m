%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Esta função determinará as pseudo-referências utilizadas por Cavalca

function [r, x_ss, Eps, yb, Qsol, Ysol] = ReferencesCavalca(Y, C, xk0)
    

%% Passo 1: Determinação das referências em y.

Ymax = Y(1,2);
Ymin = Y(1,1);
y0   = C*xk0;

% Passo 1.1.
r(1) = (Ymax + y0)/2;       % Primeiro Caso

% Passo 1.2.
i = 2;

% Passo 1.3
while(abs(r(i-1)) > Ymax)
    r(i) = (Ymax + r(i-1))/2;
    i    = i+1;
end

% Passo 1.4
imax = i;

% Passo 1.5
r(imax) = 0;


%% Passo 2: Determinação das referências em x.
for j = 1:imax
    x_ss{j} = mldivide(C, r(j));
end


%% Passo 3: Determinação das referências em 'Epsilon'.
Eps{1} = xk0 - x_ss{1};
yb(1)  = Ymax - r(1);
for j = 2:imax
    Eps{j} = x_ss{j-1} - x_ss{j};
    yb(j)  = Ymax - r(j);
end

end