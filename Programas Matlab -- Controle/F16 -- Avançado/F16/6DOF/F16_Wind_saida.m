function [xd, y] = F16_Wind_saida(x, u, t)

% =========================================================================
%                   INFORMA��ES GERAIS DO AVI�O E CONSTANTES
% 
% 
% -- Informa��es do avi�o em si. Estas infoma��es foram fornecidas no
% inicio da simula��o, mas as mesmas podem ser consultadas na p�gina 633 no
% Apendix A do livro do Lewis.
% =========================================================================
RtoD = 57.29578;            % Variavel de convers�o de Radiano para Graus.
S    = 300;                 % Area das asas.
B    = 30;                  % 'Span', que � a dist�ncia de ponta a ponta 
                            % das asas (wingtip to wingtip).
Cbar = 11.32;               % Corda media.
Xcgr = 0.35;
Hx   = 160.0;

% Coleta de informa��es do vetor de entradas.
throatle = u(1);
elevator = u(2);
aileron  = u(3);
rudder   = u(4);
Xcg      = u(5);


% =========================================================================
%                   PROPRIEDADES DE MASSA E IN�RCIA
% 
% 
% -- No caso do TM, n�o se faz considera��o � sloshing (que � o deslocamen-
%    to interno de flu�do dentro do ve�culo).
% 
% -- Todas as propriedades de massa e in�rcia dependem, obviamente da
%    quantidade de combust�vel (e, no caso do TM, se h� booster ou n�o).
% 
% -- Essas propriedades de massa e in�rcia v�m do CAD e s�o particionadas
%    para um range de combust�vel que vai de 100% (completamente cheio) a
%    0% (completamente vazio). Esse passo � quebrado em uma tabela o qual
%    divide essas componentes de massa e in�rcia em passos 10%. Ademais,
%    esses par�metros s�o referenciados ao nariz do m�ssil.
% 
% -- Altera��es de in�rcia em decorr�ncia de deflex�es de empenas s�o
%    desprezas (obviamente, a depender da modelagem que se deseja fazer,
%    voc� pode fazer esse tipo de inclus�o).
% 
% -- No caso de abertura das asas, foi passado uma tabela o qual contempla
%    a altera��o da matriz de in�rcia e CM do m�ssil.
% 
% -- A ideia � se calcular a posi��o do centro de massa (CM) do m�ssil
%    considerando
% =========================================================================
Jxx   = 9496.0;
Jyy   = 55814.0;
Jzz   = 63100.0;
Jxz   = 982.0;
Jxz2  = Jxz*Jxz;                 % O '2' simboliza o 'square'.
Peso  = 20500;                   % em lbs.
Gd    = 32.17;                   % Gravidade, em lb/s^2.
Massa = Peso/Gd;                 % Massa;

%  Calculos intermedi�rios que ser�o utilizados para o c�lculo final do
%  valor nas Equa��es de Momento.
Gama = (Jxx*Jzz - Jxz2);        % Este 'Gama' diz respeito aquele termo
                                % que entra no "Calculo de Inercia".                                           
Xpq  = Jxz*(Jxx - Jyy + Jzz);
Xqr  = Jzz*(Jzz - Jyy) + Jxz2;
Zpq  = (Jxx - Jyy)*Jxx + Jxz2;
Ypr  = Jzz - Jxx;



