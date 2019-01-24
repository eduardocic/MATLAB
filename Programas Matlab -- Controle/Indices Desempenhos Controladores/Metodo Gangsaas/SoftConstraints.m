function f = SoftConstraints(x, G, Hard, Soft)

% Desembrulho as variáveis.
Kp = x(1);
Kd = x(2);

% Função de malha aberta 'L(s)' e malha fechada 'T(s)'.
L = minreal(Kp*G(1) + Kd*G(2));
T = minreal(L/(1 + L));
S = allmargin(L);

% Ganho de Nichols e frequencia de corte.
Hinf = 20*log10(norm(T,inf));

% Requisito de Margem de Fase.
f(1) = (S.PhaseMargin - Hard.PhaseMargin(1))/(Hard.PhaseMargin(2) - Hard.PhaseMargin(1));
f(2) = (S.GainMargin - Hard.GainMargin(1))/(Hard.GainMargin(2) - Hard.GainMargin(1));

% Requisito de frequência.
% f(3) = (S.PMFrequency - Hard.FreqCrossover(1))/(Hard.FreqCrossover(2) - Hard.FreqCrossover(1));
f(3) = (S.PMFrequency - Hard.FreqCrossover(1));

% Pegando os índices do numerador da malha fechada.
num    = T.den{1};
raizes = real(roots(num));
tam    = max(size(raizes));
for i = 1:tam
   f(i+3) = (raizes(i) - Hard.Eigenvalues(1))/(Hard.Eigenvalues(2) - Hard.Eigenvalues(1));
end
alpha = max(size(f));



f(alpha + 1) = (Hinf - Soft.HinfClosedLoop(1))/(Soft.HinfClosedLoop(2) - Soft.HinfClosedLoop(1));
% f(2) = (S.PMFrequency - Soft.FreqCrossover(1))/(Soft.FreqCrossover(2) - Soft.FreqCrossover(1));
f(alpha + 2) = (S.PMFrequency - Soft.FreqCrossover(1));



end