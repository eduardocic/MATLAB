function [T0, T1, T2] = Times(Vref, Angulo, T)

T1 = T*Vref*2*sin((pi/3) - Angulo)/sqrt(3);   % Tempo para o V1.
T2 = T*Vref*2*sin(Angulo)/sqrt(3);            % Tempo para o V2.
T0 = T - T1 - T2;                             % Tempo para o Vetor Nulo.

end