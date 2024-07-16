f_domain(tuitionfeesuptodate, 0).
f_domain(tuitionfeesuptodate, 1).

f_domain(debtor, 0).
f_domain(debtor, 1).

f_domain(displaced, 0).
f_domain(displaced, 1).

f_domain(scholarshipholder, 0).
f_domain(scholarshipholder, 1).


f_domain(curricularunits2ndsem_approved, X):-  X #>= 0, X #=< 20.
f_domain(applicationmode, X):-  X #>= 1, X #=< 57.
f_domain(curricularunits2ndsem_enrolled, X):-  X #>= 0, X #=< 23.
f_domain(curricularunits2ndsem_evaluations, X):-  X #>= 0, X #=< 33.
f_domain(course, X):-  X #>= 3, X #=< 9991.
f_domain(mothersqualification, X):-  X #>= 1, X #=< 44.
f_domain(fathersqualification, X):-  X #>= 1, X #=< 44.
f_domain(curricularunits1stsem_approved, X):-  X #>= 0, X #=< 26.
f_domain(age_at_enrollment, X):-  X #>= 17, X #=< 70.
f_domain(admissiongrade, X):-  X #>= 95, X #=< 190.
f_domain(mothersoccupation, X):-  X #>= 0, X #=< 194.
f_domain(previousqualification, X):-  X #>= 95, X #=< 190.

% Properties for Categorical Features

	% tuitionfeesuptodate

		% Pre-intervention world
			not_pre_tuitionfeesuptodate(X) :- f_domain(tuitionfeesuptodate, Y),pre_tuitionfeesuptodate(Y), Y \= X.
			pre_tuitionfeesuptodate(X):- not not_pre_tuitionfeesuptodate(X).

		% Post-Intervention world
			not_post_tuitionfeesuptodate(X) :- f_domain(tuitionfeesuptodate, Y), post_tuitionfeesuptodate(Y), Y \= X.
			post_tuitionfeesuptodate(X):- not not_post_tuitionfeesuptodate(X).

	% debtor

		% Pre-intervention world
			not_pre_debtor(X) :- f_domain(debtor, Y),pre_debtor(Y), Y \= X.
			pre_debtor(X):- not not_pre_debtor(X).

		% Post-Intervention world
			not_post_debtor(X) :- f_domain(debtor, Y), post_debtor(Y), Y \= X.
			post_debtor(X):- not not_post_debtor(X).

	% displaced

		% Pre-intervention world
			not_pre_displaced(X) :- f_domain(displaced, Y),pre_displaced(Y), Y \= X.
			pre_displaced(X):- not not_pre_displaced(X).

		% Post-Intervention world
			not_post_displaced(X) :- f_domain(displaced, Y), post_displaced(Y), Y \= X.
			post_displaced(X):- not not_post_displaced(X).

	% scholarshipholder

		% Pre-intervention world
			not_pre_scholarshipholder(X) :- f_domain(scholarshipholder, Y),pre_scholarshipholder(Y), Y \= X.
			pre_scholarshipholder(X):- not not_pre_scholarshipholder(X).

		% Post-Intervention world
			not_post_scholarshipholder(X) :- f_domain(scholarshipholder, Y), post_scholarshipholder(Y), Y \= X.
			post_scholarshipholder(X):- not not_post_scholarshipholder(X).



