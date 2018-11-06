function [t_cortado, signal_cortado] = corte(signal, tempo, t1, t2)

% Pegando os índices dos sinais para averiguação dos parâmetros.
index1 = find(tempo >= t1, 1, 'first');
index2 = find(tempo <= t2, 1, 'last');

% Cortando o sinal.
t_cortado      = tempo(index1:index2);
signal_cortado = signal(index1:index2);

end