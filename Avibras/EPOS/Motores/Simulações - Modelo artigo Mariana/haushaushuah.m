close all; clear all; clc;

% Carrega apenas o necessário.
% ----------------------------
PreLoad;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                           Algoritmo Eduardo
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x{1} = xk0;

clear all; clear all; clc;
PreLoad;

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
    y2(i) = C*x2{i};
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                           Plot das figuras.
%
% PS: pro brevidade, plotarei apenas os resultados de um único vértice.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
TAM = 2;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                       Determinação dos elispóides
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                           
n = max(size(Qsol2));
theta = linspace(0, 180, 181);
Epsilon = [cos(theta*pi/180);
           sin(theta*pi/180)];

for i=1:n
    for j = 1:181 
        Beta    = DesenhandoElipsoides(Epsilon(1:end,j), Qsol2{i});
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
        O1(j) = V{i}(j,1) + xss2{i}(1,1);
        O2(j) = V{i}(j,2) + xss2{i}(2,1); 
    end
    Vv{i} = [O1' O2'];
end

figure;
for i=1:n
    Plota_DA(V{i});   hold on;
end

figure;
plot(Y1, Y2, 'b-', 'LineWidth', 2); grid;
hold on;
for i=1:n
    Plota_DA(Vv{i});   hold on;
end
plot(Y1, Y2, 'b-', 'LineWidth', 2);
xlabel('x_1(k)', 'FontSize', 16); ylabel('x_2(k)', 'FontSize', 16);

for i=1:max(size(xss2))
    yss2(i) = C*xss2{i};
end


load('EduardoSIM.mat');
Edu = SIM;
clear SIM;

figure;
% Plot dos tempos
plot(Edu.t, Edu.Tempo1, t, Tempo2); grid;
xlabel('k','FontSize', 16);
ylabel('Tempo de otimização (s)', 'FontSize', 16);
legend('Método Proposto', 'CGY2011');


