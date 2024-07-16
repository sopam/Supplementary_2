f_domain(gender, male).
f_domain(gender, female).

f_domain(class, 1).
f_domain(class, 2).
f_domain(class, 3).

f_domain(fare, X):-  X #>= 0, X #=< 512.3292.


% Properties for Categorical Features

	% gender

		% Pre-intervention world
			not_pre_gender(X) :- f_domain(gender, Y),pre_gender(Y), Y \= X.
			pre_gender(X):- not not_pre_gender(X).

		% Post-Intervention world
			not_post_gender(X) :- f_domain(gender, Y), post_gender(Y), Y \= X.
			post_gender(X):- not not_post_gender(X).


	% class

		% Pre-intervention world
			not_pre_class(X) :- f_domain(class, Y),pre_class(Y), Y \= X.
			pre_class(X):- not not_pre_class(X).

		% Post-Intervention world
			not_post_class(X) :- f_domain(class, Y), post_class(Y), Y \= X.
			post_class(X):- not not_post_class(X).



% Properties for Numerical Features

	% fare 
		% Pre-intervention world
			pre_fare(X):- f_domain(fare, X).

		% Post-Intervention world
			post_fare(X):- f_domain(fare, X).



% Decision rule to classify if a person perishes
	
	#show lite_perish/3, not lite_perish/3.

	lite_perish(X,_,_) :- X = male.
	lite_perish(X,Y,Z) :- Y = 3, X \= male, Z #> 23.25.  

	perish(A,B,C):- f_domain(gender, A),
		f_domain(class, B), f_domain(fare, C),
		pre_gender(A), pre_class(B),pre_fare(C), 
		lite_perish(A,B,C).



% Counterfactual rule to clasify if a person does not perish i.e. survived
	cf_perish(A,B,C):- f_domain(gender, A),
		f_domain(class, B), f_domain(fare, C),
		post_gender(A), post_class(B),post_fare(C), 
		not lite_perish(A,B,C).



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

	measure(Z1,Z2,Z3, X):- f_domain(control,Z1), 
		f_domain(control,Z2), f_domain(control_N,Z3),
	    Q3 #= Z3*Z3, X #= Z1+Z2+Q3.


% Realistic: consistent with causal dependencies. checks if the individuals are realistic or not . 
% ie husband, then cannot be female, etc

	% Checks if the individual is consistent with the world pre intervention
	pre_realistic(A,B,C):-f_domain(gender, A),
		f_domain(class, B), f_domain(fare, C),
		pre_gender(A),
		pre_class(B),pre_fare(C).

	% Checks if the individual is consistent with the world post intervention
	post_realistic(A,B,C):-f_domain(gender, A),
		f_domain(class, B), f_domain(fare, C),
		post_gender(A),
		post_class(B),post_fare(C).


% Identify and Restrict: Identify the features to be intervened on / Restrict features to be intervened on

id_restrict(orgiginal(A,B,C),id(Z1,Z2,Z3),counterfactual(A1,B1,C1)):- 
	compare_C(A,A1,Z1), compare_C(B,B1,Z2), compare_N(C,C1,Z3).

% Make the craig function Extremely interpretable
refined(orgiginal(A,B,C),id(Z1,Z2,Z3),counterfactual(A1,B1,C1),X):-
	perish(A,B,C),
	pre_realistic(A,B,C),

	cf_perish(A1,B1,C1),
	post_realistic(A1,B1,C1),

	id_restrict(orgiginal(A,B,C),id(Z1,Z2,Z3),counterfactual(A1,B1,C1)), 
	measure(Z1,Z2,Z3,X).



%% QUERY

?- perish(A,B,C).
?- cf_perish(A,B,C).
%?-pre_realistic(A,B,C).
%?-post_realistic(A,B,C).
?- refined(orgiginal(A,B,C),id(Z1,Z2,Z3),counterfactual(A1,B1,C1),X).
