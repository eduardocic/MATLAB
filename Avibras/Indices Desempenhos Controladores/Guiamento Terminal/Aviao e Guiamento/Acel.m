clear all; close all; clc;

% Planta.
% -------
Ap = [ -1.0189  0.90506; 
        0.82225 -1.0774];  % x1 = alpha,  x2 = q
Bp = [ -2.1499E-3; 
       -1.7555E-1];        % Elevator input
Cp = [      0   57.29578; 
       16.262   0.978770]; % y1 = q,  y2 =  an
Dp = [     0; 
       -0.048523];
SYS_planta = ss(Ap, Bp, Cp, Dp); 

% Atuador.
% --------
SYS_atuador = ss(-20.2, 20.2, -1,0);    % Actuator, SIGN CHANGE

% Cascata ATUADOR + PLANTA.
% -------------------------
[SYS] = series(SYS_atuador,SYS_planta); % Actuator then Plant


% Ganhos.
% -------
kp = 5;
kq = 0.4;


[a,b,c,d]= ssdata(SYS);               % an/u transfer fn.
% acl= a - b*[0.4 0]*c;                 % Close q loop
% [z,p,k]= ss2zp(acl,b,c(2,:),d(2,:))        % an/u1 transfer fn.