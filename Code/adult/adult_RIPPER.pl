f_domain(marital_status, married_civ_spouse). % Not in dm rule
f_domain(marital_status, never_married).
f_domain(marital_status, divorced).

f_domain(relationship, husband). % Not in dm rule
f_domain(relationship, wife). % Not in dm rule
f_domain(relationship, own_child).
f_domain(relationship, not_in_family).
f_domain(relationship, unmarried).

f_domain(education, hs_grad). % Not in dm rule
f_domain(education, some_college).

f_domain(occupation, farming_fishing). % Not in dm rule
f_domain(occupation, adm_clerical).
f_domain(occupation, machine_op_inspct).
f_domain(occupation, other_service).

f_domain(workclass, never_worked). % Not in dm rule
f_domain(workclass, private).

f_domain(native_country, japan). % Not in dm rule
f_domain(native_country, united_States).


f_domain(sex, male). % Not in dm rule
f_domain(sex, female).

f_domain(capital_gain, X):-  X #>= 0, X #=< 99999.
f_domain(education_num, X):- X #>= 1, X #=< 16.
f_domain(age, X):-  X #>= 17, X #=< 90.

f_domain(hours_per_week, X):-  X #>= 1, X #=< 99.
f_domain(capital_loss, X):-  X #>= 0, X #=< 4356.



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


	% education
	
		% Pre_intervention world
			not_pre_education(X) :- f_domain(education, Y),pre_education(Y), Y \= X.
			pre_education(X):- not not_pre_education(X).

		% Post_Intervention world
			not_post_education(X) :- f_domain(education, Y), post_education(Y), Y \= X.
			post_education(X):- not not_post_education(X).


	% occupation
	
		% Pre_intervention world
			not_pre_occupation(X) :- f_domain(occupation, Y),pre_occupation(Y), Y \= X.
			pre_occupation(X):- not not_pre_occupation(X).

		% Post_Intervention world
			not_post_occupation(X) :- f_domain(occupation, Y), post_occupation(Y), Y \= X.
			post_occupation(X):- not not_post_occupation(X).


	% workclass
	
		% Pre_intervention world
			not_pre_workclass(X) :- f_domain(workclass, Y),pre_workclass(Y), Y \= X.
			pre_workclass(X):- not not_pre_workclass(X).

		% Post_Intervention world
			not_post_workclass(X) :- f_domain(workclass, Y), post_workclass(Y), Y \= X.
			post_workclass(X):- not not_post_workclass(X).


	% native_country
	
		% Pre_intervention world
			not_pre_native_country(X) :- f_domain(native_country, Y),pre_native_country(Y), Y \= X.
			pre_native_country(X):- not not_pre_native_country(X).

		% Post_Intervention world
			not_post_native_country(X) :- f_domain(native_country, Y), post_native_country(Y), Y \= X.
			post_native_country(X):- not not_post_native_country(X).

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

	% hours_per_week 
		% Pre-intervention world
			pre_hours_per_week(X):- f_domain(hours_per_week, X).

		% Post-Intervention world
			post_hours_per_week(X):- f_domain(hours_per_week, X).

	% capital_loss 
		% Pre-intervention world
			pre_capital_loss(X):- f_domain(capital_loss, X).

		% Post-Intervention world
			post_capital_loss(X):- f_domain(capital_loss, X).




