% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%
%                           MATRIZES DE ESTADO
%
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

%% -------------------
% Matrizes Incertas A.
% --------------------
A1 = [   0   1;
      -1.5 2.5];
  
A2 = [   0   1;
      -0.8 1.8];  

%% -------------------
% Matrizes Incertas B.
% --------------------  
B1 = [0;
     1];

 
 

 
 
%% ---------------------
% Concatena as Matrizes.
% ----------------------
A = [A1;
     A2];
B = [B1];

C = eye(2);
D = [0; 0];

