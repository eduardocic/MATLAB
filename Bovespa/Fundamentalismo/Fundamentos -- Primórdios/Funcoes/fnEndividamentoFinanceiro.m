function [ResultadoTrimestral, ResultadoAnual] = fnEndividamentoFinanceiro(ticker)
%
% (*) Esta função calcula aproximadamente o 'Endividamento Financeiro da
%     Empresa';
%
% (*) Seu valor mede o percentual do capital de terceiros na dívida da
%     empresa. Entenda como 'Dívida Total' o valor obtido por terceiros,
%     sendo eles:
%           
%            -- Empréstimo de Longo Prazo(LP) + 
%            -- Empréstimo de Curto Prazo(CP) + 
%            -- Debêntures.
% 
%     PS: Os valores de 'Debêntures' não se encontram na planilha da
%     Fundamentus.
%
% (*) O cálculo dela é tomado considerando o 'Lucro Liquido' com o
%     'Patrimônio Líquido', ou seja:
%
%                                              Dívida Total 
%        Endividamento Financeiro = -------------------------------------
%                                    (Dívida Total + Patrimônio Líquido)
%
%                                     Dívida Curto Prazo    
%        Endividamento Curto Prazo = ----------------------
%                                       (Dívida Total)
%                 
%        Endividamento Longo Prazo = (1 -  Endividamento Curto Prazo)
%                                       
%
% (*) Na planilha do Fundamentos:
%
% -------------------------------------------------------------------------
% |        Índice       |       Planilha        | Equivalência |  Posição |
% -------------------------------------------------------------------------
% | Emp. Curto Prazo    |   'BAL. PATRIMONIAL'  |      T1      | Linha 32 |
% | Emp. Longo Prazo    |   'BAL. PATRIMONIAL'  |      T1      | Linha 39 |
% |      Debêntures     |         xxxxxx        |      xx      |    xxx   |
% | Patrimônio Líquido  |   'BAL. PATRIMONIAL'  |      T1      | Linha 48 |
% -------------------------------------------------------------------------
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% -------------------------------------------------------------------------
%                              Pré-Cálculo
% -------------------------------------------------------------------------
[Ano, Mes, Dia, Hora, Minuto, Segundo] = datevec(ticker.D);
n = max(size(ticker.D));     % nº de Trimestres.

EmprestimoCurtoPrazo = ticker.T1.EmprestimosFinanciamentos1;
EmprestimoLongoPrazo = ticker.T1.EmprestimosFinanciamentos2;
PatrimonioLiquido    = ticker.T1.PatrimonioLiquido;


DividaTotal = EmprestimoCurtoPrazo + EmprestimoLongoPrazo;
DividaCurtoPrazo = EmprestimoCurtoPrazo./DividaTotal;
DividaLongoPrazo = linspace(1,1,n) - DividaCurtoPrazo;
% -------------------------------------------------------------------------
%                         Cálculo por Trimestre.
% -------------------------------------------------------------------------
EndividamentoFinanceiro_T = DividaTotal./(DividaTotal + PatrimonioLiquido);

% Criação de Intervalo para os Trimestres - para 'plot'.
for i=1:n
    Trimestres(i) = (Mes(i)/12) + Ano(i) - 1/4;       % com offset para o gráfico.
end

% -------------------------------------------------------------------------
%                        Cálculo por Ano Completo
% -------------------------------------------------------------------------
contador  = 0;
contador2 = 0;
Somador   = 0;
for i=1:n
    
    % Os valores dos anos terão como referência o mês de Dezembro.
    if (mod(Mes(i), 12) == 0)
        contador = contador + 1;
        EndividamentoFinanceiro_A(contador) = EndividamentoFinanceiro_T(i);    % Para o Ano.
        Anos(contador)         = Ano(i) + 37/100;                              % com offset para o gráfico.
    end
end

% -------------------------------------------------------------------------
%                        Cálculo por Ano Incompleto.
% -------------------------------------------------------------------------
% 
% (*) O cálculo para o ativo total tomado como o último trimestre
%     disponível.
if (contador*4 ~= n)
    AnoIncompleto = Ano(n) + 37/100;         % com offset para o gráfico.  
    flag = 1;
else
    flag = 0;
end


% -------------------------------------------------------------------------
%                              Plota Resultado.
% -------------------------------------------------------------------------

% % 1) Anos cheios (com 4 trimestres).
% bar(AnoRef, 100*EndividamentoFinananceiro_A, 'r'); hold on; grid;
% % 2) Ano incompleto (ou seja, com menos de 4 trimestres).
% if (flag == 1)
%     bar(AnoIncompleto, 100*EndividamentoFinananceiro_A(end), 'm');    
% end
% % 3) Trimestre.  
% bar(TriRef, 100*EndividamentoFinanceiro_T, 0.4);
% 
% % 4) Curto Prazo;
% plot(TriRef, 100*DividaCurtoPrazo, 'g'); hold on;
% set(gca,'YAxisLocation','left');
% 
% % 5) Longo Prazo;
% plot(TriRef, 100*DividaLongoPrazo, 'c');
% 
% % Configurações do plot.
% if (flag == 1)
%     legend('Anual - Completo','Anual - Incompleto','Trimestral', 'Dívida Curto Prazo', 'Dívida Longo Prazo');;
% else
%     legend('Anual - Completo','Trimestral', 'Dívida Curto Prazo', 'Dívida Longo Prazo');
% end
% ylabel('Endividamente Financeiro');
% xlabel('Ano');
% xlim([(Ano(1)-1/4) (Ano(n)+1)]);

% -------------------------------------------------------------------------
%         Agrupa os resultados em dois vetores: Anual e Trimestral
% -------------------------------------------------------------------------
Trimestral = [Trimestres EndividamentoFinanceiro_T];
Anual      = [Anos EndividamentoFinanceiro_A];

ResultadoTrimestral = Trimestral;
ResultadoAnual      = Anual;

end