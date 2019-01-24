load('Resultado.mat');

%%% Pega os resultados parciais.
xk = Result.xk;
uk = Result.uk;

%%% Variáveis do plano de fases.
xk1 = xk(1,1:end);
xk2 = xk(2,1:end);

dt = 0.2;           % intervalo do 'comet'.
axis([-200 500 -30 30]); hold on; grid;
xlabel('x_1(k)');
ylabel('x_2(k)');
comet(xk1, xk2, dt);


