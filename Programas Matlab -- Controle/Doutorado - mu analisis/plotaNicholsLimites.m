function [] = plotaNicholsLimites(Mdb)
% -------------------------------------------------------------------------
% Essa fun��o pega apenas o valor desejado da regi�o de m�xima pico em
% malha fechada e o transforma em regi�o na carta de Nichols.
%
% Eduardo H. Santos. 
% 25/08/2017
% -------------------------------------------------------------------------
% 1. Converge o valor que j� vem em dB para magnitude normal. Assim, tem-se
% que Mdb = 20*log10(M) --> M = 10^(Mdb/20).
M    = 10^(Mdb/20);

% 2. Posi��o do centro da circunfer�ncia de magnitude e o raio.
xc   = -M^2/(M^2 - 1);
Raio = sqrt(M^2/(M^2 - 1)^2);

% 3. Mapeio em G(jw) = X + jY. Ou seja, ser�o determinados os pontos 
% no plano complexo (X,Y) da fun��o G(jw) que fornecem a magnitude 'M'.
X = linspace(xc-Raio, xc+Raio, 10000);
for i=1:max(size(X))
    Yn(i) = real(sqrt(Raio^2 - (X(i) - xc)^2));
    Yp(i) = real(-sqrt(Raio^2 - (X(i) - xc)^2));
end
X = [X X];
Y = [Yp Yn];

% 4. Construo, ent�o, as fun��es de transfer�ncia em malha aberta G(jw).
G = X + j*Y;
Magnitude = abs(G);
Phase     = (180/pi)*atan2(Y,X);
for i=1:max(size(G))
    if (Phase(i)>0)
        Phase(i) = Phase(i)-360;
    end
end

% 5. Como eu desejo plotar um gr�fico 'Phase' x 'Magnitude (em dB), �
% necess�rio que se fa�a a convers�o ent�o dos valores de magnitude de
% G(jw) para dm.
MagDB = 20*log10(Magnitude);

% 6. Ploto o resultado.
plot(Phase, MagDB, 'ro', ...
                   'MarkerFaceColor','r',...
                   'MarkerSize',2); 
xlabel('Phase (in degrees)');               
ylabel('Magnitude (in dB).');
end




