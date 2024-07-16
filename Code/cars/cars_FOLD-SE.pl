f_domain(persons, 2).
f_domain(persons, 4).
f_domain(persons, more).

f_domain(safety, low).
f_domain(safety, med).
f_domain(safety, high).

f_domain(buying, low).
f_domain(buying, med).
f_domain(buying, high).
f_domain(buying, vhigh).

f_domain(maint, low).
f_domain(maint, med).
f_domain(maint, high).
f_domain(maint, vhigh).


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

#show rule_1/1, rule_2/1, rule_3/2, rule_4/2, rule_5/2.
rule_1(A):- A = 2.
rule_2(B):- B = low.
rule_3(C,D):- C = vhigh, D = vhigh.
rule_4(C,D):- C \= low, C \= med, D = vhigh.
rule_5(C,D):- C = vhigh, D = high.

% Decision rule to classify if a person makes ’<=50K/yr’

	% Uncomment
		%lite_reject(A,_,_,_):- A = 2.
		%lite_reject(_,B,_,_):- B = low.
		%lite_reject(_,_,C,D):- C = vhigh, D = vhigh.
		%lite_reject(_,_,C,D):- C \= low, C \= med, D = vhigh.
		%lite_reject(_,_,C,D):- C = vhigh, D = high.

	lite_reject(A,_,_,_):- rule_1(A).
	lite_reject(_,B,_,_):- rule_2(B).
	lite_reject(_,_,C,D):- rule_3(C,D).
	lite_reject(_,_,C,D):- rule_4(C,D).
	lite_reject(_,_,C,D):- rule_5(C,D).

	reject(A,B,C,D):- f_domain(persons, A), f_domain(safety, B),
					f_domain(buying, C), f_domain(maint, D),

					pre_persons(A), pre_safety(B), pre_buying(C), pre_maint(D),

					lite_reject(A,B,C,D).


% Counterfactual rule to clasify if a person does not make ’<=50K/yr’
	
	cf_reject(A,B,C,D):- f_domain(persons, A), f_domain(safety, B),
					f_domain(buying, C), f_domain(maint, D),

					post_persons(A), post_safety(B), post_buying(C), post_maint(D),

					not lite_reject(A,B,C,D).


% Control Features:

	compare_C(X,X,0).
	compare_C(X,Y,1):- X \= Y.


% Measure
	f_domain(control,0).
	f_domain(control,1).


	measure(Z1,Z2,Z3,Z4,X):- f_domain(control,Z1), f_domain(control,Z2), 
									f_domain(control,Z3), f_domain(control,Z4), 
									X #= Z1+Z2+Z3+Z4.



% Identify and Restrict: Identify the features to be intervened on / Restrict features to be intervened on

id_restrict(original(A,B,C,D),id(Z1,Z2,Z3,Z4),counterfactual(A1,B1,C1,D1)):- 
	compare_C(A,A1,Z1), compare_C(B,B1,Z2), compare_C(C,C1,Z3), compare_C(D,D1,Z4).


% Realistic: consistent with causal dependencies. checks if the individuals are realistic or not . 
% ie husband, then cannot be female, etc

	% Checks if the individual is consistent with the world pre intervention
	pre_realistic(A,B,C,D):-f_domain(persons, A),
		f_domain(safety, B), f_domain(buying, C), f_domain(maint, D),
		
		pre_persons(A), pre_safety(B), pre_buying(C), pre_maint(D).

	% Checks if the individual is consistent with the world post intervention
	post_realistic(A,B,C,D):-f_domain(persons, A),
		f_domain(safety, B), f_domain(buying, C), f_domain(maint, D),
		
		post_persons(A), post_safety(B), post_buying(C), post_maint(D).


% Make the craig function Extremely interpretable
refined(original(A,B,C,D),id(Z1,Z2,Z3,Z4),counterfactual(A1,B1,C1,D1),X):-
	reject(A,B,C,D),
	pre_realistic(A,B,C,D),

	cf_reject(A1,B1,C1,D1), 
	post_realistic(A1,B1,C1,D1),

	id_restrict(original(A,B,C,D),id(Z1,Z2,Z3,Z4),counterfactual(A1,B1,C1,D1)),
	measure(Z1,Z2,Z3,Z4,X).


#show lite_reject/4, not lite_reject/4.
?-reject(A,B,C,D).
?-cf_reject(A,B,C,D).
?-refined(original(A,B,C,D),id(Z1,Z2,Z3,Z4),counterfactual(A1,B1,C1,D1),X).

%?-refined(original(2,B,C,D),id(Z1,Z2,Z3,Z4),counterfactual(A1,B1,C1,D1),X).

