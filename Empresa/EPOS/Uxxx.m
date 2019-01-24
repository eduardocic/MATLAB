function [V0, VS1, VS2, V7] = Uxxx(Setor)

V0 = [0 0 0];
V1 = [1 0 0];
V2 = [1 1 0];
V3 = [0 1 0];
V4 = [0 1 1];
V5 = [0 0 1];
V6 = [1 0 1];
V7 = [1 1 1];

if (Setor == 1)
    VS1 = V1;
    VS2 = V2;
elseif (Setor == 2)
    VS1 = V2;
    VS2 = V3;
elseif (Setor == 3)
    VS1 = V3;
    VS2 = V4;
elseif (Setor == 4)
    VS1 = V4;
    VS2 = V5; 
elseif (Setor ==5)
    VS1 = V5;
    VS2 = V6;   
elseif (Setor == 6)
    VS1 = V6;
    VS2 = V1;
end

end