function [o] = fn_AjusteAcumulado_Tabela4(o)


% -------------------------------------------------------------------------
% (*) Ajuste para o 4� Trimestre
% (*) No caso, eu irei verificar se existem quatro trimestres para um mesmo
%     ano. Se existir, eu tenho de fazer uma compensa��o em rela��o ao
%     �ltimo trimestre. Ou seja, o balan�o do �ltimo trimestre tem que ser
%     o resultado do �ltimo trimestre subtra�do dos tr�s primeiros
%     trimestres do ano.
quant = max(size(o.DATA_OrdemDecrescente));
for i=1:quant
   D       = o.DATA_OrdemDecrescente{i};
   dia{i}  = D(1:2);
   mes{i}  = D(4:5);
   ano{i}  = D(7:end);
end

for i=1:quant
    % Verifica se tem balan�o do 4� trimestre
    if(mes{i} == '12')
       % Se tiver, vamos verificar se h� 3 trimestres do respectivo ano
       % com balan�o
       anoTrabalhado = ano{i};
       % Os tr�s trimestres subsequentes est�o no mesmo ano?
       cont = 0;
       if((quant - i) >= 3)
           for j=(i+1):(i+3)
               if(ano{j} == anoTrabalhado)
                   cont = cont+1;
               end
           end
       end
   
       % Se existem tr�s balan�os seguidos, relativo aos tr�s primeiros
       % semestres do ano, o que a gente ir� fazer � pegar o valor do 4
       % trimestre e subtrair o valor dos primeiros tr�s. 
       index = i;
       if (cont == 3)
            UM        = 0;
            DOIS      = 0;
            TRES      = 0;
            QUATRO    = 0;
            CINCO     = 0;
            SEIS      = 0;    
            SETE      = 0;    
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
                SEIS         = SEIS     + o.T4.DespesasComVendas(k);                 
                SETE         = SETE     + o.T4.DespesasGeraisEAdministrativas(k);    
                OITO         = OITO     + o.T4.ResultadoFinanceiro(k);
                NOVE         = NOVE     + o.T4.ResultadoAntesDosTributosSobreOLucro(k);
                DEZ          = DEZ      + o.T4.ImpostoDeRendaEContribuicaoSocialSobreOLucro(k);
                ONZE         = ONZE     + o.T4.ResultadoLiquidoDasOperacoesContinuadas(k);
                DOZE         = DOZE     + o.T4.ResultadoLiquidoDeOperacoesDescontinuadas(k);
                TREZE        = TREZE    + o.T4.LucroPrejuizoDoPeriodo(k);                     
                QUATORZE     = QUATORZE + o.T4.AtribuidoASociosDaEmpresaControladora(k);      
                QUINZE       = QUINZE   + o.T4.AtribuidoASociosNaoControladora(k);            
            end 
            o.T4.ReceitaDeVendaDeBensEOUServicos(index)                  = o.T4.ReceitaDeVendaDeBensEOUServicos(index) - UM;                
            o.T4.CustoDosBensEOUServicosVendidos(index)                  = o.T4.CustoDosBensEOUServicosVendidos(index) - DOIS;                 
            o.T4.ResultadoBruto(index)                                   = o.T4.ResultadoBruto(index) - TRES;                                  
            o.T4.DespesasReceitasOperacionais(index)                     = o.T4.DespesasReceitasOperacionais(index) - QUATRO;   
            o.T4.DespesasComVendas(index)                                = o.T4.DespesasComVendas(index) - SEIS;                
            o.T4.DespesasGeraisEAdministrativas(index)                   = o.T4.DespesasGeraisEAdministrativas(index) - SETE;   
            o.T4.ResultadoAntesDoResultadoFinanceiroEDosTributos(index)  = o.T4.ResultadoAntesDoResultadoFinanceiroEDosTributos(index) - CINCO;
            o.T4.ResultadoFinanceiro(index)                              = o.T4.ResultadoFinanceiro(index) - OITO;                
            o.T4.ResultadoAntesDosTributosSobreOLucro(index)             = o.T4.ResultadoAntesDosTributosSobreOLucro(index) - NOVE;            
            o.T4.ImpostoDeRendaEContribuicaoSocialSobreOLucro(index)     = o.T4.ImpostoDeRendaEContribuicaoSocialSobreOLucro(index) - DEZ;    
            o.T4.ResultadoLiquidoDasOperacoesContinuadas(index)          = o.T4.ResultadoLiquidoDasOperacoesContinuadas(index) - ONZE;         
            o.T4.ResultadoLiquidoDeOperacoesDescontinuadas(index)        = o.T4.ResultadoLiquidoDeOperacoesDescontinuadas(index) - DOZE;        
            o.T4.LucroPrejuizoDoPeriodo(index)                           = o.T4.LucroPrejuizoDoPeriodo(index) - TREZE;                    
            o.T4.AtribuidoASociosDaEmpresaControladora(index)            = o.T4.AtribuidoASociosDaEmpresaControladora(index) - QUATORZE;  
            o.T4.AtribuidoASociosNaoControladora(index)                  = o.T4.AtribuidoASociosNaoControladora(index) - QUINZE;          
       end
   end
end

end