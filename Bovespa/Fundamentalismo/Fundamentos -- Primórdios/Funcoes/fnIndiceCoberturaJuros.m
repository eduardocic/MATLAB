function [ResultadoTrimestral, ResultadoAnual] = fnIndiceCoberturaJuros(ticker)
%
% (*) Esta fun��o calcula o '�ndice de Cobertura';
%
% (*) Seu valor mede o EBIT, ou seja, o lucro financeiro da atividade
%     comercial (sem tirar impostos e despesas financeiras). � para
%     verificar se a atividade em si, vender determinado produto, est�
%     vantajosa ou n�o. O 'Lucro Operacional' � calculado a partir da soma
%     dos seguintes par�metros:
%           
%            -- Resultado Bruto + 
%            -- Despesas com Vendas + 
%            -- Despesas Gerais e Administrativas + 
%            -- Perdas pela N�o Recuperabilidade de Ativos + 
%            -- Outas Receitas Operacionais + 
%            -- Outas Despesas Operacionais +
%            -- Resultado da Equival�ncia Patrimonial +
% 
%
% (*) O c�lculo dela � tomado considerando o 'Lucro Operacional' com o
%     'Resultado Financeiro', ou seja:
%
%                                       Lucro Operacional 
%     Indice de Cobertura de Juros = ------------------------
%                                      Resultado Financeiro
%                                       
%
% (*) Na planilha do Fundamentos:
%
% -------------------------------------------------------------------------
% |        �ndice        |       Planilha        | Equival�ncia |  Posi��o |
% -------------------------------------------------------------------------
% |   Resultado Bruto    |    'DEMONSTRATIVO'    |      T2      | Linha 07 |
% | Despesas com Vendas  |   'DEMONSTRATIVO'     |      T2      | Linha 08 |
% |   Despesas Gerais    |     'DEMONSTRATIVO'   |      T2      | Linha 09 |
% | Perdas � Rec. Ativos |   'DEMONSTRATIVO'     |      T2      | Linha 10 |
% | Outras Receitas Op.  |   'DEMONSTRATIVO'     |      T2      | Linha 11 |
% | Outras Despesas Op.  |   'DEMONSTRATIVO'     |      T2      | Linha 12 |
% | Res. Equiv. Patrim.  |   'DEMONSTRATIVO'     |      T2      | Linha 13 |
% | Resultado Financeiro |   'DEMONSTRATIVO'     |      T2      | Linha 14 |
% -------------------------------------------------------------------------
%
% (*) Ser� necessario somar dentro dos trimestres (T1 -> T4) tanto o
%     'Resultado Financeiro' quanto o 'Lucro Operacional' para an�lise por
%     ano. 
%
% (*) A analise por trimestre se d� de maneira direta (divide um pelo
%     outro).
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% -------------------------------------------------------------------------
%                              Pr�-C�lculo
% -------------------------------------------------------------------------
[Ano, Mes, Dia, Hora, Minuto, Segundo] = datevec(ticker.D);
n = max(size(ticker.D));     % n� de Trimestres.

ResultadoBruto              = ticker.T2.ResultadoBruto;
DespesasComVendas           = ticker.T2.DespesasComVendas;
DespesasGerais              = ticker.T2.DespesasGeraisAdministrativas;
PerdasNaoRecuperabAtivos    = ticker.T2.PerdasNaoRecuperabAtivos;
OutrasReceitasOperacionais  = ticker.T2.OutrasReceitasOperacionais;
OutrasDespesasOperacionais  = ticker.T2.OutrasDespesasOperacionais;
ResEquivalenciaPatrimonial  = ticker.T2.ResultadoEquivalenciaPatrimonial;


LucroOperacional  = ResultadoBruto + DespesasComVendas + DespesasGerais + ...
                    PerdasNaoRecuperabAtivos + OutrasReceitasOperacionais + ...
                    ResEquivalenciaPatrimonial;

ResultadoFinanceiro  = ticker.T2.Financeiras;



% -------------------------------------------------------------------------
%                         C�lculo por Trimestre.
% -------------------------------------------------------------------------
IndiceCobertura_T = LucroOperacional./ResultadoFinanceiro;

% Cria��o de Intervalo para os Trimestres - para 'plot'.
for i=1:n
     Trimestres(i) = (Mes(i)/12) + Ano(i) - 1/4;       % com offset para o gr�fico.
end

% -------------------------------------------------------------------------
%                        C�lculo por Ano Completo
% -------------------------------------------------------------------------
contador  = 0;
Somador1  = 0;
Somador2  = 0;
for i=1:n
    
    % O 'Lucro Operacional' e o 'Resultado Financeiro' ser�o tomados com a 
    % soma de 4 trimestres.
    if (mod(Mes(i), 12) ~= 0)
        Somador1 = Somador1 + LucroOperacional(i);
        Somador2 = Somador2 + ResultadoFinanceiro(i);
    elseif (mod(Mes(i), 12) == 0)
        Somador1 = Somador1 + LucroOperacional(i);
        Somador2 = Somador2 + ResultadoFinanceiro(i);
        contador = contador + 1;
        Anos(contador) = Ano(i) + 37/100; % com offset para o gr�fico.
        IndiceCobertura_A(contador) = Somador1/Somador2;
        Somador1 = 0;
        Somador2 = 0;
    end
end

% -------------------------------------------------------------------------
%                        C�lculo por Ano Incompleto.
% -------------------------------------------------------------------------
% 
% (*) O c�lculo para o ativo total tomado como o �ltimo trimestre
%     dispon�vel.
if (contador*4 ~= n)
    AnoIncompleto = Ano(n) + 37/100;         % com offset para o gr�fico.
    
    flag = 1;
else
    flag = 0;
end



% -------------------------------------------------------------------------
%                              Plota Resultado.
% -------------------------------------------------------------------------

% % 1) Anos cheios (com 4 trimestres).
% bar(Anos, 100*IndiceCoberturaAnual, 'r'); hold on; grid;
% % 2) Ano incompleto (ou seja, com menos de 4 trimestres).
% if (flag == 1)
%     bar(AnoIncompleto, 100*IndiceCoberturaAnual(end), 'm');    
% end
% % 3) Trimestre.  
% bar(Trimestres, 100*IndiceCobertura_T, 0.4);
% 
% % Configura��es do plot.
% if (flag == 1)
%     legend('Anual - Completo','Anual - Incompleto','Trimestral');
% else
%     legend('Anual - Completo','Trimestral');
% end
% ylabel('Incide de Cobertura de Juros');
% xlabel('Ano');
% xlim([(Ano(1)-1/4) (Ano(n)+1)]);

Trimestral = [Trimestres IndiceCobertura_T];
Anual      = [Anos IndiceCobertura_A];

ResultadoTrimestral = Trimestral;
ResultadoAnual      = Anual;


end