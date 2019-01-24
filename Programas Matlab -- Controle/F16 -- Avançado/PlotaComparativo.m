% fprintf('Valores de 1 a 99.\n');
% fprintf('OBS: Caso deseje sair, digite 0. \n\n');
% flag = input('Digite o número da simulação desejada: ');  
if (flag ~= 0)
        
    % Parte não-linear
    % ----------------
    for k = 1:(max(size(X_nl{flag}))-1)
       % Estados.
       Vt_nl(k)      = X_nl{flag}{1,k}(1,1);
       alpha_nl(k)   = X_nl{flag}{1,k}(1,2);
       beta_nl(k)    = X_nl{flag}{1,k}(1,3);
       phi_nl(k)     = X_nl{flag}{1,k}(1,4);
       theta_nl(k)   = X_nl{flag}{1,k}(1,5);
       psi_nl(k)     = X_nl{flag}{1,k}(1,6);
       P_nl(k)       = X_nl{flag}{1,k}(1,7);
       Q_nl(k)       = X_nl{flag}{1,k}(1,8);
       R_nl(k)       = X_nl{flag}{1,k}(1,9);
    end
        
        
    % Parte linear
    % ------------
    for k = 1:max(size(Y_l{flag}))
       % Estados.
       Vt_l(k)      = Y_l{flag}(k,1) + X{flag}(1,1);
       alpha_l(k)   = Y_l{flag}(k,2) + X{flag}(1,2);
       beta_l(k)    = Y_l{flag}(k,3) + X{flag}(1,3);
       phi_l(k)     = Y_l{flag}(k,4) + X{flag}(1,4);
       theta_l(k)   = Y_l{flag}(k,5) + X{flag}(1,5);
       psi_l(k)     = Y_l{flag}(k,6) + X{flag}(1,6);
       P_l(k)       = Y_l{flag}(k,7) + X{flag}(1,7);  
       Q_l(k)       = Y_l{flag}(k,8) + X{flag}(1,8);
       R_l(k)       = Y_l{flag}(k,9) + X{flag}(1,9);
    end
end
    
    
subplot(5,2,1); 
% Plota o resultado.
plot(t_nl, Vt_nl, t_l, Vt_l, 'r'); grid;
xlabel('Tempo (s)');
ylabel('V_t (m/s)');

subplot(5,2,2); 
plot(t_nl, alpha_nl, t_l, alpha_l, 'r'); grid;
xlabel('Tempo (s)');
ylabel('\alpha (rad)');

subplot(5,2,3); 
plot(t_nl, beta_nl, t_l, beta_l, 'r'); grid;
xlabel('Tempo (s)');
ylabel('\beta (rad)');

subplot(5,2,4);
plot(t_nl, phi_nl, t_l, phi_l, 'r'); grid;
xlabel('Tempo (s)');
ylabel('\phi (rad)');

subplot(5,2,5);
plot(t_nl, theta_nl, t_l, theta_l, 'r'); grid;
xlabel('Tempo (s)');
ylabel('\theta (rad)');

subplot(5,2,6);
plot(t_nl, psi_nl, t_l, psi_l, 'r'); grid;
xlabel('Tempo (s)');
ylabel('\psi (rad)');

subplot(5,2,7);
plot(t_nl, P_nl, t_l, P_l, 'r'); grid;
xlabel('Tempo (s)');
ylabel('P (rad/s)');

subplot(5,2,8);
plot(t_nl, Q_nl, t_l, Q_l, 'r'); grid;
xlabel('Tempo (s)');
ylabel('Q (rad/s)');

subplot(5,2,9);
plot(t_nl, R_nl, t_l, R_l, 'r'); grid;
xlabel('Tempo (s)');
ylabel('R (rad/s)');
legend('Não-Linear', 'Linear');


