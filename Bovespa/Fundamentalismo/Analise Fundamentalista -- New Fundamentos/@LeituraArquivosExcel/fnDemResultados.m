function [o] = fnDemResultados(o,varargin)

i = varargin{1};

o.DemResultados{i}.texto = {'Receitas de Venda de Bens e/ou Serviços';
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
        
o.DemResultados{i}.numero = {'3.01';
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
                         
o.DemResultados{i}.ReceitasDeVendaDeBensEOUServicos          = o.Tabela2(3,:);                     
o.DemResultados{i}.CustoDeBensEOUServicosVendidos            = o.Tabela2(4,:);                     
o.DemResultados{i}.ResultadoBruto                            = o.Tabela2(5,:);
o.DemResultados{i}.DespesasComVendas                         = o.Tabela2(6,:);
o.DemResultados{i}.DespesasGeraisEAdministrativas            = o.Tabela2(7,:);
o.DemResultados{i}.PerdaPelaNaoRecuperabilidadeDeAtivos      = o.Tabela2(8,:);
o.DemResultados{i}.OutrasReceitasOperacionais                = o.Tabela2(9,:);
o.DemResultados{i}.OutrasDespesasOperacionais                = o.Tabela2(10,:);  
o.DemResultados{i}.ResultadoDeEquivalenciaPatrimonal         = o.Tabela2(11,:);
o.DemResultados{i}.ResultadoFinanceiro                       = o.Tabela2(12,:);
o.DemResultados{i}.ReceitasFinanceiras                       = o.Tabela2(13,:);
o.DemResultados{i}.DespesasFinanceiras                       = o.Tabela2(14,:);
o.DemResultados{i}.ResultadoAntesDosTributosSobreOLucro      = o.Tabela2(18,:);
o.DemResultados{i}.Corrente                                  = o.Tabela2(19,:);
o.DemResultados{i}.Diferido                                  = o.Tabela2(20,:);
o.DemResultados{i}.ResultadoLiquidoDasOperacoesContinuadas   = o.Tabela2(24,:);

% Ajustes nas Tabelas.
o.DemResultados{i}.DespesasReceitasOperacionais =  o.DemResultados{i}.DespesasComVendas + ...
                                                   o.DemResultados{i}.DespesasGeraisEAdministrativas + ...
                                                   o.DemResultados{i}.PerdaPelaNaoRecuperabilidadeDeAtivos + ...
                                                   o.DemResultados{i}.OutrasReceitasOperacionais + ...
                                                   o.DemResultados{i}.OutrasDespesasOperacionais + ...
                                                   o.DemResultados{i}.ResultadoDeEquivalenciaPatrimonal;
o.DemResultados{i}.ImpostoDeRendaEContribuicaoSocialSobreOLucro = o.DemResultados{i}.Corrente + ...
                                                                  o.DemResultados{i}.Diferido;                      

end