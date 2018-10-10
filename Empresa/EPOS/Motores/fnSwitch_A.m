function sig_A = fnSwitch_A (Ia, Iaa, Imax, pMax, pMin, theta)
%
% Dados:
%
% Ia  ---- Corrente de operação na fase A;
% Iaa  --- Corrente de operação na fase A no instante passado;
% Ia  ---- Corrente máxima admitida para o ramo;
% pMax --- Porcentagem além do máximo para a corrente máxima;
% pMin --- Porcentagem além do máximo para a corrente mínima; e
% theta -- Ângulo de rolamento.
% -------------------------------------------------------------------------

% 1) Lógica para o theta.
% -----------------------
if(theta > pi/6 && theta < (5*pi)/6)
    log_a1 = 1;
else
    log_a1 = 0;
end

if(theta > (7*pi)/6 && theta < (11*pi)/6)
    log_a2 = 1;
else
    log_a2 = 0;
end

% 2) Lógica 1 do segundo passo.
% -----------------------------

if (Ia < (1-pMin)*Imax)
    p1 = 1;
else
    p1 = 0;
end

if (Ia > (1+pMax)*Imax)
    p2 = 1;
else
    p2 = 0;
end

if ((Ia > (1-pMin)*Imax) && (Ia < (1+pMax)*Imax) && (Ia > Iaa))
    p3 = 1;
else
    p3 = 0;
end

if ((Ia > (1-pMin)*Imax) && (Ia < (1+pMax)*Imax) && (Ia < Iaa))
    p4 = 1;
else
    p4 = 0;
end


% 3) Lógica 2 do segundo passo.
% -----------------------------

if (Ia > -(1-pMin)*Imax)
    p5 = 1;
else
    p5 = 0;
end

if (Ia < -(1+pMax)*Imax)
    p6 = 1;
else
    p6 = 0;
end

if ((Ia > -(1-pMin)*Imax) && (Ia > -(1+pMax)*Imax) && (Ia > Iaa))
    p7 = 1;
else
    p7 = 0;
end

if ((Ia > -(1-pMin)*Imax) && (Ia > -(1+pMax)*Imax) && (Ia < Iaa))
    p8 = 1;
else
    p8 = 0;
end


% 4) Resultado final.
% -------------------

sig_A = log_a1*(p1 - p2 + p3 - p4) + ...
        log_a2*(-p5 + p6 - p7 + p8);

end