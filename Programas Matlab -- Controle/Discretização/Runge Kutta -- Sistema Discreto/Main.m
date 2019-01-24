%%% Início de tudo.
clear all; close all; clc;

%%% Sistema de equações que descrevem o sistema a ser simulado.
SISTEMA = 'SYS';

%%% Início das variáveis de estado.
x{1} = zeros(3,1);       

%%% Passo de integração (h), de amostragem (dt) e tempo total de sim.(T)
h  = 0.001;  
dt = 0.25;
% dt = 0.1;
% dt = 0.025;
T  = 5;                

%%% Variável que executará os parâmetros de ZOH do meu sistema discreto.
i = 0;

%%% Ganhos do LQR do livro -- página 594.
Ki = 1.361;
Ka = -0.0807;
Kq = -0.475;

%%% Após a discretização, os ganhos dos controladores.
k1 = Ki*dt/2;
PI = (1-10*dt/2)/(1+10*dt/2);
k2 = 10*Ka*dt/(10*dt+2);
k3 = Kq;

%%% Sistema em malha fechada.
for k = 1:(T/h)
    
    %%% Entrada tipo 'Degrau Unitário'.
    if (k < (1/h))
        ref(k) = 0;
    else (k < (2/h))
        ref(k) = 1;
    end
    
    %%% Tempo discreto -- iniciando do zero.
    t(k)     = h*(k-1);
    
    %%% Leitura das variáveis de saída no instante 'k'.
    alpha(k) = [57.2958 0 0]*x{k};
    q(k)     = [0 57.2958 0]*x{k};
    
    %%% A cada instante de amostragem, realize o seguinte cálculo.
    if (mod(t(k), dt) == 0)
        i = i+1;
        %%% No instante inicial, quando todas as variáveis ainda não foram
        %%% sequer definidas (como aquelas do instante k-1, por exemplo).
        if (k == 1)         
            e_zoh(i) = ref(k) - q(k);           % Erro de amostragem.
            v1(i)    = k1*e_zoh(k);
            v2(i)    = PI*alpha(k);
            v3(i)    = k3*q(k);    

            % Cálculo do controle a ser aplicado à planta.
            tt(i) = t(k);
            u(i)  = -(v1(i) + v2(i) + v3(i));    
        else
            e_zoh(i) = ref(k) - q(k);           % Erro de amostragem.
            v1(i)    = v1(i-1) + k1*(e_zoh(i) + e_zoh(i-1));
            v2(i)    = PI*v2(i-1) + k2*(alpha(k) + alpha(k-1));
            v3(i)    = k3*q(k);    
        
            % Cálculo do controle a ser aplicado à planta.
            tt(i) = t(k);
            u(i)  = -(v1(i) + v2(i) + v3(i));
        end
    end
    
    % Simulação do sistema linear.
    x{k+1}   = RK4(SISTEMA, t(k), h, x{k}, u(i));
end

%%% Plota o resultado - saída 'q'.
TAM = 2;
plot(t, q, 'LineWidth', TAM); grid;
axis([0 5 -0.5 1.5]);
xlabel('Tempo (s)');
ylabel('Pitch rate - q');

%%% Plota o resultado - controle 'u(k)'.
figure;
stairs(tt, u, 'LineWidth', TAM); grid;
axis([0 5 -0.35 0.01]);
xlabel('Tempo (s)');
ylabel('Controle u(k)');


