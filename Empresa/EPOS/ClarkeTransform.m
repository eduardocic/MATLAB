function [Alfa, Beta, Neutro] = ClarkeTransform (A, B, C)

%--------------------------------------------------------------------------
%
%   Transformação de Clarke
%   -----------------------
%
%  1. Esta função é responsável pela transformação da um sistema trifásico 
%     (a,b,c) em um sistema bifásico (alfa, beta) os quais possuem
%     coordenadas estáticas.
%  2. Maiores informações a respeito deste tipo de transformação ou o
%     porquê do seu uso se encontram no documento base (Implementatio of a
%     Speed Field Oriented Control of 3-phase PMSM).
%
%  3. Ia, Ib, Ic   -- Correntes medidas nas fases A, B e C respectivamente.
%  
%  4. Ialfa, Ibeta -- Correntes obtidas após a transformação de Clarke.
%--------------------------------------------------------------------------

% (*) sqrt(3) foi tomado como vpa(sqrt(3),15), tal valor é igual a 
%     '1.73205080756888'.

M = [2/3         -1/3        -1/3;
       0    1/sqrt(3)  -1/sqrt(3); 
     1/3          1/3         1/3;] ;

Solve  = M*[A; B; C];
Alfa   = Solve(1);
Beta   = Solve(2);
Neutro = Solve(3);

end