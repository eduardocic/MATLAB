function Resultado = fnCusto(s, varargin)

varargin = varargin{1};

% Direto da variável a ser minimizada.
x(2)  = s(1);           % alpha
x(3)  = s(2);           % beta
u(1)  = s(3);           % throtle
u(2)  = s(4);           % elevator
u(3)  = s(5);           % aileron
u(4)  = s(6);           % rudder
x(13) = TGear(u(1));

% Das variáveis de acordo com o que se deseja do voo.
x(1)    = varargin(1);      % Vt.
x(12)   = varargin(2);      % h.
gamma   = varargin(3);      % gamma.
u(5)    = varargin(4);      % Xcg;
phi_d   = varargin(5);      % phi ponto (derivada).  
theta_d = varargin(6);      % theta ponto (derivada).  
psi_d   = varargin(7);      % psi ponto (derivada).  
Indice  = varargin(8);      % Indice para situação de voo.

switch Indice
    case 1
        % Sem rolamento. Assim:
        x(4) = 0;
        
        % Cálculo do valor de theta.
        a = cos(x(2))*cos(x(3));
        b = sin(x(4))*sin(x(3)) + cos(x(4))*sin(x(2))*cos(x(3));
        num = a*b + sin(gamma)*sqrt(a^2 - sin(gamma)^2 + b^2);
        den = a^2 - sin(gamma)^2;
        x(5) = atan(num/den);
        
        % A variável 'psi' é livre.
        x(6) = 0;
        
        % P, Q e R são iguais a zero.
        x(7) = 0;
        x(8) = 0;
        x(9) = 0;       
%         x
    case 2
        % Haverá um rolamento. Dessa forma, definiremos:
        E = psi_d*x(1)/32.17;
        a = 1 - E*tan(x(2))*sin(x(3));
        b = sin(gamma)/cos(x(3));
        c = 1 + (E*cos(x(3))^2);
        
        num = E*cos(x(3))*((a-b^2) + b*tan(x(2))*sqrt(c*(1-b^2) + (E*sin(x(3))^2)));
        den = cos(x(2))*(a^2 - b^2*(1 + c*tan(x(2))^2));
        
        x(4) = atan(num/den);
        
        % Cálculo do valor de theta.
        a2 = cos(x(2))*cos(x(3));
        b2 = sin(x(4))*sin(x(3)) + cos(x(4))*sin(x(2))*cos(x(3));
        
        num = a2*b2 + sin(gamma)*sqrt(a2^2 - sin(gamma)^2 + b2^2);
        den = a2^2 - sin(gamma)^2;
        
        x(5) = atan(num/den);
        
        % A variável psi é livre.
        x(6) = 0;
        
        % P, Q e R são iguais a zero.
        x(7) = phi_d - sin(x(5))*psi_d;
        x(8) = cos(x(4))*theta_d + sin(x(4))*cos(x(5))*psi_d;
        x(9) = -sin(x(4))*theta_d + cos(x(4))*cos(x(5))*psi_d;    
        x
end

t = 0.0;
[xd, ~]   = F16_saida(x, u, t);  
Resultado = xd(1)^2 + 100*(xd(2)^2 + xd(3)^2) + 10*(xd(7)^2 + xd(8)^2 + xd(9)^2);
end