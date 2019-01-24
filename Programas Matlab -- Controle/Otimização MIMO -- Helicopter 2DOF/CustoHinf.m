function f = CustoHinf(x, G)

% Destrinchando o vetor a ser minimizado.
k1 = x(1);
k2 = x(2);
k3 = x(3);
k4 = x(4);

% Matrizes de ganho de realimentação.
K  = [k1 k3;
      k2 k4];  

% Matrizes do sistema.
L = K*G;
S = inv(eye(2) + L);

% Pesos das matrizes.
A  = 10^-4;
M  = 2;
wb = 2;

wP = eye(2)*tf([1/M wb],[1 wb*A]);

N  = wP*S;
   
f = norm(N, inf); 
end