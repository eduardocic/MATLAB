function  Y_dot = f_target(Y, t, nt, beta)

Y_dot(1,1) = Y(1,2);
Y_dot(1,2) = nt*sin(beta);
Y_dot(1,3) = Y(1,4);
Y_dot(1,4) = nt*cos(beta);

end