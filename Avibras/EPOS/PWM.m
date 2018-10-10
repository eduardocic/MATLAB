function [Saida] = PWM(t, T0, T1, T2, V0, VS1, VS2, V7)

%%% O pulso está dividido em 7 partes. 

int1 = T0/4;
int2 = (T0 + 2*T1)/4;
int3 = (T0 + 2*T1 + 2*T2)/4;
int4 = (3*T0 + 2*T1 + 2*T2)/4;
int5 = (3*T0 + 2*T1 + 4*T2)/4;
int6 = (3*T0 + 4*T1 + 4*T2)/4;
int7 = T0 + T1 + T2;

while(tempo < int1)
   Saida = V0;
end

while((tempo >= int1) && (tempo <= int2))
   Saida = VS1;
end

while((tempo >= int2) && (tempo <= int3))
   Saida = VS2;
end

while((tempo >= int3) && (tempo <= int4)
   Saida = V7;
end

while((tempo >= int4) && (tempo <= int5))
   Saida = VS2;
end

while((tempo >= int5) && (tempo <= int6))
   Saida = VS1;
end

while((tempo >= int6) && (tempo <= int7))
   Saida = V0;
end
    

end