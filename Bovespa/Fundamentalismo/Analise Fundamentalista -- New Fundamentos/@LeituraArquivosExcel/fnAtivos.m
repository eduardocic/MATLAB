function [o] = fnAtivos(o, varargin)

i = varargin{1};

o.Ativos{i}.texto = {'Ativo Total';
                     'Ativo Circulante';
                     'Caixa e Equivalentes de Caixa';
                     'Aplicações Financeiras';
                     'Contas a Receber';
                     'Estoques';
                     'Ativos{i} Biológicos';
                     'Tributos a Recuperar';
                     'Despesas Antecipadas';
                     'Outros Ativos{i} Circulantes';
                     'Ativo Não Circulante';
                     'Ativo Realizável a Longo Prazo';
                     'Aplicações Financeiras Avaliadas a Valor Justo';
                     'Aplicações Financeiras Avaliadas ao Custo Amortizado';
                     'Contas a Receber';
                     'Estoque';
                     'Ativos{i} Biológicos';
                     'Tributos Diferidos';
                     'Despesas Antecipadas';
                     'Créditos com partes Relacionadas';
                     'Outros Ativos{i} Não Circulantes';
                     'Investimentos';
                     'Imobilizado';
                     'Intangível';};
        
o.Ativos{i}.numero = {'1';
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
                      '1.02.01.01';
                      '1.02.01.02';
                      '1.02.01.03';
                      '1.02.01.04';
                      '1.02.01.05';
                      '1.02.01.06';
                      '1.02.01.07';
                      '1.02.01.08';
                      '1.02.01.09';
                      '1.02.02';
                      '1.02.03';
                      '1.02.04';};
               
               
o.Ativos{i}.AtivoTotal                                  = o.Tabela1(1,:);
o.Ativos{i}.AtivoCirculante                             = o.Tabela1(2,:);
o.Ativos{i}.CaixaEEquivalentesDeCaixa                   = o.Tabela1(3,:);
o.Ativos{i}.AplicacoesFinanceiras                       = o.Tabela1(4,:);
o.Ativos{i}.ContasReceber                               = o.Tabela1(5,:);
o.Ativos{i}.Estoques1                                   = o.Tabela1(6,:);
o.Ativos{i}.AtivosBiologicos1                           = o.Tabela1(7,:);
o.Ativos{i}.TributosRecuperar                           = o.Tabela1(8,:);
o.Ativos{i}.DespesasAntecipadas                         = o.Tabela1(9,:);
o.Ativos{i}.OutrosAtivosCirculantes                     = o.Tabela1(10,:);
o.Ativos{i}.AtivoRealizavelALongoPrazo                  = o.Tabela1(11,:);
o.Ativos{i}.AplicFinanceirasAvaliadasAValorJusto        = o.Tabela1(12,:);
o.Ativos{i}.AplicFinanceirasAvaliadasAOCustoAmortizado  = o.Tabela1(13,:);
o.Ativos{i}.ContasReceber                               = o.Tabela1(14,:);
o.Ativos{i}.Estoques2                                   = o.Tabela1(15,:);
o.Ativos{i}.AtivosBiologicos2                           = o.Tabela1(16,:);
o.Ativos{i}.TributosDiferidos1                          = o.Tabela1(17,:);
o.Ativos{i}.DespesasAntecipadas                         = o.Tabela1(18,:);
o.Ativos{i}.CreditoPartesRelacionadas                   = o.Tabela1(19,:);
o.Ativos{i}.OutrosAtivosNaoCirculantes                  = o.Tabela1(20,:);
o.Ativos{i}.Investimentos                               = o.Tabela1(21,:);
o.Ativos{i}.Imobilizado                                 = o.Tabela1(22,:);
o.Ativos{i}.Intangivel                                  = o.Tabela1(23,:);               

% Ajuste para inclusão da parcela relativa ao item 2.01 (que não está
% presente na tabela do Fundamentos).
o.Ativos{i}.AtivosNaoCirculantes  = o.Ativos{i}.AtivoRealizavelALongoPrazo + ...
                                    o.Ativos{i}.Investimentos + ...
                                    o.Ativos{i}.Imobilizado + ...
                                    o.Ativos{i}.Intangivel;
               
end