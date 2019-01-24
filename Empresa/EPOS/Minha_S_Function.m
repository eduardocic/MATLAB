function [sys, States0, str, ts] = mpc_ss_du_mimo_restricoes(t, States, Inputs, flag, ...
                                                            Phi,Gn,Hqp,Aqp,dumax,dumin,umax,umin,ymax,ymin,p,q,n,M,N,T)

% -------------------------------------------------------------------------
%   1º Parte
%  ----------
%
% OBS: Maiores informações podem ser obtidas na página 85/548 do documento
%      da MathWorks.
% 
% 'Nome da função' -- função chamada no Simulink (aqui você dá o nome que
%                     lhe bem interessar).
% 't'              -- tempo corrente da simulação.
% 'States'         -- vetor de estados.
% 'Inputs'         -- vetor de entradas.
% 'flag'           -- chamada para a realização de determinada ação.
%
%    2º Parte
%   ----------
%
%   'sys'     -- parâmetro genérico que depende da 'solução' para cada flag
%                chamada.
%   'States0' -- valor inicial dos estados. Tal valor é ignirado para flags
%                diferente de 0.
%   'str'     -- ainda sem aplicação :/
%   'ts'      -- vetor que indica o tempo de amostragem e o tempo de
%                'offset', ou seja, o tempo que você espera para que se
%                inicie a sua s-function.
%                (*) Para tempo contínuo, faça ts = [0 0];
%                (*) Se você quer discreto a cada T, faça ts = [T 0];
%                (*) Maiores informações, página 86/548 do Documento base.
% 
% Input parameters:
% Phi: Column vector (N x 1) --> [CA;CA^2; ... ; CA^N]
% Gn: Normalized Dynamic matrix
% Hqp,Aqp: H,A matrices for use with the Quadprog function
% dumax,dumin,umax,umin,ymax,ymin: Constraints
% M: Control Horizon
% N: Prediction Horizon
% T: Sampling period

switch flag,    
% -------------------------------------------------------------------------
%   Explicação do 'switch - case'
%  -------------------------------
% 
% 0     -- flag chamada antes mesmo de a simulação ser inicializada.
% 2     -- flag chamada para atualização dos estados do sistema.
% 1,4,9 -- flag que não serão por hora utilizadas.
% 3     -- flag chamada para atualização dos cálculos que iremos realizar.
% -------------------------------------------------------------------------
case 0
    [sys,States0,str,ts] = mdlInitializeSizes(T, p, q, n); 
    
case 2
    sys = mdlUpdate(t);
    
case {1,4,9}
    sys = []; 

case 3 

yref = inputs(1:q); % yref(k)
xk   = inputs(q+1:q+n);  % x(k)
uk1  = inputs(q+n+1:end); % u(k-1)

xik = [xk;uk1]; % Estado aumentado xi(k)
    
% Valores futuros de referência
Yref = repmat(yref,N,1);

% Resposta livre
F = Phi*xik;
   
% Cálculo do controle ótimo

bqp = [repmat(dumax,M,1); -repmat(dumin,M,1); repmat((umax - uk1),M,1); repmat((uk1 - umin),M,1); repmat(ymax,N,1) - F; F - repmat(ymin,N,1)];

fqp = 2*Gn'*(F - Yref);

options = optimset('Algorithm','active-set','Display','off');
DUk = quadprog(Hqp,fqp,Aqp,bqp,[],[],[],[],[],options);

sys =  DUk(1:p); % Saída da S-function (incremento nos p controles)

end


function [sys, States0, str, ts] = mdlInitializeSizes(T,p,q,n)
% -------------------------------------------------------------------------
% (*) 1º função a ser chamada antes mesmo de que se inicie o loop de
%     simulação.
%
% (*) É responsável por:
%
%    a) Inicializar uma estrutura que contém as informações a respeito da
%       S-Function a qual estamos desejando simular.
%    b) Setar o númerio e a quantidade de portas de entradas e saídas.
%    c) Especificar o tempo de amostragem do bloco.
%    d) Uma vez feito tudo isso, alocar a memória necessária para tais
%       parâmetros.
%
% Autor: Eduardo H. Santos
% Data:  25/08/2016
% -------------------------------------------------------------------------

% 1.1º Parte - Chame uma estrutura NÃO INICIALIZADA.
sizes = simsizes;
% 1.2º Parte - Especifique cada um dos parâmetros da estrutura criada.
sizes.NumContStates  = 0;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = p;   % du(k)
sizes.NumInputs      = q + n + p; % yref(k), x(k), u(k-1)
sizes.DirFeedthrough = 1;   % Yes
sizes.NumSampleTimes = 1;   % Just one sample time
% 1.3º Parte - Salve os parâmetros recém inicializados.
sys = simsizes(sizes);

% 2º Inicializa a situação inicial do sistema
States0  = [];

% 3º Sempre vazio.
str      = [];

% 4º Vetor de tempo do meu sistema.
ts       = [T 0];
end mdlInitializeSizes


%=======================================================================
% mdlUpdate
% Handle discrete state updates, sample time hits, and major time step
% requirements.
%=======================================================================
%
function sys = mdlUpdate(t)

sys = [];

%end mdlUpdate