% Properties for Numerical Features

	% curricularunits2ndsem_approved 
		% Pre-intervention world
			pre_curricularunits2ndsem_approved(X):- f_domain(curricularunits2ndsem_approved, X).

		% Post-Intervention world
			post_curricularunits2ndsem_approved(X):- f_domain(curricularunits2ndsem_approved, X).

	% applicationmode 
		% Pre-intervention world
			pre_applicationmode(X):- f_domain(applicationmode, X).

		% Post-Intervention world
			post_applicationmode(X):- f_domain(applicationmode, X).

	% curricularunits2ndsem_enrolled 
		% Pre-intervention world
			pre_curricularunits2ndsem_enrolled(X):- f_domain(curricularunits2ndsem_enrolled, X).

		% Post-Intervention world
			post_curricularunits2ndsem_enrolled(X):- f_domain(curricularunits2ndsem_enrolled, X).

	% curricularunits2ndsem_evaluations 
		% Pre-intervention world
			pre_curricularunits2ndsem_evaluations(X):- f_domain(curricularunits2ndsem_evaluations, X).

		% Post-Intervention world
			post_curricularunits2ndsem_evaluations(X):- f_domain(curricularunits2ndsem_evaluations, X).

	% course 
		% Pre-intervention world
			pre_course(X):- f_domain(course, X).

		% Post-Intervention world
			post_course(X):- f_domain(course, X).

	% mothersqualification 
		% Pre-intervention world
			pre_mothersqualification(X):- f_domain(mothersqualification, X).

		% Post-Intervention world
			post_mothersqualification(X):- f_domain(mothersqualification, X).

	% fathersqualification 
		% Pre-intervention world
			pre_fathersqualification(X):- f_domain(fathersqualification, X).

		% Post-Intervention world
			post_fathersqualification(X):- f_domain(fathersqualification, X).

	% curricularunits1stsem_approved 
		% Pre-intervention world
			pre_curricularunits1stsem_approved(X):- f_domain(curricularunits1stsem_approved, X).

		% Post-Intervention world
			post_curricularunits1stsem_approved(X):- f_domain(curricularunits1stsem_approved, X).

	% age_at_enrollment 
		% Pre-intervention world
			pre_age_at_enrollment(X):- f_domain(age_at_enrollment, X).

		% Post-Intervention world
			post_age_at_enrollment(X):- f_domain(age_at_enrollment, X).

	% admissiongrade 
		% Pre-intervention world
			pre_admissiongrade(X):- f_domain(admissiongrade, X).

		% Post-Intervention world
			post_admissiongrade(X):- f_domain(admissiongrade, X).

	% mothersoccupation 
		% Pre-intervention world
			pre_mothersoccupation(X):- f_domain(mothersoccupation, X).

		% Post-Intervention world
			post_mothersoccupation(X):- f_domain(mothersoccupation, X).			


	% previousqualification 
		% Pre-intervention world
			pre_previousqualification(X):- f_domain(previousqualification, X).

		% Post-Intervention world
			post_previousqualification(X):- f_domain(previousqualification, X).



