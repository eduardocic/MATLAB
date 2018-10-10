function [Valfa, Vbeta] = InverseParkTransform (Vd, Vq, theta_e)

%--------------------------------------------------------------------------
%
%   Transformação Inversa de Park
%   -----------------------------
%
%  1. Esta função é responsável pela transformação da um sistema bifásico
%     rotativo (d, q)  em um sistema bifásico estático (alfa, beta).
%  2. Maiores informações a respeito deste tipo de transformação ou o
%     porquê do seu uso se encontram no documento base (Implementatio of a
%     Speed Field Oriented Control of 3-phase PMSM).
%
%  3. Valfa, Vbeta -- Tensões obtidas após a transformação inversa de Park.
%  
%  4. Vd, Vq       -- Tensões obtidas após a passagem pelos controladores.
%
%  5. theta_e      -- Posição elétrica (theta_e = p*theta_m). Este valor é
%                     obtido por meio de algum sensor de posição (um
%                     encoder calibrado, por exemplo).
%--------------------------------------------------------------------------

Valfa = Vd*cos(theta_e) - Vq*sin(theta_e);
Vbeta = Vq*cos(theta_e) + Vd*sin(theta_e);

end