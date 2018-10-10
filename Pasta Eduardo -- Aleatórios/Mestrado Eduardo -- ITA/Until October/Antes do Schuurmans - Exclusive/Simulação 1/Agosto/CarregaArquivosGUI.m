% clear; close all; clc;
%% 0.: Determinação dos Arquivos do Sistema.
MatrizesEspacoEstados;
[n, p, qA, qB, N] = ProcessamentoMatrizesEstado(A, B);

%% 1.: Arquivo Sem_Restricao
file1 = load('Sem_Restricao.mat');
SemRestricao = file1.SemRestricao;

% 1.a) Variáveis do Arquivo 'SemRestricao.mat'.
TempoSemRestricao = SemRestricao(1,:)';
uSemRestricao     = SemRestricao(2,:)';
xkSemRestricao    = SemRestricao(3:4,:)';
FSemRestricao     = SemRestricao(5:6,:)';




%% 2.: Arquivo Com_Restricao
file2 = load('Com_Restricao.mat');
ComRestricao = file2.ComRestricao;

% 1.a) Variáveis do Arquivo 'SemRestricao.mat'.
TempoComRestricao = ComRestricao(1,:)';
uComRestricao     = ComRestricao(2,:)';
xkComRestricao    = ComRestricao(3:4,:)';
FComRestricao     = ComRestricao(5:6,:)';


%% 3.: Arquivo Xss_Sem_Restricao
file3 = load('Xss_Sem_Restricao.mat');
XssSemRestricao = file3.XssSemRestricao;

% 1.a) Variáveis do Arquivo 'SemRestricao.mat'.
TempoXssSemRestricao = XssSemRestricao(1,:)';
uXssSemRestricao     = XssSemRestricao(2,:)';
xkXssSemRestricao    = XssSemRestricao(3:4,:)';
xssXssSemRestricao   = XssSemRestricao(5:6,:)';
FXssSemRestricao     = XssSemRestricao(7:8,:)';





