function sig_B = fnSwitch_B (Ib, Iba, Imax, pMax, pMin, theta)
%
% Dados:
%
% Ib  ---- Corrente de opera��o na fase B;
% Iba  --- Corrente de opera��o na fase B no instante passado;
% Ia  ---- Corrente m�xima admitida para o ramo;
% pMax --- Porcentagem al�m do m�ximo para a corrente m�xima;
% pMin --- Porcentagem al�m do m�ximo para a corrente m�nima; e
% theta -- �ngulo de rolamento.
% -------------------------------------------------------------------------

% 1) L�gica para o theta.
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

% 2) L�gica 1 do segundo passo.
% -----------------------------

if (Ib < (1-pMin)*Imax)
    p1 = 1;
else
    p1 = 0;
end

if (Ib > (1+pMax)*Imax)
    p2 = 1;
else
    p2 = 0;
end

if ((Ib > (1-pMin)*Imax) && (Ib < (1+pMax)*Imax) && (Ib > Iba))
    p3 = 1;
else
    p3 = 0;
end

if ((Ib > (1-pMin)*Imax) && (Ib < (1+pMax)*Imax) && (Ib < Iba))
    p4 = 1;
else
    p4 = 0;
end


% 3) L�gica 2 do segundo passo.
% -----------------------------

if (Ib > -(1-pMin)*Imax)
    p5 = 1;
else
    p5 = 0;
end

if (Ib < -(1+pMax)*Imax)
    p6 = 1;
else
    p6 = 0;
end

if ((Ib > -(1-pMin)*Imax) && (Ib > -(1+pMax)*Imax) && (Ib > Iba))
    p7 = 1;
else
    p7 = 0;
end

if ((Ib > -(1-pMin)*Imax) && (Ib > -(1+pMax)*Imax) && (Ib < Iba))
    p8 = 1;
else
    p8 = 0;
end


% 4) Resultado final.
% -------------------

sig_B = log_a1*(p1 - p2 + p3 - p4) + ...
        log_a2*(-p5 + p6 - p7 + p8);

end