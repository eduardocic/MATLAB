close all; clear all; clc;


% Carrega o sistema.
% ------------------
load_system('main.slx');


% % Pegar os parâmetros do sistema de simulação.
% % --------------------------------------------
% get_param('main/Gain', 'Gain');
% get_param('main/Constant', 'Value');


% Na setagem dos valores, temos de colocar os parametros entre ''.
% ----------------------------------------------------------------
set_param('main/Gain', 'Gain', '2');
set_param('main/Constant', 'Value', '2');


% output = sim('main.slx', 'SaveState','on','StateSaveName','xoutNew',...
%          'SaveOutput','on','OutputSaveName','youtNew');
output = sim('main.slx');