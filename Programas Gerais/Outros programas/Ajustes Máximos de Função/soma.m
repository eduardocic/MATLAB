function [resultado] = soma(vetor)

n = max(size(vetor));
sum = 0;

for i=1:n
    sum = sum + vetor(i);
end

resultado = sum;

end