function Saida = DirectionDomainOfAtractionKothare(A, B, Umax, n)

Linha = linspace(0,180,n)';
V = 0*[Linha Linha; Linha Linha];

for i = 1:n
   theta = (i-1)*181/n; 
   Epsilon = [cos(theta*pi/180);
              sin(theta*pi/180)]; 
    
   ConsMultiVetor = LMI_DomainOfAtraction(A, B, Epsilon, Umax);
   Vetor1 = ConsMultiVetor*Epsilon';
   Vetor2 = -ConsMultiVetor*Epsilon';
   V1(i,:) = Vetor1;
   V2(i,:) = Vetor2; 
end   

V = [V1; V2];
Saida = V;

end
