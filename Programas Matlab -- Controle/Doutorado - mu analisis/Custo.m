function [cost] = Custo(x, Gss_fechado, Wt, Ws)

% Constante determinadas -- valores dos papers.
ki = x(1);
kp = x(2);
kq = x(3);

% Controladores.
Kq = tf(kq,1);
PI = tf([kp ki],[1 0]);

% Entradas e saídas dos controladores.
Kq.u = 'q';      Kq.y = 'out1';
PI.u = 'erro';   PI.y = 'out2';

sum1 = sumblk('erro = ref - an');
sum2 = sumblk('u = out2 - out1');

Kq_otimiza = tf(kq,1);
PI_otimiza = tf([kp ki],[1 0]);

Kq_otimiza.u = 'q';      Kq_otimiza.y = 'out1';
PI_otimiza.u = 'erro';   PI_otimiza.y = 'out2';

% Pesos do sistema.
Ws.u = 'erro';             Ws.y = 'z1';
Wt.u = 'an';               Wt.y = 'z2';

% Fechamento da malha.
ClosedLoopIncerto = connect(Gss_fechado, PI_otimiza, Kq_otimiza,...
                      sum1, sum2, {'ref'}, {'an'});

                  
% A primeira parte -- minimização do mu-sintesis.
opt = robopt('Display', 'on');                  
[MargemEst, DeltasDesestabilizantes, Report, info] = robuststab(ClosedLoopIncerto, opt);

maxSSV = MargemEst.UpperBound;
v1 = 1/maxSSV
 
% Minimização do H-inf.
T0    = connect(Gss_fechado.Nominal, PI_otimiza, Kq_otimiza, Ws, Wt, sum1, sum2, {'ref'}, {'z1','z2'});
gamma = norm(T0,'Inf');
v2    = gamma


cost(1) = v1;
cost(2) = (v2-0.8)^2;
% cost = v2;

end