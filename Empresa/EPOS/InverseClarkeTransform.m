function [A, B, C] = InverseClarkeTransform (Alfa, Beta, Neutro)

%--------------------------------------------------------------------------
%
%   Transformação Inversa de Clarke
%   -------------------------------
%
%  1. Esta função é responsável pela transformação da um sistema bifásico 
%     estático (alfa, beta) em um sistema trifásico original (a, b, c).
%  2. Maiores informações a respeito deste tipo de transformação ou o
%     porquê do seu uso se encontram no documento base (Implementatio of a
%     Speed Field Oriented Control of 3-phase PMSM).
%
%  3. Valfa, Vbeta -- Tensões obtidas após a transformação de Clarke.
%
%  4. Va, Vb, Vc   -- Tensões medidas nas fases A, B e C respectivamente.  
%--------------------------------------------------------------------------

M = [   1           0   1;
     -1/2   sqrt(3)/2   1; 
     -1/2  -sqrt(3)/2   1;] ;
 
Solve  = M*[Alfa; Beta; Neutro];
A = Solve(1);
B = Solve(2);
C = Solve(3);

end