% Decision rule to classify if a person makes ’<=50K/yr’
	lite_dropout(A,B,C,D,E,F,G,H, I,J,K,L,M,N,O,P):- A #=< 1.0 , B=0 , C=0.
	lite_dropout(A,B,C,D,E,F,G,H, I,J,K,L,M,N,O,P):- A #=< 1.0 , D #>=17.0, D #=< 39.0.
	lite_dropout(A,B,C,D,E,F,G,H, I,J,K,L,M,N,O,P):- A #=< 1.0 , E #>=5.0, E #=< 6.0 , F #=< 5.0.
	lite_dropout(A,B,C,D,E,F,G,H, I,J,K,L,M,N,O,P):- A #=< 1.0 , G #>= 9238.0, G #=< 9500.0.
	lite_dropout(A,B,C,D,E,F,G,H, I,J,K,L,M,N,O,P):- A #=< 1.0 , H=0 , E #>=5.0, E #=< 6.0 , I #=< 3.0.
	lite_dropout(A,B,C,D,E,F,G,H, I,J,K,L,M,N,O,P):- A #=< 1.0 , H=0 , J #>=19.0, J #=< 37.0  , I #>=19.0, I #=< 37.0 .
	lite_dropout(A,B,C,D,E,F,G,H, I,J,K,L,M,N,O,P):- B=0 , A #>=1.0, A #=< 3.0 .
	lite_dropout(A,B,C,D,E,F,G,H, I,J,K,L,M,N,O,P):- A #=< 1.0 , C=1 , F #=< 5.0.
	lite_dropout(A,B,C,D,E,F,G,H, I,J,K,L,M,N,O,P):- A #=< 1.0 , H=0.
	lite_dropout(A,B,C,D,E,F,G,H, I,J,K,L,M,N,O,P):- A #>=1.0, A #=< 3.0  , K #>=2.0, K #=< 4.0  , I #>=19.0, I #=< 37.0  , L #>= 34.2.
	lite_dropout(A,B,C,D,E,F,G,H, I,J,K,L,M,N,O,P):- B=0 , K #>=2.0, K #=< 4.0  , I #=< 3.0.
	lite_dropout(A,B,C,D,E,F,G,H, I,J,K,L,M,N,O,P):- B=0.
	lite_dropout(A,B,C,D,E,F,G,H, I,J,K,L,M,N,O,P):- A #>=1.0, A #=< 3.0  , J #>=19.0, J #=< 37.0  , M #>=138.3, M #=< 146.22.
	lite_dropout(A,B,C,D,E,F,G,H, I,J,K,L,M,N,O,P):- A #>=1.0, A #=< 3.0  , L #>= 27.0, M #=< 34.0.
	lite_dropout(A,B,C,D,E,F,G,H, I,J,K,L,M,N,O,P):- A #>=1.0, A #=< 3.0  , D #>=17.0, D #=< 39.0 , N #>= 3.0, N #=< 4.0.
	lite_dropout(A,B,C,D,E,F,G,H, I,J,K,L,M,N,O,P):- O=0 , K #>=2.0, K #=< 4.0  , E #>=5.0, E #=< 6.0 , P #>= 130.0, P #=< 133.1.


	dropout(A,B,C,D,E,F,G,H, I,J,K,L,M,N,O,P):- f_domain(curricularunits2ndsem_approved, A), f_domain(tuitionfeesuptodate, B), f_domain(debtor, C), f_domain(applicationmode, D), 
					f_domain(curricularunits2ndsem_enrolled, E), f_domain(curricularunits2ndsem_evaluations, F), f_domain(course, G), f_domain(displaced, H), 
					f_domain(mothersqualification, I), f_domain(fathersqualification, J), f_domain(curricularunits1stsem_approved, K), f_domain(age_at_enrollment, L), 
					f_domain(admissiongrade, M), f_domain(mothersoccupation, N), f_domain(scholarshipholder, O), f_domain(previousqualification, P),

					pre_curricularunits2ndsem_approved(A), pre_tuitionfeesuptodate(B), pre_debtor(C), pre_applicationmode(D), 
					pre_curricularunits2ndsem_enrolled(E), pre_curricularunits2ndsem_evaluations(F), pre_course(G), pre_displaced(H), 
					pre_mothersqualification(I), pre_fathersqualification(J), pre_curricularunits1stsem_approved(K), pre_age_at_enrollment(L), 
					pre_admissiongrade(M), pre_mothersoccupation(N), pre_scholarshipholder(O), pre_previousqualification(P), 

					lite_dropout(A,B,C,D,E,F,G,H, I,J,K,L,M,N,O,P).

% Counterfactual 
	cf_dropout(A,B,C,D,E,F,G,H, I,J,K,L,M,N,O,P):- f_domain(curricularunits2ndsem_approved, A), f_domain(tuitionfeesuptodate, B), f_domain(debtor, C), f_domain(applicationmode, D), 
					f_domain(curricularunits2ndsem_enrolled, E), f_domain(curricularunits2ndsem_evaluations, F), f_domain(course, G), f_domain(displaced, H), 
					f_domain(mothersqualification, I), f_domain(fathersqualification, J), f_domain(curricularunits1stsem_approved, K), f_domain(age_at_enrollment, L), 
					f_domain(admissiongrade, M), f_domain(mothersoccupation, N), f_domain(scholarshipholder, O), f_domain(previousqualification, P),

					post_curricularunits2ndsem_approved(A), post_tuitionfeesuptodate(B), post_debtor(C), post_applicationmode(D), 
					post_curricularunits2ndsem_enrolled(E), post_curricularunits2ndsem_evaluations(F), post_course(G), post_displaced(H), 
					post_mothersqualification(I), post_fathersqualification(J), post_curricularunits1stsem_approved(K), post_age_at_enrollment(L), 
					post_admissiongrade(M), post_mothersoccupation(N), post_scholarshipholder(O), post_previousqualification(P), 

					not lite_dropout(A,B,C,D,E,F,G,H, I,J,K,L,M,N,O,P).



