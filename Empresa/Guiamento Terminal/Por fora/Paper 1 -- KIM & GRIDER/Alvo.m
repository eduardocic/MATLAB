function [Xd] = Alvo(X, u, t)

Xd(1,1) = X(1,2);       % Velocidade em y.
Xd(1,2) = 0;            % Acelera��o em y.
Xd(1,3) = X(1,4);       % Velocidade em y.
Xd(1,4) = 0;            % Acelera��o em y;
end
