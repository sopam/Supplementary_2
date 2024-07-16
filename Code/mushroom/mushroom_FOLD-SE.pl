f_domain(odor, n).
f_domain(odor, f). % not in dm rule

f_domain(spore_print_color, r).
f_domain(spore_print_color, b). % not in dm rule

f_domain(bruises, f).
f_domain(bruises, t). % not in dm rule


f_domain(stalk_root, c).
f_domain(stalk_root, r).
f_domain(stalk_root, b). % not in dm rule

f_domain(gill_spacing, c).
f_domain(gill_spacing, w). % not in dm rule


% Properties for Categorical Features

	% odor

		% Pre-intervention world
			not_pre_odor(X) :- f_domain(odor, Y),pre_odor(Y), Y \= X.
			pre_odor(X):- not not_pre_odor(X).

		% Post-Intervention world
			not_post_odor(X) :- f_domain(odor, Y), post_odor(Y), Y \= X.
			post_odor(X):- not not_post_odor(X).

	% spore_print_color

		% Pre-intervention world
			not_pre_spore_print_color(X) :- f_domain(spore_print_color, Y),pre_spore_print_color(Y), Y \= X.
			pre_spore_print_color(X):- not not_pre_spore_print_color(X).

		% Post-Intervention world
			not_post_spore_print_color(X) :- f_domain(spore_print_color, Y), post_spore_print_color(Y), Y \= X.
			post_spore_print_color(X):- not not_post_spore_print_color(X).

	% bruises

		% Pre-intervention world
			not_pre_bruises(X) :- f_domain(bruises, Y),pre_bruises(Y), Y \= X.
			pre_bruises(X):- not not_pre_bruises(X).

		% Post-Intervention world
			not_post_bruises(X) :- f_domain(bruises, Y), post_bruises(Y), Y \= X.
			post_bruises(X):- not not_post_bruises(X).

	% stalk_root

		% Pre-intervention world
			not_pre_stalk_root(X) :- f_domain(stalk_root, Y),pre_stalk_root(Y), Y \= X.
			pre_stalk_root(X):- not not_pre_stalk_root(X).

		% Post-Intervention world
			not_post_stalk_root(X) :- f_domain(stalk_root, Y), post_stalk_root(Y), Y \= X.
			post_stalk_root(X):- not not_post_stalk_root(X).

	% gill_spacing

		% Pre-intervention world
			not_pre_gill_spacing(X) :- f_domain(gill_spacing, Y),pre_gill_spacing(Y), Y \= X.
			pre_gill_spacing(X):- not not_pre_gill_spacing(X).

		% Post-Intervention world
			not_post_gill_spacing(X) :- f_domain(gill_spacing, Y), post_gill_spacing(Y), Y \= X.
			post_gill_spacing(X):- not not_post_gill_spacing(X).


#show rule_1/1, rule_2/1, rule_3/2, rule_4/2, rule_5/2.
rule_1(A):- A = 2.
rule_2(B):- B = low.
rule_3(C,D):- C = vhigh, D = vhigh.
rule_4(C,D):- C \= low, C \= med, D = vhigh.
rule_5(C,D):- C = vhigh, D = high.

% Decision rule to classify if a person makes ’<=50K/yr’

	% Uncomment
		%lite_republican(A,B,C,D,E):- A = yes, not ab2(B,C,D,E).
		%ab1(B,C):- B = yes , C \= no.
		%ab2(B,C,D,E):- D = yes , E \= no, not ab1(B,C).

	%poisonous(A,B,C,D,E):- not odor(X,'n'), not ab1(X,'True'), not ab2(X,'True'), not ab3(X,'True').
	%poisonous(A,B,C,D,E) :- spore_print_color(X,'r').
	%	ab1(X,'True') :- not bruises(X,'f'), stalk_root(X,'c').
	%	ab2(X,'True') :- not bruises(X,'f'), stalk_root(X,'r').
	%	ab3(X,'True') :- not gill_spacing(X,'c'), not bruises(X,'f').

	lite_poisonous(A,_,C,D,E):- A \= n, not ab1(C,D), not ab2(C,D), not ab3(E,C).
	lite_poisonous(_,B,_,_,_):- B = r.
		ab1(C,D):- C \= f, D \= c.
		ab2(C,D):- C \= f, D \= r.
		ab3(E,C):- E \= c, C \= f.

	poisonous(A,B,C,D,E):- f_domain(odor, A), f_domain(spore_print_color, B),
					f_domain(bruises, C), f_domain(stalk_root, D), f_domain(gill_spacing, E),

					pre_odor(A), pre_spore_print_color(B), 
					pre_bruises(C), pre_stalk_root(D),
					pre_gill_spacing(E),
					lite_poisonous(A,B,C,D,E).

