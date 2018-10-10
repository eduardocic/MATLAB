function [o] = fn_Tabela4(o, varargin)

i = varargin{1};
j = varargin{2};
% Tabela 4
% ----------
% O campo 1 está reservado para 'texto'.
% O campo 2 está reservado para 'numero'.
o.T4.(o.Campos_Tabela4{3})(1,j) = o.TRI{j}.o.T4.ReceitaDeVendaDeBensEOUServicos;
o.T4.(o.Campos_Tabela4{4})(1,j) = o.TRI{j}.o.T4.CustoDosBensEOUServicosVendidos;
o.T4.(o.Campos_Tabela4{5})(1,j) = o.TRI{j}.o.T4.ResultadoBruto;
o.T4.(o.Campos_Tabela4{6})(1,j) = o.TRI{j}.o.T4.DespesasReceitasOperacionais;
o.T4.(o.Campos_Tabela4{7})(1,j) = o.TRI{j}.o.T4.DespesasComVendas;                % 13/03/2016
o.T4.(o.Campos_Tabela4{8})(1,j) = o.TRI{j}.o.T4.DespesasGeraisEAdministrativas;   % 13/03/2016
o.T4.(o.Campos_Tabela4{9})(1,j) = o.TRI{j}.o.T4.ResultadoAntesDoResultadoFinanceiroEDosTributos;
o.T4.(o.Campos_Tabela4{10})(1,j) = o.TRI{j}.o.T4.ResultadoFinanceiro;
o.T4.(o.Campos_Tabela4{11})(1,j) = o.TRI{j}.o.T4.ResultadoAntesDosTributosSobreOLucro;
o.T4.(o.Campos_Tabela4{12})(1,j) = o.TRI{j}.o.T4.ImpostoDeRendaEContribuicaoSocialSobreOLucro;
o.T4.(o.Campos_Tabela4{13})(1,j) = o.TRI{j}.o.T4.ResultadoLiquidoDasOperacoesContinuadas;
o.T4.(o.Campos_Tabela4{14})(1,j) = o.TRI{j}.o.T4.ResultadoLiquidoDeOperacoesDescontinuadas;
o.T4.(o.Campos_Tabela4{15})(1,j) = o.TRI{j}.o.T4.LucroPrejuizoDoPeriodo;                 % 16/03/2016
o.T4.(o.Campos_Tabela4{16})(1,j) = o.TRI{j}.o.T4.AtribuidoASociosDaEmpresaControladora;  % 14/03/2016
o.T4.(o.Campos_Tabela4{17})(1,j) = o.TRI{j}.o.T4.AtribuidoASociosNaoControladora;        % 14/03/2016

end