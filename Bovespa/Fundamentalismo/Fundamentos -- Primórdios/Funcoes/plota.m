function [] = plota(vetor, cor)

N = max(size(vetor));
plot(vetor(1,1:N/2), vetor(1,(1+N/2):N),...
                                        cor,...
                                        'LineWidth', 2);

end