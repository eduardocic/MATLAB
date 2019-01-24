clear; close all; clc;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               Inicialização.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 0) Inclui as pastas com as funções.
raiz    = pwd;
subRaiz = {'Funções'; 'LMIs'};

nMax = max(size(subRaiz));
for i = 1:nMax
    rmpath([raiz '\' subRaiz{i,:}]);
    addpath([raiz '\' subRaiz{i,:}]); 
end

% 1) Carrega os dados originais da planta: 
%  --- A, B, C, Umax, tao, R, Rmeio, S e Smeio ---
PreLoad;

% 2) Construção do Politopo - APENAS ATRASO.
[Ad, Bd, Cd] = InsereAtrasos(A, B, C, tao); 

% 2.3) Determinação da Matriz null(H).
H  = MatrizH (Ad);
na = size(H,2);
H  = [H; zeros(1,na)];

% 3) Construção do Politopo - APENAS ATRASO + Integrador.
N = size(Ad,2);
for i=1:N
    [AdI{i}, BdI{i}] = InsereIntegrador(Ad{i}, Bd{i}, Cd);
end
f  = size(Cd,1);
g0 = linspace(0,0,f)';
CdI = [Cd g0];


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                               Preâmbulo.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
K  = 1500;     % Tempo total de Simulação.
Nt = K/Ta;     % Quantidade de Intervalos.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                              Malha Aberta.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:(Nt/4)
    t(i)  = Ta*(i-1);  % Tempo.
    
    up(i) = up_ref;    % Valor esperado p/ Malha Aberta
    hp(i) = hp_ref;    % Valor esperado p/ Malha Aberta 
    
    uk(i) = 0;         % u(k) do modelo.
    ud(i) = 0;         % ud(k) do modelo.
    
    w(i)  = 0;         % Integrador.
    
    yss(i) = 0;        % yss caso exista.
end

% Linha vertical simbolizando o fim da malha aberta.
yv = 100;
xv = t(i);
lineMA_x = [xv xv];
lineMA_y = [0 yv];


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                              Malha Fechada.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Upast  = zeros(tao,1);      %[u(k-1) ... u(k-tao)].
Wpast  = zeros(1,1);        %[w(k)].

theta  = waitbar(0, sprintf('Calculando...', Nt));   % Waitbox.
for i=((Nt/4)+1):(Nt+1)
    
   % 1. Determinação de 'u(k)' e 'w(k)'.
   % -----------------------------------
   [uk(i), w(i), yss(i)] = LMI_Restricao_Assimetrica_Saida(hk, AdI, BdI, CdI, H, Smeio, Rmeio, Umax, ...
                                                           Ylimites, tao, at, Upast, Wpast);
                    
   % 2. Atualização do estado 'h(k)'.
   % --------------------------------
   hk = A*hk + B*Upast(tao_p);         % h(k+1) = A.h(k) + B.u(k-tao_p).
   
   % 3. Atualiza os vetores 'Upast' e 'Wpast'.
   % -----------------------------------------
   if (tao == 1)
       Upast = uk(i);                      % u(k-1);
   else
       Upast = [uk(i); Upast(1:tao-1)];    % [u(k) | u(k-1) ... u(k-tao+1)]. 
   end
   Wpast = w(i);
   
   % 4. Montagem dos Vetores para plotagem de Gráficos.
   % --------------------------------------------------
   ud(i) = 5 + uk(i);
   up(i) = up_ref + ud(i);
   
   hp(i) = 30 + hk;
   t(i)  = Ta*(i-1);
   
   waitbar((i-(Nt/4))/((Nt+1)-(Nt/4))); 
end
close(theta);

% _________________________________________________________________________
%                          Salva o Resultado.
% _________________________________________________________________________

Yoko = struct('t', t, 'up_k', up, 'hp_k', hp, ...
              'u_k', uk, 'ud_k', ud, 'w_k', w, ...
              'yss', yss);                          % struct com as variáveis.

          
% Nome do arquivo.
% ----------------
ntao     = num2str(tao);
Nome1    = strcat('Tao_',ntao);
ntao_p   = num2str(tao_p);
Nome2    = strcat('_Tao_p',ntao_p);
Nome2    = strcat(Nome2,'SIM_Com_Restricao_Saida.mat');
fileName = strcat(Nome1, Nome2);
save(fileName, 'Yoko');

% Plota Resultado.
% ----------------
TAM = 2;

plot(Yoko.t, Yoko.up_k, Yoko.t, Yoko.hp_k, 'LineWidth', TAM); hold on;
plot(lineMA_x,lineMA_y, 'k-.');
xlim([0 t(end)]); ylim([0 100]); 
legend('u_{p}(k)','h_{p}(k)');
