function [a] = fn_ROE(a)

% Eduardo H. Santos
% Data: 15/03/2017
% 
%   Significado
%  -------------
%
%   ROE é um indicador financeiro PERCENTUAL que se refere à capacidade de
% uma empresa em agregar valor a ela mesma utilizando os seus próprios
% recursos. Isto é, quanto ela consegue crescer usando nada além daquilo
% que ela já tem.
%
%
%   Cálculo
%  ----------
%                              
%                                 Lucro Líquido
%                       ROE  = --------------------
%                               Patrimônio Líquido
% 
% (*) No caso do presente programa, o que cálculo será tomado utilizando-se
%     os últimos 12 meses, calculados a cada trimestre. Ou seja, em
%     cada trimestre, eu irei olhar os resultados do trimestre atual e dos
%     últimos 3 para fechar o balanço;
%
% (*) O Patrimônio Líquido será tomado a partir do valor disponibilizado no
%     último balanço;
%
% (*) O Lucro Líquido será tomado a partir da soma dos 4 últimos balanços
%     disponibilizados;
%
% (*) Após a obtenção do valor, multiplica-se o mesmo por 100% para obter o
%     o seu valor em '%';
% 
% (*) Estou utilizando a referência do site FUNDAMENTUS.
%
%
%   Localização dos itens
%  -----------------------
%
% -------------------------------------------------------------------------
% |     Código    |                  Descrição                            |
% -------------------------------------------------------------------------
% | 2.03          | 'Patrimônio Líquido'                                  |
% | 3.11.01       | 'Atribuído a Sócios da Empresa Controladora'          |
% -------------------------------------------------------------------------

% 1.: Pega os valores aos quais serão calculados no objeto.
LucroTrimestre    = a.DemResultados.AtribuidoASociosDaEmpresaControladora;
PatrimonioLiquido = a.Passivos.PatrimonioLiquido;
n = max(size(a.Data.Ano));

% 2.: Obtenção do resultado dos Lucro dos 4 últimos trimestres.
[Trimestre, Lucro4UltimosTrimestres] = SomaUltimosQuatroTrimestres(a, LucroTrimestre);

% 3.: Média do patrimônio Líquido dos 4 últimos trimestres.
Patrimonio4UltimosTrimestres = PatrimonioLiquido(4:end);

% 4.: Resultado da Operação.
ROE = Lucro4UltimosTrimestres./Patrimonio4UltimosTrimestres;

% 5.: Cálculo do ROE em %.
ROE = 100*ROE;

% 6.: Salva o indicador.
a.Indicador.ROE.x = Trimestre;
a.Indicador.ROE.y = ROE;
end