close all; clear all; clc;

% Dinâmica desejada para a resposta lateral.
HQ_p    = 5.0 * tf(2.0,[1 2.0]);
step(HQ_p), title('Desired response from lateral stick to roll rate (Handling Quality)');


% Dinãmica desejara para a resposta de estabilidade.
HQ_beta = -2.5 * tf(1.25^2,[1 2.5 1.25^2]);
step(HQ_beta), title('Desired response from rudder pedal to side-slip angle (Handling Quality)')


% Filtros anti-aliasing.
freq = 12.5 * (2*pi);  % 12.5 Hz
zeta = 0.5;
yaw_filt = tf(freq^2,[1 2*zeta*freq freq^2]);
lat_filt = tf(freq^2,[1 2*zeta*freq freq^2]);

freq = 4.1 * (2*pi);  % 4.1 Hz
zeta = 0.7;
roll_filt = tf(freq^2,[1 2*zeta*freq freq^2]);

AAFilters = append(roll_filt,yaw_filt,lat_filt);


% Limitantes em taxa de variação e de ângulos normalizados para o sistema.
W_act = ss(diag([1/50,1/20,1/60,1/30]));


% Passa altas para caracterizar a entrada de um ruído de medida dos
% sensores.
W_n = append(0.025,tf(0.0125*[1 1],[1 100]),0.025);
clf, bodemag(W_n(2,2)), title('Sensor noise power as a function of frequency')


% Peso para performance dentro dessa região de interesse.
W_p = tf([0.05 2.9 105.93 6.17 0.16],[1 9.19 30.80 18.83 3.95]);
clf, bodemag(W_p), title('Weight on Handling Quality spec')

W_beta = 2*W_p;


% Carrego a dinâmica do meu sistema.
load LateralAxisModel
LateralAxis


% Dinâmica dos atuadores.
A_S = [tf([25 0],[1 25]); tf(25,[1 25])];
A_S.OutputName = {'stab_rate','stab_angle'};

A_R = A_S;
A_R.OutputName = {'rud_rate','rud_angle'};


% Erros normalizados de dinâmica.
Delta_G = ultidyn('Delta_G', [2 2], 'Bound',1.0);


% Comportamento em frequência da dinãmica do erro multiplicativo na entrada
% da planta.
w_1 = tf(2.0*[1 4],[1 160]);
w_2 = tf(1.5*[1 20],[1 200]);
W_in = append(w_1,w_2);

bodemag(w_1,'-',w_2,'--')
title('Relative error on nominal model as a function of frequency');
legend('stabilizer','rudder','Location','NorthWest');


% Modelo da dinâmica das incertezas do atuadores.
Act_unc = append(A_S, A_R) * (eye(2) + W_in*Delta_G);
Act_unc.InputName = {'delta_stab','delta_rud'};

% Dinâmica nominal da planta.
Plant_nom = LateralAxis;
Plant_nom.InputName = {'stab_angle','rud_angle'};

% Connect the two subsystems
Inputs = {'delta_stab','delta_rud'};
Outputs = [A_S.y ; A_R.y ; Plant_nom.y];
Plant_unc = connect(Plant_nom, Act_unc, Inputs,Outputs);


% Pegue 10 amostras randômicas.
Plant_unc_sampl = usample(Plant_unc,10);

% Olhe a resposta para diferentes pontos de beta.
figure('Position', [100, 100, 560, 500])
subplot(211), step(Plant_unc.Nominal(5,1),'r+', Plant_unc_sampl(5,1),'b-',10)
legend('Nominal','Perturbed')

subplot(212), bodemag(Plant_unc.Nominal(5,1),'r+',Plant_unc_sampl(5,1),'b-',{0.001,1e3})
legend('Nominal','Perturbed')


% Dar nomes aos bois.
AAFilters.u = {'p','r','yac'};    AAFilters.y = 'AAFilt';
W_n.u = 'noise';                  W_n.y = 'Wn';
HQ_p.u = 'p_cmd';                 HQ_p.y = 'HQ_p';
HQ_beta.u = 'beta_cmd';           HQ_beta.y = 'HQ_beta';
W_p.u = 'e_p';                    W_p.y = 'z_p';
W_beta.u = 'e_beta';              W_beta.y = 'z_beta';
W_act.u = [A_S.y ; A_R.y];        W_act.y = 'z_act';

