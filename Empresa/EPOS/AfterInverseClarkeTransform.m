function [Vref, Setor, Angulo] = AfterInverseClarkeTransform(Va_ref, Vb_ref)

%%% 1º Módulo
Vref = sqrt(Valfa_ref^2 + Vbeta_ref^2);

%%% 2º Ângulo para definição do setor
Ang = atan2(Vb_ref, Va_ref);
Ang = Ang*180/pi;
Ang = mod(Ang,360);

if ((Ang >= 0) && (Ang <60))
    Setor = 1;
elseif((Ang >= 60) && (Ang <120))
    Setor = 2;
elseif((Ang >= 120) && (Ang <180))
    Setor = 3;
elseif((Ang >= 180) && (Ang <240))
    Setor = 4;
elseif((Ang >= 240) && (Ang <=300))
    Setor = 5;
elseif((Ang >= 300) && (Ang <360))
    Setor = 6;
elseif (Ang == 360)
    Setor = 1;
end

%%% 3º Ângulo no setor (em radiano)
Angulo = mod(Ang, 60)*pi/180;



end