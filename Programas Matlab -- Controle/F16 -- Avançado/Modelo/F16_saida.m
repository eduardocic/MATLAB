function [xd, y] = F16_saida(x, u, t)

% -------------------------------------------------------------------------
% a) Propriedades de Massa.
Jxx   = 9496.0;
Jyy   = 55814.0;
Jzz   = 63100.0;
Jxz   = 982.0;
Jxz2  = Jxz*Jxz;                 % O '2' simboliza o 'square'.
Peso  = 20500;                   % em lbs.
Gd    = 32.17;                   % Gravidade, em lb/s^2.
Massa = Peso/Gd;                 % Massa;

% -------------------------------------------------------------------------
% b) Calculos intermediários que serão utilizados para o cálculo final do
%    valor nas Equações de Momento.

Gama = (Jxx*Jzz - Jxz2);        % Este 'Gama' diz respeito aquele termo que entra no "Calculo de Inercia".                                           
Xpq  = Jxz*(Jxx - Jyy + Jzz);
Xqr  = Jzz*(Jzz - Jyy) + Jxz2;
Zpq  = (Jxx - Jyy)*Jxx + Jxz2;
Ypr  = Jzz - Jxx;

% -------------------------------------------------------------------------
% c) Informações do avião em si. Estas infomações foram fornecidas no
% inicio da simulação, mas as mesmas podem ser consultadas na página 633 no
% Apendix A do livro do Lewis.

S    = 300;                    % Area das asas
B    = 30;                     % 'Span', que é a distância de ponta a ponta das asas (wingtip to wingtip).
Cbar = 11.32;                  % Corda media.
Xcgr = 0.35;
Hx   = 160.0;

% -------------------------------------------------------------------------
% d) Abertura do vetor de entrada.
throatle = u(1);
elevator = u(2);
aileron  = u(3);
rudder   = u(4);
Xcg      = u(5);
if (max(size(u)) > 5)
    xw   = u(6);
    yw   = u(7);
    zw   = u(8);
    Vw   = [xw yw zw];
end


% -------------------------------------------------------------------------
% e) Variavel de conversão de radiano para graus 
RtoD = 57.29578;   

% *************************************************************************
%% 1. Carregamento dos Vetores e Variaveis de Controle.

VT    = x(1);
alfa  = x(2)*RtoD;               % Aqui já trabalhando com graus.
beta  = x(3)*RtoD;               % Aqui já trabalhando com graus.
phi   = x(4);
theta = x(5);
psi   = x(6);
P     = x(7);
Q     = x(8);
R     = x(9);
Alt   = x(12);
pow   = x(13);


% =========================================================================
%% 2. Carrega os dados do ar e modelo.

[Mach, Qbar] = ADC(VT, Alt);

Cpow   = TGear(throatle);
xd(13) = PowerRate(pow, Cpow);
T      = Thrust (pow, Alt, Mach);


% =========================================================================
%% 3. Procura nas tabelas e constroi componentes.
%
% *   As informações de contrução dos coeficientes que entrarão na
%   contabilidade total relativa aos coeficientes de Aceleração e de Momento
%   podem ser encontradas na página 75 do livro do Lewis;
%
% *   Perceba que o termo que está se calculando neste ponto da etapa 3, diz
%   respeito apenas aos termos que foram LINEARIZADOS em torno da origem. A 
%   partir do calculo desses termos, faz-se-á a composição deste com os
%   termos que sao multiplicados pelas derivadas de Damping.
% -------------------------------------------------------------------------
Cxt = Cx(alfa, elevator);               % Cx Total.
Cyt = Cy(beta, aileron, rudder);        % Cy Total.
Czt = Cz(alfa, beta, elevator);         % Cz Total.

Dail = aileron/20.0;                    % Delta aileron (aqui já se encontra "normalizado").
Drdr = rudder/30.0;                     % Delta rudder (aqui já se encontra "normalizado");

Clt = Cl(alfa, beta) + Dlda(alfa, beta)*Dail + Dldr(alfa, beta)*Drdr;      % Equivalente ao DeltaC Roll.
Cmt = Cm(alfa, elevator);                                                  % Equivalente ao DeltaC Pitch.
Cnt = Cn(alfa, beta) + Dnda(alfa, beta)*Dail + Dndr(alfa, beta)*Drdr;      % Equivalente ao DeltaC Yaw.

% =========================================================================
%% 4. Adiciona as derivadas de amortecimento e arrasto.

TVT = 0.5/VT;
B2V = B*TVT;
Cq  = Cbar*Q*TVT;
D   = Damping(alfa);                 % 'D' é vetor de dimensão 9.

% Perceba que o termo LINEAR calculado no passo (3) entra como uma
% constante na somatária. Os termos que estao sendo multiplicados diz
% respeito aos coeficientes de DAMPING que são inseridos apenas no presente
% momento para originar o que seria o "coeficiente global".

