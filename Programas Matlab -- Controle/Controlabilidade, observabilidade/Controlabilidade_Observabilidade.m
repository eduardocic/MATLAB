close all; clear all; clc;

% Matrizes do sistema.
A = [-2 -2;
      0 -4];
B = [1 1]';
C = [1 0];
D = 0;

% Autovetores pela esquerda.
[autoVectorLeft, ~] = eig(A');
autoValueLeft = eig(A');

% C�lculo dos 'input pole vectors'.
u_p = B'*autoVectorLeft;

for i=1:max(size(u_p))
    a1 = num2str(i);
    a2 = num2str(autoValueLeft(i));
    a3 = num2str(u_p(i));
    if (round(u_p(i)) ~= 0)    
        X = ['(*) O polo (modo) p(', a1,') = ', a2, ' � CONTROL�VEL, pois u_p,', a1, ' = ', a3];
        disp(X);
    else
        X = ['(*) O polo (modo) p(', a1,') = ', a2, ' � N�O CONTROL�VEL, pois u_p,', a1, ' = ', a3];
        disp(X);
        if(round(u_p(i)) <= 0)
            X = ['    ... mas polo (modo) p(', num2str(a1),') = ', num2str(a2), ' � ESTABILIZ�VEL, pois p(', a2, ') � <= 0 '];
            disp(X);
        else
            X = ['    ... e polo (modo) p(', num2str(a1),') = ', num2str(a2), ' � N�O ESTABILIZ�VEL, pois p(', a1, ') � > 0 '];
            disp(X);
        end
    end
end

% Matrizes do sistema.
A = [-2 -2;
      0 -4];
B = [1 1]';
C = [1 0];
D = 0;

% Autovetores pela direita.
[autoVectorRight, ~] = eig(A);
autoValueRight = eig(A);

% C�lculo dos 'output pole vectors'.
y_p = C*autoVectorRight;
disp(' ');
for i=1:max(size(u_p))
    a1 = num2str(i);
    a2 = num2str(autoValueRight(i));
    a3 = num2str(y_p(i));
    if (round(y_p(i)) ~= 0)    
        X = ['(*) O polo (modo) p(', a1,') = ', a2, ' � OBSERV�VEL, pois u_p,', a1, ' = ', a3];
        disp(X);
    else
        X = ['(*) O polo (modo) p(', a1,') = ', a2, ' � N�O OBSERV�VEL, pois u_p,', a1, ' = ', a3];
        disp(X);
        if(round(y_p(i)) <= 0)
            X = ['    ... mas polo (modo) p(', num2str(a1),') = ', num2str(a2), ' � DETECT�VEL, pois p(', a2, ') � <= 0 '];
            disp(X);
        else
            X = ['    ... e polo (modo) p(', num2str(a1),') = ', num2str(a2), ' � N�O DETECT�VEL, pois p(', a1, ') � > 0 '];
            disp(X);
        end
    end
end
