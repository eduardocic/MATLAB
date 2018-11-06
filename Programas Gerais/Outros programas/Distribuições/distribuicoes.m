clear all; close all; clc;

seed = rng('Default');


% Distribuição uniforme.
% ----------------------
a = 10;
b = 20;
max_uni = 1/(20-10);

for i = 1:max(size(seed.State))
    intermed = double(seed.State(i));
    r(i) = a + (b-a)*intermed/2^32;
end

% Linha horizontal.
yh = linspace(max_uni,max_uni,100);
xh = linspace(a,b,100);
plot(xh, yh, 'LineWidth', 2);
xlim([8 22]);
ylim([0 (max_uni + 0.01)]);

% linhas verticais.
yv1 = linspace(0, max_uni, 100);
xv1 = linspace(a, a, 100);
yv2 = linspace(0, max_uni, 100);
xv2 = linspace(b, b, 100);
hold on;
plot(xv1, yv1, '--k',  'LineWidth', 2);
plot(xv2, yv2, '--k',  'LineWidth', 2);

% % Apresentação dos parâmetros aleatórios.
% % ---------------------------------------
% for i = 1:max(size(seed.State))
%     plot(r(i), max_uni, 'ok'); 
%     pause(0.01);
% end



