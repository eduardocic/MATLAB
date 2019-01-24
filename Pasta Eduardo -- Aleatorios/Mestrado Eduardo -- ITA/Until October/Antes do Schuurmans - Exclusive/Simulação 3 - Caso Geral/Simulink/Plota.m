X1 = ValX.Data(1:end,1);
X2 = ValX.Data(1:end,2);
% plot(X1,X2); grid;
% xlabel('X1');
% ylabel('X2');

% figure;
X1ss = ValXss.Data(1:end,1)
X2ss = ValXss.Data(1:end,2)
% plot(X1ss,X2ss); grid;
% xlabel('X1ss');
% ylabel('X2ss');

% plot(X1,X2, X1ss, X2ss)
n = size(X1ss,1);
X1a = X1(1);
X2a = X2(1);
X1ssa = X1ss(1);
X2ssa = X2ss(1);
for i=1:n-1
%     drawnow;
    plot(X1a,X2a,'b*',X1ssa,X2ssa,'r+');
    hold on;
    X1a = [X1a X1(i+1)];
    X2a = [X2a X2(i+1)];
    X1ssa = [X1ssa X1ss(i+1)];
    X2ssa = [X2ssa X2ss(i+1)];
    
%     axis([-35 0 -35 0]);
    pause(0.2);
end