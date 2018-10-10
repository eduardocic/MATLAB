function [ResultadoTrimestral] = fnIndiceSolvenciaCaixa(ticker)
%
% (*) Esta função calcula o 'Índice de Solvência de Caixa';
%
% (*) Seu valor mede o percentual das dívidas de curto prazo que a empresa
%     pode liquidar imediatamente; 
%
% (*) O cálculo dela é tomado considerando o 'Lucro Operacional' com o
%     'Resultado Financeiro', ou seja:
%
%                                     (Caixa + Aplicação Financeira)
%     Indice de Solvencia de Caixa = -------------------------------
%                                          Passivo Circulante
%                                       
% (*) Na planilha do Fundamentos:
%
% -------------------------------------------------------------------------
% |        Índice        |       Planilha        | Equivalência |  Posição |
% -------------------------------------------------------------------------
% | Caixa e Equiv. Caixa |  'BAL. PATRIMONIAL'   |      T1      | Linha 05 |
% |  Aplic. Financeiras  |  'BAL. PATRIMONIAL'   |      T1      | Linha 06 |
% |  Passivo Circulante  |  'BAL. PATRIMONIAL'   |      T1      | Linha 28 |
% -------------------------------------------------------------------------
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% -------------------------------------------------------------------------
%                              Pré-Cálculo
% -------------------------------------------------------------------------
[Ano, Mes, Dia, Hora, Minuto, Segundo] = datevec(ticker.D);
n = max(size(ticker.D));     % nº de Trimestres.


CaixaEquivalenteCaixa = ticker.T1.CxEquiCx;
AplicacoesFinanceiras = ticker.T1.ApliFinanceira;
PassivoCirculante     = ticker.T1.PassivoCirculante;


Numerador   = (CaixaEquivalenteCaixa + AplicacoesFinanceiras);
Denominador = PassivoCirculante;

% -------------------------------------------------------------------------
%                         Cálculo por Trimestre.
% -------------------------------------------------------------------------
IndiceSolvenciaCaixa = Numerador./Denominador;

% Criação de Intervalo para os Trimestres - para 'plot'.
for i=1:n
    Trimestres(i) = (Mes(i)/12) + Ano(i) - 1/4;       % com offset para o gráfico.
end

% -------------------------------------------------------------------------
%                        Cálculo por Ano Completo
% -------------------------------------------------------------------------
% contador  = 0;
% Somador1  = 0;
% Somador2  = 0;
% for i=1:n
%     % O 'Lucro Operacional' e o 'Resultado Financeiro' serão tomados com a 
%     % soma de 4 trimestres.
%     if (mod(Mes(i), 12) ~= 0)
%         Somador1 = Somador1 + LucroOperacional(i);
%         Somador2 = Somador2 + ResultadoFinanceiro(i);
%     elseif (mod(Mes(i), 12) == 0)
%         Somador1 = Somador1 + LucroOperacional(i);
%         Somador2 = Somador2 + ResultadoFinanceiro(i);
%         contador = contador + 1;
%         
%         Anos(contador) = Ano(i) + 37/100; % com offset para o gráfico.
%         IndiceCoberturaAnual(contador) = Somador1/Somador2;
%         
%         Somador1 = 0;
%         Somador2 = 0;
%     end
% end

% -------------------------------------------------------------------------
%                        Cálculo por Ano Incompleto.
% -------------------------------------------------------------------------
% 
% (*) O cálculo para o ativo total tomado como o último trimestre
%     disponível.
% if (contador*4 ~= n)
%     AnoIncompleto = Ano(n) + 37/100;         % com offset para o gráfico.
%     flag = 1;
% else
%     flag = 0;
% end



% -------------------------------------------------------------------------
%                              Plota Resultado.
% -------------------------------------------------------------------------

% % 1) Anos cheios (com 4 trimestres).
% bar(Anos, 100*IndiceCoberturaAnual, 'r'); hold on; grid;
% % 2) Ano incompleto (ou seja, com menos de 4 trimestres).
% if (flag == 1)
%     bar(AnoIncompleto, 100*IndiceCoberturaAnual(end), 'm');    
% end
% 3) Trimestre.  
% bar(Trimestres, 100*IndiceSolvenciaCaixa, 0.4);

% Configurações do plot.
% if (flag == 1)
%     legend('Anual - Completo','Anual - Incompleto','Trimestral');
% else
%     legend('Anual - Completo','Trimestral');
% end
% ylabel('Índice de Solvência de Caixa.');
% xlabel('Ano');
% xlim([(Ano(1)-1/4) (Ano(n)+1)]);

% -------------------------------------------------------------------------
%         Agrupa os resultados em dois vetores: Anual e Trimestral
% -------------------------------------------------------------------------
Trimestral = [Trimestres IndiceSolvenciaCaixa];

ResultadoTrimestral = Trimestral;

end