% =========================================================================
%                   	A��ES DO VENTO NO SISTEMA
% 
% 
% -- A caracteriza��o do vento � colocada de forma opcional. O porque disso
%    � possibilitar fazer um sistema de simula��o que possibilite trimar o
%    avi�o (ou m�ssil) numa determinada situa��o de voo e tamb�m simular o
%    sistema com ventos. 
% 
% -- O vento entra aqui como forma de possibilitar calcular os �ngulos de
%    ataque (AoA) e de derrapagem (beta) e tamb�m da velocidade total do
%    corpo em rela��o ao vento. 
% 
% -- � importante salientar que a velocidade do vento � sempre um valor
%    positivo e o azimute do mesmo varia de 0� a 360�. Essa informa��es s�o
%    coletadas por um bal�o metereol�gico e est�o direcionadas ao CG do
%    corpo que voa. 
% 
% -- Para expressar esse vetor velocidade em rela��o ao referencial NED.
%    Decomp�e-se esse vetor velocidade do vento de acordo com a seguinte 
%    rela��o matem�tica:
% 
%             Vw_ned = -Vw*[cos(azi_wind) sin(azi_wind) 0]'.
% 
%    em que:
% 
%        * Vw   .......... � o valor absoluto da velocidade do vento obtida
%                          pelo bal�o meteorol�gico.
%        * azi_wind ...... o azimute coletado pelo bal�o meteorol�gico. 
% 
% -- Comumente assume-se que n�o haver� vento na dire��o do eixo 'z'. Isso
%    � posto para o 'vento padr�o'. Caso haja a inser��o de turbul�ncia
%    etc, voc� insere � esse 'vento padr�o' esses valores turbulentos.
% 
% -- Obviamente o pr�ximo passo para se utilizar a informa��o do vento �
%    expressa esse vento no referencial NED no referencial do corpo, pois �
%    a partir da� que voc� consegue expressa os �ngulos de ataque e de
%    derrapagem. Isso � feito por meio de tal rela��o matem�tica:
% 
%                         Vrel = Vb - Bn2b*Vw_ned.
% 
%    em que:
% 
%        * Vb   .......... � a velocidade do corpo. 
%        * Vrel .......... � a velocidade relativa do corpo em rela��o ao
%                          vento.
%        * Bn2b .......... � a matrix de transforma��o do referencial NED
%                          para o referencial do corpo.
% 
if (max(size(u)) > 5)
    xw   = u(6);
    yw   = u(7);
    zw   = u(8);
    
    % Velocidade do vento.
    Vw = [xw, yw, zw]';
else
    Vw = [0 0 0]';
end




% =========================================================================
%                   	DIN�MICA DO SISTEMA 6DOF
% 
% 
% -- A primeira coisa a voc� deve ter em mente � que o par�metro de vento
%    entra apenas para o c�lculo do �ngulo de ataque, derrapagem e da
%    velocidade total do sistema. Ap�s a obten��o dessa informa��es, a
%    ideia � fazer uma busca nas tabelas de derivadas de estabilidade, as
%    quais normalmente s�o apresentadas na forma (Vt x AoA x beta).
%
% -- De posse dessas informa��es que se determinam as for�as nos 3 eixos do
%    sistema, bem como os momentos. 
% 
% -- Ent�o em termos de sequenciamento de equa��es, ser� realizada a
%    seguinte forma:
% 
%       1. Pegar os dados do vetor de estados X. Do jeito que est� montado
%          o vetor de estados ele vem na forma de Velocidade Total (VT),
%          alfa e beta. Num primeiro momento ser� salutar escrever essa
%          decomposi��o de entrada na forma U, V e W (para c�lculos
%          futuros).
% 
%       2. Velocidade do c�lculo relativo entre o corpo e o vento (caso
%          exista vento), para determina��o dos �ngulos de ataque e do
%          �ngulo de derrapagem e velocidade total em rela��o ao vento.
%          Importante para determina��o de Mach e tamb�m press�o din�mica.
% 
%       3. Valida��o da abertura da turbina dado a altitude, velocidade e
%          da manete.
% 
%       4. Determina��o 

%  Parte 1
% ---------
% VT    = x(1);
% alfa  = x(2)*RtoD;     % Em graus.
% beta  = x(3)*RtoD;     % Em graus.
U     = x(1);
V     = x(2);
W     = x(3);
phi   = x(4);
theta = x(5);
psi   = x(6);
P     = x(7);
Q     = x(8);
R     = x(9);
Alt   = x(12);
pow   = x(13);

% if (max(size(u)) > 5)
%     % Velocidade do m�ssil expressa da forma U, V e W.
%     V = [VT*cos(x(2))*cos(x(3)), VT*sin(x(3)), VT*cos(x(3))*sin(x(2))]';    
% end

%  Parte 2
% ---------
Vrel = [U V W]' - Vw;                               % Vetor velocidade relativa.
VT   = sqrt(Vrel(1)^2 + Vrel(2)^2 + Vrel(3)^2);     % Velocidade total.
alfa = atan(Vrel(3), Vrel(1))*RtoD;                 % J� passando para graus.
beta = asin(Vrel(2)/VT)*RtoD;                       % J� passando para graus.
[Mach, Qbar] = ADC(abs(Vrel), Alt);   


%  Parte 3
% ---------
Cpow   = TGear(throatle);
xd(13) = PowerRate(pow, Cpow);
T      = Thrust (pow, Alt, Mach);

