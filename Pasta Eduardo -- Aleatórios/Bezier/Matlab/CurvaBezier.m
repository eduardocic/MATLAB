close all; clear all; clc;
TAM = 1.5;

% Pontos.
P0 = [-10 0];
P1 = [4 8];
P2 = [6 6];
P3 = [7 0];
P = [P0; P1; P2; P3];   % Pontos de Controle.

% Curva de Bezier.
t = linspace(0,1,101);
M = [-1   3  -3   1;
      3  -6   3   0;
     -3   3   0   0;
      1   0   0   0];

for i=1:max(size(t))
    T = vetorT(t(i));
    B(i,:) = T*M*P;
end

hold on;
plot(B(:,1),B(:,2), 'r','LineWidth', 2);
grid;

% Plota pontos -- Poligonal e também os Pontos de Controle.
plot(P(:,1), P(:,2),'LineWidth', TAM); hold on;
plot(P0(1),P0(2), 'ko', 'MarkerSize', 5*TAM, 'MarkerFaceColor','k'); 
plot(P1(1),P1(2), 'ko', 'MarkerSize', 5*TAM, 'MarkerFaceColor','k'); 
plot(P2(1),P2(2), 'ko', 'MarkerSize', 5*TAM, 'MarkerFaceColor','k'); 
plot(P3(1),P3(2), 'ko', 'MarkerSize', 5*TAM, 'MarkerFaceColor','k');

legend('Curva de Bezier', 'Poligonal', 'Pontos de Controle');

% Obtenção das derivadas.
Mlinha = [-3   9  -9   3;
           6  -12  6   0;
          -3   3   0   0;];
M2linhas = [-6   18  -18   6;
             6  -12  6   0;];  
         
for i=1:max(size(t))
    Tlinha   = vetorTlinha(t(i));
    T2linhas = vetorT2linhas(t(i));
    
    % Derivadas
    Plinha(i,:)   = Tlinha*Mlinha*P;
    P2linhas(i,:) = T2linhas*M2linhas*P;
    
    % Curvatura e raio de curvatura.
    num = (Plinha(i,1)*P2linhas(i,2) - P2linhas(i,1)*Plinha(i,2));
    den = (B(i,1)^2 + B(i,2)^2)^(3/2);
    kappa(i) = abs(num)/den;
    raio(i)  = 1/kappa(i);
    
    % Centros das circunferências.
    xc(i) = B(i,1) + (P2linhas(i,1)/sqrt(P2linhas(i,1)^2 + P2linhas(i,2)^2))*raio(i);
    yc(i) = B(i,2) + (P2linhas(i,2)/sqrt(P2linhas(i,1)^2 + P2linhas(i,2)^2))*raio(i);
end


figure;
for i=1:max(size(t))
  hold on;
  quiver(B(i,1),B(i,2),Plinha(i,1)/norm(Plinha(i,:)),Plinha(i,2)/norm(Plinha(i,:)));          % Velocidade;
  quiver(B(i,1),B(i,2),P2linhas(i,1)/norm(P2linhas(i,:)),P2linhas(i,2)/norm(P2linhas(i,:)));  % Aceleração;
  plot(B(1:i,1),B(1:i,2), 'r','LineWidth', TAM); 
  drawnow;
  axis([-15 15 -2 8]);
  pause(0.1);
%   clf;
end




