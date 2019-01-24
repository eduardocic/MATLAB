clear all; close all; clc;

% Matrizes do sistema (Planta).
% -----------------------------
Ap = [-1.01887   0.90506   -0.00215;
       0.82225  -1.07741   -0.17555;
             0         0      -20.2];
        
Bp = [0  0  20.2]';        
Cp = [57.2958      0    0;
           0  57.2958  0;];
Dp = [0 0]';  

sys = ss(Ap,Bp,Cp,Dp);
Gp  = tf(sys);          % Função de transferência da planta.


% Tempo de discretização escolhido e aproximação de Padé.
% -------------------------------------------------------
dt   = 0.25;
Gzoh = tf([-dt/6 1],[dt/3 1]);   
Gzoh = minreal(Gzoh);


% % Concatenação dos sistemas - página 215.
% % ---------------------------------------
% sys_Gzoh = ss(Gzoh);
% Ad = sys_Gzoh.a;  Bd = sys_Gzoh.b;  Cd = sys_Gzoh.c;  Dd = sys_Gzoh.d; 
% %
% % A = [  Ad      zeros(1,3);
% %       Bp*Cd      Ap     ];
% % B = [ Bd;
% %       Bp*Dd];
% % C = [Dp*Cd Cp];
% % D = [Dp*Dd];
A = Ap;   B = Bp;  C = Cp;    D = Dp;


% Ganhos do LQR do livro -- página 594.
% dt = 0.25;
dt = 0.1;
% dt = 0.025;

Ki = 0.8426;
Ka = -0.04238;
Kq = -0.4098;

% Após a discretização (obtenção dos ganhos).
% ------------------------------------------
k1 = Ki*dt/2;
PI = (1-10*dt/2)/(1+10*dt/2);
k2 = 10*Ka*dt/(10*dt+2);
k3 = Kq;