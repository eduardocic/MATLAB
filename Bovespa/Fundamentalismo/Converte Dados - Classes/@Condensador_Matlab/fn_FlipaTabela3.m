function [o] = fn_FlipaTabela3(o)

% Flipa para a Tabela 3.
o.T3.PassivoTotal                                          = fliplr(o.T3.PassivoTotal);
o.T3.PassivoCirculante                                     = fliplr(o.T3.PassivoCirculante);
o.T3.ObrigacoesSociaisETrabalhistas                        = fliplr(o.T3.ObrigacoesSociaisETrabalhistas);
o.T3.Fornecedores                                          = fliplr(o.T3.Fornecedores);
o.T3.ObrigacoesFiscais                                     = fliplr(o.T3.ObrigacoesFiscais);
o.T3.EmprestimosEFinanciamentos                            = fliplr(o.T3.EmprestimosEFinanciamentos);
o.T3.OutrasObrigacoes                                      = fliplr(o.T3.OutrasObrigacoes);
o.T3.DividendosEJCPAPagar                                  = fliplr(o.T3.DividendosEJCPAPagar);   % 13/03/2017
o.T3.Provisoes                                             = fliplr(o.T3.Provisoes);
o.T3.PassivoSobreAtivosNaoCorrentesAVendaEDescontinuados   = fliplr(o.T3.PassivoSobreAtivosNaoCorrentesAVendaEDescontinuados);
o.T3.PassivoNaoCirculante                                  = fliplr(o.T3.PassivoNaoCirculante);
o.T3.EmprestimosEFinanciamentos2                           = fliplr(o.T3.EmprestimosEFinanciamentos2);
o.T3.OutrasObrigacoes2                                     = fliplr(o.T3.OutrasObrigacoes2);
o.T3.TributosDiferidos                                     = fliplr(o.T3.TributosDiferidos);
o.T3.Provisoes2                                            = fliplr(o.T3.Provisoes2);
o.T3.PassivosSobreAtivosNaoCorrentesAVendaEDescontinuados2 = fliplr(o.T3.PassivosSobreAtivosNaoCorrentesAVendaEDescontinuados2);
o.T3.LucrosEReceitasAApropriar                             = fliplr(o.T3.LucrosEReceitasAApropriar);
o.T3.PatrimonioLiquido                                     = fliplr(o.T3.PatrimonioLiquido);
o.T3.CapitalSocialRealizado                                = fliplr(o.T3.CapitalSocialRealizado);
o.T3.ReservaDeCapital                                      = fliplr(o.T3.ReservaDeCapital);
o.T3.ReservasDeReavaliacao                                 = fliplr(o.T3.ReservasDeReavaliacao);
o.T3.ReservasDeLucros                                      = fliplr(o.T3.ReservasDeLucros);
o.T3.LucrosPrejuizosAcumulados                             = fliplr(o.T3.LucrosPrejuizosAcumulados);
o.T3.AjustesDeAvalicaoPatrimonial                          = fliplr(o.T3.AjustesDeAvalicaoPatrimonial);
o.T3.AjustesAcumuladosDeConversao                          = fliplr(o.T3.AjustesAcumuladosDeConversao);
o.T3.OutrosResultadosAbrangentes                           = fliplr(o.T3.OutrosResultadosAbrangentes);

end