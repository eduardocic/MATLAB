n2 = max(size(o.T2.texto));
m2 = max(size(o.T2.AtivoTotal));

% Primeira linha
% --------------
A2{1,1} = 'Código';
A2{1,2} = 'Descrição da Conta';
for i=1:(n2+1)
    if (i == 1)
        for j=3:(m2+2)
            % Escreve a data;
            A2{i,j} = o.T1.data(j-2,:);
        end
    end
    
    if (i > 1)
        numero = num2str(cell2mat(o.T2.numero(i-1)));
        Jota  = num2str(cell2mat(o.T2.texto(i-1)));
        A2{i,1} = numero;
        A2{i,2} = Jota;
        
        % Ativo Total
        if (i == 2)
            for j=3:(m2+2)
                A2{i,j} = o.T2.AtivoTotal(j-2);
            end
        end
        
        % Ativo Circulante
        if (i == 3)
            for j=3:(m2+2)
                A2{i,j} = o.T2.AtivoCirculante(j-2);
            end
        end
        
        % Caixa e Equivalente de Caixa
        if (i == 4)
            for j=3:(m2+2)
                A2{i,j} = o.T2.CaixaEEquivalenteDeCaixa(j-2);
            end
        end
        
        % Aplicações Financeiras
        if (i == 5)
            for j=3:(m2+2)
                A2{i,j} = o.T2.AplicacoesFinanceiras(j-2);
            end
        end
        
        % Contasa a Receber
        if (i == 6)
            for j=3:(m2+2)
                A2{i,j} = o.T2.ContasAReceber(j-2);
            end
        end
        
        % Estoques
        if (i == 7)
            for j=3:(m2+2)
                A2{i,j} = o.T2.Estoques(j-2);
            end
        end
        
        % Ativos Biologicos
        if (i == 8)
            for j=3:(m2+2)
                A2{i,j} = o.T2.AtivosBiologicos(j-2);
            end
        end
        
        % Tributos a Recuperar
        if (i == 9)
            for j=3:(m2+2)
                A2{i,j} = o.T2.TributosARecuperar(j-2);
            end
        end
        
        % Despesas Antecipadas
        if (i == 10)
            for j=3:(m2+2)
                A2{i,j} = o.T2.DespesasAntecipadas(j-2);
            end
        end
         
        % Outros Ativos Circulantes
        if (i == 11)
            for j=3:(m2+2)
                A2{i,j} = o.T2.OutrosAtivosCirculantes(j-2);
            end
        end
         
        % Ativo Não Circulante
        if (i == 12)
            for j=3:(m2+2)
                A2{i,j} = o.T2.AtivoNaoCirculante(j-2);
            end
        end
         
        % Ativo Realizavel a LongoPrazo
        if (i == 13)
            for j=3:(m2+2)
                A2{i,j} = o.T2.AtivoRealizavelALongoPrazo(j-2);
            end
        end
        
        % Investimentos
        if (i == 14)
            for j=3:(m2+2)
                A2{i,j} = o.T2.Investimentos(j-2);
            end
        end
        
        % Imobilizado
        if (i == 15)
            for j=3:(m2+2)
                A2{i,j} = o.T2.Imobilizado(j-2);
            end
        end
        
        %  Intangivel
        if (i == 16)
            for j=3:(m2+2)
                A2{i,j} = o.T2.Intangivel(j-2);
            end
        end

% -------------------------------------------------------------------------
% 16/03/2016 
%
%         % Diferido
%         if (i == 17)
%             for j=3:(m2+2)
%                 A2{i,j} = o.T2.Diferido(j-2);
%             end
%         end
    end
end