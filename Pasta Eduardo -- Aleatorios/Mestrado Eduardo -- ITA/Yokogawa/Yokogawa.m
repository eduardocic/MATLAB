close all; clear; clc;

% -------------------------------------------------------------------------
%                Estabelecendo Comunicação e Criando Grupo.
%
% -------------------------------------------------------------------------
% 1) Me comunicar com quem?
% 2) Uma vez estabelecido como quem se comunicar, se conecte.
% 3) Adiciona um grupo para o objeto de opcda. Um grupo é um container para
%    o usuário que organiza e manipula os itens de dedo.
conexao = opcda('localhost','Yokogawa.ExaopcDASTARDOMFCX.1');
connect(conexao);
grupo   = addgroup(conexao);


% -------------------------------------------------------------------------
%                    Criando itens para o grupo criado.
%
% -------------------------------------------------------------------------

% ATUADORES
% ---------

% (*) Bomba do Tanque 1 
Percentual_bomba1   = additem(grupo,'FCX01!Nivel_TqProcesso.LIC02.MV.Value');
Liga_desliga_bomba1 = additem(grupo,'FCX01!Nivel_TqProcesso.BOMBA_TQ02');

% (*) Bomba do Tanque 2
Percentual_bomba2   = additem(grupo,'FCX01!Nivel_TqAquecimento.LIC01.MV.Value');
Liga_desliga_bomba2 = additem(grupo,'FCX01!Nivel_TqAquecimento.BOMBA_TQ01');

% (*) Bomba entre tanque 1 e 2
Liga_desliga_bomba12 = additem(grupo,'FCX01!Temperat_TqProcesso.BOMBA_TRANSP');

% (*) Válvula de controle de vazão entre 1 e 2
Percentual_valvula_controle = additem(grupo,'FCX01!Temperat_TqProcesso.FIC02.MV.Value');

% (*) Percentual da Potencia Máxima Fornecida pelo aquecedor
Percentual_temperatura = additem(grupo,'FCX01!Temperat_TqAquecimento.TIC02.MV.Value');

% SENSORES
% --------

% (*) Altura tanque 1
Altura_tanque1 = additem(grupo,'FCX01!Nivel_TqProcesso.LIC02.PV.Value');

% (*) Altura tanque 2
Altura_tanque2 = additem(grupo,'FCX01!Nivel_TqAquecimento.LIC01.PV.Value');

% (*) Vazão fornecida pela valvula de controle
Vazao_TQ1_TQ2  = additem(grupo,'FCX01!Temperat_TqProcesso.FIC02.PV.Value');

% (*) Vazao fornecida bomba 1
Vazao_TQ1      = additem(grupo,'FCX01!Nivel_TqProcesso.FI01.PV.Value');

% (*) Temperatura no topo do tanque 1
Temperatura_TQ1_Up  = additem(grupo,'FCX01!Temperat_TqProcesso.TIC01.PV.Value');

% (*) Temperatura da agua que flui entre os tanques 1 e 2
Temperatura_TQ1_TQ2 = additem(grupo,'FCX01!Temperat_TqAquecimento.TIC02.PV.Value');

% (*) Temperatura da agua que entra no tanque 1
Temperatura_TQ1_In  = additem(grupo,'FCX01!Temperat_TqProcesso.TI03.PV.Value');

% (*) Temperatura na base do tanque 1
Temperatura_TQ1_Down = additem(grupo,'FCX01!Temperat_TqProcesso.TI04.PV.Value');

% -------------------------------------------------------------------------
%                    Quais sensores e atuadores utilizar?
%
% -------------------------------------------------------------------------

set(Percentual_bomba1,'active','on');                   % Atuador
set(Liga_desliga_bomba1,'active','on');                 % Chave de Liga e Desliga o Atuador 1
set(Percentual_bomba2,'active','off');                  % Atuador
set(Liga_desliga_bomba2,'active','off');                % Chave de Liga e Desliga o Atuador 2
set(Liga_desliga_bomba12,'active','off');               % Chave de Liga Atuador
set(Percentual_valvula_controle,'active','off');        % 
set(Percentual_temperatura,'active','off');             
set(Altura_tanque1,'active','on');
set(Altura_tanque2,'active','off');
set(Vazao_TQ1_TQ2,'active','off');
set(Vazao_TQ1,'active','off');
set(Temperatura_TQ1_Up,'active','off');
set(Temperatura_TQ1_TQ2,'active','off');
set(Temperatura_TQ1_In,'active','off');
set(Temperatura_TQ1_Down,'active','off');
%%%%%%%%%%%%%
warning off all;
hreg = [];
preg = [];
time = [];
time2 = [];
t=0;
amostragem = 1;%s
numero_pontos = 2000;
write(Liga_desliga_bomba1,1);
% writeasync(Percentual_bomba1,65)
href = 25; % <=============================================================
ek=0;
ek1=0;
ek2=0;
Bk=60;
Bk1=60;
3/16/16 7:27 PM C:\Documents a...\Implementacao_controle.m 3 of 4
Bk2=0;
tic;
for i=1:1:numero_pontos/4
s = read(grupo);
preg = [preg s(1).Value];
hreg = [hreg s(8).Value];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Lei de Controle
Bk = 60;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
time = [time;s(1).TimeStamp];
time2 = [time2;i*amostragem];
write(Percentual_bomba1,Bk);
pause(amostragem-toc);
tic;
end
ek=0;
ek1=0;
for i=501:1:numero_pontos
s = read(grupo);
preg = [preg s(1).Value];
hreg = [hreg s(8).Value];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Lei de Controle
ek = href-hreg(end);
Bk = 1.223*ek - 1.211*ek1 + Bk1;
Bk=min(Bk,100);
Bk=max(Bk,0);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
time = [time;s(1).TimeStamp];
time2 = [time2;i*amostragem];
write(Percentual_bomba1,Bk);
pause(amostragem-toc);
tic;
Bk1=Bk;
ek1=ek;
end
write(Percentual_bomba1,0);
write(Liga_desliga_bomba1,0);
%desconectar o servidor
disconnect(conexao)
3/16/16 7:27 PM C:\Documents a...\Implementacao_controle.m 4 of 4
figure
plot(time2,hreg,'-r',time2,href*ones(size(time2)),'-.k')
hold on;
stairs(time2,preg,'-b')
hold on;
% EOF