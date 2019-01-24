%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Space Vector Modulation
%   -----------------------
% 
% (*) Essa representação procura evidenciar como que estarão os transistor
%     que funcionarão como chaves para correntes em cada fase.
%
% (*) O interessante desse método é que a tomar pelas combinações entre
%     as fases. 
%
% (*) Em termos de possíveis combinações, teremos estas representações
%     dadas por uma entrada com três números (x,y,z). Cada uma das entradas
%     está relacioada diretamente com cada fase: 'x' está relacionada com a
%     fase 'A', 'y' com 'B' e 'z' com 'C'. Os valores possíveis para cada
%     uma dessas entradas é '0' ou '1'. O valor '1' significa dizer que o
%     transistor de 'cima' estará 'on' e que o transistor de 'baixo' estará
%     'off'. Já o valor '0' significa dizer que o transistor de 'cima'
%     estará 'off' e que o transistor de 'baixo' estará 'on'.
%
% (*) Essas situações possíveis geram 8 combinações distintas:
%     (000),(111),(001),(010),(011),(100),(101) e, finalmente, (110).
%
% (*) Os caras tiveram a sacada de representar 6 dessas 8 combinações como
%     se vértices de um hexágono. Os dois outros restantes, são
%     considerados como origems do sistema. Essas duas 'origem' são os
%     vetores (000) e (111) (os quais pela intepretação são todos os
%     transistores de cima 'off' e todos os transistores de cima 'on').
%
% (*) Cada lado desse hexágono tem comprimento dado por 2/sqrt(3). Tal
%     valor é conseguido quando se coloca um círculo inscrito neste
%     hexágono de raio 1 (pode fazer as contas que dá isso). Cada um dos
%     vértices desse hexágono está localizado em uma fase múltipla de 60º:
%     0º, 60º 120º, 180º, 240º, 300º.
%
% (*) Desse motor, a gente consegue dividir os hexágono em 6 diferentes
%     'setores'. Estes setores serão utilizado para a lógica que alimentará
%     o PWM.
%
% (*) Esse hexágono também possi os seus eixos dispostos com direção dada
%     por 0º e 90º. O eixo das absissas será o eixo 'alfa' e o eixo das
%     ordenadas será o eixo 'beta'.
%
% (*) As situações nas quais aparecem na Tabela 2-1 (página 20) da
%     Fresscale, dizem respeito à direção da corrente. Por exemplo, pegue o
%     caso (100) -- segunda linha da tabela. Perceba que nela você tem que
%     a tensão Ua, Ub e Uc são, respectivamente, (2/3)Udc, (-1/3)Udc e
%     (-1/3)Udc. Você consegue esses valores quando você fecha o transistor
%     de cima de 'A' e deixa aos transistores de baixo das das outras 
%     fases, 'B' e 'C', fechados. Com isso, fazendo uma análise de corrente
%     em resistores apenas (a tensão não fica alternada), você determina
%     esses valores de corrente DC (pela fechada de malha). Fazendo isso
%     para cada uma das linhas da Tabela 2-1 você determina direitinho
%     todas as situações de tensão para cada situação de 'chaveamento'.
%
% (*) A sacada do SVM é a seguinte. Após passar por todo o cálculo
%     envolvido (transformada de Clarke, Park, Controle, Transformada
%     Inversa de Park) a gente vai ter em mãos tensões no plano de Clarke
%     (ou seja Ualfa, e Ubeta). Pela tensão resultante: Ur = sqrt(Ualfa^2 + Ubeta^2) 
%     e pelos valores de Ualfa e Ubeta, a gente consegue encontrar em qual
%     dos 6 setores o vetor Ur se encontra (relação trigonométrica básica).
%     Tal Ur é normalizado em 1 (o que seria o raio do circulo inscrito ao
%     hexágono). Tá, a primeira parte, então, é identificar o setor. Fácil
%     de fazer.
%
% (*) A outra parte é decompor esse vetor (Ualfa, Ubeta) nos vetores
%     direcionais nas direções dos vértices dos hexágonos. Por brevidade de
%     notação esse novo eixo de referência, ou seja os eixos dados pelos
%     direções dos vértices dos hexágonos, serão chamados de Ux e Ux+-60º,
%     em que o Ux faz a representação do primeiro eixo vértice do segmento
%     e o Ux+-60 a representação do eixo à frente ou atrás no segmento.
%
% (*) A ideia base é aplicar voltagems dadas pelos vetores Uxxx e Oxxx
%     (casos 000 e 111) de forma a termos um vetor médio do PWM é obtido a
%     partir do tempo em que ele fica 'on' e 'off'. Tá complicado mais vai
%     melhorar. 
%
% (*) O vetor voltagem é criado após a aplicação dos vetores bases do setor
%     (ou seja, os dois vetores que definem o segmento) e também dos
%     vetores nulos Oxxx (000 ou 111). De forma que a média da tensão
%     obtida é a tensão que é aplicada. A sacada é, quanto tempo eu tenho
%     que deixar então os vetores do setor ligados e os vetores nulos Oxxx
%     desligados???
%
% (*) Primeiramente, no plano alfa-beta o vetor resultante da soma vetorial
%     dos dois será representado por Us(a,b). Tal vetor é o mesmo no plano
%     dado pelos eixos apontados para os vértices do hexágono. 
%
% (*) Assim, iremos assumir que o vetor Us(a,b) está diretamente
%     relacionado com o tempo do PWM do sistema, simbolizado por T. Esse
%     tempo total está diretamente relacionado com a decomposição dos
%     vetores em Ux e Ux+-60, de forma que o tempo T1 estará ligado a
%     Us(a,b) e T2 estará ligado a Ux+-60. O T0 é o tempo em que os vetores
%     ficarão 'off'.
%
% (*) O equacionamento fica então da seguinte forma:
%
%                 ----->       ->      ----->
%               T.Us(a,b) = T1.Ux + T2.Ux+-60
%
%                       T = T1 + T2 + T0.
%
% (*) Calculando, então, o tempo em que o PWM ficará ligado em cada um dos
%     sistemas, temos, por geometria, que:
%
%                       ->
%               (T1/T).|Ux| + x = |Ualfa| 
%
%                       ----->
%               (T2/T).|Ux+-60| = 2.sqrt(3).|Ubeta|/3
%
%
% (*) Fazer o eixo rotacionar durante todo o percurso de uma angulação
%     geométrica.




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% (*) Uma voltagem senoidal será aplicada a um motor e esta é criada por
%     meio da técnica de modulação de vetores no espaço (Space Vector
%     Technique).
%
% (*) O algoritmo Field Oriented Control (FOC) proverá um controle em tempo
%     real para o torque e para a velocidade de rotação dos motores. Tal
%     controle é muito bom tanto para o estado estacionário quanto para o
%     transiente. 
%
% (*) A operação de um motor de brushless (sem escovas) é bastante
%     dependente da conversão de energia elétrica em magnética e de
%     magnética para mecânica. A ideia precípua é que utilizando-se o FOC
%     a gente consegue gerar campos magnéticos que rotacionam por meio da
%     aplicação de sinais senoidais nas 3 diferentes fases de um motor
%     trifásico.
% 
% -------------------------------------------------------------------------
%
%   DEFINIÇÃO
%   ---------
%
% (*) Posição mecânica e posição elétrica. A posição mecânica é relacionada
%     diretamente com uma rotação completa do rotor do motor, ou seja, 360º
%     do rotor. Já a posição elétrica é relacionada diretamente ao campo
%     magnético do rotor, ou seja, quando que em um determinado sistema a
%     gente consegue repetir diretamente os pólos sentidos anterioremente.
%
% (*) Relações importantes.
%
%                        theta_e = p.theta_m          (1)
%
%                        omega_e = p.omega_m          (2)
%
%     em que:
%         1.: theta_e      -- posição elétrica
%         2.: theta_m      -- posição mecânica
%         3.: omega_e      -- velocidade elétrica (w_e)
%         4.: omega_m      -- velocidade mecânica (w_m)
%         5.: p            -- quantidade de pares de pólos
%
% (*) Relações elétricas.
%
%                         v_a = V.cos(w_e.t)          (3)
%                         v_b = V.cos(w_e.t-(2pi/3))  (4)
%                         v_c = V.cos(w_e.t-(4pi/3))  (5)
%
% (*) De maneira equivalente, para o fluxo magnético, tem-se:
%
%                      Psi_a = (Psi_m).cos(w_e.t)          (6)
%                      Psi_b = (Psi_m).cos(w_e.t-(2pi/3))  (7)
%                      Psi_c = (Psi_m).cos(w_e.t-(4pi/3))  (8)
%
%     PS: Para criar um estator de fluxo rotante, essa discrepância de 120º
%     ocorre pelo fato de as bobinas em um motor de brushless estarem
%     defasadas em 120º.
%
% (*) Para cada uma das fases, tem-se:
%
%        v_x = Z.i 
%            = (R + d(Psi)/dt).i 
%            = R.i + d(L.i + Psi_m(theta))/dt
%
%    em que: 
%
%       1.: Psi_m       -- Amplitude natural do fluxo magnético permanente.
%       2.: R           -- Resistor
%       3.: Z           -- Impedância
%       4.: i           -- Corrente
%       5.: L           -- Indutância
%       6.: d(Psi_m)/dt -- Back-EMF (voltagem induzida, dependende de (theta_e)
%
%   PS: d(Psi_m(theta_e))/dt = d(Psi_m(theta_e))/d(theta_e)*d(theta_e)/dt
%                            = d(Psi_m(theta_e))/d(theta_e)*w_e
%
% (*) Supondo que a maquinaria é senoidal, a voltagem induzida tem a
%     seguinte forma:
%
%       |E_a(theta)|             |     sin(theta_e)     |
%  E  = |E_b(theta)| = -w_e.Psi_m|sin(theta_e - (2pi/3))|= w_e.Psi_m.[K(theta_e)]
%       |E_c(theta)|             |sin(theta_e - (4pi/3))|
%
%     em que:
%
%                  |     sin(theta_e)     |
%   [K(theta_e)] = |sin(theta_e - (2pi/3))|
%                  |sin(theta_e - (4pi/3))|
%
% (*) Da energia elétrica dispendida com o motor, uma parte é transformada
%     em calor, outra parte é armazenada no campo magnético e outra parte é
%     transformada em energia mecânica.
%
% (*) O torque elétrico é dado por (sabe-se que a melhor solução para
%     produzir um torque constante é disponibilizar correntes senoidais).
%
%                     Te = p.[Is]'.Psi_m.[K(theta_e)]
%
%     em que:
%
%            |     Is.sin(w_e.t)     |
%     [Is] = |Is.sin(w_e.t - (2pi/3))|
%            |Is.sin(w_e.t - (4pi/3))|
%
%     resultando, para o torque, em:
%
%                    Te = (3/2).p.Psi_m.Is
%
%
% (*) O torque elétrico criado (Te) é, então, utilizado para cargas
%     mecânicas, tal que:
%
%                   J.d(w_m)/dt + kd.w_m + Tl = Te
%
%     em que:
%       1.: J    -- Inércia do motor.
%       2.: Kd   -- Constante de viscosidade.
%       3.: Tl   -- Torque na carga.
%       4.: w_m  -- Velocidade mecânica.
%
%
% (*) Transformação de Clarke.
% 
%                 iS_alfa = ia
%                 iS_beta = (1/sqrt(3)).ia + (2/sqrt(3)).ib
%                 ia + ib + ic = 0
%
% (*) Transformação de Park.
% 
%                 iS_d = iS_alfa.cos(theta_e) + iS_beta.sin(theta_e)
%                 iS_d = -iS_alfa.sin(theta_e) + iS_beta.cos(theta_e)
%
%
% (*) Após as transformações seguidas de Clarke e Park, tem-se que as
%     equações elétricas podem ser facilmente reduzidas para:
%
%               vS_d = Rs.iS_d + d(psi_d)/dt - w_e.psi_q
%               vS_q = Rs.iS_q + d(psi_q)/dt - w_e.psi_d


   

