function e_a = fnFCEM_A (E, theta)

% Cálculo da força eletromotriz no ramo A.
% ----------------------------------------

if (0 < theta && theta <= pi/6)
   e_a = (6*E/pi)*theta;
end

if (pi/6 < theta && theta <= (5*pi)/6)
   e_a = E;
end

if ((5*pi)/6 < theta && theta <= (7*pi)/6)
   e_a = -(6*E/pi)*theta + 6*E;
end

if ((7*pi)/6 < theta && theta <= (11*pi)/6)
   e_a = -E;
end

if ((11*pi)/6 < theta && theta <= 2*pi)
   e_a = (6*E/pi)*theta - 12*E;
end

end