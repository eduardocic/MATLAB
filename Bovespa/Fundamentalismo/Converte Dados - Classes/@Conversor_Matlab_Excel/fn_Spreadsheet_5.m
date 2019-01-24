function [o] = fn_Spreadsheet_5(o)

n5 = max(size(o.Dados.o.T5.texto));
m5 = max(size(o.Dados.o.T5.DepreciacaoEAmortizacao));

% Primeira linha
% --------------
o.Aba_5{1,1} = 'Código';
o.Aba_5{1,2} = 'Descrição da Conta';
for i = 1:(n5+1)
    if (i == 1)
        for j=3:(m5+2)
            % Escreve a data;
            o.Aba_5{i,j} =o.Dados.o.T1.data(j-2,:);
        end
    end
    
    if (i > 1)
        numero  = num2str(cell2mat(o.Dados.o.T5.numero(i-1)));
        Jota    = num2str(cell2mat(o.Dados.o.T5.texto(i-1)));
        o.Aba_5{i,1} = numero;
        o.Aba_5{i,2} = Jota;
        
        % Receita de Venda de Bens e/ou Servicos
        if (i == 2)
            for j=3:(m5+2)
                o.Aba_5{i,j} = o.Dados.o.T5.DepreciacaoEAmortizacao(j-2);
            end
        end
    end
end
end