clear all; close all; clc;

% Carrega as dinâmicas latero-direcionais.
load('DinamicaLateroDirecional_RetoNivelado.mat');

% quantMax = max(size(A_lat));
% x0 = [ -1  -1  -1   1];

for k = 1:1
    % Matrizes de estado.
    A = A_lat{k};
    B = B_lat{k};
    C = [0 1 0 0;       % phi;
         0 0 1 0;       % p;
         0 0 0 1];
    D = [0 0;
         0 0;
         0 0];
    G = minreal(tf(ss(A,B,C,D)));
    
    
    % =====================================================================
    %
    %                            Hinf estruturado
    %
    % =====================================================================
    % Ganhos do sistema -- valores a serem determinados.
    k1 = realp('k1',1);         K1 = tf([k1],[1]);
    k2 = realp('k2',1);         K2 = tf([k2],[1]); 
    kp = realp('kp',1);
    ki = realp('ki',1);         PI = tf([kp ki],[1 0]);
%     PI = tf([kp],[1]);
    
    % Referências de trajetória.
    wn_1 = 10;   wn_2 = 0.5;
    xi   = 1;
    Tar_1 = tf([wn_1^2],[1 2*xi*wn_1 wn_1^2]);
    Tar_2 = tf([wn_2^2],[1 2*xi*wn_2 wn_2^2]);
    
    % Dando nomes aos bois do nosso sistema.  
    G.u = {'u1'; 'u2'};
    G.y = {'phi'; 'p'; 'r'};
       
    K1.u = 'p';           K1.y = 'K1_out';
    K2.u = 'e_phi';       K2.y = 'K2_out';
    PI.u = 'e_r';         PI.y = 'u2';
    Tar_1.u = 'phi_com';  Tar_1.y = 'tar_phi_out';
    Tar_2.u = 'r_com';    Tar_2.y = 'tar_r_out';
    
    sum1 = sumblk('e_phi = phi_com - phi');
    sum2 = sumblk('u1    = K2_out - K1_out');
    sum3 = sumblk('e_r   = r_com - r');
    sum4 = sumblk('z1 = tar_phi_out - phi');
    sum5 = sumblk('z2 = tar_r_out - r');
    
%     T0   = connect(G, K1, K2, PI, sum1, sum2, sum3, {'phi_com', 'r_com'}, {'phi', 'r'});
    T0   = connect(G, K1, K2, PI, Tar_1, Tar_2, sum1, sum2, sum3, sum4, sum5, {'phi_com', 'r_com'}, {'z1', 'z2'});
    
    rng('default');
    opt = hinfstructOptions('Display', 'final', 'RandomStart',5);
    T   = hinfstruct(T0,opt);
    
    showTunable(T)
    step(T)
    
    
    k_1 = T.Blocks.k1.Value;
    k_2 = T.Blocks.k2.Value;
    k_p = T.Blocks.kp.Value;
    k_i = T.Blocks.ki.Value;
%     F = getIOTransfer(T0,'phi_com','phi');
    
%     K1s = T.Blocks.k1.Value;
%     K2s = T.Blocks.k2.Value;
%     K3s = T.Blocks.k3.Value;
%      
%     % Desembrulhando os valores.
%     K = [ 0  K1s  K2s   0;
%           0   0    0   K3s];
%     L = [ K2s  0;
%            0   1];
%     Acl = A - B*K;
%     Bcl = B*L;
%     Ccl = [0 1 0 0;
%            0 0 0 1];
%     Dcl = [0 0; 0 0];
% 
%     sys = ss(Acl, Bcl, Ccl, Dcl);
%     [y, t, ~] = step(sys, 0:0.01:10);
%     y11 = y(:,1,1);
%     y12 = y(:,1,2);
%     y21 = y(:,2,1);
%     y22 = y(:,2,2);
    % =====================================================================
    
%     fun = @(x)fnCustoEnvelope_LateroDirecional(x, A, B, C, D);         
%     
%     Aa   = [];
%     bb   = [];
%     Aeq  = [];
%     beq  = [];
%     lb   = [-1000, -1000, -1000,   0.01];
%     ub   = [1000, 1000, 1000,  10];
%      
% %     options = optimoptions('fminimax', 'Display', 'iter');
%     x  = fmincon(fun, x0, Aa, bb, Aeq, beq, lb, ub, []);
% %     options = optimoptions('fminimax','Display', 'iter'); % Minimize abs. values
% %     [x,fval] = fminimax(fun, x0, Aa, bb, Aeq, beq, lb, ub, [], options);
% %     x = fminsearch(fun, x0);
% 
%     % Desembrulho as variáveis.
%     K1  = x(1);
%     K2  = x(2);
%     K3  = x(3);
%     tao = x(4);
%     
%     A   = [     A      zeros(4,1);
%            [0 0 0 1/tao]  -1/tao  ];
%     B   = [B; zeros(1,2)];
%     C   = [0 1 0 0 0;
%            0 0 0 1 0];
%     D   = [0 0; 0 0];
% 
% 
%     % Matrizes de ganho do controlador -- 'K' e 'L'.
%     K = [ 0     K2    K1     0    0;
%           0      0     0     0    K3];
%     L = [ K2  0;
%            0  1];
% 
%     Acl = A - B*K;
%     Bcl = B*L;
%     C   = [0 1 0 0 0;
%            0 0 0 1 0];
%     D   = [0 0; 0 0];
% 
% 
%     Acl = A - B*K;
%     Bcl = B*L;
%     Ccl = C;
%     Dcl = D;
% 
%     TempoSim = 1:0.02:20;
%     G = minreal(tf(ss(Acl, Bcl, Ccl, Dcl)));
% 
%     g11 = G(1,1);
%     g12 = G(1,2);
%     g21 = G(2,1);
%     g22 = G(2,2);

%     y11 = step(g11,TempoSim);
%     y12 = step(g12,TempoSim);
%     y21 = step(g21,TempoSim);
%     y22 = step(g22,TempoSim);
%     
%     
%     pause(2);
%     Kp{k} = kp
%     Kd{k} = kd
end

% t = TempoSim;
% subplot(2,2,1);
% plot(t, y11); grid;
% 
% subplot(2,2,2);
% plot(t, y12); grid;
% 
% subplot(2,2,3);
% plot(t, y21); grid;
% 
% subplot(2,2,4);
% plot(t, y22); grid;
% 
% 
% 
% 
% 
% 
% 
