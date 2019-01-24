function [ResultadoTrimestral, ResultadoAnual] = fnROE(ticker)
%
% (*) Esta fun��o calcula aproximadamente o 'Retorno Sobre o Patrim�nio 
%     L�quido';
%
% (*) Seu valor mede a rentabilidade dos recursos aplicados pelos
%     acionistas;
%
% (*) O c�lculo dela � tomado considerando o 'Lucro Liquido' com o
%     'Patrim�nio L�quido', ou seja:
%
%                               Lucro L�quido  
%                      ROE = --------------------
%                             Patrim�nio L�quido
%
% (*) Na planilha do Fundamentos:
%
% -------------------------------------------------------------------------
% |        �ndice       |       Planilha        | Equival�ncia |  Posi��o |
% -------------------------------------------------------------------------
% |   Lucro L�quido     |    'DEMONSTRATIVO'    |      T2      | Linha 26 |
% | Patrim�nio L�quido  |   'BAL. PATRIMONIAL'  |      T1      | Linha 48 |
% -------------------------------------------------------------------------
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% -------------------------------------------------------------------------
%                              Pr�-C�lculo
% -------------------------------------------------------------------------
[Ano, Mes, Dia, Hora, Minuto, Segundo] = datevec(ticker.D);
n = max(size(ticker.D));     % n� de Trimestres.

LucroPeriodo      = ticker.T2.LucroPeriodo;
PatrimonioLiquido = ticker.T1.PatrimonioLiquido;

% -------------------------------------------------------------------------
%                         C�lculo por Trimestre.
% -------------------------------------------------------------------------
ROE_T = LucroPeriodo./PatrimonioLiquido;

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
        PatrimonioLiquidoDezembro(contador) = PatrimonioLiquido(i);  % Patrim�nio L�quido.
        Anos(contador)             = Ano(i) + 37/100;                         % com offset para o gr�fico.
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
ROE_A = LucroLiquidoAno./PatrimonioLiquidoDezembro;            % Resultado.

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
    PatrimonioLiquidoTrimestreIncompleto   = PatrimonioLiquido(n);
    
    ROE_TriIncompleto = LucroLiquidoTrimestreIncompleto/PatrimonioLiquidoTrimestreIncompleto;
    AnoIncompleto = Ano(n) + 37/100;         % com offset para o gr�fico.
    
    flag = 1;
else
    flag = 0;
end



% -------------------------------------------------------------------------
%                              Plota Resultado.
% -------------------------------------------------------------------------

% % 1) Anos cheios (com 4 trimestres).
% bar(AnoRef, ROE_Anual, 'r'); hold on; grid;
% % 2) Ano incompleto (ou seja, com menos de 4 trimestres).
% if (flag == 1)
%     bar(AnoIncompleto, ROE_TriIncompleto(end), 'm');    
% end
% % 3) Trimestre.  
% bar(TriRef, ROE_Trimestral, 0.4);
% 
% % Configura��es do plot.
% if (flag == 1)
%     legend('Anual - Completo','Anual - Incompleto','Trimestral');
% else
%     legend('Anual - Completo','Trimestral');
% end
% ylabel('Retorno Sobre Patrim�nio L�quido - ROE');
% xlabel('Ano');
% xlim([(Ano(1)-1/4) (Ano(n)+1)]);


% -------------------------------------------------------------------------
%         Agrupa os resultados em dois vetores: Anual e Trimestral
% -------------------------------------------------------------------------
Trimestral = [Trimestres ROE_T];
Anual      = [Anos ROE_A];

ResultadoTrimestral = Trimestral;
ResultadoAnual      = Anual;


end