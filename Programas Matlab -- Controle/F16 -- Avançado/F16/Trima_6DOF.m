% =========================================================================
% Autor: Eduardo H. Santos.
% C�digo originalmente escrito em 31/03/2015.
%
% (*) �ltima modifica��o: 26/09/2017.
% -------------------------------------------------------------------------
% A ideia primordial desse programa � fazer a programa��o inicial que ser�
% utilizada no decorrer nas simula��es que n�o funcionam em tempo real. O
% presente exemplo considera a caracteristica de uma SIMULA��O N�O LINEAR
% para que se entenda o que realmente ocorre e como fazer as simula��es
% subsequentes.
% =========================================================================
close all; clear; clc;

MainPath = pwd;
Folders = {'Modelo_Turbina'; 'Modelo_Atmosfera'; '6DOF'; 'Modelo_CoeficientesAerodinamicos'};

for i = 1:numel(Folders)
    Pasta = [MainPath '/' Folders{i}];
    rmpath(Pasta);
    addpath(Pasta);
end


% Condi��es de voo
% -----------------
Condicao = {'Reto Nivelado', 'Curva Coordenada'};
fprintf('Casos considerados\n');
fprintf('------------------\n\n');
fprintf('1: Reto Nivelado.\n');
fprintf('2: Curva Coordenada.\n\n');
flag = input('Digite a situa��o de voo de interesse: ');

switch cell2mat(Condicao(flag))
    % ---------------------------------------------------------------------
    case 'Reto Nivelado'
       clc;
       disp('Op��o RETO NIVELADO selecionada.');
       
       % Vari�veis livres.  
%        x(1)  = input('Digite a velocidade desejada: ');
%        x(12) = input('Digite a altitude desejada: ');
%        u(5)  = input('Digite a posi��o do CG: ');
       x(1)  = 502;         % Vt
       x(12) = 0;           % h
       u(5)  = 0.30;        % Xcg
       
       % Vari�veis restritas � condi��o escolhida.
       gamma    = 0;
       phi_d    = 0;
       theta_d  = 0;
       psi_d    = 0;
       
       % Passado para a fun��o custo do meu sistema.
       varargin = [x(1), x(12), gamma, u(5), phi_d, theta_d, psi_d, flag];
       
       % Chute inicial
       x(2) = 0.1;
       x(3) = 10^-6;
       u(1) = 1;              % throtle.
       u(2) = -1;             % elevator.
       u(3) = 10^-6;          % aileron.
       u(4) = 10^-6;          % rudder.
       s0   = [x(2) x(3) u(1) u(2) u(3) u(4)];  
       
       
    % ---------------------------------------------------------------------   
    case 'Curva Coordenada'
       clc;
       disp('Op��o CURVA COORDENADA selecionada.');
       
       % Vari�veis livres.
%        x(1)  = input('Digite a velocidade desejada: ');
%        x(12) = input('Digite a altitude desejada: ');
%        u(5)  = input('Digite a posi��o do CG: ');
%        gamma = input('Digite o valor de gamma: ');
%        psi_d = input('Digite o valor de "psi ponto": ');
       x(1)  = 502;
       x(12) = 0;
       u(5)  = 0.3;
       gamma = 0;
       psi_d = 0.3;
       
       % Vari�veis restritas � condi��o escolhida.
       phi_d    = 0;
       theta_d  = 0;
       
       % Passado para a fun��o custo do meu sistema.
       varargin = [x(1), x(12), gamma, u(5), phi_d, theta_d, psi_d, flag];
       
       % Chute inicial
       x(2) = 0;
       x(3) = 0;
       u(1) = 0.5;       % throtle.
       u(2) = -1;        % elevator.
       u(3) = 0.01;         % aileron.
       u(4) = 0.01;  % rudder.
       s0   = [x(2) x(3) u(1) u(2) u(3) u(4)];  
end
 

% Determina��o do custo inicial.
% ------------------------------
Cost      = @(s)fnCusto(s, varargin); 
Estados   = 'F16_Saida';

% Resolve o sistema.
% ------------------
% options   = optimset('TolFun', 10^-8, 'MaxFunEvals' , 5000);
options   = optimset('TolFun', 1.e-8, 'TolX', 1.e-8, 'MaxFunEvals' , 500000);
[s, fval] = fminsearch(Cost, s0, options)
   
% Substitui as vari�veis.
% -----------------------
x(2) = s(1);           % alpha
x(3) = s(2);           % beta
u(1) = s(3);           % throtle
u(2) = s(4);           % elevator
u(3) = s(5);           % aileron
u(4) = s(6);           % rudder

% Calcula o restante das vari�veis.
% ---------------------------------
switch flag
    case 1
        % Sem rolamento. Assim:
        x(4) = 0;
        
        % C�lculo do valor de theta.
        a = cos(x(2))*cos(x(3));
        b = sin(x(4))*sin(x(3)) + cos(x(4))*sin(x(2))*cos(x(3));
        num = a*b + sin(gamma)*sqrt(a^2 - sin(gamma)^2 + b^2);
        den = a^2 - sin(gamma)^2;
        x(5) = atan(num/den);
        
        % A vari�vel psi � livre.
        x(6) = 0;
        
        % P, Q e R s�o iguais a zero.
        x(7) = 0;
        x(8) = 0;
        x(9) = 0;      
        
        
    case 2
        % Haver� um rolamento. Dessa forma, definiremos:
        E = psi_d*x(1)/32.17;
        a = 1 - E*tan(x(2))*sin(x(3));
        b = sin(gamma)/cos(x(3));
        c = 1 + (E*cos(x(3))^2);
        
        num = E*cos(x(3))*((a-b^2) + b*tan(x(2))*sqrt(c*(1-b^2) + (E*sin(x(3))^2)));
        den = cos(x(2))*(a^2 - b^2*(1 + c*tan(x(2))^2));
        
        x(4) = atan(num/den);
        
        % C�lculo do valor de theta.
        a2 = cos(x(2))*cos(x(3));
        b2 = sin(x(4))*sin(x(3)) + cos(x(4))*sin(x(2))*cos(x(3));
        
        num = a2*b2 + sin(gamma)*sqrt(a2^2 - sin(gamma)^2 + b2^2);
        den = a2^2 - sin(gamma)^2;
        
        x(5) = atan(num/den);
        
        % A vari�vel psi � livre.
        x(6) = 0;
        
        % P, Q e R s�o iguais a zero.
        x(7) = phi_d - sin(x(5))*psi_d;
        x(8) = cos(x(4))*theta_d + sin(x(4))*cos(x(5))*psi_d;
        x(9) = -sin(x(4))*theta_d + cos(x(4))*cos(x(5))*psi_d;    
end
% �ltima Vari�vel.
x(13) = TGear(u(1));

% Resultado.
clc;
x
u'
save('Trimados.mat', 'x', 'u', 'fval');