% Counterfactual rule to clasify if a person does not make ’<=50K/yr’
	
	cf_poisonous(A,B,C,D,E):- f_domain(odor, A), f_domain(spore_print_color, B),
					f_domain(bruises, C), f_domain(stalk_root, D), f_domain(gill_spacing, E),

					post_odor(A), post_spore_print_color(B), 
					post_bruises(C), post_stalk_root(D),
					post_gill_spacing(E),
					not lite_poisonous(A,B,C,D,E).

% Control Features:

	compare_C(X,X,0).
	compare_C(X,Y,1):- X \= Y.


% Measure
	f_domain(control,0).
	f_domain(control,1).


	measure(Z1,Z2,Z3,Z4,Z5,X):- f_domain(control,Z1), f_domain(control,Z2), 
									f_domain(control,Z3), f_domain(control,Z4), 
									f_domain(control,Z5), 
									X #= Z1+Z2+Z3+Z4+Z5.


% Identify and Restrict: Identify the features to be intervened on / Restrict features to be intervened on

id_restrict(original(A,B,C,D,E),id(Z1,Z2,Z3,Z4,Z5),counterfactual(A1,B1,C1,D1,E1)):- 
	compare_C(A,A1,Z1), compare_C(B,B1,Z2), compare_C(C,C1,Z3), compare_C(D,D1,Z4),
	compare_C(E,E1,Z5).

% Realistic: consistent with causal dependencies. checks if the individuals are realistic or not . 
% ie husband, then cannot be female, etc

	% Checks if the individual is consistent with the world pre intervention
	pre_realistic(A,B,C,D,E):-f_domain(odor, A), f_domain(spore_print_color, B),
					f_domain(bruises, C), f_domain(stalk_root, D), f_domain(gill_spacing, E),

					pre_odor(A), pre_spore_print_color(B), 
					pre_bruises(C), pre_stalk_root(D),
					pre_gill_spacing(E).

	% Checks if the individual is consistent with the world post intervention
	post_realistic(A,B,C,D,E):-f_domain(odor, A), f_domain(spore_print_color, B),
					f_domain(bruises, C), f_domain(stalk_root, D), f_domain(gill_spacing, E),

					post_odor(A), post_spore_print_color(B), 
					post_bruises(C), post_stalk_root(D),
					post_gill_spacing(E).


% Make the craig function Extremely interpretable
refined(original(A,B,C,D,E),id(Z1,Z2,Z3,Z4,Z5),counterfactual(A1,B1,C1,D1,E1),X):-
	poisonous(A,B,C,D,E),
	pre_realistic(A,B,C,D,E),

	cf_poisonous(A1,B1,C1,D1,E1), 
	post_realistic(A1,B1,C1,D1,E1),

	id_restrict(original(A,B,C,D,E),id(Z1,Z2,Z3,Z4,Z5),counterfactual(A1,B1,C1,D1,E1)),
	measure(Z1,Z2,Z3,Z4,Z5,X).


#show lite_reject/4, not lite_reject/4.
?-poisonous(A,B,C,D,E).
?-cf_poisonous(A,B,C,D,E).
?-refined(original(A,B,C,D,E),id(Z1,Z2,Z3,Z4,Z5),counterfactual(A1,B1,C1,D1,E1),X).

