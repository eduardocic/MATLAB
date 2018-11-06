clear all; close all; clc;

% Mudança de frequência do sistema. 
% ---------------------------------
% 
% A variação se dará de 1Hz em 1Hz.
f_max = 100;
f     = 1:1:f_max;

% Parâmetros de tempo do sistema.
% -------------------------------
% 
% Para estabilização do ciclo, faço o mesmo ser percorrido 10 vezes
% (relativo à 2*pi*Qnt_Ciclo. Ademais, considerei o envio do sinal e a sua
% amostragem na ordem de 1000Hz.
Qnt_Ciclo   = 10;
Tempo_Ciclo = (2*pi)*Qnt_Ciclo;
dt          = 0.001;

% Criação de 'step' temporal.
% ---------------------------
%
% Apenas para criação da base temporal da senoide que será utilizada como
% referência.
t         = [];
signal_in = []; 
MAX       = [];
sum       = 0;
t_int(1) = 0;
for i = 1:f_max
    
    if(i == 1)
        t_base    = 0:dt:(Tempo_Ciclo/f(i));
        MAX       = [MAX max(t_base)];
    else
        t_base    = dt:dt:(Tempo_Ciclo/f(i));
        MAX       = [MAX max(t_base)];
    end
    
    s         = sin(f(i)*t_base);
    signal_in = [signal_in s];    
    t         = [t (t_base + sum)];
    sum       = sum + max(t_base);
    t_int(i+1)  = sum;
end

% Plota o sinal o qual você deseja utilizar como entrada do seu sistema.
% ----------------------------------------------------------------------
plot(t, signal_in); grid;
xlabel('tempo(s)');
ylabel('Entrada senoidal');


% Encontra os valores máximos -- do sinal original.
% -------------------------------------------------
[signal_in_max, index_in_max] = findpeaks(signal_in);


% Sistema -- já passado o seu valor e atraso.
% --------------------------------------------
G = tf(22.6, [1 2 9]);
signal_out = lsim(G, signal_in, t);
[signal_out_max, index_out_max] = findpeaks(signal_out);


% Plotagem do resultado original com o após passar pelo sistema.
% --------------------------------------------------------------
plot(t, signal_in); hold on;
plot(t, signal_out);


% Encontrar a média dos valores de pico dentro do ciclo (valores de pico).
% ------------------------------------------------------------------------
for i = 1:f_max
    intermed_in  = signal_in_max((Qnt_Ciclo*(i-1) + 1):(Qnt_Ciclo*i));
    intermed_out = signal_out_max((Qnt_Ciclo*(i-1) + 1):(Qnt_Ciclo*i));
    picos_in(i)  = soma(intermed_in)/Qnt_Ciclo;
    picos_out(i) = soma(intermed_out)/Qnt_Ciclo;
end


% Encontrar a média de atraso entre as variáveis.
% -----------------------------------------------
t_in  = index_in_max';
t_out = index_out_max;
delta = abs(t_in - t_out);

for i = 1:f_max
    intermed_t  = delta((Qnt_Ciclo*(i-1) + 1):(Qnt_Ciclo*i));
    atraso(i)   = dt*soma(intermed_t)/Qnt_Ciclo;      % Em segundos.
    
    % Cálculo do atraso de fase -- em graus.
    fase(i) = -(180/pi)*atraso(i)*f(i);
end

% Apresentação nas variáveis já conhecidas do sistema -- Bode e a obtida.
% -----------------------------------------------------------------------
figure;
bode(G,{1, 100}); grid;

magnitude = 20*log10(picos_out);
figure; 
subplot(2,1,1);
semilogx(f, magnitude); grid;
xlabel('frequência (rad/s)');
ylabel('Magnitude (dB)');

subplot(2,1,2);
semilogx(f, fase); grid;
xlabel('frequência (rad/s)');
ylabel('Fase (graus)');


% Criação do modelo por meio do dado da seguinte forma: 
% -----------------------------------------------------
%
%        G(jw) = |G(jw)|*exp(jw).

for i = 1:max(size(picos_out))
    data(i) = picos_out(i)*exp(j*(fase(i)*pi/180));
end


% Estimativa de pontos do sistema.
% --------------------------------
modelo = frd(data, f);
npolos = 2;                 % Estimativa de numeros de polos do sistema.
nzeros = 0;                 % Estimativa de numeros de zeros do sistema.

sys        = tfest(modelo, npolos, nzeros);
Gestimado  = tf(sys);
zpk(Gestimado);

figure; 
bode(G); hold on; bode(Gestimado);


% Apenas para ajuste de vetores.
% ------------------------------
signal_out = signal_out';
save('dados','signal_in', 'signal_out', 't', 't_int');