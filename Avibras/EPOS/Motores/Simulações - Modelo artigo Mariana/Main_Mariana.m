%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% (*) Este programa faz uma simulação pelo método proposto por Cavalca.
%
% (*) As inicializações estão todas no arquivo 'PreLoad.m'.
%
% -------------------------------------------------------------------------


close all; clear all; clc;

% Carrega apenas o necessário.
% ----------------------------
PreLoad;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                            Algoritmo PR
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Encontra as referências para chaveamento em Cavalca.
% ----------------------------------------------------
[yss, xss, Eps, b] = ReferencesCavalca(Ylimites, C, xk0);

% Encontra a 'solução' para os chaveamentos.
% ----------------------------------------
n = max(size(Eps));
for i=1:n
    [Qsol{i}, Ysol{i}] = LMI_PR(A, B, C, S, R, Umax, Eps{i}, b(i));
end




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                            Algoritmo CPR
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x{1} = xk0;
imax = n;
global j
j = 1;

% Dinâmica do sistema dada pelo par (A{1}, B{1}).
% -----------------------------------------------
for i=1:50
    T1 = tic;
    uk(i)  = LMI_CPR(x{i}, A, B, C, S, R, Umax, imax, Qsol, xss, b);
    Tempo1(i) = toc(T1);
    x{i+1} = A{1}*x{i} + B{1}*uk(i);
    Xss{i} = xss{j};
end

% Resposta obtida -- pego os valores da 'estrutura'.
% --------------------------------------------------
m = max(size(x))-1;
for i=1:m
   X1(i) = x{i}(1,1); 
   X2(i) = x{i}(2,1);
end




j = 1;
x2{1} = xk0;
% Dinâmica do sistema dada pelo par (A{2}, B{2}).
% -----------------------------------------------
for i=1:50
    T2 = tic;
    uk2(i)  = LMI_CPR(x2{i}, A, B, C, S, R, Umax, imax, Qsol, xss, b);
    Tempo2(i) = toc(T2);
    x2{i+1} = A{2}*x2{i} + B{2}*uk2(i);    
end

% Resposta obtida -- pego os valores da 'estrutura'.
% --------------------------------------------------
m = max(size(x))-1;
for i=1:m
   Y1(i) = x2{i}(1,1); 
   Y2(i) = x2{i}(2,1);
end




% Comportamento da saída y(k) pelo tempo.
% ---------------------------------------
for i=1:m
    t(i)  = i/2 - 0.5;
    y(i)  = C*x{i};                 % (A{1}, B{1})
    y2(i) = C*x2{i};                % (A{2}, B{2})
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                             Plot das figuras
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


TAM = 2;
% a) Comportamento de x1(k) e x2(k).
% ----------------------------------
plot(X1, X2, 'b-', Y1, Y2, 'r-'); grid;
xlabel('x_1(k)'); ylabel('x_2(k)');
legend('\kappa_{T} = 0.9', '\kappa_{T} = 1.1');


% b) saída y(k) e y2(k).
% ----------------------
figure;
plot(t, y, 'b-', t, y2, 'r-'); grid; hold on;
plot(t, Ymax*linspace(1,1,m),'k');
xlabel('k'); ylabel('y(k)');
legend('\kappa_{T} = 0.9', '\kappa_{T} = 1.1');
axis([t(1) t(end) -10.5 0.5]);

% c) Controle.
% ------------
figure;
plot(t, uk, 'b-', t, uk2, 'r-'); grid;
xlabel('k'); ylabel('u(k)');
legend('\kappa_{T} = 0.9', '\kappa_{T} = 1.1');



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                       Determinação dos elispóides
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%                           
n = max(size(Qsol));
theta   = linspace(0, 180, 181);
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


% Deslocamento dos elipsóides para a região de centro 'xss,i'.
% ----------------------------------------------------------
m = max(size(V{1}));
for i=1:n
    for j=1:m
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
% legend('\kappa_{T} = 0.9');
hold on;
for i=1:n
    Plota_DA(Vv{i});   hold on;
end
plot(X1, X2, 'b-','LineWidth', 2); grid;
xlabel('x_1(k)', 'FontSize', 16); ylabel('x_2(k)', 'FontSize', 16);


% Comportamento da pseudo-referência yss
% ---------------------------------------
for i=1:max(size(Xss))
    yss(i) = C*Xss{i};
end



% Salva resultado em uma estrutura.
% ---------------------------------
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
             'yss', yss,...
             'Tempo1', Tempo1, ...
             'Tempo2', Tempo2);
fileName = 'MarianaSIM';
save(fileName, 'SIM');

