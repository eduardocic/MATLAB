n = max(size(o.T1.texto));
m = size(o.T1.data,1);
theta  = waitbar(0, sprintf('Gerando o arquivo em Excel...', n));
A{1,1} = '';
for i=1:n
%     A{i,1} = o.T1.texto{i};        
    if (i == 1)
        for j=2:(m+1)
            % Escreve a data;
            A{i,j} = o.T1.data(j-1,:);
        end
    end
    
% -------------------------------------------------------------------------   
% 13/03/2016
    if (i == 2)
        A{i,1} = o.T1.texto{i};   
        for j=2:(m+1)
            A{i,j} = o.T1.totalAcoes(j-1);
        end
    end
    
    if (i == 3)
        A{i,1} = o.T1.texto{i};  
        for j=2:(m+1)
            A{i,j} = o.T1.totalAcoesEmTesouraria(j-1);
        end
    end
% -------------------------------------------------------------------------    
end