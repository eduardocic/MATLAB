function [o] = fn_Individual_Tabela3(o)
% 3.:  TERCEIRA TABELA
%     -----------------
% 
%  (*) A parte de interesse aqui diz respeito à tabela intitulada
%     'DF Ind. - Passivo' do arquivo baixado do programa Empresa.net
o.T3.texto = {'Passivo Total';
              'Passivo Circulante';
              'Obrigações Sociais e Trabalhistas';
              'Fornecedores';
              'Obrigações Fiscais';
              'Empréstimos e Financiamentos';
              'Outras Obrigações';
              'Dividendos e JCP a pagar';             % Inserido 13/03/2016
              'Provisões';
              'Passivos sobre Ativos Não-Correntes a Venda e Descontinuados';
              'Passivo Não Circulante';
              'Empréstimos e Financiamentos';
              'Outras Obrigações';
              'Tributos Diferidos';
              'Provisões';
              'Passivo sobre Ativos Não-Correntes a Venda e Descontinuados';
              'Lucro e Receitas a Apropriar';
              'Patrimônio Líquido';       % Alterado 16/03/2016
              'Capital Social Realizado';
              'Reservas de Capital';
              'Reservas de  Reavalização';
              'Reservas de Lucros';
              'Lucro/Prejuízos Acumulados';
              'Ajustes de Avalização Patrimonial';
              'Ajustes Acumulados de Conversão';
              'Outros Resultados Abrangentes';};
        
o.T3.numero = {'2';
               '2.01';
               '2.01.01';
               '2.01.02';
               '2.01.03';
               '2.01.04';
               '2.01.05';
               '2.01.05.02.01';                    % Inserido 13/03/2016
               '2.01.06';
               '2.01.07';
               '2.02';
               '2.02.01';
               '2.02.02';
               '2.02.03';
               '2.02.04';
               '2.02.05';
               '2.02.06';
               '2.03';
               '2.03.01';
               '2.03.02';
               '2.03.03';
               '2.03.04';
               '2.03.05';
               '2.03.06';
               '2.03.07';
               '2.03.08';};

% -------------------------------------------------------------------------
% Modificação realizada em 01/04/2017. Foi plotado que alguns programas
% apresentam problemas relativos aos números da tabela.
m = size(o.file.dado.DFIndPassivo,2);
alfa = 0;
flag = 1;
for j=1:m
    posicao = o.file.dado.DFIndPassivo(1,j);
    if(isnan(posicao) == 0 && alfa == 0)
       flag = j;
       alfa = 1;
    end
end
o.file.dado.DFIndPassivo = o.file.dado.DFIndPassivo(1:end,flag:end);
% -------------------------------------------------------------------------
         

         
Numero = o.file.texto.DFIndPassivo(3:end,1);
Texto  = o.file.texto.DFIndPassivo(3:end,2);
o.file.dado;
n = max(size(Texto));

for i=1:n
    str1 = Texto{i};
    
    if(strcmp(str1, 'Passivo Total'))
        if (strcmp(Numero{i},'2'))
            o.T3.PassivoTotal = o.file.dado.DFIndPassivo(i,1);
        end
    end 
    
    if(strcmp(str1, 'Passivo Circulante'))
        if (strcmp(Numero{i},'2.01'))
            o.T3.PassivoCirculante = o.file.dado.DFIndPassivo(i,1);
        end
    end 
    
    if(strcmp(str1, 'Obrigações Sociais e Trabalhistas'))
        if (strcmp(Numero{i},'2.01.01'))
            o.T3.ObrigacoesSociaisETrabalhistas = o.file.dado.DFIndPassivo(i,1);
        end
    end  
    
    if(strcmp(str1, 'Fornecedores'))
        if (strcmp(Numero{i},'2.01.02'))
            o.T3.Fornecedores = o.file.dado.DFIndPassivo(i,1);
        end
    end
    
    if(strcmp(str1, 'Obrigações Fiscais'))
        if (strcmp(Numero{i},'2.01.03'))
            o.T3.ObrigacoesFiscais = o.file.dado.DFIndPassivo(i,1);
        end
    end
    
    if(strcmp(str1, 'Empréstimos e Financiamentos'))
        if (strcmp(Numero{i},'2.01.04'))
            o.T3.EmprestimosEFinanciamentos = o.file.dado.DFIndPassivo(i,1);
        end
    end
    
    if(strcmp(str1, 'Outras Obrigações'))
        if (strcmp(Numero{i},'2.01.05'))
            o.T3.OutrasObrigacoes = o.file.dado.DFIndPassivo(i,1);
        end
    end
    
% ------------------------------------------------------------------------- 
% Inserido 13/03/2016
    if(strcmp(str1, 'Dividendos e JCP a Pagar'))
            o.T3.DividendosEJCPAPagar = o.file.dado.DFIndPassivo(i,1);
    end
