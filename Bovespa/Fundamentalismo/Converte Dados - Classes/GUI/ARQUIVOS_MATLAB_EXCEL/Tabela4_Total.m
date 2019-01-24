n4 = max(size(o.T4.texto));
m4 = max(size(o.T4.ReceitaDeVendaDeBensEOUServicos));

% Primeira linha
% --------------
A4{1,1} = 'Código';
A4{1,2} = 'Descrição da Conta';
for i=1:(n4+1)
    if (i == 1)
        for j=3:(m4+2)
            % Escreve a data;
            A4{i,j} =o.T1.data(j-2,:);
        end
    end
    
    if (i > 1)
        numero  = num2str(cell2mat(o.T4.numero(i-1)));
        Jota   = num2str(cell2mat(o.T4.texto(i-1)));
        A4{i,1} = numero;
        A4{i,2} = Jota;
        
        % Receita de Venda de Bens e/ou Servicos
        if (i == 2)
            for j=3:(m4+2)
                A4{i,j} = o.T4.ReceitaDeVendaDeBensEOUServicos(j-2);
            end
        end
        
        % Custo dos Bens e/ou Servicos Vendidos
        if (i == 3)
            for j=3:(m4+2)
                A4{i,j} = o.T4.CustoDosBensEOUServicosVendidos(j-2);
            end
        end
        
        % Resultado Bruto
        if (i == 4)
            for j=3:(m4+2)
                A4{i,j} = o.T4.ResultadoBruto(j-2);
            end
        end
        
        % Despesas/Receitas Operacionais
        if (i == 5)
            for j=3:(m4+2)
                A4{i,j} = o.T4.DespesasReceitasOperacionais(j-2);
            end
        end
        
% -------------------------------------------------------------------------
% 13/03/2016
        % Despesas com Vendas
        if (i == 6)
            for j=3:(m4+2)
                A4{i,j} = o.T4.DespesasComVendas(j-2);
            end
        end
        
        % Despesas Gerais e Administrativas
        if (i == 7)
            for j=3:(m4+2)
                A4{i,j} = o.T4.DespesasGeraisEAdministrativas(j-2);
            end
        end
% -------------------------------------------------------------------------
        
        % Resultado Antes do Resultado Financeiro e dos Tributos
        if (i == 8)
            for j=3:(m4+2)
                A4{i,j} = o.T4.ResultadoAntesDoResultadoFinanceiroEDosTributos(j-2);
            end
        end
        
        % Resultado Financeiro
        if (i == 9)
            for j=3:(m4+2)
                A4{i,j} = o.T4.ResultadoFinanceiro(j-2);
            end
        end
        
        % Resultado Antes dos Tributos Sobre o Lucro
        if (i == 10)
            for j=3:(m4+2)
                A4{i,j} = o.T4.ResultadoAntesDosTributosSobreOLucro(j-2);
            end
        end
        
        % Imposto de Renda e Contribuição Social Sobre o Lucro
        if (i == 11)
            for j=3:(m4+2)
                A4{i,j} = o.T4.ImpostoDeRendaEContribuicaoSocialSobreOLucro(j-2);
            end
        end
        
        % Resultado Liquido das Operacoes Continuadas
        if (i == 12)
            for j=3:(m4+2)
                A4{i,j} = o.T4.ResultadoLiquidoDasOperacoesContinuadas(j-2);
            end
        end
         
        % Resultado Liquido de Operacoes Descontinuadas
        if (i == 13)
            for j=3:(m4+2)
                A4{i,j} = o.T4.ResultadoLiquidoDeOperacoesDescontinuadas(j-2);
            end
        end
         
        % LucroPrejuizoDoPeriodo
        if (i == 14)
            for j=3:(m4+2)
                A4{i,j} = o.T4.LucroPrejuizoDoPeriodo(j-2);        % 16/03/2016
            end
        end
        
% -------------------------------------------------------------------------
% 14/03/2016
        % LucroPrejuizoDoPeriodo
        if (i == 15)
            for j=3:(m4+2)
                A4{i,j} = o.T4.AtribuidoASociosDaEmpresaControladora(j-2);
            end
        end
        
        % LucroPrejuizoDoPeriodo
        if (i == 16)
            for j=3:(m4+2)
                A4{i,j} = o.T4.AtribuidoASociosNaoControladora(j-2);
            end
        end
% -------------------------------------------------------------------------        
        
    end
end