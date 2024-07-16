f_domain(odor, f).
f_domain(odor, p). 
f_domain(odor, c). 
%f_domain(odor, a). % not in dm rule

f_domain(gill_size, n).
f_domain(gill_size, b). % not in dm rule

f_domain(gill_color, b).
f_domain(gill_color, n). % not in dm rule

f_domain(spore_print_color, r).
f_domain(spore_print_color, b). % not in dm rule

f_domain(stalk_surface_below_ring, y).
f_domain(stalk_surface_below_ring, k). % not in dm rule

f_domain(stalk_surface_above_ring, k).
f_domain(stalk_surface_above_ring, y). % not in dm rule

f_domain(stalk_color_above_ring, y).
f_domain(stalk_color_above_ring, c). % not in dm rule

f_domain(habitat, l).
f_domain(habitat, g). % not in dm rule

f_domain(cap_color, w).
f_domain(cap_color, e). % not in dm rule




% Properties for Categorical Features

	% odor

		% Pre-intervention world
			not_pre_odor(X) :- f_domain(odor, Y),pre_odor(Y), Y \= X.
			pre_odor(X):- not not_pre_odor(X).

		% Post-Intervention world
			not_post_odor(X) :- f_domain(odor, Y), post_odor(Y), Y \= X.
			post_odor(X):- not not_post_odor(X).

	% gill_size

		% Pre-intervention world
			not_pre_gill_size(X) :- f_domain(gill_size, Y),pre_gill_size(Y), Y \= X.
			pre_gill_size(X):- not not_pre_gill_size(X).

		% Post-Intervention world
			not_post_gill_size(X) :- f_domain(gill_size, Y), post_gill_size(Y), Y \= X.
			post_gill_size(X):- not not_post_gill_size(X).

	% gill_color

		% Pre-intervention world
			not_pre_gill_color(X) :- f_domain(gill_color, Y),pre_gill_color(Y), Y \= X.
			pre_gill_color(X):- not not_pre_gill_color(X).

		% Post-Intervention world
			not_post_gill_color(X) :- f_domain(gill_color, Y), post_gill_color(Y), Y \= X.
			post_gill_color(X):- not not_post_gill_color(X).

	% spore_print_color

		% Pre-intervention world
			not_pre_spore_print_color(X) :- f_domain(spore_print_color, Y),pre_spore_print_color(Y), Y \= X.
			pre_spore_print_color(X):- not not_pre_spore_print_color(X).

		% Post-Intervention world
			not_post_spore_print_color(X) :- f_domain(spore_print_color, Y), post_spore_print_color(Y), Y \= X.
			post_spore_print_color(X):- not not_post_spore_print_color(X).

	% stalk_surface_below_ring

		% Pre-intervention world
			not_pre_stalk_surface_below_ring(X) :- f_domain(stalk_surface_below_ring, Y),pre_stalk_surface_below_ring(Y), Y \= X.
			pre_stalk_surface_below_ring(X):- not not_pre_stalk_surface_below_ring(X).

		% Post-Intervention world
			not_post_stalk_surface_below_ring(X) :- f_domain(stalk_surface_below_ring, Y), post_stalk_surface_below_ring(Y), Y \= X.
			post_stalk_surface_below_ring(X):- not not_post_stalk_surface_below_ring(X).

	% stalk_surface_above_ring

		% Pre-intervention world
			not_pre_stalk_surface_above_ring(X) :- f_domain(stalk_surface_above_ring, Y),pre_stalk_surface_above_ring(Y), Y \= X.
			pre_stalk_surface_above_ring(X):- not not_pre_stalk_surface_above_ring(X).

		% Post-Intervention world
			not_post_stalk_surface_above_ring(X) :- f_domain(stalk_surface_above_ring, Y), post_stalk_surface_above_ring(Y), Y \= X.
			post_stalk_surface_above_ring(X):- not not_post_stalk_surface_above_ring(X).

	% stalk_color_above_ring

		% Pre-intervention world
			not_pre_stalk_color_above_ring(X) :- f_domain(stalk_color_above_ring, Y),pre_stalk_color_above_ring(Y), Y \= X.
			pre_stalk_color_above_ring(X):- not not_pre_stalk_color_above_ring(X).

		% Post-Intervention world
			not_post_stalk_color_above_ring(X) :- f_domain(stalk_color_above_ring, Y), post_stalk_color_above_ring(Y), Y \= X.
			post_stalk_color_above_ring(X):- not not_post_stalk_color_above_ring(X).

	% habitat

		% Pre-intervention world
			not_pre_habitat(X) :- f_domain(habitat, Y),pre_habitat(Y), Y \= X.
			pre_habitat(X):- not not_pre_habitat(X).

		% Post-Intervention world
			not_post_habitat(X) :- f_domain(habitat, Y), post_habitat(Y), Y \= X.
			post_habitat(X):- not not_post_habitat(X).

	% cap_color

		% Pre-intervention world
			not_pre_cap_color(X) :- f_domain(cap_color, Y),pre_cap_color(Y), Y \= X.
			pre_cap_color(X):- not not_pre_cap_color(X).

		% Post-Intervention world
			not_post_cap_color(X) :- f_domain(cap_color, Y), post_cap_color(Y), Y \= X.
			post_cap_color(X):- not not_post_cap_color(X).


