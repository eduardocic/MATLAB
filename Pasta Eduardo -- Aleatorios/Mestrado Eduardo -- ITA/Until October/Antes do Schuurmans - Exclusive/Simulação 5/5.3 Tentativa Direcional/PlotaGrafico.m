X1 = ValX.Data(1:end,1);
X2 = ValX.Data(1:end,2);
U  = ValX.Data(1:end,3);
t  = ValX.Time;

n = size(X1,1);


%% Plota o Valor dos Estados.

X1a = X1(1);
X2a = X2(1);

% for i=1:n-1
% %     drawnow;
%     plot(X1a, X2a, 'ro-'); grid on;
%     hold on;
%     X1a = [X1a X1(i+1)];
%     X2a = [X2a X2(i+1)];    
% %     axis([-35 0 -35 0]);
%     pause(0.2);
%     
% end

figure

%% ---------------------------
%  Plota o valor da Entrada U
% ----------------------------

Ua = U(1);

for i=1:n-1
    stairs(Ua, '-'); grid on;
    hold on;
    stem(Ua, 'r','LineStyle', 'none', 'MarkerFaceColor','red');
    axis([1 21 -5 5]);
    
    Ua = [Ua U(i+1)];
    pause(0.2);
end


