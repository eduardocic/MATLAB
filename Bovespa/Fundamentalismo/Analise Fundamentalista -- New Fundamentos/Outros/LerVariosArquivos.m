clear; close all; clc;

Arquivo  = dir('*.mat');
N        = max(size(Arquivo));

for i = 1:N
   load(Arquivo(i).name);       % Carrega todos os arquivos.
end

clear i Arquivo
