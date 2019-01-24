clear all; close all; clc;

load('Kd.mat');
load('Kp.mat');

[kp, kd] = CoeficientesControladores_Interpolados(Kp, Kd, 440, 1200)