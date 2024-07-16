f_domain(debtor, 0).
f_domain(debtor, 1).

f_domain(course, 171).
f_domain(course, 33).

f_domain(curricular_units_2nd_sem_grade, X):-  X #>= 0, X #=< 18.57142857.
f_domain(admission_grade, X):-  X #>= 95, X #=< 190.


% Properties for Categorical Features

	% course

		% Pre-intervention world
			not_pre_course(X) :- f_domain(course, Y),pre_course(Y), Y \= X.
			pre_course(X):- not not_pre_course(X).

		% Post-Intervention world
			not_post_course(X) :- f_domain(course, Y), post_course(Y), Y \= X.
			post_course(X):- not not_post_course(X).

	% debto

		% Pre-intervention world
			not_pre_debtor(X) :- f_domain(debtors, Y),pre_debtor(Y), Y \= X.
			pre_debtor(X):- not not_pre_debtor(X).

		% Post-Intervention world
			not_post_debtor(X) :- f_domain(debtors, Y), post_debtor(Y), Y \= X.
			post_debtor(X):- not not_post_debtor(X).



% Properties for Numerical Features

	% curricular_units_2nd_sem_grade 
		% Pre-intervention world
			pre_curricular_units_2nd_sem_grade(X):- f_domain(curricular_units_2nd_sem_grade, X).

		% Post-Intervention world
			post_curricular_units_2nd_sem_grade(X):- f_domain(curricular_units_2nd_sem_grade, X).

	
	% admission_grade 
		% Pre-intervention world
			pre_admission_grade(X):- f_domain(admission_grade, X).

		% Post-Intervention world
			post_admission_grade(X):- f_domain(admission_grade, X).



% Decision rule to classify if a person makes ’<=50K/yr’
	lite_dropout(A,_,C,D):- A #=< 10.167, not ab1(C,D).
	lite_dropout(_,B,_,_):- B \= 1.
	ab1(C,D):- C = 171, D #> 136.


	dropout(A,B,C,D):- f_domain(curricular_units_2nd_sem_grade, A),f_domain(debtor, B),
					f_domain(course,C),f_domain(admission_grade, D),

					pre_curricular_units_2nd_sem_grade(A), pre_debtor(B), 
					pre_course(C), pre_admission_grade(D),

					lite_dropout(A,B,C,D).



% Counterfactual rule to clasify if a person does not make ’<=50K/yr’
	cf_dropout(A,B,C,D):- f_domain(curricular_units_2nd_sem_grade, A),f_domain(debtor, B),
					f_domain(course,C),f_domain(admission_grade, D),

					post_curricular_units_2nd_sem_grade(A), post_debtor(B), 
					post_course(C), post_admission_grade(D),

					not lite_dropout(A,B,C,D).


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

	measure(Z1,Z2,Z3,Z4, X):- f_domain(control_N,Z1), f_domain(control,Z2),
	
	f_domain(control,Z3), f_domain(control_N,Z4),
	Q1 #= Z1*Z1, Q4 #= Z4*Z4,
	X #= Q1+Z2+Z3+Q4.

% Identify and Restrict: Identify the features to be intervened on / Restrict features to be intervened on

	id_restrict(original(A,B,C,D),id(Z1,Z2,Z3,Z4),counterfactual(A1,B1,C1,D1)):- 
		compare_N(A,A1,Z1), compare_C(B,B1,Z2), compare_C(C,C1,Z3), compare_N(D,D1,Z4).


% Realistic: consistent with causal dependencies. checks if the individuals are realistic or not . 
% ie husband, then cannot be female, etc

	% Checks if the individual is consistent with the world pre intervention
	pre_realistic(A,B,C,D):-f_domain(curricular_units_2nd_sem_grade, A),f_domain(debtor, B),
					f_domain(course,C),f_domain(admission_grade, D),

					pre_curricular_units_2nd_sem_grade(A), pre_debtor(B), 
					pre_course(C), pre_admission_grade(D).

	% Checks if the individual is consistent with the world post intervention
	post_realistic(A,B,C,D):-f_domain(curricular_units_2nd_sem_grade, A),f_domain(debtor, B),
					f_domain(course,C),f_domain(admission_grade, D),

					post_curricular_units_2nd_sem_grade(A), post_debtor(B), 
					post_course(C), post_admission_grade(D).


% Make the craig function Extremely interpretable
refined(original(A,B,C,D),id(Z1,Z2,Z3,Z4),counterfactual(A1,B1,C1,D1),X):-
	dropout(A,B,C,D),
	pre_realistic(A,B,C,D),

	cf_dropout(A1,B1,C1,D1),
	post_realistic(A1,B1,C1,D1),

	id_restrict(original(A,B,C,D),id(Z1,Z2,Z3,Z4),counterfactual(A1,B1,C1,D1)), 
	measure(Z1,Z2,Z3,Z4,X).


#show lite_dropout/4, not lite_dropout/4.
#show ab1/2, not ab1/2.
?-dropout(A,B,C,D).
?-cf_dropout(A,B,C,D).
?-refined(original(A,B,C,D),id(Z1,Z2,Z3,Z4),counterfactual(A1,B1,C1,D1),X).
%?-refined(original(A,B,C,D),id(Z1,Z2,Z3,Z4),counterfactual(A1,B1,C1,D1),4).
