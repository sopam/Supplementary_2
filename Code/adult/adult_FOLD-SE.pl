f_domain(marital_status, married_civ_spouse).
f_domain(marital_status, never_married).

f_domain(relationship, husband).
f_domain(relationship, wife).
f_domain(relationship, unmarried).

f_domain(sex, male).
f_domain(sex, female).

f_domain(capital_gain, X):-  X #>= 0, X #=< 99999.
f_domain(education_num, X):- X #>= 1, X #=< 16.
f_domain(age, X):-  X #>= 17, X #=< 90.


% Properties for Categorical Features

	% marital_status

		% Pre-intervention world
			not_pre_marital_status(X) :- f_domain(marital_status, Y),pre_marital_status(Y), Y \= X.
			pre_marital_status(X):- not not_pre_marital_status(X).

		% Post-Intervention world
			not_post_marital_status(X) :- f_domain(marital_status, Y), post_marital_status(Y), Y \= X.
			post_marital_status(X):- not not_post_marital_status(X).


	% relationship

		% Pre-intervention world
			not_pre_relationship(X) :- f_domain(relationship, Y),pre_relationship(Y), Y \= X.
			pre_relationship(X):- not not_pre_relationship(X).

		% Post-Intervention world
			not_post_relationship(X) :- f_domain(relationship, Y), post_relationship(Y), Y \= X.
			post_relationship(X):- not not_post_relationship(X).


	% sex
	
		% Pre-intervention world
			not_pre_sex(X) :- f_domain(sex, Y),pre_sex(Y), Y \= X.
			pre_sex(X):- not not_pre_sex(X).

		% Post-Intervention world
			not_post_sex(X) :- f_domain(sex, Y), post_sex(Y), Y \= X.
			post_sex(X):- not not_post_sex(X).


% Properties for Numerical Features

	% capital_gain 
		% Pre-intervention world
			pre_capital_gain(X):- f_domain(capital_gain, X).

		% Post-Intervention world
			post_capital_gain(X):- f_domain(capital_gain, X).

	% education_num 
		% Pre-intervention world
			pre_education_num(X):- f_domain(education_num, X).

		% Post-Intervention world
			post_education_num(X):- f_domain(education_num, X).

	% age 
		% Pre-intervention world
			pre_age(X):- f_domain(age, X).

		% Post-Intervention world
			post_age(X):- f_domain(age, X).



% Decision rule to classify if a person makes ’<=50K/yr’
	lite_le_50K(X,Y,_) :- X \= married_civ_spouse, Y #=< 6849.0.
	lite_le_50K(X,Y,Z) :- X = married_civ_spouse, Y #=< 5013.0, Z #=< 12.0.

	less_equal_50K(A,B,C):- f_domain(marital_status, A),
		f_domain(capital_gain, B), f_domain(education_num, C),
		pre_marital_status(A), pre_capital_gain(B),pre_education_num(C), 
		lite_le_50K(A,B,C).


%#show lite_le_50K/3, not lite_le_50K/3.
?-less_equal_50K(A,B,C).


% Constraint rules identify causal relationships amongst features.
% They restrict the values taken for relationship(Y) and age(Z)
	constraint_ms_reln_age(married_civ_spouse,Y,Z):- Y = husband.
	constraint_ms_reln_age(married_civ_spouse,Y,Z):- Y = wife.
	constraint_ms_reln_age(never_married,Y,Z):- Y \= husband, Y\= wife, Z #=<29.
% Add the rule to catch all other cases
	constraint_ms_reln_age(X,Y,Z):- X\= married_civ_spouse, X\= never_married,
	Y \= husband, Y\= wife.

	

% Constraint rules that restrict age and sex for relationship
	constraint_reln_sex_age(husband,Y,Z):- Y\= female, Z#>27.
% There is no rule for wife, so we put a rule to allow the same
	constraint_reln_sex_age(wife,Y,Z):- Y= female.
% Add the rule to catch all other cases
	constraint_reln_sex_age(X,Y,Z):- X \= husband, X \= wife.






% Counterfactual rule to clasify if a person does not make ’<=50K/yr’
	cf_less_equal_50K(A,B,C):- f_domain(marital_status, A),
	f_domain(capital_gain, B), f_domain(education_num, C),
	post_marital_status(A), post_capital_gain(B),post_education_num(C), 
	not lite_le_50K(A,B,C).

