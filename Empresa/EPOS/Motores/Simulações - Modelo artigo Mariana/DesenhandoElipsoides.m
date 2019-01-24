function [Saida] = DesenhandoElipsoides(Epsilon, Q)

setlmis([]);

%% (2) Defini��o das vari�veis.
[Beta, m0, sBeta] = lmivar(1,[1 0]);    % Beta, vari�vel a ser minimizada.


% +++++++++++++++++++++++++++++++++++++++++++
%     | Q  B*epsilon|  >= 0             (i) +
%     | *      1    |                       +
% +++++++++++++++++++++++++++++++++++++++++++
LMI = newlmi;
lmiterm([-LMI 1 1 0],Q);           
lmiterm([-LMI 1 2 Beta],1,Epsilon); 
lmiterm([-LMI 2 2 0],1);    
                                     
                                              
SistemaLMIs = getlmis;

NumVar = decnbr(SistemaLMIs);
c      = zeros(NumVar,1);
c(1)   = 1;                 % Beta.

options = [0 200 0 0 1];           
[Copt, Xopt] = mincx(SistemaLMIs, c, options);

Bsol  = dec2mat(SistemaLMIs, Xopt, Beta);    % Solu��o para o velor de 'B'eta.

Saida = Bsol;
end

