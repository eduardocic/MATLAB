function [sys, States0, str, ts] = mpc_ss_du_mimo_restricoes(t, States, Inputs, flag, ...
                                                            Phi,Gn,Hqp,Aqp,dumax,dumin,umax,umin,ymax,ymin,p,q,n,M,N,T)

% -------------------------------------------------------------------------
%   1� Parte
%  ----------
%
% OBS: Maiores informa��es podem ser obtidas na p�gina 85/548 do documento
%      da MathWorks.
% 
% 'Nome da fun��o' -- fun��o chamada no Simulink (aqui voc� d� o nome que
%                     lhe bem interessar).
% 't'              -- tempo corrente da simula��o.
% 'States'         -- vetor de estados.
% 'Inputs'         -- vetor de entradas.
% 'flag'           -- chamada para a realiza��o de determinada a��o.
%
%    2� Parte
%   ----------
%
%   'sys'     -- par�metro gen�rico que depende da 'solu��o' para cada flag
%                chamada.
%   'States0' -- valor inicial dos estados. Tal valor � ignirado para flags
%                diferente de 0.
%   'str'     -- ainda sem aplica��o :/
%   'ts'      -- vetor que indica o tempo de amostragem e o tempo de
%                'offset', ou seja, o tempo que voc� espera para que se
%                inicie a sua s-function.
%                (*) Para tempo cont�nuo, fa�a ts = [0 0];
%                (*) Se voc� quer discreto a cada T, fa�a ts = [T 0];
%                (*) Maiores informa��es, p�gina 86/548 do Documento base.
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
%   Explica��o do 'switch - case'
%  -------------------------------
% 
% 0     -- flag chamada antes mesmo de a simula��o ser inicializada.
% 2     -- flag chamada para atualiza��o dos estados do sistema.
% 1,4,9 -- flag que n�o ser�o por hora utilizadas.
% 3     -- flag chamada para atualiza��o dos c�lculos que iremos realizar.
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
    
% Valores futuros de refer�ncia
Yref = repmat(yref,N,1);

% Resposta livre
F = Phi*xik;
   
% C�lculo do controle �timo

bqp = [repmat(dumax,M,1); -repmat(dumin,M,1); repmat((umax - uk1),M,1); repmat((uk1 - umin),M,1); repmat(ymax,N,1) - F; F - repmat(ymin,N,1)];

fqp = 2*Gn'*(F - Yref);

options = optimset('Algorithm','active-set','Display','off');
DUk = quadprog(Hqp,fqp,Aqp,bqp,[],[],[],[],[],options);

sys =  DUk(1:p); % Sa�da da S-function (incremento nos p controles)

end


function [sys, States0, str, ts] = mdlInitializeSizes(T,p,q,n)
% -------------------------------------------------------------------------
% (*) 1� fun��o a ser chamada antes mesmo de que se inicie o loop de
%     simula��o.
%
% (*) � respons�vel por:
%
%    a) Inicializar uma estrutura que cont�m as informa��es a respeito da
%       S-Function a qual estamos desejando simular.
%    b) Setar o n�merio e a quantidade de portas de entradas e sa�das.
%    c) Especificar o tempo de amostragem do bloco.
%    d) Uma vez feito tudo isso, alocar a mem�ria necess�ria para tais
%       par�metros.
%
% Autor: Eduardo H. Santos
% Data:  25/08/2016
% -------------------------------------------------------------------------

% 1.1� Parte - Chame uma estrutura N�O INICIALIZADA.
sizes = simsizes;
% 1.2� Parte - Especifique cada um dos par�metros da estrutura criada.
sizes.NumContStates  = 0;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = p;   % du(k)
sizes.NumInputs      = q + n + p; % yref(k), x(k), u(k-1)
sizes.DirFeedthrough = 1;   % Yes
sizes.NumSampleTimes = 1;   % Just one sample time
% 1.3� Parte - Salve os par�metros rec�m inicializados.
sys = simsizes(sizes);

% 2� Inicializa a situa��o inicial do sistema
States0  = [];

% 3� Sempre vazio.
str      = [];

% 4� Vetor de tempo do meu sistema.
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