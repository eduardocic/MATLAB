function  X_dot = f_missil(X, t, nc, lambda)

X_dot(1,1) = X(1,2);
X_dot(1,2) = -nc*sin(lambda);
X_dot(1,3) = X(1,4);
X_dot(1,4) = nc*cos(lambda);

end