% Control Features:

	compare_C(X,X,0).
	compare_C(X,Y,1):- X \= Y.


	compare_N(X,X,0).
	compare_N(X,Y,1):- X #< Y.
	compare_N(X,Y,-1):- X #> Y.

% Measure
	f_domain(control,0).
	f_domain(control,1).
	f_domain(control_N,0).
	f_domain(control_N,1).
	f_domain(control_N,-1).


% Measure the cost
	measure(Z1,Z2,Z3,Z4,Z5,Z6,Z7,Z8,Z9,Z10,Z11,Z12,Z13,Z14,Z15,Z16, X):- f_domain(control_N,Z1), 
						f_domain(control,Z2),
						f_domain(control,Z3), 
						f_domain(control_N,Z4),
						f_domain(control_N,Z5),
						f_domain(control_N,Z6),
						f_domain(control_N,Z7),
						f_domain(control,Z8),

						f_domain(control_N,Z9), 
						f_domain(control_N,Z10),
						f_domain(control_N,Z11),
						f_domain(control_N,Z12),
						f_domain(control_N,Z13),
						f_domain(control_N,Z14),
						f_domain(control,Z15),
						f_domain(control_N,Z13),

		Q1 #= Z1*Z1, 
		Q4 #= Z4*Z4,
		Q5 #= Z5*Z5,
		Q6 #= Z6*Z6,
		Q7 #= Z7*Z7,

		Q9 #= Z9*Z9, 
		Q10 #= Z10*Z10,
		Q11 #= Z11*Z11,
		Q12 #= Z12*Z12,
		Q13 #= Z13*Z13,
		Q14 #= Z14*Z14,
		Q16 #= Z16*Z16,
		X #= Q1+Z2+Z3+Q4+Q5+Q6+Q7+Z8+Q9+Q10+Q11+Q12+Q13+Q14+Z15+Q16.


% Identify and Restrict: Identify the features to be intervened on / Restrict features to be intervened on

	id_restrict(original(A,B,C,D,E,F,G,H, I,J,K,L,M,N,O,P),id(Z1,Z2,Z3,Z4,Z5,Z6,Z7,Z8,Z9,Z10,Z11,Z12,Z13,Z14,Z15,Z16),counterfactual(A1,B1,C1,D1,E1,F1,G1,H1, I1,J1,K1,L1,M1,N1,O1,P1)):- 
		compare_N(A,A1,Z1), compare_C(B,B1,Z2), compare_C(C,C1,Z3), compare_N(D,D1,Z4), 
		compare_N(E,E1,Z5), compare_N(F,F1,Z6), compare_N(G,G1,Z7), compare_C(H,H1,Z8), 

		compare_N(I,I1,Z9), compare_N(J,J1,Z10), compare_N(K,K1,Z11), compare_N(L,L1,Z12), 
		compare_N(M,M1,Z13), compare_N(N,N1,Z14), compare_C(O,O1,Z15), compare_N(P,P1,Z16). 

