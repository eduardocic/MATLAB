function f = Custo(x, A, B, C, D)

% Destrinchando o vetor a ser minimizado.
k1 = x(1);
k2 = x(2);
k3 = x(3);
k4 = x(4);

% Matrizes de ganho de realimentação.
K  = [k1 k3;
      k2 k4];  
Acl = A - B*K*C;
Bcl = B*K;

% Construção do sistema.
sys = ss(Acl, Bcl, C, D);

% Resposta ao degrau.
[y, t] = step(sys, 10);

y11    = y(:,1,1);
y12    = y(:,1,2);
y21    = y(:,2,1);
y22    = y(:,2,2);

e1     = 1 - y11;
e2     = 1 - y22;

% Erro do sistema.
e11    = 1 - y11;
e12    = y12;
e21    = y21;
e22    = 1 - y22;

% 1. Cálculo do custos pelo padrão ITAE (integral of time multiplied by
%    absolute error) -- página 221.
mod_e11 = abs(e11);
mod_e12 = abs(e12);
mod_e21 = abs(e21);
mod_e22 = abs(e22);
% 
% f(1)    = t'*mod_e11;
% f(2)    = t'*mod_e12;
% f(3)    = t'*mod_e21;
% f(4)    = t'*mod_e22;

% f(1)    = t'*mod_e11;
% f(2)    = t'*mod_e22;


t1    = e11'*e11;
t2    = e12'*e12;
t3    = e21'*e21;
t4    = e22'*e22;

f = t1 +t4;
end