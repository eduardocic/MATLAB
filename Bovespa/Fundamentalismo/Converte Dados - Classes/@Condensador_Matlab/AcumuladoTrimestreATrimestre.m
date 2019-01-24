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


for i = 1:quant
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

       % Se existem três balanços seguidos, eu irei fazer a compensação por
       % diferenças entre os valores, começando pelo último trimestre e
       % subtraindo a medida que for andando no próprio ano os valores.
       index = i;
       if (cont == 3)           
            % Subtrai do quatro trimestre o valor acumulado do três
            % primeiros trimestres.
            for k = 0:2
                o.T4.ReceitaDeVendaDeBensEOUServicos(index+k)                 = o.T4.ReceitaDeVendaDeBensEOUServicos(index+k) - o.T4.ReceitaDeVendaDeBensEOUServicos(index+k+1);
                o.T4.CustoDosBensEOUServicosVendidos(index+k)                 = o.T4.CustoDosBensEOUServicosVendidos(index+k) - o.T4.CustoDosBensEOUServicosVendidos(index+k+1);
                o.T4.ResultadoBruto(index+k)                                  = o.T4.ResultadoBruto(index+k)                  - o.T4.ResultadoBruto(index+k+1);
                o.T4.DespesasReceitasOperacionais(index+k)                    = o.T4.DespesasReceitasOperacionais(index+k)    - o.T4.DespesasReceitasOperacionais(index+k+1);   
                o.T4.DespesasComVendas(index+k)                               = o.T4.DespesasComVendas(index+k)               - o.T4.DespesasComVendas(index+k+1);               
                o.T4.DespesasGeraisEAdministrativas(index+k)                  = o.T4.DespesasGeraisEAdministrativas(index+k)  - o.T4.DespesasGeraisEAdministrativas(index+k+1);
                o.T4.ResultadoAntesDoResultadoFinanceiroEDosTributos(index+k) = o.T4.ResultadoAntesDoResultadoFinanceiroEDosTributos(index+k) - o.T4.ResultadoAntesDoResultadoFinanceiroEDosTributos(index+k+1);
                o.T4.ResultadoFinanceiro(index+k)                             = o.T4.ResultadoFinanceiro(index+k)                             - o.T4.ResultadoFinanceiro(index+k+1);                
                o.T4.ResultadoAntesDosTributosSobreOLucro(index+k)            = o.T4.ResultadoAntesDosTributosSobreOLucro(index+k)            - o.T4.ResultadoAntesDosTributosSobreOLucro(index+k+1);
                o.T4.ImpostoDeRendaEContribuicaoSocialSobreOLucro(index+k)    = o.T4.ImpostoDeRendaEContribuicaoSocialSobreOLucro(index+k)    - o.T4.ImpostoDeRendaEContribuicaoSocialSobreOLucro(index+k+1);
                o.T4.ResultadoLiquidoDasOperacoesContinuadas(index+k)         = o.T4.ResultadoLiquidoDasOperacoesContinuadas(index+k)         - o.T4.ResultadoLiquidoDasOperacoesContinuadas(index+k+1);
                o.T4.ResultadoLiquidoDeOperacoesDescontinuadas(index+k)       = o.T4.ResultadoLiquidoDeOperacoesDescontinuadas(index+k)       - o.T4.ResultadoLiquidoDeOperacoesDescontinuadas(index+k+1);      
                o.T4.LucroPrejuizoDoPeriodo(index+k)                          = o.T4.LucroPrejuizoDoPeriodo(index+k)                          - o.T4.LucroPrejuizoDoPeriodo(index+k+1);                
                o.T4.AtribuidoASociosDaEmpresaControladora(index+k)           = o.T4.AtribuidoASociosDaEmpresaControladora(index+k)           - o.T4.AtribuidoASociosDaEmpresaControladora(index+k+1);
                o.T4.AtribuidoASociosNaoControladora(index+k)                 = o.T4.AtribuidoASociosNaoControladora(index+k)                 - o.T4.AtribuidoASociosNaoControladora(index+k+1);
            end   
       end
   end
end