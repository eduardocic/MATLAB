function [kp, kd] = CoeficientesControladores_Interpolados(Kp, Kd, Vt, H)
% =========================================================================
%
%              Interpolação de coeficientes de Controladores
%             -----------------------------------------------
% 
% -- Os valores de velocidade variam de 250 a 500 ft/s, em passos de 25
%    ft/s.
%
% -- Os valores de altitude variam 1000 a 3000 m, em passos de 125 m;
%
% -- A tabela abaixo tem a seguinte equivalência:
%      x: Vt; e
%      y: H.
%
% -- Atentar que a tabela em se reflete de forma que cresce da seguinte
%    da seguinte forma: (250, 500), ou seja da esquerda para a direita, e
%    (1000,3000) de cima para baixo.
%
% -- Para acessarmos o valor correspondente para um determinado 'Vt' e
%    'H' a gente chama da forma 'A(H, Vt)', pois as variáveis 
%    variam de acordo com 'A(linha, coluna)'.
%               
% -- Com a coluna variando diz respeito aos parâmetros 'Vt' e as linhas
%    dizem respeito aos parâmetros 'H', a chamada do valor da
%    interpolação será dado por 'A(H, Vt)'.
%
% Última revisão: 10/10/2017.
% Eduardo H. Santos
% =========================================================================

% 1. Velocidade.
S = (Vt-250)/25;
x = floor(S);
if(x <= 0)
    x = 0;
end
if(x >= 11)
    x = 10;
end
 
% 2. Altitude -- H.
S = (H - 1000)/125;
y = floor(S);
if(y <= 0)
    y = 0;
end
if(y >= 9)
    y = 8;
end

% 3. Valores dos retângulos.
x1 = 25*x + 250;
x2 = 25*(x+1) + 250;
y1 = 125*y + 1000;
y2 = 125*(y+1) + 1000;


% 4. Ajuste para pegar os valores das tabelas -- kp
xc = x + 1;
yc = y + 1;
Q11 = Kp(yc, xc);
Q12 = Kp(yc+1, xc);
Q21 = Kp(yc, xc+1);
Q22 = Kp(yc+1, xc+1);

% 5. Realiza o cálculo da interpolação.
Q = [Q11 Q12;
     Q21 Q22];
X = [ x1 1;
      x2 1];
Y = [ y1 1;
      y2 1];

% 6. Encontra o valor de 'kp'.
kp = [H 1]*inv(Y)*(Q')*inv(X)'*[Vt 1]';  


% 7. Encontra o valor de 'kd'.
Q11 = Kd(yc, xc);
Q12 = Kd(yc+1, xc);
Q21 = Kd(yc, xc+1);
Q22 = Kd(yc+1, xc+1);
Q = [Q11 Q12;
     Q21 Q22];
 
kd = [H 1]*inv(Y)*(Q')*inv(X)'*[Vt 1]';
end
 
    
    