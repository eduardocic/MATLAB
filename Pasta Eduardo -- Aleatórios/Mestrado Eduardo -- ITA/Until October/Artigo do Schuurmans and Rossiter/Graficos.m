clear; close all; clc;

Umax = 2;
%%
f1 = load('ComRestricao.mat');
f2 = load('Schuurmans.mat');
f3 = load('Xss_Com_Restricao.mat');

% x1's
x1CR     = f1.ComRestricao (3,:);
x1Schu   = f2.Schuurmans(3,:);
x1Xss    = f3.XssComRestricao(3,:);

% u's
uCR     = f1.ComRestricao (2,:);
uSchu   = f2.Schuurmans(2,:);
uXss    = f3.XssComRestricao(2,:);

t = f1.ComRestricao(1,:);
LimUmax = Umax*linspace(1,1, max(size(t)));

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
s(1) = subplot(1,2,1); hold on; grid on;
s(2) = subplot(1,2,2); hold on; grid on;

% Figure 1: x1's
stairs(s(1),x1CR);
stairs(s(1),x1Schu,'r');
stairs(s(1),x1Xss, 'm'); 
title(s(1),'x1 convergindo para a origem.')
legend(s(1),'Com Restrição','Schuurmans','Perseguição Xss móvel','Location','East')

% Figure 2: u's
stairs(s(2),uCR);
stairs(s(2),uSchu,'r');
stairs(s(2),uXss, 'm');
line([0 max(size(t))],[-2 -2],'Color','k',...
                              'LineWidth',2);
line([0 max(size(t))],[2 2],'Color','k',...
                              'LineWidth',2);
% grid on
title(s(2),'Entrada u.')
legend(s(2),'Com Restrição','Schuurmans','Perseguição Xss móvel','Location','East')
axis([0 max(t) -4 2.5]);


