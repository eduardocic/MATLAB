function [] = plotaNicholsLimites(Mdb)
% -------------------------------------------------------------------------
% Essa função pega apenas o valor desejado da região de máxima pico em
% malha fechada e o transforma em região na carta de Nichols.
%
% Eduardo H. Santos. 
% 25/08/2017
% -------------------------------------------------------------------------
% 1. Converge o valor que já vem em dB para magnitude normal. Assim, tem-se
% que Mdb = 20*log10(M) --> M = 10^(Mdb/20).
M    = 10^(Mdb/20);

% 2. Posição do centro da circunferência de magnitude e o raio.
xc   = -M^2/(M^2 - 1);
Raio = sqrt(M^2/(M^2 - 1)^2);

% 3. Mapeio em G(jw) = X + jY. Ou seja, serão determinados os pontos 
% no plano complexo (X,Y) da função G(jw) que fornecem a magnitude 'M'.
X = linspace(xc-Raio, xc+Raio, 10000);
for i=1:max(size(X))
    Yn(i) = real(sqrt(Raio^2 - (X(i) - xc)^2));
    Yp(i) = real(-sqrt(Raio^2 - (X(i) - xc)^2));
end
X = [X X];
Y = [Yp Yn];

% 4. Construo, então, as funções de transferência em malha aberta G(jw).
G = X + j*Y;
Magnitude = abs(G);
Phase     = (180/pi)*atan2(Y,X);
for i=1:max(size(G))
    if (Phase(i)>0)
        Phase(i) = Phase(i)-360;
    end
end

% 5. Como eu desejo plotar um gráfico 'Phase' x 'Magnitude (em dB), é
% necessário que se faça a conversão então dos valores de magnitude de
% G(jw) para dm.
MagDB = 20*log10(Magnitude);

% 6. Ploto o resultado.
plot(Phase, MagDB, 'ro', ...
                   'MarkerFaceColor','r',...
                   'MarkerSize',2); 
xlabel('Phase (in degrees)');               
ylabel('Magnitude (in dB).');
end




