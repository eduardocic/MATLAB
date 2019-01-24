clear all; close all; clc;

% Carrega as dinâmicas longitudinais.
load('DinamicaLongitudinal_RetoNivelado.mat');

quantMax = max(size(A_long));
x0 = [ -1  -1];



for k = 1:quantMax
    A = A_long{k};
    B = B_long{k};
    C = C_long{k};
    D = D_long{k};
    fun = @(x)fnCustoEnvelope(x, A, B, C, D);     
    
    
    Aa   = [];
    bb   = [];
    Aeq  = [];
    beq  = [];
    lb   = [-50, -50];
    ub   = [50, 50];
     
%     options = optimoptions('fmincon', 'Display', 'iter');
    x       = fmincon(fun, x0, Aa, bb, Aeq, beq, lb, ub, []);
%     x = fminsearch(fun, x0);
    

    % Pega os valores novamente.
    kp = x(1);
    kd = x(2);

    K = [ 0  0  kp  kd];
    Acl = A - B*K;
    Bcl = B*kp;
    Ccl = C(3,1:end);
    Dcl = D(3,1:end);

    
    close all;
    sys = ss(Acl, Bcl, Ccl, Dcl);
    [y, t, ~] = step(sys, 0:0.01:10);

    figure;
    plot(t, y); grid;
    title(['Agora vai o número ', num2str(k)]);
    
    eta = 0.7;
    wn  = 1.5;
    theta = tf([wn^2],[1 2*eta*wn wn^2]);
    [yref, ~, ~]  = step(theta, 0:0.01:10);
    hold on; 
    plot(t, yref, 'r'); grid;
    legend('Obtido', 'Referência');
    
    
    pause(2);
    Kp{k} = kp
    Kd{k} = kd
end

save('Controladores_Kp_Kd.mat', 'Kp', 'Kd');
