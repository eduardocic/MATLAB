function [Mach, Qbar] = ADC (VT, Alt)
% Atmosphete Data Computer.

rho0 = 2.377e-3;                  % Densidade ao nivel do mar.

Tfac = 1.0 - 0.703e-5*Alt;
T    = 519.0*Tfac;                % Temperatura.

if (Alt >= 35000.0)
   T = 390.0;
end

rho = rho0*(Tfac^(4.14));

Mach = VT/sqrt(1.4*1716.3*T);   % Numero de Mach.
Qbar = 0.5*rho*VT*VT;           % Press�o Din�mica.
Cps  = 1715*rho*T;              % Press�o est�tica.


end
