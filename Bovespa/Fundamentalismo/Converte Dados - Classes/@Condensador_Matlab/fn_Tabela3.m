function [o] = fn_Tabela3(o, varargin)

i = varargin{1};
j = varargin{2};

% Tabela 3
% ----------
% O campo 1 está reservado para 'texto'.
% O campo 2 está reservado para 'numero'.
o.T3.(o.Campos_Tabela3{3})(1,j)  = o.TRI{j}.o.T3.PassivoTotal;
o.T3.(o.Campos_Tabela3{4})(1,j)  = o.TRI{j}.o.T3.PassivoCirculante;
o.T3.(o.Campos_Tabela3{5})(1,j)  = o.TRI{j}.o.T3.ObrigacoesSociaisETrabalhistas;
o.T3.(o.Campos_Tabela3{6})(1,j)  = o.TRI{j}.o.T3.Fornecedores;
o.T3.(o.Campos_Tabela3{7})(1,j)  = o.TRI{j}.o.T3.ObrigacoesFiscais;
o.T3.(o.Campos_Tabela3{8})(1,j)  = o.TRI{j}.o.T3.EmprestimosEFinanciamentos;
o.T3.(o.Campos_Tabela3{9})(1,j)  = o.TRI{j}.o.T3.OutrasObrigacoes;
o.T3.(o.Campos_Tabela3{10})(1,j) = o.TRI{j}.o.T3.DividendosEJCPAPagar;  
o.T3.(o.Campos_Tabela3{11})(1,j) = o.TRI{j}.o.T3.Provisoes;
o.T3.(o.Campos_Tabela3{12})(1,j) = o.TRI{j}.o.T3.PassivoSobreAtivosNaoCorrentesAVendaEDescontinuados;
o.T3.(o.Campos_Tabela3{13})(1,j) = o.TRI{j}.o.T3.PassivoNaoCirculante;
o.T3.(o.Campos_Tabela3{14})(1,j) = o.TRI{j}.o.T3.EmprestimosEFinanciamentos2;
o.T3.(o.Campos_Tabela3{15})(1,j) = o.TRI{j}.o.T3.OutrasObrigacoes2;
o.T3.(o.Campos_Tabela3{16})(1,j) = o.TRI{j}.o.T3.TributosDiferidos;
o.T3.(o.Campos_Tabela3{17})(1,j) = o.TRI{j}.o.T3.Provisoes2;
o.T3.(o.Campos_Tabela3{18})(1,j) = o.TRI{j}.o.T3.PassivosSobreAtivosNaoCorrentesAVendaEDescontinuados2;
o.T3.(o.Campos_Tabela3{19})(1,j) = o.TRI{j}.o.T3.LucrosEReceitasAApropriar;
o.T3.(o.Campos_Tabela3{20})(1,j) = o.TRI{j}.o.T3.PatrimonioLiquido;    
o.T3.(o.Campos_Tabela3{21})(1,j) = o.TRI{j}.o.T3.CapitalSocialRealizado;
o.T3.(o.Campos_Tabela3{22})(1,j) = o.TRI{j}.o.T3.ReservaDeCapital;
o.T3.(o.Campos_Tabela3{23})(1,j) = o.TRI{j}.o.T3.ReservasDeReavaliacao;
o.T3.(o.Campos_Tabela3{24})(1,j) = o.TRI{j}.o.T3.ReservasDeLucros;
o.T3.(o.Campos_Tabela3{25})(1,j) = o.TRI{j}.o.T3.LucrosPrejuizosAcumulados;
o.T3.(o.Campos_Tabela3{26})(1,j) = o.TRI{j}.o.T3.AjustesDeAvalicaoPatrimonial;
o.T3.(o.Campos_Tabela3{27})(1,j) = o.TRI{j}.o.T3.AjustesAcumuladosDeConversao;
o.T3.(o.Campos_Tabela3{28})(1,j) = o.TRI{j}.o.T3.OutrosResultadosAbrangentes;     

end