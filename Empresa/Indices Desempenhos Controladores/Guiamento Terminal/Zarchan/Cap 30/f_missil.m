function  X_dot = f_missil(X, t, nc, lambda)

theta = atan2(X(1,4),X(1,2));   % Inserido dia 17/04/2017
ang = theta*180/pi;

X_dot(1,1) = X(1,2);
X_dot(1,2) = -nc*sin(lambda); 
% X_dot(1,2) = -nc*sin(theta); 
X_dot(1,3) = X(1,4);
X_dot(1,4) = nc*cos(lambda);
% X_dot(1,4) = nc*cos(theta);

end