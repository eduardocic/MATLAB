function [o] = fn_YYYYMMDD(o)

% function [MontaData] = fnYYYYMMDD(data)

% (*) A ideia do algoritmo é pegar as datas, em STRING, e ordenar da MAIOR
%     para a MENOR.
% (*) Para fazer isso, eu primeiro irei quebrar todas as datas, em STRING,
%     para algo DIA - MES - ANO. Com isso, eu conseguirei ordenar da data
%     MAIOR para a data MENOR agrupando as variáveis da forma YYYYMMDD.
% (*) Por incrível que pareça, existe uma função no Matlab que faz isso, só
%     que disponível para a versão 2017a em diante...
% (*) Fazer a função então...

% -------------------------------------------------------------------------
n = max(size(o.TRI));

for i=1:n
   % Seleciona a data do referido trimestre.
   Data(i,:)    = o.TRI{i}.o.T1.data;
   
   % 1.: Pego a referida data (string) e a quebro em DIA, MÊS e ANO.
   DataQuebrada = strsplit(Data(i,:), '/'); 

   % 2.: Concateno a STRING no formato YYYYMMDD
   DATA{i} = strcat(DataQuebrada{3}, DataQuebrada{2});
   DATA{i} = strcat(DATA{i}, DataQuebrada{1});
  
   % 3.: Montando data com as barras '/'.
   ano  = DATA{i}(1:4);
   mes  = DATA{i}(5:6);
   dia  = DATA{i}(7:end);
    
   MontaData = strcat(dia,'/');
   MontaData = strcat(MontaData, mes);
   MontaData = strcat(MontaData, '/');
   MontaData = strcat(MontaData, ano);
    
   DATA{i}   = MontaData;
   
   % Ordena as datas em ordem decrescente
   o.DATA_OrdemDecrescente{n-i+1} = DATA{i};
end

end
