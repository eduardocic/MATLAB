function [ResultadoTrimestral, ResultadoAnual] = fnROA(ticker)
%
% (*) Esta fun��o calcula aproximadamente o retorno sobre o investimento 
%     de acionistas e credores;
%
% (*) O c�lculo dela � tomado considerando o 'Lucro Liquido' com o 'Ativo
%     Total', ou seja:
%
%                              Lucro L�quido  
%                      ROA = ----------------
%                               Ativo Total
%
% (*) Na planilha do Fundamentos:
%
% -------------------------------------------------------------------------
% |     Indice     |       Planilha        |   Equival�ncia    |  Posi��o |
% -------------------------------------------------------------------------
% |  Lucro L�quido |    'DEMONSTRATIVO'    |        T2         | Linha 26 |
% |  Ativo Total   |   'BAL. PATRIMONIAL'  |        T1         | Linha 03 |
% -------------------------------------------------------------------------
%
% (*) Algumas pessoas preferem, no entanto, utilizar o 'Lucro Operacional'
% (procurar).
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% -------------------------------------------------------------------------
%                              Pr�-C�lculo
% -------------------------------------------------------------------------
[Ano, Mes, Dia, Hora, Minuto, Segundo] = datevec(ticker.D);
n = max(size(ticker.D));     % n� de Trimestres.

LucroPeriodo = ticker.T2.LucroPeriodo;
AtivoTotal   = ticker.T1.AtivoTotal;



% -------------------------------------------------------------------------
%                         C�lculo por Trimestre.
% -------------------------------------------------------------------------
ROA_T = LucroPeriodo./AtivoTotal;

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
        AtivoTotalDezembro(contador) = AtivoTotal(i);        % Ativo Fim de Ano.
        Anos(contador)               = Ano(i) + 37/100;      % com offset para o gr�fico.
    end
    
    % O lucro l�quido ser� tomado como a soma de 4 trimestres.
    if (mod(Mes(i), 12) ~= 0)
        Somador = Somador + LucroPeriodo(i);
    elseif (mod(Mes(i), 12) == 0)
        Somador = Somador + LucroPeriodo(i);
        contador2 = contador2 + 1;
        LucroLiquidoAno(contador2) = Somador;
        Somador = 0;
    end
end
ROA_A = LucroLiquidoAno./AtivoTotalDezembro;            % Resultado.

% -------------------------------------------------------------------------
%                        C�lculo por Ano Incompleto.
% -------------------------------------------------------------------------
% 
% (*) O c�lculo para o ativo total tomado como o �ltimo trimestre
%     dispon�vel.
Somador2 = 0;
if (contador*4 ~= n)
    for i = (contador*4):n
        Somador2 = Somador2 + LucroPeriodo(i);
    end
    LucroLiquidoTrimestreIncompleto = Somador2;
    AtivoTotalTrimestreIncompleto   = AtivoTotal(n);
    
    ROA_TriIncompleto = LucroLiquidoTrimestreIncompleto/AtivoTotalTrimestreIncompleto;
    AnoIncom = Ano(n) + 37/100;         % com offset para o gr�fico.
    
    flag = 1;
else
    flag = 0;
end



% -------------------------------------------------------------------------
%                              Plota Resultado.
% -------------------------------------------------------------------------

% % 1) Anos cheios (com 4 trimestres).
% bar(Anos, ROA_A, 'r'); hold on; grid;
% % 2) Ano incompleto (ou seja, com menos de 4 trimestres).
% if (flag == 1)
%     bar(AnoIncom, ROA_TriIncompleto, 'm');    
% end
% % 3) Trimestre.  
% bar(Trimestres, ROA_T, 0.4);
% 
% % Configura��es do plot.
% if (flag == 1)
%     legend('Anual - Completo','Anual - Incompleto','Trimestral');
% else
%     legend('Anual - Completo','Trimestral');
% end
% ylabel('Retorno Sobre Ativo - ROA');
% xlabel('Ano');
% xlim([(Ano(1)-1/4) (Ano(n)+1)]);

% -------------------------------------------------------------------------
%         Agrupa os resultados em dois vetores: Anual e Trimestral
% -------------------------------------------------------------------------
Trimestral = [Trimestres ROA_T];
Anual      = [Anos ROA_A];

ResultadoTrimestral = Trimestral;
ResultadoAnual      = Anual;

end