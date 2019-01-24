function CoeficienteRollingMomentRudder = Dlrd (alpha, beta)
% rolling moment due to rudder - OK.

A = [ 0.005  0.017  0.014  0.010  -0.005  0.009  0.019  0.005  -0.000  -0.005  -0.011  0.008;
      0.007  0.016  0.014  0.014   0.013  0.009  0.012  0.005   0.000   0.004   0.009  0.007;
      0.013  0.013  0.011  0.012   0.011  0.009  0.008  0.005  -0.002   0.005   0.003  0.005;
      0.018  0.015  0.015  0.014   0.014  0.014  0.014  0.015   0.013   0.011   0.006  0.001;
      0.015  0.014  0.013  0.013   0.012  0.011  0.011  0.010   0.008   0.008   0.007  0.003;
      0.021  0.011  0.010  0.011   0.010  0.009  0.008  0.010   0.006   0.005   0.000  0.001;
      0.023  0.010  0.011  0.011   0.011  0.010  0.008  0.010   0.006   0.014   0.020  0.000];
  
S = 0.2*alpha;
K = fix(S);
if(K <= -2)
    K = -1;
end
if(K >= 9)
    K = 8;
end
DA = S - K;                 % DA = S - float(K).
L = K + fix(1.1*sign(DA));

S = 0.1*beta;
M = fix(S);
if(M == -3)
    M = -2;
end
if(M >= 3)
    M = 2;
end

DB = S - M;
N = M + fix(1.1*sign(DB));


 % -------------------------------------------------------------------------
 % Compensacao por software
 K = K + 3;
 L = L + 3;
 M = M + 4;
 N = N + 4;
 % -------------------------------------------------------------------------

% T = A(K, M);
% U = A(K, N);
% V = T + abs(DA)*(A(L, M) - T);
% W = U + abs(DA)*(A(L, N) - U);

T = A(M, K);
U = A(N, K);
V = T + abs(DA)*(A(M, L) - T);
W = U + abs(DA)*(A(N, L) - U);


CoeficienteRollingMomentRudder = V + (W-V)*abs(DB);

end