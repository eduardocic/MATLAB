function CoeficientePitching = Cm (alpha, elevator)
% =========================================================================
%
%                        Coeficiente de Pithing
%                       -------------------------
% 
% -- Os valores do AoA (�ngulo de ataque) varia de -10� a 45� em passos de
%    5�;
%
% -- Os valores de derrapagem varia de -25� a 25� em passos de 12,5�;
%
% -- A tabela abaixo tem a seguinte equival�ncia:
%      x: AoA; e
%      y: Elevator.
%
% -- Atentar que a tabela em se reflete de forma que cresce da seguinte
%    da seguinte forma: (-10,45), ou seja da esquerda para a direita, e
%    (-25,25) de cima para baixo.
%
% -- Para acessarmos o valor correspondente para um determinado 'alpha' e
%    'elevator' a gente chama da forma 'A(elevator, alpha)', pois as 
%    vari�veis variam de acordo com 'A(linha, coluna)'.
%               
% -- Com a coluna variando diz respeito aos par�metros 'alpha' e as linhas
%    dizem respeito aos par�metros 'elevator', a chamada do valor da
%    interpola��o ser� dado por 'A(elevator, alpha)'.
%
% �ltima revis�o: 19/09/2017.
% Eduardo H. Santos
% =========================================================================

Cm = [  0.205   0.168   0.186   0.196   0.213   0.251   0.245   0.238   0.252   0.231   0.198   0.192;
        0.081   0.077   0.107   0.110   0.110   0.141   0.127   0.119   0.133   0.108   0.081   0.093;
       -0.046  -0.020  -0.009  -0.005  -0.006   0.010   0.006  -0.001   0.014   0.000  -0.013   0.032;
       -0.174  -0.145  -0.121  -0.127  -0.129  -0.102  -0.097  -0.113  -0.087  -0.084  -0.069  -0.006;
       -0.259  -0.202  -0.184  -0.193  -0.199  -0.150  -0.160  -0.167  -0.104  -0.076  -0.041  -0.005;];
  
% Encontrando a c�lula de interpola��o.
% 'AoA'.
S = alpha/5;
x = floor(S);
if(x <= -2)
    x = -2;
end
if(x >= 9)
    x = 8;
end

% Elevator
S = elevator/12;
y = floor(S);
if(y <= -2)
    y = -2;
end
if(y >= 2)
    y = 1;
end

% Valores dos ret�ngulos.
x1 = 5*x;
x2 = 5*(x+1);
y1 = 12*y;
y2 = 12*(y+1);

% Ajuste para pegar os valores das tabelas.
xc  = x + 3;
yc  = y + 3;
Q11 = Cm(yc, xc);
Q12 = Cm(yc+1, xc);
Q21 = Cm(yc, xc+1);
Q22 = Cm(yc+1, xc+1);

% 5. Realiza o c�lculo da interpola��o.
Q = [Q11 Q12;
     Q21 Q22];
X = [ x1 1;
      x2 1];
Y = [ y1 1;
      y2 1];
CoeficientePitching = [elevator 1]*inv(Y)*(Q')*inv(X)'*[alpha 1]';  
  
end