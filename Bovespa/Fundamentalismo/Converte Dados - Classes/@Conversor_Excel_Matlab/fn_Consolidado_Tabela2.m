function [o] = fn_Consolidado_Tabela2(o)
% 2.:  SEGUNDA TABELA
%     -----------------
% 
%  (*) A parte de interesse aqui diz respeito à tabela intitulada
%     'DF Ind. - Ativo' do arquivo baixado do programa Empresa.net
o.T2.texto = {'Ativo Total';
              'Ativo Circulante';
              'Caixa e Equivalentes de Caixa';
              'Aplicações Financeiras';
              'Contas a Receber';
              'Estoques';
              'Ativos Biológicos';
              'Tributos a Recuperar';
              'Despesas Antecipadas';
              'Outros Ativos Circulantes';
              'Ativo Não Circulante';
              'Ativo Realizável a Longo Prazo';
              'Investimentos';
              'Imobilizado';
              'Intangível';};
        
o.T2.numero = {'1';
               '1.01';
               '1.01.01';
               '1.01.02';
               '1.01.03';
               '1.01.04';
               '1.01.05';
               '1.01.06';
               '1.01.07';
               '1.01.08';
               '1.02';
               '1.02.01';
               '1.02.02';
               '1.02.03';
               '1.02.04';}; 

% -------------------------------------------------------------------------
% Modificação realizada em 01/04/2017. Foi plotado que alguns programas
% apresentam problemas relativos aos números da tabela.
m = size(o.file.dado.DFConsAtivo,2);
alfa = 0;
flag = 1;
for j=1:m
    posicao = o.file.dado.DFConsAtivo(1,j);
    if(isnan(posicao) == 0 && alfa == 0)
       flag = j;
       alfa = 1;
    end
end
o.file.dado.DFConsAtivo = o.file.dado.DFConsAtivo(1:end,flag:end);
% -------------------------------------------------------------------------


Numero = o.file.texto.DFConsAtivo(3:end,1);
Texto  = o.file.texto.DFConsAtivo(3:end,2);
n = max(size(Texto));

for i=1:n
    str1 = Texto{i};
    
    if(strcmp(str1, 'Ativo Total'))
        if (strcmp(Numero{i},'1'))
            o.T2.AtivoTotal = o.file.dado.DFConsAtivo(i,1);
        end
    end    
    
    if(strcmp(str1, 'Ativo Circulante'))
        if (strcmp(Numero{i},'1.01'))
            o.T2.AtivoCirculante = o.file.dado.DFConsAtivo(i,1);
        end
    end
    
    if(strcmp(str1, 'Caixa e Equivalentes de Caixa'))
        if (strcmp(Numero{i},'1.01.01'))
            o.T2.CaixaEEquivalenteDeCaixa = o.file.dado.DFConsAtivo(i,1);
        end
    end
    
    if(strcmp(str1, 'Aplicações Financeiras'))
        if (strcmp(Numero{i},'1.01.02'))
            o.T2.AplicacoesFinanceiras = o.file.dado.DFConsAtivo(i,1); 
        end
    end
    
    if(strcmp(str1, 'Contas a Receber'))
        if (strcmp(Numero{i},'1.01.03'))
            o.T2.ContasAReceber = o.file.dado.DFConsAtivo(i,1); 
        end
    end
    
    if(strcmp(str1, 'Estoques'))
        if (strcmp(Numero{i},'1.01.04'))
            o.T2.Estoques = o.file.dado.DFConsAtivo(i,1); 
        end
    end
    
    if(strcmp(str1, 'Ativos Biológicos'))
        if (strcmp(Numero{i},'1.01.05'))
            o.T2.AtivosBiologicos = o.file.dado.DFConsAtivo(i,1);  
        end
    end
    
    if(strcmp(str1, 'Tributos a Recuperar'))
        if (strcmp(Numero{i},'1.01.06'))
            o.T2.TributosARecuperar = o.file.dado.DFConsAtivo(i,1);
        end
    end
    
    if(strcmp(str1, 'Despesas Antecipadas'))
        if (strcmp(Numero{i},'1.01.07'))
            o.T2.DespesasAntecipadas = o.file.dado.DFConsAtivo(i,1);
        end
    end
    
    if(strcmp(str1, 'Outros Ativos Circulantes'))
        if (strcmp(Numero{i},'1.01.08'))
            o.T2.OutrosAtivosCirculantes = o.file.dado.DFConsAtivo(i,1); 
        end
    end
    
    if(strcmp(str1, 'Ativo Não Circulante'))
        if (strcmp(Numero{i},'1.02'))
            o.T2.AtivoNaoCirculante = o.file.dado.DFConsAtivo(i,1); 
        end
    end
    
    if(strcmp(str1, 'Ativo Realizável a Longo Prazo'))
        if (strcmp(Numero{i},'1.02.01'))
            o.T2.AtivoRealizavelALongoPrazo = o.file.dado.DFConsAtivo(i,1);  
        end
    end
    
    if(strcmp(str1, 'Investimentos'))
        if (strcmp(Numero{i},'1.02.02'))
            o.T2.Investimentos = o.file.dado.DFConsAtivo(i,1);     
        end
    end
    
    if(strcmp(str1, 'Imobilizado'))
        if (strcmp(Numero{i},'1.02.03'))
            o.T2.Imobilizado = o.file.dado.DFConsAtivo(i,1);  
        end
    end
    
    if(strcmp(str1, 'Intangível'))
        if (strcmp(Numero{i},'1.02.04'))
            o.T2.Intangivel = o.file.dado.DFConsAtivo(i,1); 
        end
    end

end
end