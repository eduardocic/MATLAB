function [o] = fn_FlipaTabela1(o)


% Flipa para a Tabela 1.
o.T1.totalAcoes               = fliplr(o.T1.totalAcoes);
o.T1.totalAcoesEmTesouraria   = fliplr(o.T1.totalAcoesEmTesouraria);

end