% Especifica os blocos de soma.
Sum1 = sumblk('%meas = AAFilt + Wn',{'p_meas','r_meas','yac_meas'});
Sum2 = sumblk('e_p = HQ_p - p');
Sum3 = sumblk('e_beta = HQ_beta - beta');

% Conecta todo mundo.
OLIC = connect(Plant_unc,AAFilters,W_n,HQ_p,HQ_beta,...
   W_p,W_beta,W_act,Sum1,Sum2,Sum3,...
   {'noise','p_cmd','beta_cmd','delta_stab','delta_rud'},...
   {'z_p','z_beta','z_act','p_cmd','beta_cmd','p_meas','r_meas','yac_meas'});


% Por H infinito.
nmeas = 5;		% number of measurements
nctrls = 2;		% number of controls
[kinf,~,gamma_inf] = hinfsyn(OLIC.NominalValue,nmeas,nctrls);
gamma_inf


% Por mu-sintesys
fmu = logspace(-2,2,60);
opt = dksynOptions('FrequencyVector',fmu,'NumberofAutoIterations',5);
[kmu,~,gamma_mu] = dksyn(OLIC,nmeas,nctrls,opt);
gamma_mu


% Malha fechada no entorno de cada um dos loops.
clinf = lft(OLIC,kinf);
clmu = lft(OLIC,kmu);


% Compute worst-case gain as a function of frequency
% opt = wcOptions('VaryFrequency','on');

% Compute worst-case gain (as a function of frequency) for kinf
[mginf, wcuinf, infoinf] = wcgain(clinf);

% Compute worst-case gain for kmu
[mgmu, wcumu, infomu] = wcgain(clmu);


% Análise das respostas de malha fechada.
clf
subplot(211)
f = infoinf.Frequency;
gnom = sigma(clinf.NominalValue,f);
plot(f, gnom(1,:), 'r', f, infoinf.BadUncertainValues.Delta_G, 'b');
title('Performance analysis for kinf')
xlabel('Frequency (rad/sec)')
ylabel('Closed-loop gain');
xlim([1e-2 1e2])
legend('Nominal Plant','Worst-Case','Location','NorthWest');

subplot(212)
f = infomu.Frequency;
gnom = sigma(clmu.NominalValue,f);
plot(f, gnom(1,:), 'r', f, infomu.BadUncertainValues.Delta_G, 'b');
title('Performance analysis for kmu')
xlabel('Frequency (rad/sec)')
ylabel('Closed-loop gain');
xlim([1e-2 1e2])
legend('Nominal Plant','Worst-Case','Location','SouthWest');


% Resposta ao doublet.
kmu.u = {'p_cmd','beta_cmd','p_meas','r_meas','yac_meas'};
kmu.y = {'delta_stab','delta_rud'};

AAFilters.y = {'p_meas','r_meas','yac_meas'};


% Construção das referências.
time = 0:0.02:15;
u_stick = (time>=9 & time<12);
u_pedal = (time>=1 & time<4) - (time>=4 & time<7);

clf
subplot(211), plot(time,u_stick), axis([0 14 -2 2]), title('Lateral stick command')
subplot(212), plot(time,u_pedal), axis([0 14 -2 2]), title('Rudder pedal command')

CLSIM = connect(Plant_unc(5:end,:),AAFilters,kmu,{'p_cmd','beta_cmd'},{'p','beta'});


% Ideal behavior
IdealResp = append(HQ_p,HQ_beta);
IdealResp.y = {'p','beta'};

% Worst-case response
WCResp = usubs(CLSIM,wcumu);

% Compare responses
clf
lsim(IdealResp,'g',CLSIM.NominalValue,'r',WCResp,'b:',[u_stick ; u_pedal],time)
legend('ideal','nominal','perturbed','Location','SouthEast');
title('Closed-loop responses with mu controller KMU')