function [o] = fnDemResultados(o)

o.DemResultados.texto = {'Receita de Venda de Bens e/ou Serviços';
                         'Custo dos Bens e/ou Serviços Vendidos';
                         'Resultado Bruto';
                         'Despesas/Receitas Operacionais';
                         'Despesas com Vendas';
                         'Despesas Gerais e Administrativas';
                         'Perdas pela Não Recuperabilidade de Ativos';
                         'Outras Receitas Operacionais';
                         'Outras Despesas Operacionais';
                         'Resultado de Equivalência Patrimonal';
                         'Resultado Financeiro';
                         'Receitas Financeiras';
                         'Despesas Financeiras';
                         'Resultado Antes dos Tributos sobre o Lucro';
                         'Imposto de Renda e Contribuição Social sobre o Lucro';
                         'Corrente';
                         'Diferido';
                         'Resultado Líquido das Operações Continuadas'};
        
o.DemResultados.numero = {'3.01';
                          '3.02';
                          '3.03';
                          '3.04';
                          '3.04.01';
                          '3.04.02';
                          '3.04.03';
                          '3.04.04';
                          '3.04.05';
                          '3.04.06';
                          '3.06';
                          '3.06.01';
                          '3.06.02';
                          '3.07';
                          '3.08';
                          '3.08.01';
                          '3.08.02';
                          '3.09';};
                         
o.DemResultados.ReceitaDeVendaDeBensEOUServicos          = o.Tabela2(3,:);                     
o.DemResultados.CustoDeBensEOUServicosVendidos            = o.Tabela2(4,:);                     
o.DemResultados.ResultadoBruto                            = o.Tabela2(5,:);
o.DemResultados.DespesasComVendas                         = o.Tabela2(6,:);
o.DemResultados.DespesasGeraisEAdministrativas            = o.Tabela2(7,:);
o.DemResultados.PerdaPelaNaoRecuperabilidadeDeAtivos      = o.Tabela2(8,:);
o.DemResultados.OutrasReceitasOperacionais                = o.Tabela2(9,:);
o.DemResultados.OutrasDespesasOperacionais                = o.Tabela2(10,:);  
o.DemResultados.ResultadoDeEquivalenciaPatrimonal         = o.Tabela2(11,:);
o.DemResultados.ResultadoFinanceiro                       = o.Tabela2(12,:);
o.DemResultados.ReceitasFinanceiras                       = o.Tabela2(13,:);
o.DemResultados.DespesasFinanceiras                       = o.Tabela2(14,:);
o.DemResultados.ResultadoAntesDosTributosSobreOLucro      = o.Tabela2(18,:);
o.DemResultados.Corrente                                  = o.Tabela2(19,:);
o.DemResultados.Diferido                                  = o.Tabela2(20,:);
o.DemResultados.ResultadoLiquidoDasOperacoesContinuadas   = o.Tabela2(24,:);

% Ajustes nas Tabelas.
% --------------------
o.DemResultados.DespesasReceitasOperacionais =  o.DemResultados.DespesasComVendas + ...
                                                o.DemResultados.DespesasGeraisEAdministrativas + ...
                                                o.DemResultados.PerdaPelaNaoRecuperabilidadeDeAtivos + ...
                                                o.DemResultados.OutrasReceitasOperacionais + ...
                                                o.DemResultados.OutrasDespesasOperacionais + ...
                                                o.DemResultados.ResultadoDeEquivalenciaPatrimonal;
                                            
o.DemResultados.ImpostoDeRendaEContribuicaoSocialSobreOLucro = o.DemResultados.Corrente + ...
                                                               o.DemResultados.Diferido;                      

end