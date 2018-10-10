function [] = fn_SalvaDadosCondensados_FormatoMatlab(o)

% (*) Salvando o resultado
Arquivo = o.Arquivo_Matlab{1};
Arquivo = strsplit(Arquivo,'_');
nomeCompanhia = Arquivo{1};

% Criando uma estrutura;
% O = struct('T1', o.T1, 'T2', o.T2, 'T3', o.T3, 'T4', o.T4, 'T5', o.T5);
O = struct('T1', o.T1, 'T2', o.T2, 'T3', o.T3, 'T4', o.T4);
clear o;

eval(['o' '=O;']);
ResultadoCondensado = strcat(nomeCompanhia,'_CONDENSADO.mat')
save(ResultadoCondensado, 'o');

end