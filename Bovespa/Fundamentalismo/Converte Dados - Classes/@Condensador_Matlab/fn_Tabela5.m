function [o] = fn_Tabela5(o, varargin)

i = varargin{1};
j = varargin{2};

% Tabela 5
% ----------
% O campo 1 está reservado para 'texto'.
% O campo 2 está reservado para 'numero'.
o.T5.(o.Campos_Tabela5{3})(1,j) = o.TRI{j}.o.T5.DepreciacaoEAmortizacao;

end