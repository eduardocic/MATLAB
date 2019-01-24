% -------------------------------------------------------------------------
% (*) Ajuste para o 4º Trimestre
% (*) No caso, eu irei verificar se existem quatro trimestres para um mesmo
%     ano. Se existir, eu tenho de fazer uma compensação em relação ao
%     último trimestre. Ou seja, o balanço do último trimestre tem que ser
%     o resultado do último trimestre subtraído dos três primeiros
%     trimestres do ano.
data  = o.T1.data;
quant = size(data,1);
for i=1:quant
   D       = fnYYYYMMDD(data(i,:));
   ano{i}  = D(1:4);
   mes{i}  = D(5:6);
   dia{i}  = D(7:end);
end


for i=1:quant
    % Verifica se tem balanço do 4º trimestre
    if(mes{i} == '12')
       % Se tiver, vamos verificar se há 3 trimestres do respectivo ano
       % com balanço
       anoTrabalhado = ano{i};
       % Os três trimestres subsequentes estão no mesmo ano?
       cont = 0;
       if((quant - i) >= 3)
           for j=(i+1):(i+3)
               if(ano{j} == anoTrabalhado)
                   cont = cont+1;
               end
           end
       end

       % Se existem três balanços seguidos, relativo aos três primeiros
       % semestres do ano, o que a gente irá fazer é pegar o valor do 4
       % trimestre e subtrair o valor dos primeiros três. 
       index = i;
       if (cont == 3)
            UM        = 0;
            DOIS      = 0;
            TRES      = 0;
            QUATRO    = 0;
            CINCO     = 0;
            SEIS      = 0;    % 13/04/2016
            SETE      = 0;    % 13/04/2016
            OITO      = 0;
            NOVE      = 0;
            DEZ       = 0;
            ONZE      = 0;
            DOZE      = 0;
            TREZE     = 0;
            QUATORZE  = 0;
            QUINZE    = 0;
            for k=(i+1):(i+3)
                UM           = UM       + o.T4.ReceitaDeVendaDeBensEOUServicos(k);  
                DOIS         = DOIS     + o.T4.CustoDosBensEOUServicosVendidos(k);
                TRES         = TRES     + o.T4.ResultadoBruto(k);
                QUATRO       = QUATRO   + o.T4.DespesasReceitasOperacionais(k);
                CINCO        = CINCO    + o.T4.ResultadoAntesDoResultadoFinanceiroEDosTributos(k);
                SEIS         = SEIS     + o.T4.DespesasComVendas(k);                 % 13/04/2016
                SETE         = SETE     + o.T4.DespesasGeraisEAdministrativas(k);    % 13/04/2016
                OITO         = OITO     + o.T4.ResultadoFinanceiro(k);
                NOVE         = NOVE     + o.T4.ResultadoAntesDosTributosSobreOLucro(k);
                DEZ          = DEZ      + o.T4.ImpostoDeRendaEContribuicaoSocialSobreOLucro(k);
                ONZE         = ONZE     + o.T4.ResultadoLiquidoDasOperacoesContinuadas(k);
                DOZE         = DOZE     + o.T4.ResultadoLiquidoDeOperacoesDescontinuadas(k);
                TREZE        = TREZE    + o.T4.LucroPrejuizoDoPeriodo(k);                     % 16/03/2016
                QUATORZE     = QUATORZE + o.T4.AtribuidoASociosDaEmpresaControladora(k);      % 14/04/2016
                QUINZE       = QUINZE   + o.T4.AtribuidoASociosNaoControladora(k);            % 14/04/2016
            end 
            o.T4.ReceitaDeVendaDeBensEOUServicos(index) = o.T4.ReceitaDeVendaDeBensEOUServicos(index) - UM;                
            o.T4.CustoDosBensEOUServicosVendidos(index) = o.T4.CustoDosBensEOUServicosVendidos(index) - DOIS;                 
            o.T4.ResultadoBruto(index)                  = o.T4.ResultadoBruto(index) - TRES;                                  
            o.T4.DespesasReceitasOperacionais(index)    = o.T4.DespesasReceitasOperacionais(index) - QUATRO;   
            o.T4.DespesasComVendas(index)               = o.T4.DespesasComVendas(index) - SEIS;                % 13/04/2016
            o.T4.DespesasGeraisEAdministrativas(index)  = o.T4.DespesasGeraisEAdministrativas(index) - SETE;   % 13/04/2016
            o.T4.ResultadoAntesDoResultadoFinanceiroEDosTributos(index)  = o.T4.ResultadoAntesDoResultadoFinanceiroEDosTributos(index) - CINCO;
            o.T4.ResultadoFinanceiro(index)                              = o.T4.ResultadoFinanceiro(index) - OITO;                
            o.T4.ResultadoAntesDosTributosSobreOLucro(index)             = o.T4.ResultadoAntesDosTributosSobreOLucro(index) - NOVE;            
            o.T4.ImpostoDeRendaEContribuicaoSocialSobreOLucro(index)     = o.T4.ImpostoDeRendaEContribuicaoSocialSobreOLucro(index) - DEZ;    
            o.T4.ResultadoLiquidoDasOperacoesContinuadas(index)          = o.T4.ResultadoLiquidoDasOperacoesContinuadas(index) - ONZE;         
            o.T4.ResultadoLiquidoDeOperacoesDescontinuadas(index)        = o.T4.ResultadoLiquidoDeOperacoesDescontinuadas(index) - DOZE;        
            o.T4.LucroPrejuizoDoPeriodo(index)                           = o.T4.LucroPrejuizoDoPeriodo(index) - TREZE;                    % 16/03/2016
            o.T4.AtribuidoASociosDaEmpresaControladora(index)            = o.T4.AtribuidoASociosDaEmpresaControladora(index) - QUATORZE;  % 14/03/2016       
            o.T4.AtribuidoASociosNaoControladora(index)                  = o.T4.AtribuidoASociosNaoControladora(index) - QUINZE;          % 14/03/2016       
       end
   end
end