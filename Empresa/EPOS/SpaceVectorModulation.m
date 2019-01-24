%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Space Vector Modulation
%   -----------------------
% 
% (*) Essa representa��o procura evidenciar como que estar�o os transistor
%     que funcionar�o como chaves para correntes em cada fase.
%
% (*) O interessante desse m�todo � que a tomar pelas combina��es entre
%     as fases. 
%
% (*) Em termos de poss�veis combina��es, teremos estas representa��es
%     dadas por uma entrada com tr�s n�meros (x,y,z). Cada uma das entradas
%     est� relacioada diretamente com cada fase: 'x' est� relacionada com a
%     fase 'A', 'y' com 'B' e 'z' com 'C'. Os valores poss�veis para cada
%     uma dessas entradas � '0' ou '1'. O valor '1' significa dizer que o
%     transistor de 'cima' estar� 'on' e que o transistor de 'baixo' estar�
%     'off'. J� o valor '0' significa dizer que o transistor de 'cima'
%     estar� 'off' e que o transistor de 'baixo' estar� 'on'.
%
% (*) Essas situa��es poss�veis geram 8 combina��es distintas:
%     (000),(111),(001),(010),(011),(100),(101) e, finalmente, (110).
%
% (*) Os caras tiveram a sacada de representar 6 dessas 8 combina��es como
%     se v�rtices de um hex�gono. Os dois outros restantes, s�o
%     considerados como origems do sistema. Essas duas 'origem' s�o os
%     vetores (000) e (111) (os quais pela intepreta��o s�o todos os
%     transistores de cima 'off' e todos os transistores de cima 'on').
%
% (*) Cada lado desse hex�gono tem comprimento dado por 2/sqrt(3). Tal
%     valor � conseguido quando se coloca um c�rculo inscrito neste
%     hex�gono de raio 1 (pode fazer as contas que d� isso). Cada um dos
%     v�rtices desse hex�gono est� localizado em uma fase m�ltipla de 60�:
%     0�, 60� 120�, 180�, 240�, 300�.
%
% (*) Desse motor, a gente consegue dividir os hex�gono em 6 diferentes
%     'setores'. Estes setores ser�o utilizado para a l�gica que alimentar�
%     o PWM.
%
% (*) Esse hex�gono tamb�m possi os seus eixos dispostos com dire��o dada
%     por 0� e 90�. O eixo das absissas ser� o eixo 'alfa' e o eixo das
%     ordenadas ser� o eixo 'beta'.
%
% (*) As situa��es nas quais aparecem na Tabela 2-1 (p�gina 20) da
%     Fresscale, dizem respeito � dire��o da corrente. Por exemplo, pegue o
%     caso (100) -- segunda linha da tabela. Perceba que nela voc� tem que
%     a tens�o Ua, Ub e Uc s�o, respectivamente, (2/3)Udc, (-1/3)Udc e
%     (-1/3)Udc. Voc� consegue esses valores quando voc� fecha o transistor
%     de cima de 'A' e deixa aos transistores de baixo das das outras 
%     fases, 'B' e 'C', fechados. Com isso, fazendo uma an�lise de corrente
%     em resistores apenas (a tens�o n�o fica alternada), voc� determina
%     esses valores de corrente DC (pela fechada de malha). Fazendo isso
%     para cada uma das linhas da Tabela 2-1 voc� determina direitinho
%     todas as situa��es de tens�o para cada situa��o de 'chaveamento'.
%
% (*) A sacada do SVM � a seguinte. Ap�s passar por todo o c�lculo
%     envolvido (transformada de Clarke, Park, Controle, Transformada
%     Inversa de Park) a gente vai ter em m�os tens�es no plano de Clarke
%     (ou seja Ualfa, e Ubeta). Pela tens�o resultante: Ur = sqrt(Ualfa^2 + Ubeta^2) 
%     e pelos valores de Ualfa e Ubeta, a gente consegue encontrar em qual
%     dos 6 setores o vetor Ur se encontra (rela��o trigonom�trica b�sica).
%     Tal Ur � normalizado em 1 (o que seria o raio do circulo inscrito ao
%     hex�gono). T�, a primeira parte, ent�o, � identificar o setor. F�cil
%     de fazer.
%
% (*) A outra parte � decompor esse vetor (Ualfa, Ubeta) nos vetores
%     direcionais nas dire��es dos v�rtices dos hex�gonos. Por brevidade de
%     nota��o esse novo eixo de refer�ncia, ou seja os eixos dados pelos
%     dire��es dos v�rtices dos hex�gonos, ser�o chamados de Ux e Ux+-60�,
%     em que o Ux faz a representa��o do primeiro eixo v�rtice do segmento
%     e o Ux+-60 a representa��o do eixo � frente ou atr�s no segmento.
%
% (*) A ideia base � aplicar voltagems dadas pelos vetores Uxxx e Oxxx
%     (casos 000 e 111) de forma a termos um vetor m�dio do PWM � obtido a
%     partir do tempo em que ele fica 'on' e 'off'. T� complicado mais vai
%     melhorar. 
%
% (*) O vetor voltagem � criado ap�s a aplica��o dos vetores bases do setor
%     (ou seja, os dois vetores que definem o segmento) e tamb�m dos
%     vetores nulos Oxxx (000 ou 111). De forma que a m�dia da tens�o
%     obtida � a tens�o que � aplicada. A sacada �, quanto tempo eu tenho
%     que deixar ent�o os vetores do setor ligados e os vetores nulos Oxxx
%     desligados???
%
% (*) Primeiramente, no plano alfa-beta o vetor resultante da soma vetorial
%     dos dois ser� representado por Us(a,b). Tal vetor � o mesmo no plano
%     dado pelos eixos apontados para os v�rtices do hex�gono. 
%
% (*) Assim, iremos assumir que o vetor Us(a,b) est� diretamente
%     relacionado com o tempo do PWM do sistema, simbolizado por T. Esse
%     tempo total est� diretamente relacionado com a decomposi��o dos
%     vetores em Ux e Ux+-60, de forma que o tempo T1 estar� ligado a
%     Us(a,b) e T2 estar� ligado a Ux+-60. O T0 � o tempo em que os vetores
%     ficar�o 'off'.
%
% (*) O equacionamento fica ent�o da seguinte forma:
%
%                 ----->       ->      ----->
%               T.Us(a,b) = T1.Ux + T2.Ux+-60
%
%                       T = T1 + T2 + T0.
%
% (*) Calculando, ent�o, o tempo em que o PWM ficar� ligado em cada um dos
%     sistemas, temos, por geometria, que:
%
%                       ->
%               (T1/T).|Ux| + x = |Ualfa| 
%
%                       ----->
%               (T2/T).|Ux+-60| = 2.sqrt(3).|Ubeta|/3
%
%
% (*) Fazer o eixo rotacionar durante todo o percurso de uma angula��o
%     geom�trica.




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% (*) Uma voltagem senoidal ser� aplicada a um motor e esta � criada por
%     meio da t�cnica de modula��o de vetores no espa�o (Space Vector
%     Technique).
%
% (*) O algoritmo Field Oriented Control (FOC) prover� um controle em tempo
%     real para o torque e para a velocidade de rota��o dos motores. Tal
%     controle � muito bom tanto para o estado estacion�rio quanto para o
%     transiente. 
%
% (*) A opera��o de um motor de brushless (sem escovas) � bastante
%     dependente da convers�o de energia el�trica em magn�tica e de
%     magn�tica para mec�nica. A ideia prec�pua � que utilizando-se o FOC
%     a gente consegue gerar campos magn�ticos que rotacionam por meio da
%     aplica��o de sinais senoidais nas 3 diferentes fases de um motor
%     trif�sico.
% 
% -------------------------------------------------------------------------
%
%   DEFINI��O
%   ---------
%
% (*) Posi��o mec�nica e posi��o el�trica. A posi��o mec�nica � relacionada
%     diretamente com uma rota��o completa do rotor do motor, ou seja, 360�
%     do rotor. J� a posi��o el�trica � relacionada diretamente ao campo
%     magn�tico do rotor, ou seja, quando que em um determinado sistema a
%     gente consegue repetir diretamente os p�los sentidos anterioremente.
%
% (*) Rela��es importantes.
%
%                        theta_e = p.theta_m          (1)
%
%                        omega_e = p.omega_m          (2)
%
%     em que:
%         1.: theta_e      -- posi��o el�trica
%         2.: theta_m      -- posi��o mec�nica
%         3.: omega_e      -- velocidade el�trica (w_e)
%         4.: omega_m      -- velocidade mec�nica (w_m)
%         5.: p            -- quantidade de pares de p�los
%
% (*) Rela��es el�tricas.
%
%                         v_a = V.cos(w_e.t)          (3)
%                         v_b = V.cos(w_e.t-(2pi/3))  (4)
%                         v_c = V.cos(w_e.t-(4pi/3))  (5)
%
% (*) De maneira equivalente, para o fluxo magn�tico, tem-se:
%
%                      Psi_a = (Psi_m).cos(w_e.t)          (6)
%                      Psi_b = (Psi_m).cos(w_e.t-(2pi/3))  (7)
%                      Psi_c = (Psi_m).cos(w_e.t-(4pi/3))  (8)
%
%     PS: Para criar um estator de fluxo rotante, essa discrep�ncia de 120�
%     ocorre pelo fato de as bobinas em um motor de brushless estarem
%     defasadas em 120�.
%
% (*) Para cada uma das fases, tem-se:
%
%        v_x = Z.i 
%            = (R + d(Psi)/dt).i 
%            = R.i + d(L.i + Psi_m(theta))/dt
%
%    em que: 
%
%       1.: Psi_m       -- Amplitude natural do fluxo magn�tico permanente.
%       2.: R           -- Resistor
%       3.: Z           -- Imped�ncia
%       4.: i           -- Corrente
%       5.: L           -- Indut�ncia
%       6.: d(Psi_m)/dt -- Back-EMF (voltagem induzida, dependende de (theta_e)
%
%   PS: d(Psi_m(theta_e))/dt = d(Psi_m(theta_e))/d(theta_e)*d(theta_e)/dt
%                            = d(Psi_m(theta_e))/d(theta_e)*w_e
%
% (*) Supondo que a maquinaria � senoidal, a voltagem induzida tem a
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
% (*) Da energia el�trica dispendida com o motor, uma parte � transformada
%     em calor, outra parte � armazenada no campo magn�tico e outra parte �
%     transformada em energia mec�nica.
%
% (*) O torque el�trico � dado por (sabe-se que a melhor solu��o para
%     produzir um torque constante � disponibilizar correntes senoidais).
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
% (*) O torque el�trico criado (Te) �, ent�o, utilizado para cargas
%     mec�nicas, tal que:
%
%                   J.d(w_m)/dt + kd.w_m + Tl = Te
%
%     em que:
%       1.: J    -- In�rcia do motor.
%       2.: Kd   -- Constante de viscosidade.
%       3.: Tl   -- Torque na carga.
%       4.: w_m  -- Velocidade mec�nica.
%
%
% (*) Transforma��o de Clarke.
% 
%                 iS_alfa = ia
%                 iS_beta = (1/sqrt(3)).ia + (2/sqrt(3)).ib
%                 ia + ib + ic = 0
%
% (*) Transforma��o de Park.
% 
%                 iS_d = iS_alfa.cos(theta_e) + iS_beta.sin(theta_e)
%                 iS_d = -iS_alfa.sin(theta_e) + iS_beta.cos(theta_e)
%
%
% (*) Ap�s as transforma��es seguidas de Clarke e Park, tem-se que as
%     equa��es el�tricas podem ser facilmente reduzidas para:
%
%               vS_d = Rs.iS_d + d(psi_d)/dt - w_e.psi_q
%               vS_q = Rs.iS_q + d(psi_q)/dt - w_e.psi_d


   

