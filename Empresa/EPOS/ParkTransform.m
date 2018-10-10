function [Id, Iq] = ParkTransform (Ialfa, Ibeta, theta_e)

%--------------------------------------------------------------------------
%
%   Transforma��o de Park
%   ---------------------
%
%  1. Esta fun��o � respons�vel pela transforma��o da um sistema bif�sico
%     est�tico (alfa,beta)  em um sistema bif�sico rotativo (d, q).
%  2. Maiores informa��es a respeito deste tipo de transforma��o ou o
%     porqu� do seu uso se encontram no documento base (Implementatio of a
%     Speed Field Oriented Control of 3-phase PMSM).
%
%  3. Ialfa, Ibeta -- Correntes obtidas ap�s a transforma��o de Clarke.
%  
%  4. Id, Iq       -- Correntes obtidas ap�s a transforma��o de Parke.
%
%  5. theta_e      -- Posi��o el�trica (theta_e = p*theta_m). Este valor �
%                     obtido por meio de algum sensor de posi��o (um
%                     encoder calibrado, por exemplo).
%--------------------------------------------------------------------------

Id = Ialfa*cos(theta_e) + Ibeta*sin(theta_e);
Iq = -Ialfa*sin(theta_e) + Ibeta*cos(theta_e);

end