#show rule_1/1, rule_2/1, rule_3/2, rule_4/2, rule_5/2.
rule_1(A):- A = 2.
rule_2(B):- B = low.
rule_3(C,D):- C = vhigh, D = vhigh.
rule_4(C,D):- C \= low, C \= med, D = vhigh.
rule_5(C,D):- C = vhigh, D = high.

% Decision rule 


	lite_poisonous(A,_,_,_,_,_,_,_,_):- A = f.
	lite_poisonous(_,B,C,_,_,_,_,_,_):- B = n, C = b.
	lite_poisonous(A,B,_,_,_,_,_,_,_):- B = n, A = p.
	lite_poisonous(A,_,_,_,_,_,_,_,_):- A = c.
	lite_poisonous(_,_,_,D,_,_,_,_,_):- D = r.
	lite_poisonous(_,_,_,_,E,F,_,_,_):- E = y, F = k.
	lite_poisonous(_,_,_,_,_,_,G,_,_):- G = y.
	lite_poisonous(_,_,_,_,_,_,_,H,I):- H = l, I = w.

	poisonous(A,B,C,D,E,F,G,H,I):- f_domain(odor, A), f_domain(gill_size, B),
					f_domain(gill_color, C), f_domain(spore_print_color, D), 
					f_domain(stalk_surface_below_ring, E),
					f_domain(stalk_surface_above_ring, F),
					f_domain(stalk_color_above_ring, G),
					f_domain(habitat, H),
					f_domain(cap_color, I),

					pre_odor(A), pre_gill_size(B),
					pre_gill_color(C), pre_spore_print_color(D), 
					pre_stalk_surface_below_ring(E),
					pre_stalk_surface_above_ring(F),
					pre_stalk_color_above_ring(G),
					pre_habitat(H),
					pre_cap_color(I),
					lite_poisonous(A,B,C,D,E,F,G,H,I).

% Counterfactual rule to clasify if a person does not make ’<=50K/yr’
	
	cf_poisonous(A,B,C,D,E,F,G,H,I):- f_domain(odor, A), f_domain(gill_size, B),
					f_domain(gill_color, C), f_domain(spore_print_color, D), 
					f_domain(stalk_surface_below_ring, E),
					f_domain(stalk_surface_above_ring, F),
					f_domain(stalk_color_above_ring, G),
					f_domain(habitat, H),
					f_domain(cap_color, I),

					post_odor(A), post_gill_size(B),
					post_gill_color(C), post_spore_print_color(D), 
					post_stalk_surface_below_ring(E),
					post_stalk_surface_above_ring(F),
					post_stalk_color_above_ring(G),
					post_habitat(H),
					post_cap_color(I),
					not lite_poisonous(A,B,C,D,E,F,G,H,I).


% Control Features:

	compare_C(X,X,0).
	compare_C(X,Y,1):- X \= Y.


