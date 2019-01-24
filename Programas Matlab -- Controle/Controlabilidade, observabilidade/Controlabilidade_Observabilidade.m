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

% Cálculo dos 'input pole vectors'.
u_p = B'*autoVectorLeft;

for i=1:max(size(u_p))
    a1 = num2str(i);
    a2 = num2str(autoValueLeft(i));
    a3 = num2str(u_p(i));
    if (round(u_p(i)) ~= 0)    
        X = ['(*) O polo (modo) p(', a1,') = ', a2, ' é CONTROLÁVEL, pois u_p,', a1, ' = ', a3];
        disp(X);
    else
        X = ['(*) O polo (modo) p(', a1,') = ', a2, ' é NÃO CONTROLÁVEL, pois u_p,', a1, ' = ', a3];
        disp(X);
        if(round(u_p(i)) <= 0)
            X = ['    ... mas polo (modo) p(', num2str(a1),') = ', num2str(a2), ' é ESTABILIZÁVEL, pois p(', a2, ') é <= 0 '];
            disp(X);
        else
            X = ['    ... e polo (modo) p(', num2str(a1),') = ', num2str(a2), ' é NÃO ESTABILIZÁVEL, pois p(', a1, ') é > 0 '];
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

% Cálculo dos 'output pole vectors'.
y_p = C*autoVectorRight;
disp(' ');
for i=1:max(size(u_p))
    a1 = num2str(i);
    a2 = num2str(autoValueRight(i));
    a3 = num2str(y_p(i));
    if (round(y_p(i)) ~= 0)    
        X = ['(*) O polo (modo) p(', a1,') = ', a2, ' é OBSERVÁVEL, pois u_p,', a1, ' = ', a3];
        disp(X);
    else
        X = ['(*) O polo (modo) p(', a1,') = ', a2, ' é NÃO OBSERVÁVEL, pois u_p,', a1, ' = ', a3];
        disp(X);
        if(round(y_p(i)) <= 0)
            X = ['    ... mas polo (modo) p(', num2str(a1),') = ', num2str(a2), ' é DETECTÁVEL, pois p(', a2, ') é <= 0 '];
            disp(X);
        else
            X = ['    ... e polo (modo) p(', num2str(a1),') = ', num2str(a2), ' é NÃO DETECTÁVEL, pois p(', a1, ') é > 0 '];
            disp(X);
        end
    end
end
