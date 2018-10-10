% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
%
%                           MATRIZES DE ESTADO
%
% +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

% -------------------
% Matrizes Incertas A.
% --------------------
% A1 = [   0   1;
%       -1.5 2.5];
%   
% A2 = [   0   1;
%       -0.8 1.8];  

A1 = [   1   0.1;
         0     1];
  
A2 = [   1   0.1;
         0    1.2];  

%% ----------------------------------------
% Matrizes Incertas A - Matrizes Professor.
% -----------------------------------------
% A1 = [ 0.1   10;
%         0   0.1];
%   
%   
% A2 = [ 0.1   0;
%         10  0.1];  
    

%% -------------------
% Matrizes Incertas B.
% --------------------  
B1 = [0;
     0.0787];

 
 
 

 
 
%% ---------------------
% Concatena as Matrizes.
% ----------------------
A = [A1;
     A2];
B = [B1];

n = size(A,2);

C = eye(n);
D = 0*C(:,n);

