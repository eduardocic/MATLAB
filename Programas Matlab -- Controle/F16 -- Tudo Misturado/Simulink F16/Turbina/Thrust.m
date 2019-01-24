function THRUST = Thrust (Pow, Altitude, RMach)
% Modelo da turbina.


% A tabela A est� OK!!!!
A = [  1060.0   670.0   880.0   1140.0   1500.0  1860.0;
        635.0   425.0   690.0   1010.0   1330.0  1700.0;
         60.0    25.0   345.0    755.0   1130.0  1525.0;
      -1020.0  -710.0  -300.0    350.0    910.0  1360.0;
      -2700.0 -1900.0 -1300.0   -247.0    600.0  1100.0;
      -3600.0 -1400.0  -595.0   -342.0   -200.0   700.0];

% A tabela B est� OK!!!!
B = [  12680.0   9150.0  6200.0  3950.0  2450.0  1400.0;
       12680.0   9150.0  6313.0  4040.0  2470.0  1400.0;
       12610.0   9312.0  6610.0  4290.0  2600.0  1560.0;
       12640.0   9839.0  7090.0  4660.0  2840.0  1660.0;
       12390.0  10176.0  7750.0  5320.0  3250.0  1930.0;
       11680.0   9848.0  8050.0  6100.0  3800.0  2310.0;];
 
% A tabela C est� OK!!!
C = [ 20000.0  15000.0  10800.0   7000.0  4000.0  2500.0;
      21420.0  15700.0  11225.0   7323.0  4435.0  2600.0;
      22700.0  16860.0  12250.0   8154.0  5000.0  2835.0;
      24240.0  18910.0  13760.0   9285.0  5700.0  3215.0;
      26070.0  21075.0  15975.0  11115.0  6860.0  3950.0;
      28886.0  23319.0  18300.0  13484.0  8642.0  5057.0;];
  
H = 0.0001*Altitude;
I = fix(H);               % int(H).  
if (I >= 5)
    I = 4;
end
DH = H - I;               % DH = H - float(H).

RM = 5*RMach;
M = fix(RM);              % int(M).
if (M >= 5)
    M = 4;
end
DM  = RM - M;              % DM = RM - float(M).
CDH = 1 - DH;              % Complementar de DH para que da 1.

% -------------------------------------------------------------------------
% Compensacao de linhas e colunas.
I = I + 1;
M = M + 1;
% -------------------------------------------------------------------------

% S = B(I, M)*CDH + B(I+1, M)*DH;
% T = B(I, M+1)*CDH + B(I+1, M+1)*DH;
% Tmil  = S + (T-S)*DM;
% 
% if (Pow < 50)
%     S = A(I, M)*CDH + A(I+1, M)*DH;
%     T = A(I, M+1)*CDH + A(I+1, M+1)*DH;
%     Tidl = S + (T-S)*DM;
%     THRUST = Tidl + (Tmil - Tidl)*Pow*0.02;
% else
%     S = C(I, M)*CDH + C(I+1, M)*DH;
%     T = C(I, M+1)*CDH + C(I+1, M+1)*DH;
%     Tmax = S + (T-S)*DM;
%     THRUST = Tmil + (Tmax - Tmil)*(Pow - 50)*0.02;
% end
    

S = B(M, I)*CDH + B(M, I+1)*DH;
T = B(M+1, I)*CDH + B(M+1, I+1)*DH;
Tmil  = S + (T-S)*DM;

if (Pow < 50)
    S = A(M, I)*CDH + A(M, I+1)*DH;
    T = A(M+1, I)*CDH + A(M+1, I+1)*DH;
    Tidl = S + (T-S)*DM;
    THRUST = Tidl + (Tmil - Tidl)*Pow*0.02;
else
    S = C(M, I)*CDH + C(M, I+1)*DH;
    T = C(M+1, I)*CDH + C(M+1, I+1)*DH;
    Tmax = S + (T-S)*DM;
    THRUST = Tmil + (Tmax - Tmil)*(Pow - 50)*0.02;
end


end