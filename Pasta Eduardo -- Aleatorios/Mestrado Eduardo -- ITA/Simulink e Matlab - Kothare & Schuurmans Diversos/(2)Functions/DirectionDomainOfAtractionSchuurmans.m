function Saida = DirectionDomainOfAtractionKothare(A, B, K, Umax, n)

Linha = linspace(0,180,n+1)';
V = 0*[Linha Linha; Linha Linha];

for i = 1:max(size(Linha))
   theta = Linha(i);                % Em graus.
   Epsilon = [cos(theta*pi/180);
              sin(theta*pi/180)]; 
    
   ConsMultiVetor = LMI_DomainOfAtractionSchuurmans(A, B, K, Epsilon, Umax);
   Vetor1 = ConsMultiVetor*Epsilon';
   Vetor2 = -ConsMultiVetor*Epsilon';
   V1(i,:) = Vetor1;
   V2(i,:) = Vetor2; 
end   

V = [V1; V2];
Saida = V;

end
