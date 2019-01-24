close all; clear all; clc;

% Desembrulha as pastas e afins.
% ------------------------------
MainPath = pwd;
Folders = {'Turbina'; 'Atmosfera'; 'Modelo'; 'CoeficientesAerodinamicos'};

for i = 1:numel(Folders)
    Pasta = [MainPath '/' Folders{i}];
    rmpath(Pasta);
    addpath(Pasta);
end

name = 'F16_saida';
load('TrimadosRetoNivelado.mat');

n   = max(size(X{1}));
m   = max(size(U{1})) - 1;
mm  = m;
tol  = 1e-6;
time = 0.;

for k=1:max(size(X))

    x = X{k};
    % Controle para a matriz A
    dx = 0.1*x;
    for i=1:n
        if dx(i) == 0
            dx(i) = 0.1;
        end
    end

    u = U{k};
    % Controle para a matriz B
    du = 0.1*u;
    for i=1:m
        if du(i) == 0
            du(i) == 0.1;
        end
    end
    
    last  = zeros(n, 1);
    A     = zeros(n, n);
    B     = zeros(n, mm);
    C     = zeros(2, n);
    D     = zeros(2, mm);
    
    
    % -------------------------------------------------------------------------
    %                                  Matriz A
    %                                 ----------
    % 
    % Verificar como se comporta a saída quando farei algumas alterações nos
    % valores de X.
    % -------------------------------------------------------------------------
    rep = 100;
    for j = 1:n
        xt = x;
        for i = 1:rep
            xt(j)     = x(j) + dx(j);
            [xd1, ~]  = feval(name, xt, u, time);
            xt(j)     = x(j) - dx(j);
            [xd2, ~]  = feval(name, xt, u, time);
            A(:,j)    = (xd1 - xd2)'/(2*dx(j));
            if max( abs(A(:,j) - last)./abs(A(:, j) + 1e-12)) < tol
                break
            end
            dx(j) = 0.5*dx(j);
            last = A(:,j);
        end

        iteration  = i;

       if iteration == rep
           disp(['Não convergiu em A, coluna ', num2str(j)]);
       end
    end


    % -------------------------------------------------------------------------
    %                                  Matriz B
    % 
    % Verificar como se comporta a saída quando farei algumas alterações nos
    % valores da entradas U.
    for j=1:mm
        ut = u;
        for i=1:rep
            ut(j)    = u(j) + du(j);
            [xd1, ~] = feval(name, x, ut, time);
            ut(j)    = u(j) - du(j);
            [xd2, ~] = feval(name, x, ut, time);
            B(:,j)   = (xd1 - xd2)'/(2*du(j));
            if max( abs(B(:, j) - last)./abs(B(:, j) + 1e-12)) < tol
                break
            end
            du(j) = 0.5*du(j);
            last = B(:,j);
        end

        iteration  = i;

       if iteration == rep
           disp(['Não convergiu em B, coluna ', num2str(j)]);
       end
    end



    % Sabe-se que: 
    %
    %      y = g(x, u, t)
    % 
    % A matriz C pode ser obtida a partir de:
    %          
    %         d.(g(x, u, t))
    %    C = ----------------
    %             d.x
    last  = zeros(2, 1);    % Desejo ter 2 saídas.
    for j = 1:n
        ut = u;
        for i = 1:rep
            xt(j)    = x(j) + dx(j);
            [~, yd1] = feval(name, xt, ut, time);
            xt(j)    = x(j) - dx(j);
            [~, yd2] = feval(name, xt, ut, time);
            C(:,j)   = (yd1 - yd2)'/(2*dx(j));
            if max( abs(C(:,j) - last)./abs(C(:, j) + 1e-12)) < tol
                break
            end
            dx(j) = 0.5*dx(j);
            last  = C(:,j);
        end
        iteration  = i;
        if iteration == rep
            disp('Coluna não convergiu em C na coluna: ', num2str(j));
        end
    end


    % Sabe-se que: 
    %
    %      y = g(x, u, t)
    % 
    % A matriz D pode ser obtida a partir de:
    %          
    %         d.(g(x, u, t))
    %    D = ----------------
    %             d.u
    last  = zeros(2, 1);               % Desejo ter 2 saídas.
    for j = 1:2                        % Desejo ter 2 saídas.
        ut = u;
        for i=1:rep
            ut(j)    = u(j) + du(j);
            [~, yd1] = feval(name, x, ut, time);
            ut(j)    = u(j) - du(j);
            [~, yd2] = feval(name, x, ut, time);
            D(:,j)   = (yd1 - yd2)'/(2*du(j));
            if max( abs(D(:, j) - last)./abs(D(:, j) + 1e-12)) < tol
                break
            end
            du(j) = 0.5*du(j);
            last  = D(:,j);
        end
        iteration  = i;
        if iteration == rep
            disp('Não convergiu em D na coluna', num2str(j));
        end
    end
    
   a{k} = A;
   b{k} = B;
   c{k} = C;
   d{k} = D;
   k
end

save('MatrizesDeEstadoEnvelope.mat', 'a', 'b', 'c', 'd');