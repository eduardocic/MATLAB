function [Valfa, Vbeta] = InverseParkTransform (Vd, Vq, theta_e)

%--------------------------------------------------------------------------
%
%   Transforma��o Inversa de Park
%   -----------------------------
%
%  1. Esta fun��o � respons�vel pela transforma��o da um sistema bif�sico
%     rotativo (d, q)  em um sistema bif�sico est�tico (alfa, beta).
%  2. Maiores informa��es a respeito deste tipo de transforma��o ou o
%     porqu� do seu uso se encontram no documento base (Implementatio of a
%     Speed Field Oriented Control of 3-phase PMSM).
%
%  3. Valfa, Vbeta -- Tens�es obtidas ap�s a transforma��o inversa de Park.
%  
%  4. Vd, Vq       -- Tens�es obtidas ap�s a passagem pelos controladores.
%
%  5. theta_e      -- Posi��o el�trica (theta_e = p*theta_m). Este valor �
%                     obtido por meio de algum sensor de posi��o (um
%                     encoder calibrado, por exemplo).
%--------------------------------------------------------------------------

Valfa = Vd*cos(theta_e) - Vq*sin(theta_e);
Vbeta = Vq*cos(theta_e) + Vd*sin(theta_e);

end