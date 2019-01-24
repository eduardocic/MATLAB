function Out = Inverte(Y)
    
n = size(Y,1);    % Quantidade de limitantes para os vetores de entrada.
ep = 1e-2;


MIN = Y(1:end,1); % Vetores de M�nimo.
MAX = Y(1:end,2); % Vetores de M�ximo.

for i=1:n
   %%% C�lculo do Min.
   if ( MIN(i) == 0 )
       min(i) = ep;
   else
       min(i) = 1/MIN(i);
   end
   
   %%% C�lculo do Max.
   if ( MAX(i) == 0 )
       max(i) = -ep;
   else
       max(i) = 1/MAX(i);
   end
end

Out = [min' max'];
end