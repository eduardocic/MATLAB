imax = max(size(r));       % Quantidade de Chaveamentos.

for j = 1:imax
    [Qsol{j}, Ysol{j}] = LMICavalca(A, B, C, S, Smeio, R, Rmeio, Umax, Eps{j}, yb(j));
end

