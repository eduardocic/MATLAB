function [o] = fnAtivos(o)

o.Ativos.texto = {'Ativo Total';
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
                  'Aplicações Financeiras Avaliadas a Valor Justo';
                  'Aplicações Financeiras Avaliadas ao Custo Amortizado';
                  'Contas a Receber';
                  'Estoque';
                  'Ativos Biológicos';
                  'Tributos Diferidos';
                  'Despesas Antecipadas';
                  'Crédito com Partes Relacionadas';
                  'Outros Ativos Não Circulantes';
                  'Investimentos';
                  'Imobilizado';
                  'Intangível';};
        
o.Ativos.numero = {'1';
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
               
% Captura dos dados.
% ------------------
o.Ativos.AtivoTotal                                       = o.Tabela1(1,:);
o.Ativos.AtivoCirculante                                  = o.Tabela1(2,:);
o.Ativos.CaixaEEquivalentesDeCaixa                        = o.Tabela1(3,:);
o.Ativos.AplicacoesFinanceiras                            = o.Tabela1(4,:);
o.Ativos.ContasAReceber1                                  = o.Tabela1(5,:);
o.Ativos.Estoques1                                        = o.Tabela1(6,:);
o.Ativos.AtivosBiologicos1                                = o.Tabela1(7,:);
o.Ativos.TributosARecuperar                               = o.Tabela1(8,:);
o.Ativos.DespesasAntecipadas                              = o.Tabela1(9,:);
o.Ativos.OutrosAtivosCirculantes                          = o.Tabela1(10,:);
o.Ativos.AtivoRealizavelALongoPrazo                       = o.Tabela1(11,:);
o.Ativos.AplicacoesFinanceirasAvaliadasAValorJusto        = o.Tabela1(12,:);
o.Ativos.AplicacoesFinanceirasAvaliadasAOCustoAmortizado  = o.Tabela1(13,:);
o.Ativos.ContasAReceber2                                  = o.Tabela1(14,:);
o.Ativos.Estoque2                                         = o.Tabela1(15,:);
o.Ativos.AtivosBiologicos2                                = o.Tabela1(16,:);
o.Ativos.TributosDiferidos                                = o.Tabela1(17,:);
o.Ativos.DespesasAntecipadas                              = o.Tabela1(18,:);
o.Ativos.CreditoComPartesRelacionadas                     = o.Tabela1(19,:);
o.Ativos.OutrosAtivosNaoCirculantes                       = o.Tabela1(20,:);
o.Ativos.Investimentos                                    = o.Tabela1(21,:);
o.Ativos.Imobilizado                                      = o.Tabela1(22,:);
o.Ativos.Intangivel                                       = o.Tabela1(23,:);               

% Ajuste para inclusão da parcela relativa ao item 2.01 (que não está
% presente na tabela do Fundamentos).
o.Ativos.AtivoNaoCirculante = o.Ativos.AtivoRealizavelALongoPrazo + ...
                              o.Ativos.Investimentos + ...
                              o.Ativos.Imobilizado + ...
                              o.Ativos.Intangivel;
               
end