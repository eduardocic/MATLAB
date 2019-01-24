clear all; close all; clc;

load('Controladores_Kp_Kd.mat');

n = max(size(Kd));

Vt = linspace(250, 500, 11);      % de 250 ft/s a 500 ft/s
H  = linspace(1000, 3000, 9);     % de 1000m a 3000m

cont1 = 0;
cont2 = 1;
for i = 1:n
    
    cont1 = cont1 + 1;
    A(cont2, cont1) = Kd{i};
    B(cont2, cont1) = Kp{i};
    
    if (mod(i,11) == 0)
        cont1 = 0;
        cont2 = cont2 + 1;
    end
end

mesh(Vt, H, A);
xlabel('Velocidate total -- ft/s');
ylabel('Altitude -- h');
zlabel('K_p');

figure
mesh(Vt, H, B);
xlabel('Velocidade total -- ft/s');
ylabel('Altitude -- h');
zlabel('K_d');

Kd = A;
Kp = B;
save('Kp.mat', 'Kp');
save('Kd.mat', 'Kd');
