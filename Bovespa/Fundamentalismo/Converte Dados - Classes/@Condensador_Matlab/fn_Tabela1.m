function [o] = fn_Tabela1(o, varargin)

i = varargin{1};
j = varargin{2};

%  Tabela 1
% ----------
% O campo 1 está reservado para 'texto'.

o.T1.(o.Campos_Tabela1{2})(i,:) = o.TRI{j}.o.T1.data;
o.T1.(o.Campos_Tabela1{3})(1,j) = o.TRI{j}.o.T1.totalAcoes;
o.T1.(o.Campos_Tabela1{4})(1,j) = o.TRI{j}.o.T1.totalAcoesEmTesouraria;   

end