clear all; close all; clc;

% Carrega as matrizes 'A' e 'B'.
% ------------------------------
load('MatrizesDeEstadoEnvelope.mat');

cont = max(size(a));

for i=1:cont
    a{i} = a{i}(1:12,1:12);
    b{i} = b{i}(1:12, 2:end);
    c{i} = eye(max(size(a{i})));      
    d{i} = zeros(max(size(a{i})),3);
end

tTotal = 10;
t_l = linspace(0, tTotal, tTotal*100);            


% Doublet em elevator.
% --------------------
u11 = linspace(0,0,100);
u12 = linspace(1,1,50);
u13 = linspace(-1,-1,50);
u14 = linspace(0,0,max(size(t_l)) - 200);
u1 = [u11 u12 u13 u14];
u2 = 0*u1;
u3 = 0*u1;


for i=1:cont
    % Sistema.
    % --------
    sys = ss(a{i},b{i},c{i},d{i});
    
    % Simulação linear.
    Y_l{i} = lsim(sys, [u1' u2' u3'], t_l);
    
    disp(['Realizou a simulação no sistema ', num2str(i)]);
end
save('SimulacaoLinearEnvelope_RetoNivelado.mat', 'Y_l', 't_l');

% % Simulação linear.
% Y = lsim(sys, [u1' u2' u3'], t);
% 
% % Salva o Resultado.
% % ------------------
% save('SimulacaoLinear.mat', 'Y', 't');
% 
% 
% subplot(5,2,1); 
% % Plota o resultado.
% plot(t, Y(:,1)); grid;
% xlabel('tempo (s)');
% ylabel('V_t (m/s)');
% 
% subplot(5,2,2); 
% plot(t, Y(:,2)); grid;
% xlabel('tempo (s)');
% ylabel('\alpha (rad)');
% 
% subplot(5,2,3); 
% plot(t, Y(:,3)); grid;
% xlabel('tempo (s)');
% ylabel('\beta (rad)');
% 
% subplot(5,2,4);
% plot(t, Y(:,4)); grid;
% xlabel('tempo (s)');
% ylabel('\phi (rad)');
% 
% subplot(5,2,5);
% plot(t, Y(:,5)); grid;
% xlabel('tempo (s)');
% ylabel('\theta (rad)');
% 
% subplot(5,2,6);
% plot(t, Y(:,6)); grid;
% xlabel('tempo (s)');
% ylabel('\psi (rad)');
% 
% subplot(5,2,7);
% plot(t, Y(:,7)); grid;
% xlabel('tempo (s)');
% ylabel('P (rad/s)');
% 
% subplot(5,2,8);
% plot(t, Y(:,8)); grid;
% xlabel('tempo (s)');
% ylabel('Q (rad/s)');
% 
% subplot(5,2,9);
% plot(t, Y(:,9)); grid;
% xlabel('tempo (s)');
% ylabel('R (rad/s)');
% 
% 