% Realistic: consistent with causal dependencies. checks if the individuals are realistic or not . 
% ie husband, then cannot be female, etc

	% Checks if the individual is consistent with the world pre intervention
	pre_realistic(A,B,C,D,E,F,G,H, I,J,K,L,M,N,O,P):-f_domain(curricularunits2ndsem_approved, A), f_domain(tuitionfeesuptodate, B), f_domain(debtor, C), f_domain(applicationmode, D), 
					f_domain(curricularunits2ndsem_enrolled, E), f_domain(curricularunits2ndsem_evaluations, F), f_domain(course, G), f_domain(displaced, H), 
					f_domain(mothersqualification, I), f_domain(fathersqualification, J), f_domain(curricularunits1stsem_approved, K), f_domain(age_at_enrollment, L), 
					f_domain(admissiongrade, M), f_domain(mothersoccupation, N), f_domain(scholarshipholder, O), f_domain(previousqualification, P),

					pre_curricularunits2ndsem_approved(A), pre_tuitionfeesuptodate(B), pre_debtor(C), pre_applicationmode(D), 
					pre_curricularunits2ndsem_enrolled(E), pre_curricularunits2ndsem_evaluations(F), pre_course(G), pre_displaced(H), 
					pre_mothersqualification(I), pre_fathersqualification(J), pre_curricularunits1stsem_approved(K), pre_age_at_enrollment(L), 
					pre_admissiongrade(M), pre_mothersoccupation(N), pre_scholarshipholder(O), pre_previousqualification(P).

	% Checks if the individual is consistent with the world post intervention
	post_realistic(A,B,C,D,E,F,G,H, I,J,K,L,M,N,O,P):-f_domain(curricularunits2ndsem_approved, A), f_domain(tuitionfeesuptodate, B), f_domain(debtor, C), f_domain(applicationmode, D), 
					f_domain(curricularunits2ndsem_enrolled, E), f_domain(curricularunits2ndsem_evaluations, F), f_domain(course, G), f_domain(displaced, H), 
					f_domain(mothersqualification, I), f_domain(fathersqualification, J), f_domain(curricularunits1stsem_approved, K), f_domain(age_at_enrollment, L), 
					f_domain(admissiongrade, M), f_domain(mothersoccupation, N), f_domain(scholarshipholder, O), f_domain(previousqualification, P),

					post_curricularunits2ndsem_approved(A), post_tuitionfeesuptodate(B), post_debtor(C), post_applicationmode(D), 
					post_curricularunits2ndsem_enrolled(E), post_curricularunits2ndsem_evaluations(F), post_course(G), post_displaced(H), 
					post_mothersqualification(I), post_fathersqualification(J), post_curricularunits1stsem_approved(K), post_age_at_enrollment(L), 
					post_admissiongrade(M), post_mothersoccupation(N), post_scholarshipholder(O), post_previousqualification(P).



% Make the craig function Extremely interpretable
refined(original(A,B,C,D,E,F,G,H, I,J,K,L,M,N,O,P),id(Z1,Z2,Z3,Z4,Z5,Z6,Z7,Z8,Z9,Z10,Z11,Z12,Z13,Z14,Z15,Z16),counterfactual(A1,B1,C1,D1,E1,F1,G1,H1, I1,J1,K1,L1,M1,N1,O1,P1),X):-
	dropout(A,B,C,D,E,F,G,H, I,J,K,L,M,N,O,P),
	pre_realistic(A,B,C,D,E,F,G,H, I,J,K,L,M,N,O,P),

	cf_dropout(A1,B1,C1,D1,E1,F1,G1,H1, I1,J1,K1,L1,M1,N1,O1,P1),
	post_realistic(A1,B1,C1,D1,E1,F1,G1,H1, I1,J1,K1,L1,M1,N1,O1,P1),

	id_restrict(original(A,B,C,D,E,F,G,H, I,J,K,L,M,N,O,P),id(Z1,Z2,Z3,Z4,Z5,Z6,Z7,Z8,Z9,Z10,Z11,Z12,Z13,Z14,Z15,Z16),counterfactual(A1,B1,C1,D1,E1,F1,G1,H1, I1,J1,K1,L1,M1,N1,O1,P1)), 
	measure(Z1,Z2,Z3,Z4,Z5,Z6,Z7,Z8,Z9,Z10,Z11,Z12,Z13,Z14,Z15,Z16, X).



#show lite_dropout/4, not lite_dropout/4.
#show ab1/2, not ab1/2.
?-dropout(A,B,C,D,E,F,G,H, I,J,K,L,M,N,O,P).
?-cf_dropout(A,B,C,D,E,F,G,H, I,J,K,L,M,N,O,P).
?-refined(original(A,B,C,D,E,F,G,H, I,J,K,L,M,N,O,P),id(Z1,Z2,Z3,Z4,Z5,Z6,Z7,Z8,Z9,Z10,Z11,Z12,Z13,Z14,Z15,Z16),counterfactual(A1,B1,C1,D1,E1,F1,G1,H1, I1,J1,K1,L1,M1,N1,O1,P1),X).