Cxt = Cxt + Cq*D(1);
Cyt = Cyt + B2V*(D(2)*R + D(3)*P);
Czt = Czt + Cq*D(4);
Clt = Clt + B2V*(D(5)*R + D(6)*P);
Cmt = Cmt + Cq*D(7) + Czt*(Xcgr - Xcg);
Cnt = Cnt + B2V*(D(8)*R + D(9)*P) - Cyt*(Xcgr - Xcg)*Cbar/B;

% =========================================================================
%% 5. Vamos nos preparar para as Equações de Estado.

Cbeta = cos(x(3));      
U     = VT*cos(x(2))*Cbeta;
V     = VT*sin(x(3));
W     = VT*sin(x(2))*Cbeta;

Stheta = sin(theta); 
Ctheta = cos(theta);
Sphi   = sin(phi);
Cphi   = cos(phi);
Spsi   = sin(psi);
Cpsi   = cos(psi);
Qs     = Qbar*S;
Qsb    = Qs*B;
Rmqs   = Qs/Massa;
G_ctheta = Gd*Ctheta;            % G cosseno theta
Q_sphi   = Q*Sphi;               % Q seno phi.
Ay     = Rmqs*Cyt;
Az     = Rmqs*Czt;


% =========================================================================
%% 6. Equaçãoes de Força.

Udot = R*V - Q*W - Gd*Stheta + (Qs*Cxt + T)/Massa;
Vdot = P*W - R*U + G_ctheta*Sphi + Ay;
Wdot = Q*U - P*V + G_ctheta*Cphi + Az;
DUM  = (U*U + W*W);

xd(1) = (U*Udot + V*Vdot + W*Wdot)/VT;
xd(2) = (U*Wdot - W*Udot)/DUM;
xd(3) = (VT*Vdot - V*xd(1))*Cbeta/DUM;


% =========================================================================
%% 7. Cinemática.

xd(4) = P + (Stheta/Ctheta)*(Q_sphi + R*Cphi);
xd(5) = Q*Cphi - R*Sphi;
xd(6) = (Q_sphi + R*Cphi)/Ctheta;


% =========================================================================
%% 8. Momentos.

Roll  = Qsb*Clt;
Pitch = Qs*Cbar*Cmt;
Yaw   = Qsb*Cnt;
PQ    = P*Q;
QR    = Q*R;
QHX   = Q*Hx;

xd(7) = (Xpq*PQ - Xqr*QR + Jzz*Roll + Jxz*(Yaw + QHX))/Gama;
xd(8) = (Ypr*P*R - Jxz*(P*P - R*R) + Pitch - R*Hx)/Jyy;
xd(9) = (Zpq*PQ - Xpq*QR + Jxz*Roll + Jxx*(Yaw + QHX))/Gama;

% =========================================================================
%% 9. Navegação.

T1 = Sphi*Cpsi;               % sin(PHI)*cos(PSI).
T2 = Cphi*Stheta;             % cos(PHI)*sin(THETA).
T3 = Sphi*Spsi;               % sin(PHI)*sin(PSI).
S1 = Ctheta*Cpsi;             % cos(THETA)*cos(PSI).
S2 = Ctheta*Spsi;             % cos(THETA)*sin(PSI).
S3 = T1*Stheta - Cphi*Spsi;   % sin(PHI)*cos(PSI)*sin(THETA) - cos(PHI)*sin(PSI).
S4 = T3*Stheta + Cphi*Cpsi;   % sin(PHI)*sin(PSI)*sin(THETA) + cos(PHI)*cos(PSI).
S5 = Sphi*Ctheta;             % sin(PHI)*cos(THETA).
S6 = T2*Cpsi + T3;            % cos(PHI)*sin(THETA)*cos(PSI) + sin(PHI)*sin(PSI).
S7 = T2*Spsi - T1;            % cos(PHI)*sin(THETA)*sin(PSI) - sin(PHI)*cos(PSI).
S8 = Cpsi*Ctheta;             % cos(PSI)*cos(THETA).  

xd(10) = U*S1 + V*S3 + W*S6;      % Velocidade de Norte.
xd(11) = U*S2 + V*S4 + W*S7;      % Velocidade de Leste.
xd(12) = U*Stheta - V*S5 - W*S8;  % Velocidade Vertical.

%% 10. Acelerações

An    = -Az/Gd;
Alat  = Ay/Gd;



%% Saídas desejadas 
% Desejo verificar o comportamento com 'An'.
% y(1) = An;

% y(1) = sqrt(U^2 + V^2 + W^2);
y(1) = VT;

xa   = 15;          % Página 309 do livro do Lewis.
y(2) = -(Az - xd(8)*xa + P*Q*xa)/Gd;            % an.
y(3) = y(2) + 12.42*Q;


end