% Decision rule to classify if a person makes ’<=50K/yr’


	% Org Rules
		%lite_le_50K(A,B,C,D,E,F,G,H,I,J,K,L):- marital_status=never_married , relationship=own_child , age #=< 22.0.
		%lite_le_50K(A,B,C,D,E,F,G,H,I,J,K,L):- marital_status=never_married , capital_gain #=< 9999.9.
		%lite_le_50K(A,B,C,D,E,F,G,H,I,J,K,L):- relationship=not_in_family , capital_gain #=< 9999.9 , education_num #>= 7.0, education_num #=< 9.0 , hours_per_week #>= 35.0, hours_per_week #=< 40.0 , age #>= 26.0, age #=< 30.0.
		%lite_le_50K(A,B,C,D,E,F,G,H,I,J,K,L):- relationship=not_in_family , capital_gain #=< 9999.9 , education_num #>= 7.0, education_num #=< 9.0 , sex=Female.
		%lite_le_50K(A,B,C,D,E,F,G,H,I,J,K,L):- relationship=not_in_family , capital_gain #=< 9999.9 , education=some_college , sex=Female , occupation=adm_clerical.
		%lite_le_50K(A,B,C,D,E,F,G,H,I,J,K,L):- relationship=not_in_family , capital_gain #=< 9999.9 , hours_per_week #>= 35.0, hours_per_week #=< 40.0 , age #>= 22.0, age #=< 26.0.
		%lite_le_50K(A,B,C,D,E,F,G,H,I,J,K,L):- relationship=not_in_family , capital_gain #=< 9999.9 , education_num #>= 7.0, education_num #=< 9.0 , workclass=private , occupation=machine_op_inspct.
		%lite_le_50K(A,B,C,D,E,F,G,H,I,J,K,L):- relationship=not_in_family , capital_gain #=< 9999.9 , education_num #=< 7.0 , sex=Female.
		%lite_le_50K(A,B,C,D,E,F,G,H,I,J,K,L):- relationship=not_in_family , capital_gain #=< 9999.9 , education=some_college , occupation=other_service.
		%lite_le_50K(A,B,C,D,E,F,G,H,I,J,K,L):- relationship=unmarried.
		%lite_le_50K(A,B,C,D,E,F,G,H,I,J,K,L):- relationship=not_in_family , capital_gain #=< 9999.9 , hours_per_week #>= 35.0, hours_per_week #=< 40.0 , education_num #>= 7.0, education_num #=< 9.0.
		%lite_le_50K(A,B,C,D,E,F,G,H,I,J,K,L):- relationship=not_in_family , capital_gain #=< 9999.9 , age #>= 26.0, age #=< 30.0 , hours_per_week #>= 35.0, hours_per_week #=< 40.0.
		%lite_le_50K(A,B,C,D,E,F,G,H,I,J,K,L):- education_num #=< 7.0.
		%lite_le_50K(A,B,C,D,E,F,G,H,I,J,K,L):- relationship=not_in_family , capital_gain #=< 9999.9 , hours_per_week #>= 25.0, hours_per_week #=< 35.0 , workclass=private , sex=Female.
		%lite_le_50K(A,B,C,D,E,F,G,H,I,J,K,L):- relationship=not_in_family , capital_gain #=< 9999.9 , hours_per_week #=< 25.0 , capital_loss #=< 435.6 , native_country=united_States , workclass=private.
		%lite_le_50K(A,B,C,D,E,F,G,H,I,J,K,L):- marital_status=divorced , capital_gain #=< 9999.9 , hours_per_week #>= 35.0, hours_per_week #=< 40.0 , education=some_college.
		%lite_le_50K(A,B,C,D,E,F,G,H,I,J,K,L):- education_num #>= 7.0, education_num #=< 9.0 , marital_status=divorced , relationship=own_child.
		%lite_le_50K(A,B,C,D,E,F,G,H,I,J,K,L):- education_num #>= 7.0, education_num #=< 9.0 , occupation=other_service , age #>= 37.0, age #=< 41.0.
		%lite_le_50K(A,B,C,D,E,F,G,H,I,J,K,L):- education_num #>= 7.0, education_num #=< 9.0 , age #>= 26.0, age #=< 30.0.

	% Replace with letters Rules
		lite_le_50K(A,B,C,D,E,F,G,H,I,J,K,L):- A =never_married , D =own_child , F #=< 22.0.
		lite_le_50K(A,B,C,D,E,F,G,H,I,J,K,L):- A =never_married , B #=< 9999.9.
		lite_le_50K(A,B,C,D,E,F,G,H,I,J,K,L):- D =not_in_family , B #=< 9999.9 , C #>= 7.0, C #=< 9.0 , K #>= 35.0, K #=< 40.0 , F #>= 26.0, F #=< 30.0.
		lite_le_50K(A,B,C,D,E,F,G,H,I,J,K,L):- D =not_in_family , B #=< 9999.9 , C #>= 7.0, C #=< 9.0 , E =Female.
		lite_le_50K(A,B,C,D,E,F,G,H,I,J,K,L):- D =not_in_family , B #=< 9999.9 , G =some_college , E =Female , H =adm_clerical.
		lite_le_50K(A,B,C,D,E,F,G,H,I,J,K,L):- D =not_in_family , B #=< 9999.9 , K #>= 35.0, K #=< 40.0 , F #>= 22.0, F #=< 26.0.
	    lite_le_50K(A,B,C,D,E,F,G,H,I,J,K,L):- D =not_in_family , B #=< 9999.9 , C #>= 7.0, C #=< 9.0 , I =private , H =machine_op_inspct.
		lite_le_50K(A,B,C,D,E,F,G,H,I,J,K,L):- D =not_in_family , B #=< 9999.9 , C #=< 7.0 , E =Female.
		lite_le_50K(A,B,C,D,E,F,G,H,I,J,K,L):- D =not_in_family , B #=< 9999.9 , G =some_college , H =other_service.
		lite_le_50K(A,B,C,D,E,F,G,H,I,J,K,L):- D =unmarried.
		lite_le_50K(A,B,C,D,E,F,G,H,I,J,K,L):- D =not_in_family , B #=< 9999.9 , K #>= 35.0, K #=< 40.0 , C #>= 7.0, C #=< 9.0.
		lite_le_50K(A,B,C,D,E,F,G,H,I,J,K,L):- D =not_in_family , B #=< 9999.9 , F #>= 26.0, F #=< 30.0 , K #>= 35.0, K #=< 40.0.
		lite_le_50K(A,B,C,D,E,F,G,H,I,J,K,L):- C #=< 7.0.
		lite_le_50K(A,B,C,D,E,F,G,H,I,J,K,L):- D =not_in_family , B #=< 9999.9 , K #>= 25.0, K #=< 35.0 , I =private , E =Female.
		lite_le_50K(A,B,C,D,E,F,G,H,I,J,K,L):- D =not_in_family , B #=< 9999.9 , K #=< 25.0 , L #=< 435.6 , J =united_States , I =private.
		lite_le_50K(A,B,C,D,E,F,G,H,I,J,K,L):- A =divorced , B #=< 9999.9 , K #>= 35.0, K #=< 40.0 , G =some_college.
		lite_le_50K(A,B,C,D,E,F,G,H,I,J,K,L):- C #>= 7.0, C #=< 9.0 , A =divorced , D =own_child.
		lite_le_50K(A,B,C,D,E,F,G,H,I,J,K,L):- C #>= 7.0, C #=< 9.0 , H =other_service , F #>= 37.0, F #=< 41.0.
		lite_le_50K(A,B,C,D,E,F,G,H,I,J,K,L):- C #>= 7.0, C #=< 9.0 , F #>= 26.0, F #=< 30.0.



	less_equal_50K(A,B,C,D,E,F,G,H,I,J,K,L):- f_domain(marital_status, A),
		f_domain(capital_gain, B), f_domain(education_num, C),
		f_domain(relationship, D), f_domain(sex,E), f_domain(age,F), 

		f_domain(education, G), f_domain(occupation, H), f_domain(workclass, I),
		f_domain(native_country, J), f_domain(hours_per_week, K), f_domain(capital_loss, L), 

		pre_marital_status(A), pre_capital_gain(B),pre_education_num(C), 
		pre_relationship(D), pre_sex(E),pre_age(F),

		pre_education(G), pre_occupation(H),pre_workclass(I),
		pre_native_country(J), pre_hours_per_week(K),pre_capital_loss(L),

		lite_le_50K(A,B,C,D,E,F,G,H,I,J,K,L).

