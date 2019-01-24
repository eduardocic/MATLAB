close all; clear; clc;

%%% Carrega Sistemas Antes dos Gráficos Comparativos.
MatrizesEstado;
ConstraintsCavalca;
ConstraintsEduardo;

%%% Carrega Variáveis.
load('AsymmetricCavalca.mat');
load('AsymmetricEduardo.mat');

%%% Cria os vetores correspondentes para comparação.
% 1) Cavalva.
T_c      = Cavalca(1,1:end);
u_c      = Cavalca(2,1:end);
xk1_c    = Cavalca(3,1:end);
xk2_c    = Cavalca(4,1:end);
yk_c     = Cavalca(5,1:end);
yss_c    = Cavalca(6,1:end);
% 2) Eduardo.
T_e      = Eduardo(1,1:end);
u_e      = Eduardo(2,1:end);
yss_e    = Eduardo(3,1:end);
xk1_e    = Eduardo(4,1:end);
xk2_e    = Eduardo(5,1:end);
yk_e     = Eduardo(6,1:end);


%%% Limitantes Controle e Saída.
LinhaUmax = linspace(1,1,max(size(T_c)))*Umax;
LinhaUmin = -linspace(1,1,max(size(T_c)))*Umax;
LinhaYmax = linspace(1,1,max(size(T_c)))*Y(2);
LinhaYmin = linspace(1,1,max(size(T_c)))*Y(1);

%%% Parâmetros dos gráficos.
TAM      = 20;           % Tamanho da fonte dos eixos e textos.
ComLinha = 2;            % Comprimento das linhas Gráficos.
ComLim   = 1;            % Comprimento dos limitantes.
Inicio   = 8;            % Onde se Inicia no Vetor - INSET.
Fim      = 20;           % Onde termina no Vetor - INSET.


% -------------------------------------------------------------------------
%                               PLOTA u(k) 
%
% -------------------------------------------------------------------------
stairs(T_e, u_e, 'k', 'LineWidth',ComLinha);        % Resposta Eduardo.
hold on;        
stairs(T_c, u_c, 'k--', 'LineWidth',ComLinha);      % Resposta Cavalca.
grid;   
plot(T_c, LinhaUmax,'k','LineWidth',ComLim);        % Limite Superior u(k).
plot(T_c, LinhaUmin,'k','LineWidth',ComLim);        % Limite Inferior u(k).
title('Entrada de Controle u(k)'); 
legend('Método Proposto', 'CYG2011', ...
       'Location', [0.7 0.7 0.1 0.1]);              % Legenda do gráfico
xlabel('Tempo', 'FontSize', TAM);
ylabel('Controle u', 'FontSize', TAM);
axis([0 max(T_c) -(1.05*Umax) (1.05*Umax)]);        % Eixo de apresentação do gráfico.
set(gca,'fontsize', TAM);                           % Tamanho da fonte.

% Cria .pdf
h = gcf;    % Get handle to Current Figure
set(h,'PaperOrientation','landscape');
set(h,'PaperUnits','normalized');
set(h,'PaperPosition', [0 0 1 1]);
print(gcf, '-dpdf', 'uk.pdf');



% -------------------------------------------------------------------------
%                               PLOTA y(k) 
%
% -------------------------------------------------------------------------
figure
%%% Plota x1(k).
plot(T_e, yk_e, 'k', 'LineWidth',ComLinha);          % Resposta Eduardo.
hold on;  
plot(T_c, yk_c, 'k--', 'LineWidth',ComLinha);        % Resposta Cavalca.
grid;   
stairs(T_c, LinhaYmax,'k', 'LineWidth', ComLim);     % Limite Superior x(k).
stairs(T_c, LinhaYmin,'k', 'LineWidth', ComLim);     % Limite Inferior x(k).
legend( 'Método Proposto', 'CYG2011', ...
        'Location', [0.7 0.75 0.1 0.1]);             % Legenda do gráfico
xlabel('Tempo', 'FontSize', TAM);    
ylabel('Saída y', 'FontSize', TAM);
axis([0 max(T_c) (1.05*Ymin) (2*Ymax +0.3)]);        % Eixo de apresentação do gráfico.
set(gca,'fontsize', TAM);                            % Tamanho da fonte.

% Quadrado seleção
x = [ T_e(Inicio), T_e(Fim), T_e(Fim), ...
      T_e(Inicio), T_e(Inicio)];                     % Coordenadas x do quadrado.
y = [ xk1_e(Inicio), xk1_e(Inicio), (xk1_e(Fim)+0.3), ...
     (xk1_e(Fim)+0.3), xk1_e(Inicio)];               % Coordenadas x do quadrado.
plot(x, y, 'k-', 'LineWidth', 1.5);                  % Plota Quadrado.

% Inset
axes('Position',[.39 0.19 .5 .47]);
box on
plot(T_e(Inicio:Fim), xk1_e(Inicio:Fim), 'k', 'LineWidth', ComLinha); hold on;
plot(T_c(Inicio:Fim), LinhaYmax(Inicio:Fim),'k', 'LineWidth', ComLim); grid;
plot(T_c(Inicio:Fim), xk1_c(Inicio:Fim), 'k--', 'LineWidth', ComLinha);
axis([T_e(Inicio) T_e(Fim) xk1_e(Inicio) (xk1_e(Fim)+0.3)]);
set(gca,'fontsize',18);

% Cria .pdf
h = gcf;    % Get handle to Current Figure
set(h,'PaperOrientation','landscape');
set(h,'PaperUnits','normalized');
set(h,'PaperPosition', [0 0 1 1]);
print(gcf, '-dpdf', 'yk.pdf');



% -------------------------------------------------------------------------
%                               PLOTA yss 
%
% -------------------------------------------------------------------------
figure
stairs(T_e, yss_e, 'k', 'LineWidth',ComLinha);      % Resposta Eduardo.
hold on; 
stairs(T_c, yss_c, 'k--', 'LineWidth',ComLinha);    % Resposta Cavalca.
grid;    
legend( 'Método Proposto', 'CYG2011', ...
        'Location', [0.7 0.7 0.1 0.1]);             % Legenda do gráfico
xlabel('Tempo', 'FontSize', TAM);  
ylabel('Pseudo-referência y_{ss}', 'FontSize', TAM);
axis([0 max(T_c) (1.05*Ymin) (2*Ymax +0.3)]);       % Eixo de apresentação do gráfico.
set(gca,'fontsize', TAM);                           % Tamanho da fonte.

% Cria .pdf
h = gcf;    % Get handle to Current Figure
set(h,'PaperOrientation','landscape');
set(h,'PaperUnits','normalized');
set(h,'PaperPosition', [0 0 1 1]);
print(gcf, '-dpdf', 'yss.pdf');
