function [] = RegiaoEntreRetas(A, B, Umax, squad)

%%% Direção do vetor Xss.
H    = MatrixH(A);   

%%% Cálculo direcional dado H.
u = H(1);
v = H(2);

% Ângulo, em radiano
if (u~=0)
    angH = atan(v/u);
else
    angH = atan(v/(u+10^-5));
end

angMais  = angH + pi/2;     % perpendicular Mais.
angMenos = angH - pi/2;     % perpendicular Menos.

% Cálculo da distância máxima e mínima dado os vetores 'angMais' e
% 'angMenos'.
uMais = 1*cos(angMais);
vMais = 1*sin(angMais);
eMais = [uMais; vMais];
MultiMais = LMI_DominioAtracao(A, B, eMais, Umax);   % Parcela multiplicativa,
                                                     % na direção dada.

uMenos = 1*cos(angMenos);
vMenos = 1*sin(angMenos);
eMenos = [uMenos; vMenos];
MultiMenos = LMI_DominioAtracao(A, B, eMenos, Umax); % Parcela multiplicativa,
                                                     % na direção dada.

% Pontos no espaço dado pelos vetores MultiMais e MultiMenos.                                                     
pMais  = eMais*MultiMais;
pMenos = eMenos*MultiMenos;

% Plotagem dos pontos.
plot(pMais(1), pMais(2), '*'); hold on;
plot(pMenos(1), pMenos(2), '*r'); grid;
quiver(0,0,u,v);           % Vetor direção H.

% Reta paralela 1.
xmin = squad(1);
xmax = squad(2);
x = linspace(2*xmin, 2*xmax, 1001);

b1 = pMais(2) - tan(angH)*pMais(1);
y1 = tan(angH)*x + b1;
plot(x, y1);

% Reta paralela 2.
b2 = pMenos(2) - tan(angH)*pMenos(1);
y2  = tan(angH)*x + b2;
plot(x, y2);

end