%  Parte 4
% ---------
% *   As informa��es de contru��o dos coeficientes que entrar�o na
%   contabilidade total relativa aos coeficientes de Acelera��o e de Momento
%   podem ser encontradas na p�gina 75 do livro do Lewis;
%
% *   Perceba que o termo que est� se calculando neste ponto da etapa 4, diz
%   respeito apenas aos termos que foram LINEARIZADOS em torno da origem. A 
%   partir do c�lculo desses termos, faz-se-� a composi��o deste com os
%   termos que sao multiplicados pelas derivadas de Damping.
Cxt = Cx(alfa, elevator);               
Cyt = Cy(beta, aileron, rudder);        
Czt = Cz(alfa, beta, elevator);         

Dail = aileron/20.0;                    % Delta aileron (aqui j� se encontra "normalizado").
Drdr = rudder/30.0;                     % Delta rudder (aqui j� se encontra "normalizado");

Clt = Cl(alfa, beta) + Dlda(alfa, beta)*Dail + Dldr(alfa, beta)*Drdr;      % Equivalente ao DeltaC Roll.
Cmt = Cm(alfa, elevator);                                                  % Equivalente ao DeltaC Pitch.
Cnt = Cn(alfa, beta) + Dnda(alfa, beta)*Dail + Dndr(alfa, beta)*Drdr;      % Equivalente ao DeltaC Yaw.

% Adiciona as derivadas de amortecimento e arrasto.
TVT = 0.5/VT;
B2V = B*TVT;
Cq  = Cbar*Q*TVT;
D   = Damping(alfa);                 % 'D' � vetor de dimens�o 9.

% Perceba que o termo LINEAR calculado no passo (3) entra como uma
% constante na somat�ria. Os termos que estao sendo multiplicados diz
% respeito aos coeficientes de DAMPING que s�o inseridos apenas no presente
% momento para originar o que seria o "coeficiente global".

Cxt = Cxt + Cq*D(1);
Cyt = Cyt + B2V*(D(2)*R + D(3)*P);
Czt = Czt + Cq*D(4);
Clt = Clt + B2V*(D(5)*R + D(6)*P);
Cmt = Cmt + Cq*D(7) + Czt*(Xcgr - Xcg);
Cnt = Cnt + B2V*(D(8)*R + D(9)*P) - Cyt*(Xcgr - Xcg)*Cbar/B;

% =========================================================================
% 5. Vamos nos preparar para as Equa��es de Estado.

% Cbeta = cos(x(3));      
% U     = VT*cos(x(2))*Cbeta;
% V     = VT*sin(x(3));
% W     = VT*sin(x(2))*Cbeta;

Stheta   = sin(theta); 
Ctheta   = cos(theta);
Sphi     = sin(phi);
Cphi     = cos(phi);
Spsi     = sin(psi);
Cpsi     = cos(psi);
Qs       = Qbar*S;
Qsb      = Qs*B;
Rmqs     = Qs/Massa;
G_ctheta = Gd*Ctheta;            % G cosseno theta
Q_sphi   = Q*Sphi;               % Q seno phi.
Ay       = Rmqs*Cyt;
Az       = Rmqs*Czt;


% =========================================================================
%% 6. Equa��es de For�a.

xd(1) = R*V - Q*W - Gd*Stheta + (Qs*Cxt + T)/Massa;      % Udot
xd(2) = P*W - R*U + G_ctheta*Sphi + Ay;                  % Vdot
xd(3) = Q*U - P*V + G_ctheta*Cphi + Az;                  % Wdot
% DUM  = (U*U + W*W);
% 
% xd(1) = (U*Udot + V*Vdot + W*Wdot)/VT;
% xd(2) = (U*Wdot - W*Udot)/DUM;
% xd(3) = (VT*Vdot - V*xd(1))*Cbeta/DUM;


% =========================================================================
%% 7. Cinem�tica.

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
%% 9. Navega��o.

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

%% 10. Acelera��es
y(1)  = -Az/Gd;             % An
y(2)  = Ay/Gd;              % Alat.


%% Sa�das desejadas 
% Desejo verificar o comportamento com 'An'.
% y(1) = An;

% y(1) = sqrt(U^2 + V^2 + W^2);
y(3) = VT;
% y(4) = 
% y(5) = 

% xa   = 15;          % P�gina 309 do livro do Lewis.
% y(2) = -(Az - xd(8)*xa + P*Q*xa)/Gd;            % an.
% y(3) = y(2) + 12.42*Q;


end