% Rules from FOLD-SE for causal relations
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

	cf_less_equal_50K(A,B,C,D,E,F,G,H,I,J,K,L):- f_domain(marital_status, A),
	f_domain(capital_gain, B), f_domain(education_num, C),
	f_domain(relationship, D), f_domain(sex,E), f_domain(age,F), 

	f_domain(education, G), f_domain(occupation, H), f_domain(workclass, I),
	f_domain(native_country, J), f_domain(hours_per_week, K), f_domain(capital_loss, L), 

	post_marital_status(A), post_capital_gain(B),post_education_num(C), 
	post_relationship(D), post_sex(E),post_age(F),

	post_education(G), post_occupation(H),post_workclass(I),
	post_native_country(J), post_hours_per_week(K),post_capital_loss(L),

	not lite_le_50K(A,B,C,D,E,F,G,H,I,J,K,L).

%% QUERY
?- cf_le_50K(A,B,C,D,E,F,G,H,I,J,K,L).




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



measure(Z1,Z2,Z3,Z4,Z5,Z6,Z7,Z8,Z9,Z10,Z11,Z12,X):- f_domain(control,Z1), f_domain(control_N,Z2),
	
	f_domain(control_N,Z3), f_domain(control,Z4),f_domain(control,Z5),f_domain(control_N,Z6), 

	f_domain(control,Z7), f_domain(control,Z8),
	
	f_domain(control,Z9), f_domain(control,Z10),f_domain(control_N,Z11),f_domain(control_N,Z12), 


	Q2 #= Z2*Z2, Q3 #= Z3*Z3,Q6 #= Z6*Z6,
	Q11 #= Z11*Z11, Q12 #= Z12*Z12, 

	X1 #= Z1+Q2+Q3+Z4+Z5+Q6,
	X2 #= Z7+Z8+Z9+Z10+Q11+Q12,
	X #= X1+X2.


