function [Alfa, Beta, Neutro] = ClarkeTransform (A, B, C)

%--------------------------------------------------------------------------
%
%   Transforma��o de Clarke
%   -----------------------
%
%  1. Esta fun��o � respons�vel pela transforma��o da um sistema trif�sico 
%     (a,b,c) em um sistema bif�sico (alfa, beta) os quais possuem
%     coordenadas est�ticas.
%  2. Maiores informa��es a respeito deste tipo de transforma��o ou o
%     porqu� do seu uso se encontram no documento base (Implementatio of a
%     Speed Field Oriented Control of 3-phase PMSM).
%
%  3. Ia, Ib, Ic   -- Correntes medidas nas fases A, B e C respectivamente.
%  
%  4. Ialfa, Ibeta -- Correntes obtidas ap�s a transforma��o de Clarke.
%--------------------------------------------------------------------------

% (*) sqrt(3) foi tomado como vpa(sqrt(3),15), tal valor � igual a 
%     '1.73205080756888'.

M = [2/3         -1/3        -1/3;
       0    1/sqrt(3)  -1/sqrt(3); 
     1/3          1/3         1/3;] ;

Solve  = M*[A; B; C];
Alfa   = Solve(1);
Beta   = Solve(2);
Neutro = Solve(3);

end