close all; clear all; clc;

% Pontos.
P0 = [-10 0];
P1 = [-4 8];
P2 = [6 2];
P3 = [8 6];
P  = [P0; P1; P2; P3];

% Parametrização em 't'.
t = linspace(0,1,101);

% Determinação dos pontos da Recursão -- Nível 1.
for i = 1:3
    for j = 1:max(size(t))
        P_1{i,j} = (1-t(j))*P(i,:) + t(j)*P(i+1,:);
    end
end

% Determinação dos pontos da Recursão  -- Nível 2.
for i = 1:2
    for j = 1:max(size(t))
        P_2{i,j} = (1-t(j))*P_1{i,j} + t(j)*P_1{i+1,j};
    end
end

% Determinação dos pontos da Recursão -- Nível 3.
for j = 1:max(size(t))
    P_3{1,j} = (1-t(j))*P_2{1,j} + t(j)*P_2{2,j};
end


%% Plotagem das curvas de Bezier.
% --------------------------------
TAM = 2;

% a) Segmentos de retas do primeiro nível.
x = P(:,1);
y = P(:,2);
plot(x, y, 'k', 'LineWidth',2);

% b) Segmento de reta do segundo nível.
for i = 1:max(size(P_1))
    % Os 'x's.
    x_1(i) = P_1{1,i}(1,1);
    x_2(i) = P_1{2,i}(1,1);
    x_3(i) = P_1{3,i}(1,1);
    
    % Os 'y's.
    y_1(i) = P_1{1,i}(1,2);
    y_2(i) = P_1{2,i}(1,2);
    y_3(i) = P_1{3,i}(1,2);
    
    % Composição do segmento de reta.
    x1(i,:) = [x_1(i) x_2(i) x_3(i)];
    y1(i,:) = [y_1(i) y_2(i) y_3(i)];
    
%     plot(x, y, 'k', 'LineWidth',2); hold on;
%     plot(x1(i,:), y1(i,:), 'r');
%     axis([-11 18 -1 11]);
%     drawnow;
%     pause(0.1); clf;
end

% c) Segmento de reta do terceiro nível.
for i = 1:max(size(P_2))
    % Os 'x's.
    xx_1(i) = P_2{1,i}(1,1);
    xx_2(i) = P_2{2,i}(1,1);
    
    % Os 'y's.
    yy_1(i) = P_2{1,i}(1,2);
    yy_2(i) = P_2{2,i}(1,2);
    
    % Composição do segmento de reta.
    xx1(i,:) = [xx_1(i) xx_2(i)];
    yy1(i,:) = [yy_1(i) yy_2(i)];
    
%     plot(x, y, 'k', 'LineWidth',2); hold on;
%     plot(x1(i,:), y1(i,:), 'r');
%     plot(xx1(i,:), yy1(i,:), 'b');
%     axis([-11 18 -1 11]);
%     drawnow;
%     pause(0.1); clf;
end


% d) Segmento de reta do último nível.
for i = 1:max(size(P_3))
    % Os 'x's.
    xxx_1(i) = P_3{1,i}(1,1);
    
    % Os 'y's.
    yyy_1(i) = P_3{1,i}(1,2);
    
    % Composição do segmento de reta.
    xxx(i,:) = [xxx_1(i)];
    yyy(i,:) = [yyy_1(i)];
    
    clf;
    plot(x, y, 'k', 'LineWidth', 2); hold on;
    plot(x1(i,:), y1(i,:), 'r', 'LineWidth', 2);
    plot(xx1(i,:), yy1(i,:), 'b', 'LineWidth', 2);
    plot(xxx, yyy, 'g', 'LineWidth', 2);
    axis([-11 18 -1 11]);
    xlabel('Posição X.');
    ylabel('Posição Y.');
    title('Curva de Bezier de 3º ordem.');
%     legend('Segmentos Originais', '1º Recursiva', '2º Recursiva', 'Curva de Bezier');
    grid;
    drawnow;
    pause(0.1); 
end

