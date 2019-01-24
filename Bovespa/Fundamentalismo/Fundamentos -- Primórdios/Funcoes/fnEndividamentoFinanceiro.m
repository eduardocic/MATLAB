function [ResultadoTrimestral, ResultadoAnual] = fnEndividamentoFinanceiro(ticker)
%
% (*) Esta fun��o calcula aproximadamente o 'Endividamento Financeiro da
%     Empresa';
%
% (*) Seu valor mede o percentual do capital de terceiros na d�vida da
%     empresa. Entenda como 'D�vida Total' o valor obtido por terceiros,
%     sendo eles:
%           
%            -- Empr�stimo de Longo Prazo(LP) + 
%            -- Empr�stimo de Curto Prazo(CP) + 
%            -- Deb�ntures.
% 
%     PS: Os valores de 'Deb�ntures' n�o se encontram na planilha da
%     Fundamentus.
%
% (*) O c�lculo dela � tomado considerando o 'Lucro Liquido' com o
%     'Patrim�nio L�quido', ou seja:
%
%                                              D�vida Total 
%        Endividamento Financeiro = -------------------------------------
%                                    (D�vida Total + Patrim�nio L�quido)
%
%                                     D�vida Curto Prazo    
%        Endividamento Curto Prazo = ----------------------
%                                       (D�vida Total)
%                 
%        Endividamento Longo Prazo = (1 -  Endividamento Curto Prazo)
%                                       
%
% (*) Na planilha do Fundamentos:
%
% -------------------------------------------------------------------------
% |        �ndice       |       Planilha        | Equival�ncia |  Posi��o |
% -------------------------------------------------------------------------
% | Emp. Curto Prazo    |   'BAL. PATRIMONIAL'  |      T1      | Linha 32 |
% | Emp. Longo Prazo    |   'BAL. PATRIMONIAL'  |      T1      | Linha 39 |
% |      Deb�ntures     |         xxxxxx        |      xx      |    xxx   |
% | Patrim�nio L�quido  |   'BAL. PATRIMONIAL'  |      T1      | Linha 48 |
% -------------------------------------------------------------------------
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% -------------------------------------------------------------------------
%                              Pr�-C�lculo
% -------------------------------------------------------------------------
[Ano, Mes, Dia, Hora, Minuto, Segundo] = datevec(ticker.D);
n = max(size(ticker.D));     % n� de Trimestres.

EmprestimoCurtoPrazo = ticker.T1.EmprestimosFinanciamentos1;
EmprestimoLongoPrazo = ticker.T1.EmprestimosFinanciamentos2;
PatrimonioLiquido    = ticker.T1.PatrimonioLiquido;


DividaTotal = EmprestimoCurtoPrazo + EmprestimoLongoPrazo;
DividaCurtoPrazo = EmprestimoCurtoPrazo./DividaTotal;
DividaLongoPrazo = linspace(1,1,n) - DividaCurtoPrazo;
% -------------------------------------------------------------------------
%                         C�lculo por Trimestre.
% -------------------------------------------------------------------------
EndividamentoFinanceiro_T = DividaTotal./(DividaTotal + PatrimonioLiquido);

% Cria��o de Intervalo para os Trimestres - para 'plot'.
for i=1:n
    Trimestres(i) = (Mes(i)/12) + Ano(i) - 1/4;       % com offset para o gr�fico.
end

% -------------------------------------------------------------------------
%                        C�lculo por Ano Completo
% -------------------------------------------------------------------------
contador  = 0;
contador2 = 0;
Somador   = 0;
for i=1:n
    
    % Os valores dos anos ter�o como refer�ncia o m�s de Dezembro.
    if (mod(Mes(i), 12) == 0)
        contador = contador + 1;
        EndividamentoFinanceiro_A(contador) = EndividamentoFinanceiro_T(i);    % Para o Ano.
        Anos(contador)         = Ano(i) + 37/100;                              % com offset para o gr�fico.
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
% % Configura��es do plot.
% if (flag == 1)
%     legend('Anual - Completo','Anual - Incompleto','Trimestral', 'D�vida Curto Prazo', 'D�vida Longo Prazo');;
% else
%     legend('Anual - Completo','Trimestral', 'D�vida Curto Prazo', 'D�vida Longo Prazo');
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