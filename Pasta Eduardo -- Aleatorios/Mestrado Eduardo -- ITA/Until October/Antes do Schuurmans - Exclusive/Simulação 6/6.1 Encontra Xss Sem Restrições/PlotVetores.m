Ui = linspace(-Umax, Umax, 101);

nUi = size(Ui,2);


%% Vetor A1
x01 = [0 0];
for i=1:nUi
    x1 = A1*xk0 + B*Ui(i);
    x01 = [x01; x1']; 
end
x01 = x01(2:end,1:end);

%% Vetor A2
x02 = [0 0];
for i=1:nUi
    x2 = A2*xk0 + B*Ui(i);
    x02 = [x02; x2']; 
end
x02 = x02(2:end,1:end);



%% Vetor Diferenças

for i=1:nUi
  Dif1(i,:) = x01(i,:) - xk0';
  Dif2(i,:) = x02(i,:) - xk0';
    
end