% Realistic: consistent with causal dependencies. checks if the individuals are realistic or not . 
% ie husband, then cannot be female, etc

	% Checks if the individual is consistent with the world pre intervention
	pre_realistic(A,B,C,D,E,F,G,H,I,J,K,L):-f_domain(marital_status, A),
		f_domain(capital_gain, B), f_domain(education_num, C),
		f_domain(relationship, D), f_domain(sex,E), f_domain(age,F), 

		f_domain(education, G), f_domain(occupation, H), f_domain(workclass, I),
		f_domain(native_country, J), f_domain(hours_per_week, K), f_domain(capital_loss, L), 
		pre_marital_status(A), pre_capital_gain(B),pre_education_num(C), 
		pre_relationship(D), pre_sex(E),pre_age(F),

		pre_education(G), pre_occupation(H),pre_workclass(I),
		pre_native_country(J), pre_hours_per_week(K),pre_capital_loss(L),
		constraint_ms_reln_age(A,D,F), constraint_reln_sex_age(D,E,F).

	% Checks if the individual is consistent with the world post intervention
	post_realistic(A,B,C,D,E,F,G,H,I,J,K,L):-f_domain(marital_status, A),
		f_domain(capital_gain, B), f_domain(education_num, C),
		f_domain(relationship, D), f_domain(sex,E), f_domain(age,F), 

		f_domain(education, G), f_domain(occupation, H), f_domain(workclass, I),
		f_domain(native_country, J), f_domain(hours_per_week, K), f_domain(capital_loss, L), 
		post_marital_status(A), post_capital_gain(B),post_education_num(C), 
		post_relationship(D), post_sex(E),post_age(F),

		post_education(G), post_occupation(H),post_workclass(I),
		post_native_country(J), post_hours_per_week(K),post_capital_loss(L),
		constraint_ms_reln_age(A,D,F), constraint_reln_sex_age(D,E,F).


