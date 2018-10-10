clear; close all; clc;

file1 = load('Diferenca.mat');
file2 = load('Normal.mat');

Diferenca = file1.Diferenca;
Normal    = file2.Normal;

ud = Diferenca.data(:,1);
xd = Diferenca.data(:,2:3);

un = Normal.data(:,1);
xn = Normal.data(:,2:3);


stairs(xd(:,1)); hold on;
stairs(xd(:,2),'r'); grid;

hold on;
figure;

stairs(xn(:,1)); hold on;
stairs(xn(:,2),'r'); grid;
