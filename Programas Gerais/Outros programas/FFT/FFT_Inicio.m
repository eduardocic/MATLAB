clear all; close all; clc;

% =========================================================================
% Análise do primeira transformada.
% ----------------------------------

% x  = [0.5 0.5];
% N  = 8192;
% w  = linspace(0, 1, N);
% y  = fft(x, N);
% 
% % Plotagem o módulo.
% plot(w, abs(y));
% title('Módulo da Transformada de Fourier Discreta');
% xlabel('Frequência (rad/s) -- normalizada');
% ylabel('|F(w)|');
% 
% % Plotagem da fase.
% figure;
% plot(w, phase(y));
% title('Fase da Transformada de Fourier Discreta');
% xlabel('Frequência (rad/s) -- normalizada');
% ylabel('|F(w)|');
% =========================================================================


% % =========================================================================
% % Seja uma sequência tal que haja 5 pulsos no sistema apenas, ou seja:
% % x  = [1 1 1 1 1 1];
% % N  = 8192;
% % w  = linspace(0, 1, N);
% % y  = fft(x, N);
% % 
% % % Plotagem o módulo.
% % plot(w, abs(y));
% % title('Módulo da Transformada de Fourier Discreta');
% % xlabel('Frequência (rad/s) -- normalizada');
% % ylabel('|F(w)|');
% % 
% % % Plotagem da fase.
% % figure;
% % plot(w, phase(y));
% % title('Fase da Transformada de Fourier Discreta');
% % xlabel('Frequência (rad/s) -- normalizada');
% % ylabel('Fase F(w)');
% % =========================================================================
% 
% 
% 
% % =========================================================================
% % Seja uma sequência tal que haja 5 pulsos no sistema apenas, ou seja:
% % % x  = [3 5 6 7 7 6 5 3]/42;
% % x  = linspace(1, 1, 101);
% % N  = 512;
% % w  = linspace(0, 1, N);
% % y  = fft(x, N);
% % 
% % % Plotagem o módulo.
% % plot(w, abs(y));
% % title('Módulo da Transformada de Fourier Discreta');
% % xlabel('Frequência (rad/s) -- normalizada');
% % ylabel('|F(w)|');
% % 
% % % Plotagem da fase.
% % figure;
% % plot(w, phase(y));
% % title('Fase da Transformada de Fourier Discreta');
% % xlabel('Frequência (rad/s) -- normalizada');
% % ylabel('Fase F(w)');
% % 
% % %  Filtros FIR -- Especificação em Magnitude (Decibel).
% % num = x;
% % den = 1;
% % H   = tf(num, den, 1);
% % figure;
% % bode(H, {0.1 100});
% % =========================================================================
% 
% 
% 
% % =========================================================================
% % 
% % Janelamento Retangular
% % 
% % =========================================================================
% % Seja uma sequência tal que haja 5 pulsos no sistema apenas, ou seja:
% % M  = 61;
% % for i = 1:(M+1)/2
% %    x(i) = 2*i/M; 
% % end
% % for i = ((M+1)/2 + 1):M
% %    x(i) = 2 - (2*i/M); 
% % end
% M  = 8;
% x  = linspace(1, 1, M);
% N  = 8192;
% w  = linspace(0, 1, N);
% y  = fft(x, N);
% 
% % Plotagem o módulo.
% plot(w, abs(y));
% title('Módulo da Transformada de Fourier Discreta');
% xlabel('Frequência (rad/s) -- normalizada');
% ylabel('|F(w)|');
% 
% % Plotagem da fase.
% figure;
% plot(w, phase(y));
% title('Fase da Transformada de Fourier Discreta');
% xlabel('Frequência (rad/s) -- normalizada');
% ylabel('Fase F(w)');
% 
% %  Filtros FIR -- Especificação em Magnitude (Decibel).
% num = x;
% den = 1;
% H   = tf(num, den, 1);
% figure;
% bode(H, {0 1000});
% % figure;
% % W = linspace(0, pi, max(size(y)));
% % plot(W, 20*log10(abs(y)));



% =========================================================================
% 
% Janelamento Triangular ou de Barlett.
% 
% =========================================================================
% Seja uma sequência tal que haja 5 pulsos no sistema apenas, ou seja:
M  = 61;
for i = 0:(M+1)/2
   x(i+1) = 2*i/M; 
end
x1 = flip(x);
x1 = x1(2:end);
x  = [x x1];
clear x1;
N  = 8192;
w  = linspace(0, 1, N);
y  = fft(x, N);

% Plotagem o módulo.
plot(w, abs(y));
title('Módulo da Transformada de Fourier Discreta');
xlabel('Frequência (rad/s) -- normalizada');
ylabel('|F(w)|');

% Plotagem da fase.
figure;
plot(w, phase(y));
title('Fase da Transformada de Fourier Discreta');
xlabel('Frequência (rad/s) -- normalizada');
ylabel('Fase F(w)');

%  Filtros FIR -- Especificação em Magnitude (Decibel).
num = x;
den = 1;
H   = tf(num, den, 0.5);
figure;
bode(H, {0 1000});


% % =========================================================================
% % 
% % Janelamento Hanning
% % 
% % =========================================================================
% % Seja uma sequência tal que haja 5 pulsos no sistema apenas, ou seja:
% M  = 61;
% for i = 0:M
%    h(i+1) = 0.5 - 0.5*cos(2*pi*i/M); 
% end
% N  = 8192;
% w  = linspace(0, 1, N);
% y  = fft(h, N);
% 
% % Plotagem o módulo.
% plot(w, abs(y));
% title('Módulo da Transformada de Fourier Discreta');
% xlabel('Frequência (rad/s) -- normalizada');
% ylabel('|F(w)|');
% 
% % Plotagem da fase.
% figure;
% plot(w, phase(y));
% title('Fase da Transformada de Fourier Discreta');
% xlabel('Frequência (rad/s) -- normalizada');
% ylabel('Fase F(w)');
% 
% %  Filtros FIR -- Especificação em Magnitude (Decibel).
% num = h;
% den = 1;
% H   = tf(num, den, 1);
% figure;
% bode(H, {0 1000});
