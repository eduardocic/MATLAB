clear; clc; close all;

%% Determina��o dos valores constantes do problema.

A = [0 1;-2 -3];         % Inst�vel
% A = [0 1;2 -1];         % Est�vel.
% disp('Autovalores de A: ')
% eig(A)


% In�cio dos problemas de LMI.
%% 1) Defini��o das vari�veis do problema a ser resolvido.
setlmis([]);
P = lmivar(1,[2 1]);        

%% 2) 1� LMI
% Essa LMI � a inequa��o de Lyapunov.
LyapEq = newlmi;                   % Coloca-se um 'tag' para identificar as LMIs.
lmiterm([LyapEq 1 1 P],1,A,'s');   % Coloca-se o 's' para dar a no��o de "Symmetric"  

%% 3) 2� LMI
Ppos = newlmi;
lmiterm([-Ppos 1 1 P],1,1)
%lmiterm([Ppos, 1 1 0],1)

%% 4) Pega as LMIs detalhadas nos passos 2 e 3.
LMIsys = getlmis;

[tmin, xfeas] = feasp(LMIsys);

disp('M�nimo valor de t obtido: ')
tmin

% The LMI system is feasible   iff.  TMIN <= 0

Psol = dec2mat(LMIsys, xfeas, P);
disp('Autovalores de P:')
eig(Psol)
disp('Autovalores de A�P + PA')
eig(A'*Psol + Psol*A)

