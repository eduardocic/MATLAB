close all; clear; clc;

% _________________________________________________________________________
%                Carrega Arquivos Base para Simulação.
% _________________________________________________________________________
F1_MatrizesDeEstado;                % Carrega as Matrizes A, B e C.
F2_Constantes;                      % Matrizes 'R' e 'S' + 'tao' + 'T'.  
F3_RestricoesECondicoesIniciais;    % Umax e zk0.


% _________________________________________________________________________
%                Construção do Politopo - APENAS ATRASO.
% _________________________________________________________________________
[Adelay, Bdelay, Cdelay] = InsereAtrasos(A, B, C, tao);  


% _________________________________________________________________________
%              Construção do Politopo - ATRASO + INTEGRADOR.
% _________________________________________________________________________
N = max(size(Adelay{1}));     
for i=1:N
    [AdI{i}, BdI{i}] = InsereIntegrador(Adelay{i}, Bdelay{i}, Cdelay);
end


% _________________________________________________________________________
%                       Inicializa u(k)'s e w(k).
% _________________________________________________________________________
Upast  = -5*ones(tao,1);   %[u(k-1) ... u(k-tao)].
Wpast  = zeros(1,1);       %[w(k)].


% _________________________________________________________________________
%                          Realiza a Simulação.
% _________________________________________________________________________
K  = 1000;       % Tempo total de Simulação.
Passos = K/T;    % Quantidade de Intervalos.

U = [];
W = [];
Z = [];
t = [];

h  = waitbar(0, sprintf('Calculando...', Passos));   % Waitbox.
for i=1:(Passos+1)
    
   % 1. Determinação de 'u(k)' e 'w(k)'.
   [uk, wk] = LMI_Com_Delay_Integrador(zk, AdI, BdI, Cdelay, Smeio, ...
                                       Rmeio, Umax, tao, Upast, Wpast);
   
   % 2. Atualização do estado 'z(k)'.
   zk = A*zk + B*Upast(tao_p);      % z(k+1) = A.z(k) + B.u(k-tao_p)
   
   
   Upast = [uk; Upast(1:tao-1)];    % [u(k) | u(k-1) ... u(k-tao+1)].
   Wpast = wk;                      % [w(k)].
   
   % 3. Montagem dos Vetores para plotagem de Gráficos.
   U = [U uk];
   W = [W wk];
   Z = [Z zk];
   t = [t i*T];
   
   waitbar(i/Passos); 
end
close(h);
h = msgbox('Terminou a Simulação.');

% _________________________________________________________________________
%                          Salva o Resultado.
% _________________________________________________________________________
Yoko = struct('t', t, 'U', U, 'W', W, 'Z', Z);   % struct com as variáveis.
save('Resultado.mat', 'Yoko');

% _________________________________________________________________________
%                          Plota o Resultado.
% _________________________________________________________________________

%%% Carrega o resultado.
clear; close all; clc;
load('Resultado.mat');




