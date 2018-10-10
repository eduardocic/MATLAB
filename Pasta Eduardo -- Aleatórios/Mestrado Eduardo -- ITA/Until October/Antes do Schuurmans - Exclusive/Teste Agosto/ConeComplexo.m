% Faz a configuração do cone de atração do sistema.

% 1. Determinação do vetor perpendicular;
inclinacao = H(2)/H(1);

theta = (pi/2) + atan(inclinacao);   % em radiano.
% 1.a) Direção do Vetor perpendicular.
Perp = [cos(theta); sin(theta)]
% 1.b) Resolve as LMI máxima estado.
Beta2 = LMI_DominioDeAtracao(A, B, Perp, Umax)
% 1.c) Pontos limites do domínio de atração na direção do vetor perpendicular.
Ponto1 = Beta2*Perp
Ponto2 = -Beta2*Perp


% 2. Determinação do vetor máximo na direção de H.
Gama = LMI_DominioDeAtracao(A, B, H, Umax);

% quiver(Ponto1(1), Ponto1(2), H(1), H(2));
% hold on
% quiver(Ponto2(1), Ponto2(2), H(1), H(2));
t  = linspace(-1*abs(Gama),1*abs(Gama), 101);
y1 = (H(2)/H(1))*t + Ponto1(2);
y2 = (H(2)/H(1))*t + Ponto2(2);

plot(t, y1, t, y2);
hold on;
T1 = [t' y1'];
T2 = [t' y2'];
T = [T1 -T2];
% area(T(:,1),T(:,2), 'FaceColor', 'b');
PlotaDominioAtracao(V);        % Visualiza o Domínio de Atração.











