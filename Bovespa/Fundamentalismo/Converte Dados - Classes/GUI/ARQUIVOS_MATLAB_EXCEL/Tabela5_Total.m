n5 = max(size(o.T5.texto))
m5 = max(size(o.T5.DepreciacaoEAmortizacao))

% Primeira linha
% --------------
A5{1,1} = 'Código';
A5{1,2} = 'Descrição da Conta';
for i = 1:(n5+1)
    if (i == 1)
        for j=3:(m5+2)
            % Escreve a data;
            A5{i,j} =o.T1.data(j-2,:);
        end
    end
    
    if (i > 1)
        numero  = num2str(cell2mat(o.T5.numero(i-1)));
        Jota    = num2str(cell2mat(o.T5.texto(i-1)));
        A5{i,1} = numero;
        A5{i,2} = Jota;
        
        % Receita de Venda de Bens e/ou Servicos
        if (i == 2)
            for j=3:(m5+2)
                A5{i,j} = o.T5.DepreciacaoEAmortizacao(j-2);
            end
        end
    end
end