function [ResultadoTrimestral] = fnIndiceSolvenciaCaixa(ticker)
%
% (*) Esta fun��o calcula o '�ndice de Solv�ncia de Caixa';
%
% (*) Seu valor mede o percentual das d�vidas de curto prazo que a empresa
%     pode liquidar imediatamente; 
%
% (*) O c�lculo dela � tomado considerando o 'Lucro Operacional' com o
%     'Resultado Financeiro', ou seja:
%
%                                     (Caixa + Aplica��o Financeira)
%     Indice de Solvencia de Caixa = -------------------------------
%                                          Passivo Circulante
%                                       
% (*) Na planilha do Fundamentos:
%
% -------------------------------------------------------------------------
% |        �ndice        |       Planilha        | Equival�ncia |  Posi��o |
% -------------------------------------------------------------------------
% | Caixa e Equiv. Caixa |  'BAL. PATRIMONIAL'   |      T1      | Linha 05 |
% |  Aplic. Financeiras  |  'BAL. PATRIMONIAL'   |      T1      | Linha 06 |
% |  Passivo Circulante  |  'BAL. PATRIMONIAL'   |      T1      | Linha 28 |
% -------------------------------------------------------------------------
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% -------------------------------------------------------------------------
%                              Pr�-C�lculo
% -------------------------------------------------------------------------
[Ano, Mes, Dia, Hora, Minuto, Segundo] = datevec(ticker.D);
n = max(size(ticker.D));     % n� de Trimestres.


CaixaEquivalenteCaixa = ticker.T1.CxEquiCx;
AplicacoesFinanceiras = ticker.T1.ApliFinanceira;
PassivoCirculante     = ticker.T1.PassivoCirculante;


Numerador   = (CaixaEquivalenteCaixa + AplicacoesFinanceiras);
Denominador = PassivoCirculante;

% -------------------------------------------------------------------------
%                         C�lculo por Trimestre.
% -------------------------------------------------------------------------
IndiceSolvenciaCaixa = Numerador./Denominador;

% Cria��o de Intervalo para os Trimestres - para 'plot'.
for i=1:n
    Trimestres(i) = (Mes(i)/12) + Ano(i) - 1/4;       % com offset para o gr�fico.
end

% -------------------------------------------------------------------------
%                        C�lculo por Ano Completo
% -------------------------------------------------------------------------
% contador  = 0;
% Somador1  = 0;
% Somador2  = 0;
% for i=1:n
%     % O 'Lucro Operacional' e o 'Resultado Financeiro' ser�o tomados com a 
%     % soma de 4 trimestres.
%     if (mod(Mes(i), 12) ~= 0)
%         Somador1 = Somador1 + LucroOperacional(i);
%         Somador2 = Somador2 + ResultadoFinanceiro(i);
%     elseif (mod(Mes(i), 12) == 0)
%         Somador1 = Somador1 + LucroOperacional(i);
%         Somador2 = Somador2 + ResultadoFinanceiro(i);
%         contador = contador + 1;
%         
%         Anos(contador) = Ano(i) + 37/100; % com offset para o gr�fico.
%         IndiceCoberturaAnual(contador) = Somador1/Somador2;
%         
%         Somador1 = 0;
%         Somador2 = 0;
%     end
% end

% -------------------------------------------------------------------------
%                        C�lculo por Ano Incompleto.
% -------------------------------------------------------------------------
% 
% (*) O c�lculo para o ativo total tomado como o �ltimo trimestre
%     dispon�vel.
% if (contador*4 ~= n)
%     AnoIncompleto = Ano(n) + 37/100;         % com offset para o gr�fico.
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

% Configura��es do plot.
% if (flag == 1)
%     legend('Anual - Completo','Anual - Incompleto','Trimestral');
% else
%     legend('Anual - Completo','Trimestral');
% end
% ylabel('�ndice de Solv�ncia de Caixa.');
% xlabel('Ano');
% xlim([(Ano(1)-1/4) (Ano(n)+1)]);

% -------------------------------------------------------------------------
%         Agrupa os resultados em dois vetores: Anual e Trimestral
% -------------------------------------------------------------------------
Trimestral = [Trimestres IndiceSolvenciaCaixa];

ResultadoTrimestral = Trimestral;

end