% -------------------------------------------------------------------------    

    if(strcmp(str1, 'Provisões'))
        if (strcmp(Numero{i},'2.01.06'))
            o.T3.Provisoes = o.file.dado.DFIndPassivo(i,1);
        end
    end
    
    if(strcmp(str1, 'Passivos sobre Ativos Não-Correntes a Venda e Descontinuados'))
        if (strcmp(Numero{i},'2.01.07'))
            o.T3.PassivoSobreAtivosNaoCorrentesAVendaEDescontinuados = o.file.dado.DFIndPassivo(i,1);
        end
    end
    
    if(strcmp(str1, 'Passivo Não Circulante'))
        if (strcmp(Numero{i},'2.02'))
            o.T3.PassivoNaoCirculante = o.file.dado.DFIndPassivo(i,1);
        end
    end
    
    if(strcmp(str1, 'Empréstimos e Financiamentos'))
        if (strcmp(Numero{i},'2.02.01'))
            o.T3.EmprestimosEFinanciamentos2 = o.file.dado.DFIndPassivo(i,1);
        end
    end
    
    if(strcmp(str1, 'Outras Obrigações'))
        if (strcmp(Numero{i},'2.02.02'))
            o.T3.OutrasObrigacoes2 = o.file.dado.DFIndPassivo(i,1);
        end
    end
    
    if(strcmp(str1, 'Tributos Diferidos'))
        if (strcmp(Numero{i},'2.02.03'))
            o.T3.TributosDiferidos = o.file.dado.DFIndPassivo(i,1);
        end
    end
    
    if(strcmp(str1, 'Provisões'))
        if (strcmp(Numero{i},'2.02.04'))
            o.T3.Provisoes2 = o.file.dado.DFIndPassivo(i,1);
        end
    end
    
    if(strcmp(str1, 'Passivos sobre Ativos Não-Correntes a Venda e Descontinuados'))
        if (strcmp(Numero{i},'2.02.05'))
            o.T3.PassivosSobreAtivosNaoCorrentesAVendaEDescontinuados2 = o.file.dado.DFIndPassivo(i,1);
        end
    end
    
    if(strcmp(str1, 'Lucros e Receitas a Apropriar'))
        if (strcmp(Numero{i},'2.02.06'))
            o.T3.LucrosEReceitasAApropriar = o.file.dado.DFIndPassivo(i,1);
        end
    end
     
    if(strcmp(str1, 'Patrimônio Líquido'))   % Alterado 16/03/2016
        if (strcmp(Numero{i},'2.03'))
            o.T3.PatrimonioLiquido = o.file.dado.DFIndPassivo(i,1);
        end
    end
    
    if(strcmp(str1, 'Capital Social Realizado'))
        if (strcmp(Numero{i},'2.03.01'))
            o.T3.CapitalSocialRealizado = o.file.dado.DFIndPassivo(i,1);
        end
    end
    
    if(strcmp(str1, 'Reservas de Capital'))
        if (strcmp(Numero{i},'2.03.02'))
            o.T3.ReservaDeCapital = o.file.dado.DFIndPassivo(i,1);
        end
    end
    
    if(strcmp(str1, 'Reservas de Reavaliação'))
        if (strcmp(Numero{i},'2.03.03'))
            o.T3.ReservasDeReavaliacao = o.file.dado.DFIndPassivo(i,1);
        end
    end
    
    if(strcmp(str1, 'Reservas de Lucros'))
        if (strcmp(Numero{i},'2.03.04'))
            o.T3.ReservasDeLucros = o.file.dado.DFIndPassivo(i,1);
        end
    end
    
    if(strcmp(str1, 'Lucros/Prejuízos Acumulados'))
        if (strcmp(Numero{i},'2.03.05'))
            o.T3.LucrosPrejuizosAcumulados = o.file.dado.DFIndPassivo(i,1);
        end
    end
    
    if(strcmp(str1, 'Ajustes de Avaliação Patrimonial'))
        if (strcmp(Numero{i},'2.03.06'))
            o.T3.AjustesDeAvalicaoPatrimonial = o.file.dado.DFIndPassivo(i,1);
        end
    end
    
    if(strcmp(str1, 'Ajustes Acumulados de Conversão'))
        if (strcmp(Numero{i},'2.03.07'))
            o.T3.AjustesAcumuladosDeConversao = o.file.dado.DFIndPassivo(i,1);
        end
    end
    
    if(strcmp(str1, 'Outros Resultados Abrangentes'))
        if (strcmp(Numero{i},'2.03.08'))
            o.T3.OutrosResultadosAbrangentes = o.file.dado.DFIndPassivo(i,1);
        end
    end
end
end