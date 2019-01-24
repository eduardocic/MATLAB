function [sys, x0, str, ts] = sfunction_F16(t, x, u, flag, x_init)
% =========================================================================
%    ENTRADAS
%   ----------
% 
% t ............. Vari�vel de tempo;
% x ............. Um vetor coluna com as vari�veis de estado;
% u ............. Um vetor coluna com as vari�veis de entrada (cujo valores
%                 normalmente v�m de outros blocos do Simulink);
% flag .......... Indicador que informa qual grupo de informa��es ser�o
%                 calculados/requisitados pelo Simulink; e
% x_init ........ Par�metro adicional fornecido pelo projetista (no caso a
%                 'condi��o inicial'). Outros par�metros podem vir seguidos
%                 a partir do 'x_init', e a ordem com que eles est�o
%                 chegando na fun��o importa.
%
%    SA�DAS
%   --------
% 
% sys ........... Vetor principal com os resultados solicitados pelo
%                 Simulink.
% x0 ............ Vetor coluna com as condi��es iniciais (solicitado apenas
%                 quando FLAG = 0).
% str ........... Vetor deve ser setado como NULL. Est� reservado para
%                 futuras vers�es do Simulink (solicitado apenas quando
%                 FLAG = 0).
% ts ............ Um array de duas colunas para especificar: 1) o tempo de
%                 amostragem e 2) o offset de tempo (solicitado apenas
%                 quando FLAG = 0).
% 
%
% OBS 1: No caso de ter simula��o apenas envolvendo TEMPO CONT�NUO, o
%        par�metro 'ts' ser� setado como [0 0];
%
% OBS 2: No caso de ter simula��o apenas envolvendo TEMPO DISTRETO, o
%        par�metro 'ts' ser� setado como [T 0], sendo 'T' o per�odo de
%        amostragem escolhido pelo projetista.
% =========================================================================

switch flag,

  % 1. Inicializa��o
  % -----------------
  case 0,
    str = [];
    ts  = [0 0];
    x0  = x_init;

    sizes = simsizes;   
    sizes.NumContStates  = 13;                   
    sizes.NumDiscStates  = 0;                       
    sizes.NumOutputs     = 13;   
    sizes.NumInputs      = 5;   
    sizes.DirFeedthrough = 0;
    sizes.NumSampleTimes = 1;                   
    
    sys = simsizes(sizes);
    
    
  % 2. Derivadas
  % -------------
  case 1,
    [sys, ~] = F16_saida(x, u, t);
  
  
  % 3. Outputs do sistema.
  % ----------------------
  case 3,
     sys = x;  
   
   
  % 4. 'Flags' n�o utilizadas.
  % --------------------------
  case {2, 4, 9},
     sys = [];
  
end