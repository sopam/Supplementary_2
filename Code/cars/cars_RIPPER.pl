f_domain(persons, 2).
f_domain(persons, 4).
f_domain(persons, more). 

f_domain(safety, low).
f_domain(safety, med).
f_domain(safety, high). % not in dm rule

f_domain(buying, low). % not in dm rule
f_domain(buying, med).
f_domain(buying, high).
f_domain(buying, vhigh).

f_domain(maint, low). % not in dm rule
f_domain(maint, med). % not in dm rule
f_domain(maint, high).
f_domain(maint, vhigh).


f_domain(lugboot, small).
f_domain(lugboot, medium).
f_domain(lugboot, big). % not in dm rule

f_domain(doors, 2).
f_domain(doors, 3).
f_domain(doors, 4). % not in dm rule
f_domain(doors, more). % not in dm rule



% Properties for Categorical Features

	% persons

		% Pre-intervention world
			not_pre_persons(X) :- f_domain(persons, Y),pre_persons(Y), Y \= X.
			pre_persons(X):- not not_pre_persons(X).

		% Post-Intervention world
			not_post_persons(X) :- f_domain(persons, Y), post_persons(Y), Y \= X.
			post_persons(X):- not not_post_persons(X).


	% safety

		% Pre-intervention world
			not_pre_safety(X) :- f_domain(safety, Y),pre_safety(Y), Y \= X.
			pre_safety(X):- not not_pre_safety(X).

		% Post-Intervention world
			not_post_safety(X) :- f_domain(safety, Y), post_safety(Y), Y \= X.
			post_safety(X):- not not_post_safety(X).


	% buying

		% Pre-intervention world
			not_pre_buying(X) :- f_domain(buying, Y),pre_buying(Y), Y \= X.
			pre_buying(X):- not not_pre_buying(X).

		% Post-Intervention world
			not_post_buying(X) :- f_domain(buying, Y), post_buying(Y), Y \= X.
			post_buying(X):- not not_post_buying(X).


	% maint

		% Pre-intervention world
			not_pre_maint(X) :- f_domain(maint, Y),pre_maint(Y), Y \= X.
			pre_maint(X):- not not_pre_maint(X).

		% Post-Intervention world
			not_post_maint(X) :- f_domain(maint, Y), post_maint(Y), Y \= X.
			post_maint(X):- not not_post_maint(X).


	% lugboot

		% Pre-intervention world
			not_pre_lugboot(X) :- f_domain(lugboot, Y),pre_lugboot(Y), Y \= X.
			pre_lugboot(X):- not not_pre_lugboot(X).

		% Post-Intervention world
			not_post_lugboot(X) :- f_domain(lugboot, Y), post_lugboot(Y), Y \= X.
			post_lugboot(X):- not not_post_lugboot(X).


	% doors

		% Pre-intervention world
			not_pre_doors(X) :- f_domain(doors, Y),pre_doors(Y), Y \= X.
			pre_doors(X):- not not_pre_doors(X).

		% Post-Intervention world
			not_post_doors(X) :- f_domain(doors, Y), post_doors(Y), Y \= X.
			post_doors(X):- not not_post_doors(X).



#show rule_1/1, rule_2/1, rule_3/2, rule_4/2, rule_5/2.
rule_1(A):- A = 2.
rule_2(B):- B = low.
rule_3(C,D):- C = vhigh, D = vhigh.
rule_4(C,D):- C \= low, C \= med, D = vhigh.
rule_5(C,D):- C = vhigh, D = high.

