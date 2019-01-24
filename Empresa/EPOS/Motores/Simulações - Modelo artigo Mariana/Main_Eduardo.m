close all; clear all; clc;

% Carrega apenas o necessário.
% ----------------------------
PreLoad;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                           Algoritmo Eduardo
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x{1} = xk0;

% Considerando a dinâmica do vértices (A{1},B{1}).
% ------------------------------------------------
for i=1:50
    T1 = tic;
    [uk(i), Qsol{i}, xss{i}] = LMIEduardo(x{i}, A, B, C, H, S, R, Umax, Ylimites, at, rho);
    Tempo1(i) = toc(T1);
    x{i+1} = A{1}*x{i} + B{1}*uk(i);    
end

% Separa componentes do estado.
% -----------------------------
m = max(size(x))-1;
for i=1:m
   X1(i) = x{i}(1,1); 
   X2(i) = x{i}(2,1);
end


x2{1} = xk0;
% Considerando a dinâmica do vértices (A{2},B{2}).
% ------------------------------------------------
for i=1:50
    T2 = tic;
    [uk2(i), Qsol2{i}, xss2{i}] = LMIEduardo(x2{i}, A, B, C, H, S, R, Umax, Ylimites, at, rho);
    Tempo2(i) = toc(T2);
    x2{i+1} = A{2}*x2{i} + B{2}*uk2(i);   
end

% Separa componentes do estado.
% -----------------------------
m = max(size(x2))-1;
for i=1:m
   Y1(i) = x2{i}(1,1); 
   Y2(i) = x2{i}(2,1);
end



% Comportamento da saída y(k) e y2(k).
% -------------------------------------
for i=1:m
    t(i)  = i/2 - 0.5;   % Compensar o tempo 'zero'.
    y(i)  = C*x{i};
    y2(i) = C*x2{i};
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                           Plot das figuras.
%
% PS: pro brevidade, plotarei apenas os resultados de um único vértice.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
TAM = 2;

% a) Comportamento de x1(k) e x2(k).
% ----------------------------------
plot(X1, X2, 'b-', 'LineWidth', TAM); grid;
xlabel('x_1(k)'); ylabel('x_2(k)');
legend('\kappa_{T} = 0.9');


% b) saída y(k).
% --------------
figure;
plot(t, y, 'b-', 'LineWidth', TAM); grid; hold on
plot(t, Ymax*linspace(1,1,m),'k');
xlabel('k'); ylabel('y(k)');
legend('\kappa_{T} = 0.9');
axis([t(1) t(end) -10.5 0.5]);

% Quadrado seleção
Ini = 8;
Fim = 20;
xx = [ t(Ini), t(Fim), t(Fim), ...
       t(Ini), t(Ini)];                     % Coordenadas x do quadrado.
yy = [ y(Ini), y(Ini), (y2(Fim)+0.3), ...
      (y(Fim)+0.3), y2(Ini)];               % Coordenadas x do quadrado.
hold on;
plot(xx, yy, 'k--', 'LineWidth', TAM);                  % Plota Quadrado.

% Inset
axes('Position',[.39 0.18 .5 .47]);
box on
plot(t(Ini:Fim), y(Ini:Fim), 'b', 'LineWidth', TAM); hold on;
plot(t(Ini:Fim), Ymax*linspace(1,1,Fim-Ini+1),'k', 'LineWidth', TAM);grid; 
axis([t(Ini) t(Fim) y2(Ini) (y2(Fim)+0.3)]);
set(gca,'fontsize',13);


% c) Controle u(k).
% -----------------
figure;
plot(t, uk, 'b-', 'LineWidth', TAM); grid;
xlabel('k'); ylabel('u(k)');
legend('\kappa_{T} = 0.9');



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                       Determinação dos elispóides
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                           
n = max(size(Qsol));
theta = linspace(0, 180, 181);
Epsilon = [cos(theta*pi/180);
           sin(theta*pi/180)];

for i=1:n
    for j = 1:181 
        Beta    = DesenhandoElipsoides(Epsilon(1:end,j), Qsol{i});
        Vetor1  = Beta*Epsilon(1:end,j)';
        Vetor2  = -Beta*Epsilon(1:end,j)';
        V1(j,:) = Vetor1;
        V2(j,:) = Vetor2; 
    end
    V{i} = [V1; V2];
end  


% Realiza a compensação para os 'xss'.
alfa = max(size(V{1}));
for i=1:n
    for j=1:alfa
        O1(j) = V{i}(j,1) + xss{i}(1,1);
        O2(j) = V{i}(j,2) + xss{i}(2,1); 
    end
    Vv{i} = [O1' O2'];
end

figure;
for i=1:n
    Plota_DA(V{i});   hold on;
end

figure;
plot(X1, X2, 'b-', 'LineWidth', 2); grid;
hold on;
for i=1:n
    Plota_DA(Vv{i});   hold on;
end
plot(X1, X2, 'b-', 'LineWidth', 2);
xlabel('x_1(k)', 'FontSize', 16); ylabel('x_2(k)', 'FontSize', 16);

for i=1:max(size(xss))
    yss(i)  = C*xss{i};
    yss2(i) = C*xss2{i};
end

SIM = struct('t', t, ...
             'uk', uk, ...
             'uk2', uk2, ...
             'X1', X1, ...
             'X2', X2, ...
             'Y1', Y1, ...
             'Y2', Y2, ...
             'y', y, ...
             'y2', y2, ...
             'Ymax', Ymax,...
             'yss', yss, ...
             'yss2', yss2,...
             'Tempo1', Tempo1,...
             'Tempo2', Tempo2);
fileName = 'EduardoSIM';
save(fileName, 'SIM');
