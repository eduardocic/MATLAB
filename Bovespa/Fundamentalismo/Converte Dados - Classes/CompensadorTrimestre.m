clc; close all;

Campos = fieldnames(t1.T4);
n      = size(Campos,1);

for i=3:n
    o.T4.(Campos{i}) = t3.T4.(Campos{i}) - t2.T4.(Campos{i}) - t1.T4.(Campos{i});
end
