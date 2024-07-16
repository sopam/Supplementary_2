f_domain(sex, male). 
f_domain(sex, female).




% Properties for Categorical Features

	% sex
	
		% Pre-intervention world
			not_pre_sex(X) :- f_domain(sex, Y),pre_sex(Y), Y \= X.
			pre_sex(X):- not not_pre_sex(X).

		% Post-Intervention world
			not_post_sex(X) :- f_domain(sex, Y), post_sex(Y), Y \= X.
			post_sex(X):- not not_post_sex(X).





% Decision rule to classify if a person makes ’<=50K/yr’


	% Org Rules
		%lite_perished(Sex):- Sex = male.

	% Replace with letters Rules
		lite_perished(A):- A = male.



	perished(A):- f_domain(sex, A),

		pre_sex(A),

		lite_perished(A).




% Counterfactual rule to clasify if a person does not make ’<=50K/yr’

	cf_perished(A):- f_domain(sex, A),

		post_sex(A),

		not lite_perished(A).




% Control Features:

	compare_C(X,X,0).
	compare_C(X,Y,1):- X \= Y.



% Measure
	f_domain(control,0).
	f_domain(control,1).



measure(Z1, X):- f_domain(control,Z1), X #= Z1.


% Realistic: consistent with causal dependencies. checks if the individuals are realistic or not . 
% ie husband, then cannot be female, etc

	% Checks if the individual is consistent with the world pre intervention
	pre_realistic(A):-f_domain(sex, A), pre_sex(A).

	% Checks if the individual is consistent with the world post intervention
	post_realistic(A):-f_domain(sex, A), post_sex(A).


id_restrict(original(A),id(Z1),counterfactual(A1)):- compare_C(A,A1,Z1).



% Make the craig function Extremely interpretable
refined(original(A),id(Z1),counterfactual(A1),X):-
	perished(A),
	pre_realistic(A),

	cf_perished(A1),
	post_realistic(A1),

	id_restrict(original(A),id(Z1),counterfactual(A1)),
	measure(Z1,X).


#show lite_le_50K/12, not lite_le_50K/12.
?- perished(A).
?- cf_perished(A).
?-refined(original(A),id(Z1),counterfactual(A1),X).