% Measure
	f_domain(control,0).
	f_domain(control,1).


	measure(Z1,Z2,Z3,Z4,Z5,Z6,Z7,Z8,Z9,X):- f_domain(control,Z1), f_domain(control,Z2), 
									f_domain(control,Z3), f_domain(control,Z4), 
									f_domain(control,Z5), 
									f_domain(control,Z6), f_domain(control,Z7), 
									f_domain(control,Z8), f_domain(control,Z9), 
									X #= Z1+Z2+Z3+Z4+Z5+Z6+Z7+Z8+Z9.


% Identify and Restrict: Identify the features to be intervened on / Restrict features to be intervened on

id_restrict(original(A,B,C,D,E,F,G,H,I),id(Z1,Z2,Z3,Z4,Z5,Z6,Z7,Z8,Z9),counterfactual(A1,B1,C1,D1,E1,F1,G1,H1,I1)):- 
	compare_C(A,A1,Z1), compare_C(B,B1,Z2), compare_C(C,C1,Z3), compare_C(D,D1,Z4),
	compare_C(E,E1,Z5),
	compare_C(F,F1,Z6), compare_C(G,G1,Z7), compare_C(H,H1,Z8), compare_C(I,I1,Z9).



% Realistic: consistent with causal dependencies. checks if the individuals are realistic or not . 
% ie husband, then cannot be female, etc

	% Checks if the individual is consistent with the world pre intervention
	pre_realistic(A,B,C,D,E,F,G,H,I):-f_domain(odor, A), f_domain(gill_size, B),
					f_domain(gill_color, C), f_domain(spore_print_color, D), 
					f_domain(stalk_surface_below_ring, E),
					f_domain(stalk_surface_above_ring, F),
					f_domain(stalk_color_above_ring, G),
					f_domain(habitat, H),
					f_domain(cap_color, I),

					pre_odor(A), pre_gill_size(B),
					pre_gill_color(C), pre_spore_print_color(D), 
					pre_stalk_surface_below_ring(E),
					pre_stalk_surface_above_ring(F),
					pre_stalk_color_above_ring(G),
					pre_habitat(H),
					pre_cap_color(I),
					lite_poisonous(A,B,C,D,E,F,G,H,I).

	% Checks if the individual is consistent with the world post intervention
	post_realistic(A,B,C,D,E,F,G,H,I):-f_domain(odor, A), f_domain(gill_size, B),
					f_domain(gill_color, C), f_domain(spore_print_color, D), 
					f_domain(stalk_surface_below_ring, E),
					f_domain(stalk_surface_above_ring, F),
					f_domain(stalk_color_above_ring, G),
					f_domain(habitat, H),
					f_domain(cap_color, I),

					post_odor(A), post_gill_size(B),
					post_gill_color(C), post_spore_print_color(D), 
					post_stalk_surface_below_ring(E),
					post_stalk_surface_above_ring(F),
					post_stalk_color_above_ring(G),
					post_habitat(H),
					post_cap_color(I).


% Make the craig function Extremely interpretable
refined(original(A,B,C,D,E,F,G,H,I),id(Z1,Z2,Z3,Z4,Z5,Z6,Z7,Z8,Z9),counterfactual(A1,B1,C1,D1,E1,F1,G1,H1,I1),X):-
	poisonous(A,B,C,D,E,F,G,H,I),
	pre_realistic(A,B,C,D,E,F,G,H,I),

	cf_poisonous(A1,B1,C1,D1,E1,F1,G1,H1,I1), 
	post_realistic(A1,B1,C1,D1,E1,F1,G1,H1,I1),

	id_restrict(original(A,B,C,D,E,F,G,H,I),id(Z1,Z2,Z3,Z4,Z5,Z6,Z7,Z8,Z9),counterfactual(A1,B1,C1,D1,E1,F1,G1,H1,I1)),
	measure(Z1,Z2,Z3,Z4,Z5,Z6,Z7,Z8,Z9,X).


#show lite_reject/4, not lite_reject/4.
?-poisonous(A,B,C,D,E,F,G,H,I).
?-cf_poisonous(A,B,C,D,E,F,G,H,I).
?-refined(original(A,B,C,D,E,F,G,H,I),id(Z1,Z2,Z3,Z4,Z5,Z6,Z7,Z8,Z9),counterfactual(A1,B1,C1,D1,E1,F1,G1,H1,I1),X).

