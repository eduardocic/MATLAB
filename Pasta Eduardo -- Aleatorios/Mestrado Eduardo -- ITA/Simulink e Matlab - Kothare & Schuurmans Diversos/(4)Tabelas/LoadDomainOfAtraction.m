clear; close all; clc;

load('DomainKothare_CentesimoGrau.mat');
load('DomainSchuurmans_CentesimoGrau.mat');

KothareX = DomainKothare(:,1);
KothareY = DomainKothare(:,2);

SchuurmansX = DomainSchuurmans(:,1);
SchuurmansY = DomainSchuurmans(:,2);


s(1) = subplot(3,1,1);   % Matriz de 2 linhas e 1 Coluna.
s(2) = subplot(3,1,2);   % Matriz de 2 linhas e 1 Coluna.
s(3) = subplot(3,1,3);   % Matriz de 2 linhas e 1 Coluna.

% Plot Kothare
area(s(1), KothareX, KothareY, 'FaceColor', 'r');
title(s(1),'Kothare');

% Plot Schuurmans
area(s(2), SchuurmansX, SchuurmansY, 'FaceColor', 'g');
title(s(2),'Schuurmans');

% Plot Kothare e Schuurmans
area(s(3), SchuurmansX, SchuurmansY, 'FaceColor', 'g'); hold on;
area(s(3), KothareX, KothareY, 'FaceColor', 'r');
title(s(3),'Kothare e Schuurmans');






