function [o] = fn_FlipaTabela4(o)

% Flipa para a Tabela 4.
o.T4.ReceitaDeVendaDeBensEOUServicos                  = fliplr(o.T4.ReceitaDeVendaDeBensEOUServicos);
o.T4.CustoDosBensEOUServicosVendidos                  = fliplr(o.T4.CustoDosBensEOUServicosVendidos);
o.T4.ResultadoBruto                                   = fliplr(o.T4.ResultadoBruto);
o.T4.DespesasReceitasOperacionais                     = fliplr(o.T4.DespesasReceitasOperacionais);
o.T4.DespesasComVendas                                = fliplr(o.T4.DespesasComVendas);              % 13/03/2017
o.T4.DespesasGeraisEAdministrativas                   = fliplr(o.T4.DespesasGeraisEAdministrativas); % 13/03/2017
o.T4.ResultadoAntesDoResultadoFinanceiroEDosTributos  = fliplr(o.T4.ResultadoAntesDoResultadoFinanceiroEDosTributos);
o.T4.ResultadoFinanceiro                              = fliplr(o.T4.ResultadoFinanceiro);
o.T4.ResultadoAntesDosTributosSobreOLucro             = fliplr(o.T4.ResultadoAntesDosTributosSobreOLucro);
o.T4.ImpostoDeRendaEContribuicaoSocialSobreOLucro     = fliplr(o.T4.ImpostoDeRendaEContribuicaoSocialSobreOLucro);
o.T4.ResultadoLiquidoDasOperacoesContinuadas          = fliplr(o.T4.ResultadoLiquidoDasOperacoesContinuadas);
o.T4.ResultadoLiquidoDeOperacoesDescontinuadas        = fliplr(o.T4.ResultadoLiquidoDeOperacoesDescontinuadas);
o.T4.LucroPrejuizoDoPeriodo                           = fliplr(o.T4.LucroPrejuizoDoPeriodo);                % 16/03/2017
o.T4.AtribuidoASociosDaEmpresaControladora            = fliplr(o.T4.AtribuidoASociosDaEmpresaControladora); % 14/03/2017
o.T4.AtribuidoASociosNaoControladora                  = fliplr(o.T4.AtribuidoASociosNaoControladora);       % 14/03/2017

end