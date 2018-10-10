function e_c = fnFCEM_C (E, theta)

% Cálculo da força eletromotriz no ramo A.
% ----------------------------------------

if (0 < theta && theta <= pi/6)
   e_c = E;
end

if (pi/6 < theta && theta <= pi/2)
   e_c = -(6*E/pi)*theta + 2*E;
end

if (pi/2 < theta && theta <= (7*pi)/6)
   e_c = -E;
end

if ((7*pi)/6 < theta && theta <= (9*pi)/6)
   e_c = (6*E/pi)*theta - 8*E;
end

if ((9*pi)/6 < theta && theta <= 2*pi)
   e_c = E;
end

end