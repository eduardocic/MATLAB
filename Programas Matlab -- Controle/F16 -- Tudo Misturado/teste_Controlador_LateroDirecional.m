clear all; close all; clc;

% Carrega as dinâmicas latero-direcionais.
load('DinamicaLateroDirecional_RetoNivelado.mat');

%% Fechando o primeiro loop.
K1 = linspace(0,10,300);
K2 = 0;
K3 = 0;

k = 1;
% Matrizes de estado.
A = A_lat{k};
B = B_lat{k};
C = [0 1 0 0;       % phi;
     0 0 1 0;       % p;
     0 0 0 1];      % r;
D = [0 0;
     0 0;
     0 0];
G = minreal(tf(ss(A,B,C,D)));
  
g21 = G(2,1);    
rlocus(g21, K1);


%% Fechando o segundo loop.

K1 = .8;
K2 = 0;
K3 = 0;

K = [ 0     K2    K1     0;
      0      0     0     K3];
L = [ K2  0;
       0  1];

Acl = A - B*K;
Bcl = B*L;
C = [0 1 0 0;       % phi;
     0 0 1 0;       % p;
     0 0 0 1];      % r;
D = [0 0;
     0 0;
     0 0];

G = minreal(tf(ss(A,B,C,D)));
  
g11 = G(1,1); 
K2  = linspace(0,-10,300);
rlocus(g11, K2);


%% Fechando o terceiro loop.
K1 = 0.8;
K2 = -1;
K3 = 0;

K = [ 0     K2    K1     0;
      0      0     0     K3];
L = [ K2  0;
       0  1];

Acl = A - B*K;
Bcl = B*L;
C = [0 1 0 0;       % phi;
     0 0 1 0;       % p;
     0 0 0 1];      % r;
D = [0 0;
     0 0;
     0 0];

G = minreal(tf(ss(A,B,C,D)));
  
g32 = G(3,2); 
K3  = linspace(0,50,300);
rlocus(g32, K3);
K3 = -1;


% Matrizes de ganho do controlador -- 'K' e 'L'.
K = [ 0     K2    K1   0;
      0      0     0   K3];
L = [ K2  0;
       0  1];

Acl = A - B*K;
Bcl = B*L;
C = [0 1 0 0;       % phi;
     0 0 1 0;       % p;
     0 0 0 1];      % r;
D = [0 0;
     0 0;
     0 0];


Acl = A - B*K;
Bcl = B*L;
Ccl = C;
Dcl = D;

TempoSim = 1:0.02:50;
G = minreal(tf(ss(Acl, Bcl, Ccl, Dcl)));

g11 = G(1,1);
g12 = G(1,2);
g21 = G(2,1);
g22 = G(2,2);

y11 = step(g11,TempoSim);
y12 = step(g12,TempoSim);
y21 = step(g21,TempoSim);
y22 = step(g22,TempoSim);

figure;
t = TempoSim;
subplot(2,2,1);
plot(t, y11); grid;

subplot(2,2,2);
plot(t, y12); grid;

subplot(2,2,3);
plot(t, y21); grid;

subplot(2,2,4);
plot(t, y22); grid;