id_restrict(original(A,B,C,D,E,F,G,H,I,J,K,L),id(Z1,Z2,Z3,Z4,Z5,Z6,Z7,Z8,Z9,Z10,Z11,Z12),counterfactual(A1,B1,C1,D1,E1,F1,G1,H1,I1,J1,K1,L1)):- 
	compare_C(A,A1,Z1), compare_N(B,B1,Z2), compare_N(C,C1,Z3),
	compare_C(D,D1,Z4), compare_C(E,E1,Z5), compare_N(F,F1,Z6),

	compare_C(G,G1,Z7), compare_C(H,H1,Z8), compare_C(I,I1,Z9),
	compare_C(J,J1,Z10), compare_N(K,K1,Z11), compare_N(L,L1,Z12).



% Make the craig function Extremely interpretable
refined(original(A,B,C,D,E,F,G,H,I,J,K,L),id(Z1,Z2,Z3,Z4,Z5,Z6,Z7,Z8,Z9,Z10,Z11,Z12),counterfactual(A1,B1,C1,D1,E1,F1,G1,H1,I1,J1,K1,L1),X):-
	less_equal_50K(A,B,C,D,E,F,G,H,I,J,K,L),
	pre_realistic(A,B,C,D,E,F,G,H,I,J,K,L),

	cf_less_equal_50K(A1,B1,C1,D1,E1,F1,G1,H1,I1,J1,K1,L1),
	post_realistic(A1,B1,C1,D1,E1,F1,G1,H1,I1,J1,K1,L1),

	id_restrict(original(A,B,C,D,E,F,G,H,I,J,K,L),id(Z1,Z2,Z3,Z4,Z5,Z6,Z7,Z8,Z9,Z10,Z11,Z12),counterfactual(A1,B1,C1,D1,E1,F1,G1,H1,I1,J1,K1,L1)), 
	measure(Z1,Z2,Z3,Z4,Z5,Z6,Z7,Z8,Z9,Z10,Z11,Z12,X).


#show lite_le_50K/12, not lite_le_50K/12.
%?-le_50K(A,B,C,D,E,F,G,H,I,J,K,L).
?- f_domain(marital_status, A).
%?- f_domain(relationship, B).
%?- f_domain(age, F).
?- f_domain(marital_status, A),	f_domain(capital_gain, B), f_domain(education_num, C), f_domain(relationship, D), f_domain(sex,E), f_domain(age,F).

?- f_domain(education, G), f_domain(occupation, H), f_domain(workclass, I), f_domain(native_country, J), f_domain(hours_per_week, K), f_domain(capital_loss, L).

?- f_domain(marital_status, A),	f_domain(capital_gain, B), f_domain(education_num, C), f_domain(relationship, D), f_domain(sex,E), f_domain(age,F), f_domain(education, G), f_domain(occupation, H), f_domain(workclass, I), f_domain(native_country, J), f_domain(hours_per_week, K), f_domain(capital_loss, L).

?-le_50K(A,B,C,D,E,F,G,H,I,J,K,L).

?- cf_le_50K(A,B,C,D,E,F,G,H,I,J,K,L).




%?-less_equal_50K(A,B,C,D,E,F,G,H,I,J,K,L).

?-cf_less_equal_50K(A,B,C,D,E,F,G,H,I,J,K,L).

%?- refined(original(A,B,C,D,E,F,G,H,I,J,K,L),id(Z1,Z2,Z3,Z4,Z5,Z6,Z7,Z8,Z9,Z10,Z11,Z12),counterfactual(A1,B1,C1,D1,E1,F1,G1,H1,I1,J1,K1,L1),X).