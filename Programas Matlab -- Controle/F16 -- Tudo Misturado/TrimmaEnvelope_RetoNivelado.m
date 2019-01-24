% =========================================================================
% Autor: Eduardo H. Santos.
%
% Programa escrito em 05/10/2017
% =========================================================================
close all; clear; clc;

MainPath = pwd;
Folders = {'Turbina'; 'Atmosfera'; 'Modelo'; 'CoeficientesAerodinamicos'};

for i = 1:numel(Folders)
    Pasta = [MainPath '/' Folders{i}];
    rmpath(Pasta);
    addpath(Pasta);
end

% Envelope escolhido.
% -------------------
H   = linspace(1000, 3000, 9);     % de 1000m a 3000m
Vel = linspace(250, 500, 11);      % de 250 ft/s a 500 ft/s
m   = max(size(H));                 
n   = max(size(Vel));


% 'Opções' para o otimizador, e carrega a função custo e a função da
% dinâmica do F-16.
% -------------------------------------------------------------------
options   = optimset('TolFun', 1.e-8, 'TolX', 1.e-8, 'MaxFunEvals' , 50000);
Estados   = 'F16_Saida';
flag = 1;

% Inicializa a variável contadora.
% --------------------------------
cont = 0;

% Varia o valor da altitude (H).
% ------------------------------
for i = 1:m
    
    % Varia o valor da velocidade (Vel).
    % ----------------------------------
    for j = 1:n
       
       % Atualiza a variável contadora.
       % ------------------------------
       cont = cont + 1;
       
       % Parâmetros de entrada do sistema.
       % ---------------------------------
       x(1)  = Vel(j);         % Velocidade total (Vel).
       x(12) = H(i);           % Altitude (H).
       u(5)  = 0.35;           % Xcg -- valor escolhido.
       
       % Variáveis restritas à condição de voo escolhida.
       % ------------------------------------------------
       gamma    = 0;
       phi_d    = 0;
       theta_d  = 0;
       psi_d    = 0;
       
       % Passado para a função custo do meu sistema.
       % -------------------------------------------
       varargin = [x(1), x(12), gamma, u(5), phi_d, theta_d, psi_d, flag];
       Cost      = @(s)fnCusto(s, varargin); 
       
       
       % Chute inicial.
       % --------------
       x(2) = 0.1;
       x(3) = 10^-6;
       u(1) = 1;              % throtle.
       u(2) = -1;             % elevator.
       u(3) = 10^-6;          % aileron.
       u(4) = 10^-6;          % rudder.
       s0   = [x(2) x(3) u(1) u(2) u(3) u(4)];  
       
       
       % Resolve o sistema.
       % ------------------
       [s, fval] = fminsearch(Cost, s0, options);
       
   
       % Substitue as variáveis.
       % -----------------------
       x(2) = s(1);           % alpha
       x(3) = s(2);           % beta
       u(1) = s(3);           % throtle
       u(2) = s(4);           % elevator
       u(3) = s(5);           % aileron
       u(4) = s(6);           % rudder

       
       % Calcula o restantes das variáveis.
       % ----------------------------------
       % Sem rolamento. Assim:
       x(4) = 0;
        
       % Cálculo do valor de theta.
       % --------------------------
       a = cos(x(2))*cos(x(3));
       b = sin(x(4))*sin(x(3)) + cos(x(4))*sin(x(2))*cos(x(3));
       num = a*b + sin(gamma)*sqrt(a^2 - sin(gamma)^2 + b^2);
       den = a^2 - sin(gamma)^2;
       x(5) = atan(num/den);
        
       % A variável psi é livre.
       % -----------------------
       x(6) = 0;
        
       % P, Q e R são iguais a zero.
       % ---------------------------
       x(7) = 0;
       x(8) = 0;
       x(9) = 0;      
        
       
       % Última Variável.
       % ----------------
       x(13) = TGear(u(1));

       X{cont} = x;
       U{cont} = u;
       FVAL{cont} = fval;
       
       % Apenas para identificação da trimagem.
       % --------------------------------------
       texto = ['Trimagem para H = ', num2str(H(i)), ' e Vel = ', num2str(Vel(j)), ' realizada com sucesso'];
       disp(texto);
    end
end
save('TrimadosRetoNivelado.mat', 'X', 'U', 'FVAL');