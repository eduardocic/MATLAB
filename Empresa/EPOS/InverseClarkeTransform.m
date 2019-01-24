function [A, B, C] = InverseClarkeTransform (Alfa, Beta, Neutro)

%--------------------------------------------------------------------------
%
%   Transforma��o Inversa de Clarke
%   -------------------------------
%
%  1. Esta fun��o � respons�vel pela transforma��o da um sistema bif�sico 
%     est�tico (alfa, beta) em um sistema trif�sico original (a, b, c).
%  2. Maiores informa��es a respeito deste tipo de transforma��o ou o
%     porqu� do seu uso se encontram no documento base (Implementatio of a
%     Speed Field Oriented Control of 3-phase PMSM).
%
%  3. Valfa, Vbeta -- Tens�es obtidas ap�s a transforma��o de Clarke.
%
%  4. Va, Vb, Vc   -- Tens�es medidas nas fases A, B e C respectivamente.  
%--------------------------------------------------------------------------

M = [   1           0   1;
     -1/2   sqrt(3)/2   1; 
     -1/2  -sqrt(3)/2   1;] ;
 
Solve  = M*[Alfa; Beta; Neutro];
A = Solve(1);
B = Solve(2);
C = Solve(3);

end