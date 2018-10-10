
%%% Teste para verificação da temporização.
N = 601;
ang = linspace(0,60,N)*pi/180;

for i=1:N
   k(i) = i; 
   [T0(i), T1(i), T2(i)] = Times(10, ang(i), 0.002); 
end

plot(k, T1, k, T2, k, T0);
legend('T1', 'T2', 'T0');