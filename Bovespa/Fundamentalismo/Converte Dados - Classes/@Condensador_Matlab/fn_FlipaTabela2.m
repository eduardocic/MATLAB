function [o] = fn_FlipaTabela2(o)


% Flipa para a Tabela 2.
o.T2.AtivoTotal                 = fliplr(o.T2.AtivoTotal);
o.T2.AtivoCirculante            = fliplr(o.T2.AtivoCirculante);
o.T2.CaixaEEquivalenteDeCaixa   = fliplr(o.T2.CaixaEEquivalenteDeCaixa);
o.T2.AplicacoesFinanceiras      = fliplr(o.T2.AplicacoesFinanceiras);
o.T2.ContasAReceber             = fliplr(o.T2.ContasAReceber);
o.T2.Estoques                   = fliplr(o.T2.Estoques);
o.T2.AtivosBiologicos           = fliplr(o.T2.AtivosBiologicos);
o.T2.TributosARecuperar         = fliplr(o.T2.TributosARecuperar);
o.T2.DespesasAntecipadas        = fliplr(o.T2.DespesasAntecipadas);
o.T2.OutrosAtivosCirculantes    = fliplr(o.T2.OutrosAtivosCirculantes);
o.T2.AtivoNaoCirculante         = fliplr(o.T2.AtivoNaoCirculante);
o.T2.AtivoRealizavelALongoPrazo = fliplr(o.T2.AtivoRealizavelALongoPrazo);
o.T2.Investimentos              = fliplr(o.T2.Investimentos);
o.T2.Imobilizado                = fliplr(o.T2.Imobilizado);
o.T2.Intangivel                 = fliplr(o.T2.Intangivel);

end