function [o] = fn_Individual_Tabela5(o)
% 5.:  QUINTA TABELA
%     -----------------
% 
%  (*) A parte de interesse aqui diz respeito à tabela intitulada
%     'DF Ind. - Ativo' do arquivo baixado do programa Empresa.net
o.T5.texto  = {'Depreciação e Amortização'};        
o.T5.numero = {'6.01.01.04';}; 
         
texto1 = 'Deprecia';     % de Depreciação.
texto2 = 'deprecia';

n = size(o.file.texto.DFIndFluxoDeCaixa, 1);
for i = 1:n
    TEXTO = o.file.texto.DFIndFluxoDeCaixa(i,2);
    TEXTO = char(TEXTO);
    k1 = strfind(TEXTO, texto1);
    k2 = strfind(TEXTO, texto2);
    if (~isempty(k1)|| ~isempty(k2))
%         X = ['Tem um cara na posição ', i];
%         disp(X);
        o.T5.DepreciacaoEAmortizacao = o.file.dado.DFIndFluxoDeCaixa(i-2, 1);
    else
%         disp('Não tem ninguém, brother');   
    end
end
end