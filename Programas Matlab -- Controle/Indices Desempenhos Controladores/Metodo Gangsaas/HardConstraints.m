function f = HardConstraints(x, G, H)
% -------------------------------------------------------------------------
% x: o vetor a minimizar;
% G: a função de transferência do sistema; e
% H: as 'Hard' Constraints.
% =========================================================================
% Desembrulho as variáveis.
Kp = x(1);
Kd = x(2);

% Função de malha aberta 'L(s)' e malha fechada 'T(s)'.
L   = minreal(Kp*G(1) + Kd*G(2));
T   = minreal(L/(1 + L));
Req = allmargin(L);

% Requisito de 'Margem de Fase' e 'Margem de Ganho'.
f(1) = (Req.PhaseMargin - H.PhaseMargin.Good)/(H.PhaseMargin.Bad - H.PhaseMargin.Good);
f(2) = (Req.GainMargin - H.GainMargin.Good)/(H.GainMargin.Bad - H.GainMargin.Good);

% Requisito de frequência.
% f(3) = (S.PMFrequency - Hard.FreqCrossover(1))/(Hard.FreqCrossover(2) - Hard.FreqCrossover(1));
f(3) = (Req.PMFrequency - H.FreqCrossover.Good);

% Pegando os índices do numerador da malha fechada.
den    = T.den{1};
raizes = real(roots(den));
tam    = max(size(raizes));
for i = 1:tam
%    f(i+2) = (raizes(i) - H.Eigenvalues.Good)/(H.Eigenvalues.Bad - H.Eigenvalues.Good);
   f(i+2) = (raizes(i) - H.Eigenvalues.Good);
end

end