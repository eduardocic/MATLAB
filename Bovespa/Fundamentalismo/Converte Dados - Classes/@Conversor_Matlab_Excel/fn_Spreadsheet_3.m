function [o] = fn_Spreadsheet_3(o)

n3 = max(size(o.Dados.o.T3.texto));
m3 = max(size(o.Dados.o.T3.PassivoTotal));

% Primeira linha
% --------------
o.Aba_3{1,1} = 'Código';
o.Aba_3{1,2} = 'Descrição da Conta';
for i=1:(n3+1)
    if (i == 1)
        for j=3:(m3+2)
            % Escreve a data;
            o.Aba_3{i,j} = o.Dados.o.T1.data(j-2,:);
        end
    end
    
    if (i > 1)
        numero  = num2str(cell2mat(o.Dados.o.T3.numero(i-1)));
        Jota   = num2str(cell2mat(o.Dados.o.T3.texto(i-1)));
        o.Aba_3{i,1} = numero;
        o.Aba_3{i,2} = Jota;
        
        % Passivo Total
        if (i == 2)
            for j=3:(m3+2)
                o.Aba_3{i,j} = o.Dados.o.T3.PassivoTotal(j-2);
            end
        end
        
        % Passivo Circulante
        if (i == 3)
            for j=3:(m3+2)
                o.Aba_3{i,j} = o.Dados.o.T3.PassivoCirculante(j-2);
            end
        end
        
        % Obrigacoes Sociais e Trabalhistas
        if (i == 4)
            for j=3:(m3+2)
                o.Aba_3{i,j} = o.Dados.o.T3.ObrigacoesSociaisETrabalhistas(j-2);
            end
        end
        
        % Fornecedores
        if (i == 5)
            for j=3:(m3+2)
                o.Aba_3{i,j} = o.Dados.o.T3.Fornecedores(j-2);
            end
        end
        
        % Obrigações Fiscais
        if (i == 6)
            for j=3:(m3+2)
                o.Aba_3{i,j} = o.Dados.o.T3.ObrigacoesFiscais(j-2);
            end
        end
        
        % Emprestimos e Financiamentos
        if (i == 7)
            for j=3:(m3+2)
                o.Aba_3{i,j} = o.Dados.o.T3.EmprestimosEFinanciamentos(j-2);
            end
        end
        
        % Outras Obrigações
        if (i == 8)
            for j=3:(m3+2)
                o.Aba_3{i,j} = o.Dados.o.T3.OutrasObrigacoes(j-2);
            end
        end
        
        % Dividendos e JCP a Pagar
        if (i == 9)
            for j=3:(m3+2)
                o.Aba_3{i,j} = o.Dados.o.T3.DividendosEJCPAPagar(j-2);
            end
        end
        
        % Provisoes
        if (i == 10)
            for j=3:(m3+2)
                o.Aba_3{i,j} = o.Dados.o.T3.Provisoes(j-2);
            end
        end
        
        % Passivo Sobre Ativos Nao-Correntes a Venda e Descontinuados
        if (i == 11)
            for j=3:(m3+2)
                o.Aba_3{i,j} = o.Dados.o.T3.PassivoSobreAtivosNaoCorrentesAVendaEDescontinuados(j-2);
            end
        end
         
        % Passivo Não Circulante
        if (i == 12)
            for j=3:(m3+2)
                o.Aba_3{i,j} = o.Dados.o.T3.PassivoNaoCirculante(j-2);
            end
        end
         
        % Emprestimos e Financiamentos
        if (i == 13)
            for j=3:(m3+2)
                o.Aba_3{i,j} = o.Dados.o.T3.EmprestimosEFinanciamentos2(j-2);
            end
        end
         
        % Outras Obrigações
        if (i == 14)
            for j=3:(m3+2)
                o.Aba_3{i,j} = o.Dados.o.T3.OutrasObrigacoes2(j-2);
            end
        end
        
        % Tributos Diferidos
        if (i == 15)
            for j=3:(m3+2)
                o.Aba_3{i,j} = o.Dados.o.T3.TributosDiferidos(j-2);
            end
        end
        
        % Provisões
        if (i == 16)
            for j=3:(m3+2)
                o.Aba_3{i,j} = o.Dados.o.T3.Provisoes2(j-2);
            end
        end
        
        %  Passivos Sobre Ativos Nao-Correntes a Venda e Descontinuados2
        if (i == 17)
            for j=3:(m3+2)
                o.Aba_3{i,j} = o.Dados.o.T3.PassivosSobreAtivosNaoCorrentesAVendaEDescontinuados2(j-2);
            end
        end
        
        % Lucros e Receitas Apropriar
        if (i == 18)
            for j=3:(m3+2)
                o.Aba_3{i,j} = o.Dados.o.T3.LucrosEReceitasAApropriar(j-2);
            end
        end
        
        % Patrimonio Líquido
        if (i == 19)
            for j=3:(m3+2)
                o.Aba_3{i,j} = o.Dados.o.T3.PatrimonioLiquido(j-2);      % 16/03/2016
            end
        end
        
        % Capital Social Realizado
        if (i == 20)
            for j=3:(m3+2)
                o.Aba_3{i,j} = o.Dados.o.T3.CapitalSocialRealizado(j-2);
            end
        end
        
        % Reserva de Capital
        if (i == 21)
            for j=3:(m3+2)
                o.Aba_3{i,j} = o.Dados.o.T3.ReservaDeCapital(j-2);
            end
        end
        
        % Reservas de Reavaliação
        if (i == 22)
            for j=3:(m3+2)
                o.Aba_3{i,j} = o.Dados.o.T3.ReservasDeReavaliacao(j-2);
            end
        end
        
        % Reservas de Lucros
        if (i == 23)
            for j=3:(m3+2)
                o.Aba_3{i,j} = o.Dados.o.T3.ReservasDeLucros(j-2);
            end
        end
        
        % Lucros Prejuizos Acumulados
        if (i == 24)
            for j=3:(m3+2)
                o.Aba_3{i,j} = o.Dados.o.T3.LucrosPrejuizosAcumulados(j-2);
            end
        end
        
        % Ajustes de Avalição Patrimonial
        if (i == 25)
            for j=3:(m3+2)
                o.Aba_3{i,j} = o.Dados.o.T3.AjustesDeAvalicaoPatrimonial(j-2);
            end
        end
        
        % Ajustes Acumulados de Conversão
        if (i == 26)
            for j=3:(m3+2)
                o.Aba_3{i,j} = o.Dados.o.T3.AjustesAcumuladosDeConversao(j-2);
            end
        end
        
        % Outros Resultados Abrangentes
        if (i == 27)
            for j=3:(m3+2)
                o.Aba_3{i,j} = o.Dados.o.T3.OutrosResultadosAbrangentes(j-2);
            end
        end
    end
end
end