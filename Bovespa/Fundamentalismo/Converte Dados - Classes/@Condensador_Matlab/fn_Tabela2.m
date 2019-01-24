function [o] = fn_Tabela2(o, varargin)

i = varargin{1};
j = varargin{2};

% Tabela 2
% ----------
% O campo 1 está reservado para 'texto'.
% O campo 2 está reservado para 'numero'.
o.T2.(o.Campos_Tabela2{3})(1,j)  = o.TRI{j}.o.T2.AtivoTotal;
o.T2.(o.Campos_Tabela2{4})(1,j)  = o.TRI{j}.o.T2.AtivoCirculante;
o.T2.(o.Campos_Tabela2{5})(1,j)  = o.TRI{j}.o.T2.CaixaEEquivalenteDeCaixa;
o.T2.(o.Campos_Tabela2{6})(1,j)  = o.TRI{j}.o.T2.AplicacoesFinanceiras;
o.T2.(o.Campos_Tabela2{7})(1,j)  = o.TRI{j}.o.T2.ContasAReceber;
o.T2.(o.Campos_Tabela2{8})(1,j)  = o.TRI{j}.o.T2.Estoques;
o.T2.(o.Campos_Tabela2{9})(1,j)  = o.TRI{j}.o.T2.AtivosBiologicos;
o.T2.(o.Campos_Tabela2{10})(1,j) = o.TRI{j}.o.T2.TributosARecuperar;
o.T2.(o.Campos_Tabela2{11})(1,j) = o.TRI{j}.o.T2.DespesasAntecipadas;
o.T2.(o.Campos_Tabela2{12})(1,j) = o.TRI{j}.o.T2.OutrosAtivosCirculantes;
o.T2.(o.Campos_Tabela2{13})(1,j) = o.TRI{j}.o.T2.AtivoNaoCirculante;
o.T2.(o.Campos_Tabela2{14})(1,j) = o.TRI{j}.o.T2.AtivoRealizavelALongoPrazo;
o.T2.(o.Campos_Tabela2{15})(1,j) = o.TRI{j}.o.T2.Investimentos;
o.T2.(o.Campos_Tabela2{16})(1,j) = o.TRI{j}.o.T2.Imobilizado;
o.T2.(o.Campos_Tabela2{17})(1,j) = o.TRI{j}.o.T2.Intangivel;

end