%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                           MATRIZES DE ESTADO
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

m1 = 1;
m2 = 1;
K  = [0.5 10];
H  = max(size(K));

%## 1) Matrizes Incertas A ##%
for j=1:H
    A{j} = [      1              0         0.1      0;
                  0              1           0    0.1;
            -0.1*(K(j)/m1)  0.1*(K(j)/m1)    1      0;
             0.1*(K(j)/m2) -0.1*(K(j)/m2)    0      1]; 
end

%## 2) Matrizes Incertas B ##%
for j=1:max(size(m1))
    B{1} = [   0;
               0;
            0.1/m1;
              0;];
end

%## 3) Matriz C
C = [1 0 0 0];


%%% Criando os vértices do sistema.



