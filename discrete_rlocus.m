close all; clear all; clc;

T = linspace(0, 100, 1001);
a = linspace(-1, -15, 15);
b = linspace(1, 1, 11);

for i = 1:max(size(a))
   for k = 1:max(size(b))
      z  = exp((a(i) + j*b(k))*T);
      R  = real(z);
      Im = imag(z);
      plot(R, Im); hold on;
   end
end