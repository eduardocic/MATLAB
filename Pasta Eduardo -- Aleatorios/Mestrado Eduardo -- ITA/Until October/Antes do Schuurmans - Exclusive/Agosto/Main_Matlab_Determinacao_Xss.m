close all; clear; clc;

% 1.: Carrega Matrizes no Estado de Espaços.
MatrizesEspacoEstados;

% 2.: Carrega Variveis Diversars e xk0
VariaveisDiversas_Restricoes;
xk_0;

% 3.: Determinacao do 1º Xss caso não haja restrição.

Xss = LMI_Determinacao_Xss(A,B,xk0,rho);


%% ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
% 1. Plota a Primeira Situação
%
% a) Ponto xk(0)
plot(xk0(1), xk0(2), 'sr', 'MarkerSize',9,...
                         'MarkerFaceColor','g'); 
hold on
Seta1 = 'xk(0) \rightarrow';
text(xk0(1), xk0(2), Seta1,...
                 'HorizontalAlignment','right',...
                 'VerticalAlignment','middle',...
                 'FontSize',14,...
                 'LineStyle','none',...
                 'Color', 'red');

% b) Ponto Xss - o primeiro Xss
plot(Xss(1), Xss(2), '^b','MarkerSize',9,...
                          'MarkerFaceColor','b');
Seta2 = '\leftarrow Xss(1)';
text(Xss(1), Xss(2), Seta2, 'HorizontalAlignment','left');


axis([0 6 -2 6]); grid;


% c) Plota a Reta do Estado Estacionário.
H = MatrizH(A);
a = H(1)/H(2);
x = linspace(0, 6, 7);
y = a*x;
plot(x,y);




