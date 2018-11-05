clear all; close all; clc;

G = tf(12, [1 4 7 12]);
bode(G);