%% QUERY
?- cf_less_equal_50K(A,B,C).



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

	measure(Z1,Z2,Z3,Z4,Z5,Z6,X):- f_domain(control,Z1), f_domain(control_N,Z2),
	
	f_domain(control_N,Z3), f_domain(control,Z4),f_domain(control,Z5),
	f_domain(control_N,Z6), Q2 #= Z2*Z2, Q3 #= Z3*Z3,Q6 #= Z6*Z6,
		X #= Z1+Q2+Q3+Z4+Z5+Q6.






% Make the craig function more simpler utilizing the earlier function
refined_2(original(A,B,C,D,E,F),Z1,Z2,Z3,Z4,Z5,Z6,counterfactual(A1,B1,C1,D1,E1,F1),X):-
	less_equal_50K(A,B,C),

	f_domain(relationship, D),f_domain(sex,E), f_domain(age,F), 
	pre_relationship(D), pre_sex(E), pre_age(F),

	constraint_ms_reln_age(A,D,F), constraint_reln_sex_age(D,E,F),


	cf_less_equal_50K(A1,B1,C1),

	f_domain(relationship, D1),	f_domain(sex,E1),f_domain(age,F1), 
	post_relationship(D1), post_sex(E1), post_age(F1) ,
	
	constraint_ms_reln_age(A1,D1,F1), constraint_reln_sex_age(D1,E1,F1),


	compare_C(A,A1,Z1), compare_N(B,B1,Z2), compare_N(C,C1,Z3),
	compare_C(D,D1,Z4), compare_C(E,E1,Z5), compare_N(F,F1,Z6),
	measure(Z1,Z2,Z3,Z4,Z5,Z6,X).



% Realistic: consistent with causal dependencies. checks if the individuals are realistic or not . 
% ie husband, then cannot be female, etc

	% Checks if the individual is consistent with the world pre intervention
	pre_realistic(A,B,C,D,E,F):-f_domain(marital_status, A),
		f_domain(capital_gain, B), f_domain(education_num, C),
		f_domain(relationship, D),
		f_domain(sex,E), 
		f_domain(age,F), 
		pre_marital_status(A),
		pre_capital_gain(B),pre_education_num(C), 
		pre_relationship(D), pre_sex(E), pre_age(F),
		constraint_ms_reln_age(A,D,F), constraint_reln_sex_age(D,E,F).

	% Checks if the individual is consistent with the world post intervention
	post_realistic(A,B,C,D,E,F):-f_domain(marital_status, A),
		f_domain(capital_gain, B), f_domain(education_num, C),
		f_domain(relationship, D),
		f_domain(sex,E), 
		f_domain(age,F), 
		post_marital_status(A),
		post_capital_gain(B),post_education_num(C), 
		post_relationship(D), post_sex(E), post_age(F),
		constraint_ms_reln_age(A,D,F), constraint_reln_sex_age(D,E,F).





% Identify and Restrict: Identify the features to be intervened on / Restrict features to be intervened on

id_restrict(original(A,B,C,D,E,F),id(Z1,Z2,Z3,Z4,Z5,Z6),counterfactual(A1,B1,C1,D1,E1,F1)):- 
	compare_C(A,A1,Z1), compare_N(B,B1,Z2), compare_N(C,C1,Z3),
	compare_C(D,D1,Z4), compare_C(E,E1,Z5), compare_N(F,F1,Z6).


% Make the craig function Extremely interpretable
refined(original(A,B,C,D,E,F),id(Z1,Z2,Z3,Z4,Z5,Z6),counterfactual(A1,B1,C1,D1,E1,F1),X):-
	less_equal_50K(A,B,C),
	pre_realistic(A,B,C,D,E,F),

	cf_less_equal_50K(A1,B1,C1),
	post_realistic(A1,B1,C1,D1,E1,F1),

	id_restrict(original(A,B,C,D,E,F),id(Z1,Z2,Z3,Z4,Z5,Z6),counterfactual(A1,B1,C1,D1,E1,F1)), 
	measure(Z1,Z2,Z3,Z4,Z5,Z6,X).




# show lite_le_50K/2.
#show lite_le_50K/3, not lite_le_50K/3.


?- less_equal_50K(A,B,C), pre_realistic(A,B,C,D,E,F).
?- cf_less_equal_50K(A,B,C), post_realistic(A,B,C,D,E,F).

?-refined(original(A,B,C,D,E,F),id(Z1,Z2,Z3,Z4,Z5,Z6),counterfactual(A1,B1,C1,D1,E1,F1),X).
?-refined(original(married_civ_spouse,777,4,husband,male,30),id(Z1,Z2,Z3,Z4,0,Z6),counterfactual(A1,B1,C1,D1,E1,F1),X).


