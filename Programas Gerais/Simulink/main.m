clear all; close all; clc;

load('to_fft.mat');
a = ans;

data = a.Data;
t    = a.Time;

Y = fft(data);
f = linspace(0,100, max(size(Y)));
plot(f, abs(Y))