% Decision rule to classify if a person makes ’<=50K/yr’

	% Original
		%lite_reject():- persons = 2.
		%lite_reject():- safety = low.
		%lite_reject():- buying = vhigh , maint = vhigh.
		%lite_reject():- lugboot = small , safety = med , buying = high.
		%lite_reject():- maint = vhigh , buying = high.
		%lite_reject():- buying = vhigh , maint = high.
		%lite_reject():- lugboot = small , doors = 2 , persons = more.
		%lite_reject():- safety = med , lugboot = small , buying = vhigh.
		%lite_reject():- safety = med , maint = vhigh , lugboot = small.
		%lite_reject():- safety = med , doors = 3 , persons = 4 , lugboot = med.
		%lite_reject():- lugboot = small , safety = med , maint = high , buying = med.

		lite_reject(A,B,C,D,E,F):- A = 2.
		lite_reject(A,B,C,D,E,F):- B = low.
		lite_reject(A,B,C,D,E,F):- C = vhigh , D = vhigh.
		lite_reject(A,B,C,D,E,F):- E = small , B = med , C = high.
		lite_reject(A,B,C,D,E,F):- D = vhigh , C = high.
		lite_reject(A,B,C,D,E,F):- C = vhigh , D = high.
		lite_reject(A,B,C,D,E,F):- E = small , F = 2 , A = more.
		lite_reject(A,B,C,D,E,F):- B = med , E = small , C = vhigh.
		lite_reject(A,B,C,D,E,F):- B = med , D = vhigh , E = small.
		lite_reject(A,B,C,D,E,F):- B = med , F = 3 , A = 4 , E = med.
		lite_reject(A,B,C,D,E,F):- E = small , B = med , D = high , C = med.

	reject(A,B,C,D,E,F):- f_domain(persons, A), f_domain(safety, B),
					f_domain(buying, C), f_domain(maint, D),
					f_domain(lugboot, E), f_domain(doors, F),

					pre_persons(A), pre_safety(B), 
					pre_buying(C), pre_maint(D),
					pre_lugboot(E), pre_doors(F),


					lite_reject(A,B,C,D,E,F).


% Counterfactual rule to clasify if a person does not make ’<=50K/yr’
	
	cf_reject(A,B,C,D,E,F):- f_domain(persons, A), f_domain(safety, B),
					f_domain(buying, C), f_domain(maint, D),
					f_domain(lugboot, E), f_domain(doors, F),

					post_persons(A), post_safety(B), 
					post_buying(C), post_maint(D),
					post_lugboot(E), post_doors(F),


					not lite_reject(A,B,C,D,E,F).


% Control Features:

	compare_C(X,X,0).
	compare_C(X,Y,1):- X \= Y.


% Measure
	f_domain(control,0).
	f_domain(control,1).


	measure(Z1,Z2,Z3,Z4,Z5,Z6,X):- f_domain(control,Z1), f_domain(control,Z2), 
									f_domain(control,Z3), f_domain(control,Z4), 
									f_domain(control,Z5), f_domain(control,Z6), 
									X #= Z1+Z2+Z3+Z4+Z5+Z6.


% Identify and Restrict: Identify the features to be intervened on / Restrict features to be intervened on

	id_restrict(original(A,B,C,D,E,F),id(Z1,Z2,Z3,Z4,Z5,Z6),counterfactual(A1,B1,C1,D1,E1,F1)):- 
	compare_C(A,A1,Z1), compare_C(B,B1,Z2), compare_C(C,C1,Z3), compare_C(D,D1,Z4), compare_C(E,E1,Z5), compare_C(F,F1,Z6).


% Realistic: consistent with causal dependencies. checks if the individuals are realistic or not . 
% ie husband, then cannot be female, etc

	% Checks if the individual is consistent with the world pre intervention
	pre_realistic(A,B,C,D,E,F):-f_domain(persons, A),
		f_domain(safety, B), f_domain(buying, C), f_domain(maint, D),
		f_domain(lugboot, E), f_domain(doors, F),
		
		pre_persons(A), pre_safety(B), pre_buying(C), pre_maint(D),
		pre_lugboot(E), pre_doors(F).

	% Checks if the individual is consistent with the world post intervention
	post_realistic(A,B,C,D,E,F):-f_domain(persons, A),
		f_domain(safety, B), f_domain(buying, C), f_domain(maint, D),
		f_domain(lugboot, E), f_domain(doors, F),
		
		post_persons(A), post_safety(B), post_buying(C), post_maint(D),
		post_lugboot(E), post_doors(F).


% Make the craig function Extremely interpretable
refined(original(A,B,C,D,E,F),id(Z1,Z2,Z3,Z4,Z5,Z6),counterfactual(A1,B1,C1,D1,E1,F1),X):-
	reject(A,B,C,D,E,F),
	pre_realistic(A,B,C,D,E,F).

#show lite_reject/4, not lite_reject/4.
?-reject(A,B,C,D,E,F).
%?-cf_reject(A,B,C,D,E,F).
?-refined(original(A,B,C,D,E,F),id(Z1,Z2,Z3,Z4,Z5,Z6),counterfactual(A1,B1,C1,D1,E1,F1),X).

%?-refined(original(2,B,C,D,E,F),id(Z1,Z2,Z3,Z4,Z5,Z6),counterfactual(A1,B1,C1,D1,E1,F1),X).

