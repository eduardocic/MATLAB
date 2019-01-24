function [x_dot] = f(X, t)

w = 20;
x = 1;
x1_dot = X(2);
x2_dot = w*x - (w^2)*X(1);

x_dot = [x1_dot;
         x2_dot];

end