function e_b = fnFCEM_B (E, theta)

% Cálculo da força eletromotriz no ramo A.
% ----------------------------------------

if (0 < theta && theta <= pi/2)
   e_b = -E;
end

if (pi/2 < theta && theta <= (5*pi)/6)
   e_b = (6*E/pi)*theta - 4*E;
end

if ((5*pi)/6 < theta && theta <= (9*pi)/6)
   e_b = E;
end

if ((9*pi)/6 < theta && theta <= (11*pi)/6)
   e_b = -(6*E/pi)*theta + 10*E;
end

if ((11*pi)/6 < theta && theta <= 2*pi)
   e_b = -E;
end

end