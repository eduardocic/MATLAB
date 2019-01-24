function [] = PlotaGrafico(ValX, sinal)

X1 = ValX.Data(1:end,1);
X2 = ValX.Data(1:end,2);
U  = ValX.Data(1:end,3);
t  = ValX.Time;

n = size(X1,1);

if (sinal == 'N')    
    plot(X1, X2, 'ro-', 'MarkerFaceColor','red'); grid on;
    figure;
    stairs(U, '-'); grid on; hold on;
    stem(U, 'r','LineStyle', 'none', 'MarkerFaceColor','red');
else
    X1a = X1(1);
    X2a = X2(1);
    Ua = U(1);

    for i=1:n-1
        plot(X1a, X2a, 'bo-', 'MarkerFaceColor','red'); grid on;
        hold on;
        X1a = [X1a X1(i+1)];
        X2a = [X2a X2(i+1)];    
        pause(0.2);
    end
    
    figure;

    for i=1:n-1
        stairs(Ua, '-'); grid on;
        hold on;
        stem(Ua, 'r','LineStyle', 'none', 'MarkerFaceColor','red');
        % axis([0 21 -6 5]);
    
        Ua = [Ua U(i+1)];
        pause(0.2);
    end
end
