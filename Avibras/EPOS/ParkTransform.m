function [Id, Iq] = ParkTransform (Ialfa, Ibeta, theta_e)

%--------------------------------------------------------------------------
%
%   Transformação de Park
%   ---------------------
%
%  1. Esta função é responsável pela transformação da um sistema bifásico
%     estático (alfa,beta)  em um sistema bifásico rotativo (d, q).
%  2. Maiores informações a respeito deste tipo de transformação ou o
%     porquê do seu uso se encontram no documento base (Implementatio of a
%     Speed Field Oriented Control of 3-phase PMSM).
%
%  3. Ialfa, Ibeta -- Correntes obtidas após a transformação de Clarke.
%  
%  4. Id, Iq       -- Correntes obtidas após a transformação de Parke.
%
%  5. theta_e      -- Posição elétrica (theta_e = p*theta_m). Este valor é
%                     obtido por meio de algum sensor de posição (um
%                     encoder calibrado, por exemplo).
%--------------------------------------------------------------------------

Id = Ialfa*cos(theta_e) + Ibeta*sin(theta_e);
Iq = -Ialfa*sin(theta_e) + Ibeta*cos(theta_e);

end