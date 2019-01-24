clear all; close all; clc;

% %%% Faz uma análise dos valores por rodada.
% N = 10000;
% x = rand(N,1);
% y = rand(N,1);
% 
% cont  = 0;
% cont2 = 0;
% for i = 1:N
%     if(x(i)^2 + y(i)^2 <= 1)
%         cont = cont + 1;
%         Xin(cont) = x(i);
%         Yin(cont) = y(i);
%     else
%         cont2 = cont + 2;
%         Xout(cont2) = x(i);
%         Yout(cont2) = y(i);
%     end
% end
% PI = cont*4/N
% 
% plot(Xin, Yin, 'k.'); hold on;
% plot(Xout, Yout, 'r.'); 
% 
% alfa = linspace(0, 1, 1000);
% beta = sqrt(1-alfa.^2);
% plot(alfa, beta, 'b');



%%% Faz uma análise dos valores por várias rodadas
N  = 10000;
N2 = 50;
x = rand(N, N2);
y = rand(N, N2);

cont  = 0;
cont2 = 0;
for i = 1:N
    cont  = 0;
    cont2 = 0;
    for j=1:N2
        if(x(i,j)^2 + y(i,j)^2 <= 1)
            cont = cont + 1;
            Xin(i,cont) = x(i,j);
            Yin(i,cont) = y(i,j);
        else
            cont2 = cont + 2;
            Xout(i,cont2) = x(i,j);
            Yout(i,cont2) = y(i,j);
        end
    end
    PI(i) = cont*4/N2;
    disp(['Calcula para i = ' num2str(i)]);
end
mean(PI)