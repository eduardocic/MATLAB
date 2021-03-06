function CoeficienteMomentYawing = Cn(alpha, beta)
% Coeficientes do Yawing;

A = [ 0.000  0.000  0.000  0.000  0.000  0.000  0.000  0.000  0.000   0.000   0.000   0.000;
      0.018  0.019  0.018  0.019  0.019  0.018  0.013  0.007  0.004  -0.014  -0.017  -0.033;
      0.038  0.042  0.042  0.042  0.043  0.039  0.030  0.017  0.004  -0.035  -0.047  -0.057;
      0.056  0.057  0.059  0.058  0.058  0.053  0.032  0.012  0.002  -0.046  -0.071  -0.073;
      0.064  0.077  0.076  0.074  0.073  0.057  0.029  0.070  0.012  -0.034  -0.065  -0.041;
      0.074  0.086  0.093  0.089  0.080  0.062  0.049  0.022  0.028  -0.012  -0.002  -0.013;
      0.079  0.090  0.106  0.106  0.096  0.080  0.068  0.030  0.064   0.015   0.011  -0.001];

S = 0.2*alpha;
K = fix(S);
% K = floor(S);
 
 if(K <= -2)
     K = -1;
 end
 if(K >= 9)
     K = 8;
 end
 
 DA = S - K;
 L = K + fix(1.1*sign(DA));
 
 S = 0.2*abs(beta);
 M = fix(S);
% M = floor(S);
 if( M == 0)
     M = 1;
 end
 if( M >= 6)
     M = 5;
 end
 DB = S - M;
 N = M + fix(1.1*sign(DB));
 
 % -------------------------------------------------------------------------
 % Compensacao por software
 K = K + 3;
 L = L + 3;
 M = M + 1;
 N = N + 1;
 % -------------------------------------------------------------------------
 
%  T = A(K, M);
%  U = A(K, N);
%  V = T + abs(DA)*(A(L, M) - T);
%  W = U + abs(DA)*(A(L, N) - U);
 T = A(M, K);
 U = A(N, K);
 V = T + abs(DA)*(A(M, L) - T);
 W = U + abs(DA)*(A(N, L) - U); 
 
 
 DUM = V + (W - V)*abs(DB);
 
 CoeficienteMomentYawing = DUM*sign(beta);
   
end