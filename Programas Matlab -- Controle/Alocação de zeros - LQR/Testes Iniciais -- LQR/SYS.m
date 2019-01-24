function xdot = SYS(t, x, u)

A = [0    -2     0     0;
     1     0     0     0;
     0     1     0     0;
     0     0     1     0];
B =  [1    0     0     0]';

xdot = A*x + B*u;
end

